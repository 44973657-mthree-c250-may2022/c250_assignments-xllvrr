
USE Hotel;

#################################################################################################
###										  QUERY DATA										  ###
#################################################################################################

#1
-- Return List of Reservations Ending in July 2023
-- Name of Guest, Room Number, Start Date, End Date

SELECT 
    CONCAT(g.FirstName, ' ', g.LastName) AS GuestName,
    r.RoomId,
    r.StartDate,
    r.EndDate
FROM
    Guest g
        INNER JOIN
    Reservation r ON g.GuestId = r.GuestId
WHERE
    r.EndDate BETWEEN '2023-07-01' AND '2023-07-31';

-- Output: 4 rows (Rooms 205, 303, 204, 401)

#2
-- Return All Reservations with Jacuzzi
-- Guest Name, Room Number, Start Date, End Date
SELECT 
    CONCAT(g.FirstName, ' ', g.LastName) AS GuestName,
    r.RoomId,
    r.StartDate,
    r.EndDate
FROM
    Guest g
        INNER JOIN
    Reservation r ON g.GuestId = r.GuestId
        INNER JOIN
    Room rm ON r.RoomId = rm.RoomId
        AND rm.AmenitiesId IN (5 , 6);

-- Output: 11 rows


#3
-- Return Reservations by Specific Guest
-- Guest Name, Rooms Reserved, Start Date, Total Pax
SELECT 
    CONCAT(g.FirstName, ' ', g.LastName) AS GuestName,
    COUNT(r.RoomId) RoomsReserved,
    r.StartDate,
    r.EndDate,
    Adults + Children AS TotalPax
FROM
    Guest g
        INNER JOIN
    Reservation r ON g.GuestId = r.GuestId
WHERE CONCAT(g.FirstName, " ", g.LastName) = "Daniel Tan";

-- Output: 1 row, Daniel Tan with 2 rooms reserved from 2023-03-17 to 2023-03-20 for 2 people


#4
-- Return for Each Reservation (Group By) for All Reservations
-- List of Rooms, Reservation ID, Per-Room Cost
SELECT 
    rm.RoomId,
    r.ReservationId,
    IF(r.ReservationID IS NOT NULL,
        r.RoomPrice,
        rm.BasePrice) AS PerRoomCost
FROM
    Room rm
        LEFT OUTER JOIN
    Reservation r ON rm.RoomId = r.RoomId
GROUP BY r.ReservationId , rm.RoomId
ORDER BY ISNULL(r.ReservationId) , r.ReservationId;

-- Output: 26 rows

#5
-- Return Rooms with >= 3 guests in Apr 2023
SELECT RoomId
FROM Reservation
WHERE (StartDate BETWEEN "2023-04-01" AND "2023-04-31"
OR EndDate BETWEEN "2023-04-01" AND "2023-04-31")
AND Adults+Children > 2;

-- Output: 0 rows (no rooms booked in April had 3 or more guests)

#6
-- Return Per Guest
-- Guest Name, # of Reservations Made
-- Sort by Most Reservations then Guest Name
SELECT CONCAT(g.FirstName, " ", g.LastName) GuestName, COUNT(r.ReservationId) ReservationNum
FROM Guest g
INNER JOIN Reservation r ON g.GuestId = r.GuestId
GROUP BY g.GuestId
ORDER BY ReservationNum DESC, GuestName;

-- Output: 11 rows returned, Mack Simmer top at 4 reservations


#7
-- Return based on Phone Number
-- Name, Address, Phone Number of Guest
SELECT CONCAT(FirstName, ' ', LastName) GuestName, Address, PhoneNum
FROM Guest
WHERE PhoneNum = "(308) 494-0198";

-- Output: 1 row, Duane Cullision, 9662 Foxrun Lane, (308) 494-0198
