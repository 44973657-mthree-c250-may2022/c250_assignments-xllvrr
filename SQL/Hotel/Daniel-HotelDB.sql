#################################################################################################
###									 INITIALIZE DATABASE									  ###
#################################################################################################

DROP DATABASE IF EXISTS Hotel;
CREATE DATABASE Hotel;
USE Hotel;

#################################################################################################
###									   CREATE TABLES										  ###
#################################################################################################

CREATE TABLE Guest(
	GuestId Int Primary Key Auto_Increment,
	FirstName VarChar(20) NOT NULL,
	LastName VarChar(20) NOT NULL,
	Address VarChar(100) NOT NULL,
	City VarChar(40) NOT NULL,
    State VarChar(3) NOT NULL,
	Zip Int NOT NULL,
	PhoneNum VarChar(20) NOT NULL
);

CREATE TABLE Amenities(
	AmenitiesId INT PRIMARY KEY AUTO_INCREMENT,
    Microwave BOOL,
    Jacuzzi BOOL,
    Refrigerator BOOL,
    Oven BOOL
);

CREATE TABLE Room (
    RoomId INT PRIMARY KEY AUTO_INCREMENT,
	RoomType VARCHAR(20) NOT NULL,
    AmenitiesId INT NOT NULL,
    AdaAccess INT NOT NULL,
    StandardOcc INT NOT NULL,
    MaxOcc INT NOT NULL,
    BasePrice DECIMAL(6 , 2 ) NOT NULL,
    ExtraPerson INT,
    FOREIGN KEY `fk_Room_Amenities`(AmenitiesId)
        REFERENCES Amenities (AmenitiesId)
);

