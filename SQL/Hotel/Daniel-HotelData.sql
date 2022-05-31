#################################################################################################
###									 INITIALIZE DATABASE									  ###
#################################################################################################

USE Hotel;

#################################################################################################
###										 MANAGE DATA										  ###
#################################################################################################

############# Include Self into Guests and Reservations #############

-- First, increment all the GuestId values by 1
UPDATE Guest
SET GuestId = GuestId+1
-- Without ordering, MySQL will try and fail to update 1 to 2 because GuestId 2 already exists
-- MySQL statements go from top to bottom
ORDER BY GuestId DESC;
-- Note this only works if UPDATE CASCADE is used for the foreign key in Reservation
-- Otherwise, MySQL will not allow the update as by default it is ON UPDATE RESTRICT

-- Next, add the values for Self for Guest
INSERT INTO Guest (GuestId, FirstName, LastName, Address, City, State, Zip, PhoneNum)
Values (1, "Daniel", "Tan", "9000 Revosit Street", "Gogeta", "DB", 35926, "(420) 314-6996");

-- Then, add the values for Reservations
INSERT INTO Reservation (ReservationId, RoomId, GuestId, Adults, Children, StartDate, EndDate, RoomPrice) Values
(5, 307, 1, 1, 1, STR_TO_DATE("3/17/2023", "%m/%d/%Y"),STR_TO_DATE("3/20/2023", "%m/%d/%Y"),524.97),
(14, 205, 1, 2, 0, STR_TO_DATE("6/28/2023", "%m/%d/%Y"),STR_TO_DATE("7/2/2023", "%m/%d/%Y"),699.96);

#################### Delete Jeremiah Pendergrass ####################

-- To delete a record, it can either begin with the foreign key tables OR using ON DELETE CASCADE (if this is reasonable)
-- ON DELETE CASCADE was only set for the GuestId key and only when the parent is deleted, so no effect on Room table
DELETE FROM Guest
WHERE FirstName = "Jeremiah" AND LastName = "Pendergrass";