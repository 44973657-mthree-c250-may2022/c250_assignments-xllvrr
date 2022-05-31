USE PersonalTrainer;

-- Select all columns from ExerciseCategory and Exercise.
-- The tables should be joined on ExerciseCategoryId.
-- This query returns all Exercises and their associated ExerciseCategory.
-- 64 rows
-- ------------------
SELECT *
FROM ExerciseCategory AS EC
INNER JOIN Exercise E ON EC.ExerciseCategoryId = E.ExerciseCategoryId;

    
-- Select ExerciseCategory.Name and Exercise.Name
-- where the ExerciseCategory does not have a ParentCategoryId (it is null).
-- Again, join the tables on their shared key (ExerciseCategoryId).
-- 9 rows
-- ------------------
SELECT EC.Name, E.Name 
FROM ExerciseCategory AS EC
INNER JOIN Exercise E ON EC.ExerciseCategoryId = E.ExerciseCategoryId
WHERE EC.ParentCategoryId IS NULL;

-- The query above is a little confusing. At first glance, it's hard to tell
-- which Name belongs to ExerciseCategory and which belongs to Exercise.
-- Rewrite the query using an aliases. 
-- Alias ExerciseCategory.Name as 'CategoryName'.
-- Alias Exercise.Name as 'ExerciseName'.
-- 9 rows
-- ------------------
SELECT EC.Name AS CategoryName, E.Name AS ExerciseName
FROM ExerciseCategory AS EC
INNER JOIN Exercise E ON EC.ExerciseCategoryId = E.ExerciseCategoryId
WHERE EC.ParentCategoryId IS NULL;

-- Select FirstName, LastName, and BirthDate from Client
-- and EmailAddress from Login 
-- where Client.BirthDate is in the 1990s.
-- Join the tables by their key relationship. 
-- What is the primary-foreign key relationship?
-- 35 rows
-- ------------------
SELECT C.FirstName, C.LastName, C.BirthDate, L.EmailAddress
FROM Client AS C
INNER JOIN Login L ON C.ClientId = L.ClientId -- Primary-Foreign Key Rls on ClientId
WHERE C.BirthDate BETWEEN '1990-01-01' AND '1999-12-31';

-- Select Workout.Name, Client.FirstName, and Client.LastName
-- for Clients with LastNames starting with 'C'?
-- How are Clients and Workouts related?
-- 25 rows
-- ------------------
SELECT W.Name, C.FirstName, C.LastName
FROM Workout as W
INNER JOIN ClientWorkout CW ON W.WorkoutId = CW.WorkoutId
INNER JOIN Client C ON CW.ClientId = C.ClientId
WHERE C.LastName LIKE 'C%';

-- Select Names from Workouts and their Goals.
-- This is a many-to-many relationship with a bridge table.
-- Use aliases appropriately to avoid ambiguous columns in the result.
-- ------------------
SELECT W.Name, G.Name
FROM Workout as W
INNER JOIN WorkoutGoal WG ON W.WorkoutId = WG.WorkoutId
INNER JOIN Goal G ON WG.GoalId = G.GoalId;

-- Select FirstName and LastName from Client.
-- Select ClientId and EmailAddress from Login.
-- Join the tables, but make Login optional.
-- 500 rows
-- ------------------
SELECT C.FirstName, C.LastName, L.ClientId, L.EmailAddress
FROM Client as C
LEFT OUTER JOIN Login L ON C.ClientId = L.ClientId;

-- Using the query above as a foundation, select Clients
-- who do _not_ have a Login.
-- 200 rows
-- ------------------
SELECT C.FirstName, C.LastName, L.ClientId, L.EmailAddress
FROM Client as C
LEFT OUTER JOIN Login L ON C.ClientId = L.ClientId
WHERE L.ClientId IS NULL;

