USE PersonalTrainer;

-- Use an aggregate to count the number of Clients.
-- 500 rows
-- ------------------
SELECT 
    COUNT(*) AS ClientCount
FROM
    Client;

-- Use an aggregate to count Client.BirthDate.
-- The number is different than total Clients. Why?
-- 463 rows
-- ------------------
SELECT 
    COUNT(BirthDate)
FROM
    Client;
-- Number is different because not every client has a BirthDate

SELECT 
    City, COUNT(*) AS `No. of Clients`
FROM
    Client
GROUP BY City
ORDER BY COUNT(*) DESC;

-- Calculate a total per invoice using only the InvoiceLineItem table.
-- Group by InvoiceId.
-- You'll need an expression for the line item total: Price * Quantity.
-- Aggregate per group using SUM().
-- 1000 rows
-- [NOTE: ACTUAL NUMBER OF ROWS IS 1884]
-- ------------------
SELECT 
    InvoiceId, SUM(Price * Quantity) AS InvoiceTotal
FROM
    InvoiceLineItem
GROUP BY InvoiceId;

-- Calculate a total per invoice using only the InvoiceLineItem table.
-- (See above.)
-- Only include totals greater than $500.00.
-- Order from lowest total to highest.
-- 234 rows
-- ------------------
SELECT 
    InvoiceId, SUM(Price * Quantity) AS InvoiceTotal
FROM
    InvoiceLineItem
GROUP BY InvoiceId
HAVING InvoiceTotal > 500
ORDER BY InvoiceTotal , InvoiceId;

-- Calculate the average line item total
-- grouped by InvoiceLineItem.Description.
-- 3 rows
-- ------------------
SELECT 
    Description,
    AVG(Price * Quantity) AS `Average Line Item Total`
FROM
    InvoiceLineItem
GROUP BY Description;

-- Select ClientId, FirstName, and LastName from Client
-- for clients who have *paid* over $1000 total.
-- Paid is Invoice.InvoiceStatus = 2.
-- Order by LastName, then FirstName.
-- 146 rows
-- ------------------
SELECT 
    C.ClientId, C.Firstname, C.LastName
FROM
    Client C
        INNER JOIN
    Invoice I ON C.ClientId = I.ClientId
        INNER JOIN
    InvoiceLineItem IL ON I.InvoiceId = IL.InvoiceId
WHERE
    I.InvoiceStatus = 2
GROUP BY C.ClientId
HAVING SUM(Price * Quantity) > 1000
ORDER BY C.LastName , C.FirstName;

-- Count exercises by category.
-- Group by ExerciseCategory.Name.
-- Order by exercise count descending.
-- 13 rows
-- ------------------
SELECT 
    EC.Name AS CategoryName, COUNT(E.Name) AS ExerciseNo
FROM
    Exercise E
        INNER JOIN
    ExerciseCategory EC ON E.ExerciseCategoryId = EC.ExerciseCategoryId
GROUP BY EC.Name
ORDER BY COUNT(E.Name) DESC;

-- Select Exercise.Name along with the minimum, maximum,
-- and average ExerciseInstance.Sets.
-- Order by Exercise.Name.
-- 64 rows
-- ------------------
SELECT 
    E.Name AS ExerciseName,
    MIN(EI.Sets) AS MinSets,
    MAX(EI.Sets) AS MaxSets,
    AVG(EI.Sets) AS AvgSets
FROM
    Exercise E
        INNER JOIN
    ExerciseInstance EI ON E.ExerciseId = EI.ExerciseId
GROUP BY E.Name
ORDER BY E.Name;

-- Find the minimum and maximum Client.BirthDate
-- per Workout.
-- 26 rows
-- Sample: 
-- WorkoutName, EarliestBirthDate, LatestBirthDate
-- '3, 2, 1... Yoga!', '1928-04-28', '1993-02-07'
-- ------------------
SELECT 
    W.Name,
    MIN(C.BirthDate) AS EarliestBirthDate,
    MAX(C.BirthDate) AS LatestBirthDate
FROM
    Workout W
        INNER JOIN
    ClientWorkout CW ON W.WorkoutId = CW.WorkoutId
        INNER JOIN
    Client C ON CW.ClientId = C.ClientId
GROUP BY W.Name;

