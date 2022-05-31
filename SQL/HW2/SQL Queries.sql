-- Use Database
USE PersonalTrainer;

-- Activity 1
SELECT * FROM Exercise;

-- Activity 2
SELECT * FROM Client;

-- Activity 3
SELECT * FROM Client WHERE City = "Metairie";

-- Activity 4
SELECT * FROM Client WHERE ClientId = "818u7faf-7b4b-48a2-bf12-7a26c92de20c";

-- Activity 5
SELECT COUNT(*) FROM Goal;

-- Activity 6
SELECT Name, LevelId FROM Workout;

-- Activity 7
SELECT Name, LevelId, Notes FROM Workout WHERE LevelId = 2;

-- Activity 8
SELECT 
    FirstName, LastName, City
FROM
    Client
WHERE
    City IN ('Metairie' , 'Kenner', 'Gretna');

-- Activity 9
SELECT 
    FirstName, LastName, Birthdate
FROM
    Client
WHERE
    BirthDate BETWEEN '1980-01-01' AND '1989-12-31';

-- Activity 10
SELECT 
    FirstName, LastName, Birthdate
FROM
    Client
WHERE
    '1980-01-01' < BirthDate < '1989-12-31';

-- Activity 11
SELECT COUNT(*) FROM Login WHERE EmailAddress LIKE "%.gov";

-- Activity 12
SELECT COUNT(*) FROM Login WHERE EmailAddress NOT LIKE "%.com";

-- Activity 13
SELECT FirstName, LastName FROM Client WHERE BirthDate IS NULL;

-- Activity 14
SELECT Name FROM ExerciseCategory WHERE ParentCategoryId IS NOT NULL;

-- Activity 15
SELECT Name, Notes FROM Workout WHERE Notes like "%you%" AND LevelId = 3;

-- Activity 16
SELECT 
    FirstName, LastName, City
FROM
    Client
WHERE
    (LastName LIKE 'L%' OR LastName LIKE 'M%'
        OR LastName LIKE 'N%')
        AND City = 'LaPlace';

-- Activity 17
SELECT 
    InvoiceId,
    Description,
    Price,
    Quantity,
    ServiceDate,
    (Price*Quantity) AS Line_Item_Total
FROM
    InvoiceLineItem
HAVING Line_Item_Total BETWEEN 15 AND 25;

-- Activity 18
SELECT 
    Login.EmailAddress
FROM
    Login
        JOIN
    Client ON Login.ClientID = Client.ClientID
WHERE
    Client.FirstName = 'Estrella'
        AND Client.LastName = 'Bazely'
	;

-- Activity 19
SELECT WorkoutID INTO WorkoutNum FROM Workout WHERE Name = 'This is Parkour';
SELECT GoalId FROM WorkoutGoal WHERE WorkoutID = 12;
SELECT Name FROM Goal WHERE GoalID = 3;