-- Does the Client, Romeo Seaward, have a Login?
-- Decide using a single query.
-- nope :(
-- ------------------
SELECT C.FirstName, C.LastName, L.ClientId, L.EmailAddress
FROM Client as C
LEFT OUTER JOIN Login L ON C.ClientId = L.ClientId
WHERE L.ClientId IS NULL
AND CONCAT(C.FirstName, ' ', C.LastName) = "Romeo Seaward";

-- Select ExerciseCategory.Name and its parent ExerciseCategory's Name.
-- This requires a self-join.
-- 12 rows
-- ------------------
SELECT Child.Name as CategoryName, Parent.Name as ParentName
FROM ExerciseCategory Parent
INNER JOIN ExerciseCategory Child ON Parent.ExerciseCategoryId = Child.ParentCategoryId;
    
-- Rewrite the query above so that every ExerciseCategory.Name is
-- included, even if it doesn't have a parent.
-- 16 rows
-- ------------------
SELECT Child.Name as CategoryName, Parent.Name as ParentName
FROM ExerciseCategory Parent
RIGHT OUTER JOIN ExerciseCategory Child ON Parent.ExerciseCategoryId = Child.ParentCategoryId;
    
-- Are there Clients who are not signed up for a Workout?
-- 50 rows
-- ------------------
SELECT CONCAT(C.FirstName, " ", C.LastName) as ClientName, W.Name as WorkoutName
FROM Client C
LEFT OUTER JOIN ClientWorkout CW ON C.ClientId = CW.ClientId
LEFT OUTER JOIN Workout W ON CW.WorkoutId = W.WorkoutId
Where CW.WorkoutId IS NULL;

-- Which Beginner-Level Workouts satisfy at least one of Shell Creane's Goals?
-- Goals are associated to Clients through ClientGoal.
-- Goals are associated to Workouts through WorkoutGoal.
-- 6 rows, 4 unique rows
-- ------------------
-- Selecting Level 1 Workouts
-- Checking Shell's Goals
SELECT * FROM ClientGoal CG INNER JOIN Client C ON CG.ClientId = C.ClientId WHERE C.FirstName = "Shell" AND C.LastName = "Creane";

SELECT DISTINCT W.Name as WorkoutName, G.Name as Goal
FROM Workout W
INNER JOIN WorkoutGoal WG ON W.WorkoutId = WG.WorkoutId
INNER JOIN Goal G ON WG.GoalId = G.GoalId
INNER JOIN ClientGoal CG ON G.GoalId = CG.GoalId
INNER JOIN Client C ON CG.ClientId = C.ClientId
WHERE CONCAT(C.FirstName, " ", C.LastName) = "Shell Creane"
AND W.LevelId = 1;

-- Select all Workouts. 
-- Join to the Goal, 'Core Strength', but make it optional.
-- You may have to look up the GoalId before writing the main query.
-- If you filter on Goal.Name in a WHERE clause, Workouts will be excluded.
-- Why?
-- 26 Workouts, 3 Goals
-- ------------------
-- Lookup Goals
SELECT * FROM Goal;
-- Desired Goal is 10 (Core Strength)

SELECT W.Name as WorkoutName, G.Name as GoalName
FROM Workout W
LEFT OUTER JOIN WorkoutGoal WG ON W.WorkoutId = WG.WorkoutId AND WG.GoalId = 10
-- Using a WHERE Statement to Filter rather than putting it in the Join Statement would filter the final combined table
LEFT OUTER JOIN Goal G ON WG.GoalId = G.GoalId;

-- The relationship between Workouts and Exercises is... complicated.
-- Workout links to WorkoutDay (one day in a Workout routine)
-- which links to WorkoutDayExerciseInstance 
-- (Exercises can be repeated in a day so a bridge table is required) 
-- which links to ExerciseInstance 
-- (Exercises can be done with different weights, repetions,
-- laps, etc...) 
-- which finally links to Exercise.
-- Select Workout.Name and Exercise.Name for related Workouts and Exercises.
-- ------------------
SELECT W.Name as WorkoutName, E.Name as ExerciseName
FROM Workout W
INNER JOIN WorkoutDay WD ON W.WorkoutId = WD.WorkoutId
INNER JOIN WorkoutDayExerciseInstance WDI ON WD.WorkoutDayId = WDI.WorkoutDayId
INNER JOIN ExerciseInstance EI ON WDI.ExerciseInstanceId = EI.ExerciseInstanceId
INNER JOIN Exercise E ON EI.ExerciseId = E.ExerciseId;

   
-- An ExerciseInstance is configured with ExerciseInstanceUnitValue.
-- It contains a Value and UnitId that links to Unit.
-- Example Unit/Value combos include 10 laps, 15 minutes, 200 pounds.
-- Select Exercise.Name, ExerciseInstanceUnitValue.Value, and Unit.Name
-- for the 'Plank' exercise. 
-- How many Planks are configured, which Units apply, and what 
-- are the configured Values?
-- 4 rows, 1 Unit, and 4 distinct Values
-- ------------------
SELECT E.Name AS ExerciseName, EV.Value AS ExerciseValue, U.Name AS UnitName
FROM Exercise E
INNER JOIN ExerciseInstance EI ON E.ExerciseId = EI.ExerciseId AND E.ExerciseId = 17
INNER JOIN ExerciseInstanceUnitValue EV ON EI.ExerciseInstanceId = EV.ExerciseInstanceId
INNER JOIN Unit U ON EV.UnitId = U.UnitId;

-- Planks are configured in 5 minute intervals from 5-25 minutes