-- Count client goals.
-- Be careful not to exclude rows for clients without goals.
-- 500 rows total
-- 50 rows with no goals
-- ------------------
SELECT 
    CONCAT(c.FirstName, ' ', c.LastName) ClientName,
    COUNT(cg.GoalId) AS GoalCount
FROM
    Client c
        LEFT OUTER JOIN
    ClientGoal cg ON c.ClientId = cg.ClientId
GROUP BY c.ClientId
ORDER BY COUNT(cg.GoalId);

-- Select Exercise.Name, Unit.Name, 
-- and minimum and maximum ExerciseInstanceUnitValue.Value
-- for all exercises with a configured ExerciseInstanceUnitValue.
-- Order by Exercise.Name, then Unit.Name.
-- 82 rows
-- ------------------
SELECT 
    E.Name ExerciseName,
    U.Name UnitName,
    MIN(EV.Value) MinUnit,
    MAX(EV.Value) MaxUnit
FROM
    Exercise E
        INNER JOIN
    ExerciseInstance EI ON E.ExerciseId = EI.ExerciseId
        INNER JOIN
    ExerciseInstanceUnitValue EV ON EI.ExerciseInstanceId = EV.ExerciseInstanceId
        INNER JOIN
    Unit U ON EV.UnitId = U.UnitId
GROUP BY E.ExerciseId , E.Name , U.Name
ORDER BY E.Name , U.Name;

-- Modify the query above to include ExerciseCategory.Name.
-- Order by ExerciseCategory.Name, then Exercise.Name, then Unit.Name.
-- 82 rows
-- ------------------
SELECT 
    E.Name ExerciseName,
    EC.Name ExerciseCategory,
    U.Name UnitName,
    MIN(EV.Value) MinUnit,
    MAX(EV.Value) MaxUnit
FROM
    ExerciseCategory EC
        INNER JOIN
    Exercise E ON EC.ExerciseCategoryId = E.ExerciseCategoryId
        INNER JOIN
    ExerciseInstance EI ON E.ExerciseId = EI.ExerciseId
        INNER JOIN
    ExerciseInstanceUnitValue EV ON EI.ExerciseInstanceId = EV.ExerciseInstanceId
        INNER JOIN
    Unit U ON EV.UnitId = U.UnitId
GROUP BY E.ExerciseId , E.Name , U.Name
ORDER BY EC.Name , E.Name , U.Name;

-- Select the minimum and maximum age in years for
-- each Level.
-- To calculate age in years, use the MySQL function DATEDIFF.
-- 4 rows
-- ------------------
SELECT
	L.Name LevelName,
    ROUND(MIN(DATEDIFF(CURDATE(), C.BirthDate)/365)) AS MinAge,
    ROUND(MAX(DATEDIFF(CURDATE(), C.BirthDate)/365)) AS MaxAge
FROM Client C
INNER JOIN ClientWorkout CW ON C.ClientId = CW.ClientId
inner join Workout W on CW.WorkoutId = W.WorkoutId
inner join Level L on W.LevelId = L.LevelId
group by L.LevelId;

-- Stretch Goal!
-- Count logins by email extension (.com, .net, .org, etc...).
-- Research SQL functions to isolate a very specific part of a string value.
-- 27 rows (27 unique email extensions)
-- ------------------
SELECT DISTINCT
    SUBSTRING_INDEX(L.EmailAddress, '.', - 1) EmailExtension,
    COUNT(SUBSTRING_INDEX(L.EmailAddress, '.', - 1)) ExtensionCount
FROM
    Client C
        INNER JOIN
    Login L ON C.ClientId = L.ClientId
GROUP BY EmailExtension
ORDER BY ExtensionCount DESC;

-- Stretch Goal!
-- Match client goals to workout goals.
-- Select Client FirstName and LastName and Workout.Name for
-- all workouts that match at least 2 of a client's goals.
-- Order by the client's last name, then first name.
-- 139 rows
-- ------------------
SELECT C.FirstName, C.LastName, W.Name WorkoutName
FROM Workout W
INNER JOIN WorkoutGoal WG ON W.WorkoutId = WG.WorkoutId
INNER JOIN Goal G ON WG.GoalId = G.GoalId
INNER JOIN ClientGoal CG ON G.GoalId = CG.GoalId
INNER JOIN Client C ON CG.ClientId = C.ClientId
GROUP BY W.WorkoutId, C.ClientId
HAVING COUNT(G.GoalId) > 1;