CREATE TABLE Reservation (
    ReservationId INT,
	RoomId INT NOT NULL,
    GuestId INT NOT NULL,
    Adults INT NOT NULL,
    Children INT,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    RoomPrice Decimal(8,2),
    FOREIGN KEY fk_Reservation_Guest (GuestId)
        REFERENCES Guest (GuestId)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
	FOREIGN KEY fk_Reservation_Room (RoomId)
		REFERENCES Room (RoomId)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

#################################################################################################
###										INSERT DATA											  ###
#################################################################################################
-- Guest
INSERT INTO Guest (FirstName, LastName, Address, City, State, Zip, PhoneNum) Values
('Mack','Simmer','379 Old Shore Street','Council Bluffs','IA',51501,'(291) 553-0508'),
('Bettyann','Seery','750 Wintergreen Dr.','Wasilla','AK',99654,'(478) 277-9632'),
('Duane','Cullison','9662 Foxrun Lane','Harlingen','TX',78552,'(308) 494-0198'),
('Karie','Yang','9378 W. Augusta Ave.','West Deptford','NJ',8096,'(214) 730-0298'),
('Aurore','Lipton','762 Wild Rose Street','Saginaw','MI',48601,'(377) 507-0974'),
('Zachery','Luechtefeld','7 Poplar Dr.','Arvada','CO',80003,'(814) 485-2615'),
('Jeremiah','Pendergrass','70 Oakwood St.','Zion','IL',60099,'(279) 491-0960'),
('Walter','Holaway','7556 Arrowhead St.','Cumberland','RI',2864,'(446) 396-6785'),
('Wilfred','Vise','77 West Surrey Street','Oswego','NY',13126,'(834) 727-1001'),
('Maritza','Tilton','939 Linda Rd.','Burke','VA',22015,'(446) 351-6860'),
('Joleen','Tison','87 Queen St.','Drexel Hill','PA',19026,'(231) 893-2755')
;

-- Amenities
INSERT INTO Amenities (Microwave, Jacuzzi, Refrigerator, Oven) Values
(1,0,0,0),
(0,0,1,0),
(1,0,1,0),
(1,0,1,1),
(1,1,0,0),
(1,1,1,0);

-- Room
INSERT INTO Room (RoomId, RoomType, AmenitiesId, AdaAccess, StandardOcc, MaxOcc, BasePrice, ExtraPerson) Values
(201,'Double',5,0,2,4,199.99,10),
(202,'Double',2,1,2,4,174.99,10),
(203,'Double',5,0,2,4,199.99,10),
(204,'Double',2,1,2,4,174.99,10),
(205,'Single',6,0,2,2,174.99,0),
(206,'Single',3,1,2,2,149.99,0),
(207,'Single',6,0,2,2,174.99,0),
(208,'Single',3,1,2,2,149.99,0),
(301,'Double',5,0,2,4,199.99,10),
(302,'Double',2,1,2,4,174.99,10),
(303,'Double',5,0,2,4,199.99,10),
(304,'Double',2,1,2,4,174.99,10),
(305,'Single',6,0,2,2,174.99,0),
(306,'Single',3,1,2,2,149.99,0),
(307,'Single',6,0,2,2,174.99,0),
(308,'Single',3,1,2,2,149.99,0),
(401,'Suite',4,1,3,8,399.99,20),
(402,'Suite',4,1,3,8,399.99,20);

-- Reservation
INSERT INTO Reservation (ReservationId, RoomId, GuestId, Adults, Children, StartDate, EndDate, RoomPrice) Values
(1,308,1,1,0,STR_TO_DATE('2/2/2023','%m/%d/%Y'),STR_TO_DATE('2/4/2023','%m/%d/%Y'),299.98),
(2,203,2,2,1,STR_TO_DATE('2/5/2023','%m/%d/%Y'),STR_TO_DATE('2/10/2023','%m/%d/%Y'),999.95),
(3,305,3,2,0,STR_TO_DATE('2/22/2023','%m/%d/%Y'),STR_TO_DATE('2/24/2023','%m/%d/%Y'),349.98),
(4,201,4,2,2,STR_TO_DATE('3/6/2023','%m/%d/%Y'),STR_TO_DATE('3/7/2023','%m/%d/%Y'),199.99),
(6,302,5,3,0,STR_TO_DATE('3/18/2023','%m/%d/%Y'),STR_TO_DATE('3/23/2023','%m/%d/%Y'),924.95),
(7,202,6,2,2,STR_TO_DATE('3/29/2023','%m/%d/%Y'),STR_TO_DATE('3/31/2023','%m/%d/%Y'),349.98),
(8,304,7,2,0,STR_TO_DATE('3/31/2023','%m/%d/%Y'),STR_TO_DATE('4/5/2023','%m/%d/%Y'),874.95),
(9,301,8,1,0,STR_TO_DATE('4/9/2023','%m/%d/%Y'),STR_TO_DATE('4/13/2023','%m/%d/%Y'),799.96),
(10,207,9,1,1,STR_TO_DATE('4/23/2023','%m/%d/%Y'),STR_TO_DATE('4/24/2023','%m/%d/%Y'),174.99),
(11,401,10,2,4,STR_TO_DATE('5/30/2023','%m/%d/%Y'),STR_TO_DATE('6/2/2023','%m/%d/%Y'),1199.97),
(12,206,11,2,0,STR_TO_DATE('6/10/2023','%m/%d/%Y'),STR_TO_DATE('6/14/2023','%m/%d/%Y'),599.96),
(12,208,11,1,0,STR_TO_DATE('6/10/2023','%m/%d/%Y'),STR_TO_DATE('6/14/2023','%m/%d/%Y'),599.96),
(13,304,5,3,0,STR_TO_DATE('6/17/2023','%m/%d/%Y'),STR_TO_DATE('6/18/2023','%m/%d/%Y'),184.99),
(15,204,8,3,1,STR_TO_DATE('7/13/2023','%m/%d/%Y'),STR_TO_DATE('7/14/2023','%m/%d/%Y'),184.99),
(16,401,9,4,2,STR_TO_DATE('7/18/2023','%m/%d/%Y'),STR_TO_DATE('7/21/2023','%m/%d/%Y'),1259.97),
(17,303,2,2,1,STR_TO_DATE('7/28/2023','%m/%d/%Y'),STR_TO_DATE('7/29/2023','%m/%d/%Y'),199.99),
(18,305,2,1,0,STR_TO_DATE('8/30/2023','%m/%d/%Y'),STR_TO_DATE('9/1/2023','%m/%d/%Y'),349.98),
(19,208,1,2,0,STR_TO_DATE('9/16/2023','%m/%d/%Y'),STR_TO_DATE('9/17/2023','%m/%d/%Y'),149.99),
(20,203,4,2,2,STR_TO_DATE('9/13/2023','%m/%d/%Y'),STR_TO_DATE('9/15/2023','%m/%d/%Y'),399.98),
(20,401,3,2,2,STR_TO_DATE('11/22/2023','%m/%d/%Y'),STR_TO_DATE('11/25/2023','%m/%d/%Y'),1199.97),
(21,206,1,2,0,STR_TO_DATE('11/22/2023','%m/%d/%Y'),STR_TO_DATE('11/25/2023','%m/%d/%Y'),449.97),
(21,301,1,2,2,STR_TO_DATE('11/22/2023','%m/%d/%Y'),STR_TO_DATE('11/25/2023','%m/%d/%Y'),599.97),
(22,302,10,2,0,STR_TO_DATE('12/24/2023','%m/%d/%Y'),STR_TO_DATE('12/28/2023','%m/%d/%Y'),699.96);