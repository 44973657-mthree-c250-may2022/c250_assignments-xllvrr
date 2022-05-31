CREATE DATABASE IF NOT EXISTS MovieCatalogue;

USE MovieCatalogue;

############################# Create Tables ########################################

CREATE TABLE IF NOT EXISTS Movie (
    MovieID INT PRIMARY KEY AUTO_INCREMENT,
    Title VARCHAR(128) NOT NULL,
    ReleaseDate DATE
);

CREATE TABLE IF NOT EXISTS Genre (
    GenreID INT PRIMARY KEY AUTO_INCREMENT,
    GenreName VARCHAR(30) NOT NULL
);

CREATE TABLE IF NOT EXISTS Director (
    DirectorID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(30) NOT NULL,
    LastName VARCHAR(30) NOT NULL,
    BirthDate DATE
);
    
CREATE TABLE IF NOT EXISTS Rating (
    RatingID INT PRIMARY KEY Auto_Increment,
    RatingName VARCHAR(5) NOT NULL
);

CREATE TABLE IF NOT EXISTS Actor (
    ActorID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(30) NOT NULL,
    Lastname VARCHAR(30) NOT NULL,
    BirthDate DATE
);

CREATE TABLE IF NOT EXISTS CastMembers (
    CastMemberID INT PRIMARY KEY AUTO_INCREMENT,
    ActorID INT NOT NULL,
    MovieID INT NOT NULL,
    Role VARCHAR(50) NOT NULL,
    CONSTRAINT `fk_cast_actor` FOREIGN KEY (ActorID)
    REFERENCES Actor(ActorID)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
    CONSTRAINT `fk_cast_movie` FOREIGN KEY (MovieID)
    REFERENCES Movie(MovieID)
    ON DELETE CASCADE
    ON UPDATE RESTRICT
);

ALTER TABLE Movie
	ADD COLUMN (
    GenreID INT NOT NULL,
    DirectorID INT,
    RatingID INT NOT NULL),
    ADD CONSTRAINT `fk_movie_genre` FOREIGN KEY (GenreID)
    REFERENCES Genre(GenreID)
	ON DELETE CASCADE
    ON UPDATE RESTRICT,
	ADD CONSTRAINT `fk_movie_director` FOREIGN KEY (DirectorID)
    REFERENCES Director(DirectorID)
	ON DELETE SET NULL
    ON UPDATE RESTRICT,
    ADD CONSTRAINT `fk_movie_rating` FOREIGN KEY (RatingID)
    REFERENCES Rating(RatingID)
	ON DELETE CASCADE
    ON UPDATE RESTRICT;
    
############################# Insert Values ########################################

INSERT INTO Actor (FirstName, LastName, BirthDate) VALUES
('Bill', 'Murray', STR_TO_DATE("9/21/1950", "%m/%d/%Y")),
('Dan', 'Aykroyd', STR_TO_DATE("7/1/1952", "%m/%d/%Y")),
('John', 'Candy', STR_TO_DATE("10/31/1950", "%m/%d/%Y")),
('Steve', 'Martin', NULL),
('Sylvester', 'Stallone', NULL)
;

INSERT INTO Director (FirstName, LastName, BirthDate) VALUES
('Ivan', 'Reitman', STR_TO_DATE("10/27/1946", "%m/%d/%Y")),
('Ted', 'Kotcheff', NULL)
;

INSERT INTO Rating (RatingName) VALUES ('G'), ('PG'), ('PG-13'), ('R');

INSERT INTO Genre (GenreName) VALUES
('Action'),
('Comedy'),
('Drama'),
('Horror');

INSERT INTO Movie (GenreID, DirectorID, RatingID, Title, ReleaseDate) VALUES
(1, 2, 4, 'Rambo: First Blood', STR_TO_DATE("10/22/1982", "%m/%d/%Y")),
(2, NULL, 4, 'Planes, Trains & Automobiles', STR_TO_DATE("11/25/1987", "%m/%d/%Y")),
(1, 2, 2, 'Ghostbusters', NULL),
(1, NULL, 2, 'The Great Outdoors', STR_TO_DATE("6/17/1988", "%m/%d/%Y"));

INSERT INTO CastMembers (ActorID, MovieID, Role) VALUES
(5, 1, "John Rambo"),
(4, 2, "Neil Page"),
(3, 2, "Del Griffith"),
(1, 3, "Dr Peter Venkman"),
(2, 3, "Dr Raymond Stanz"),
(2, 4, "Roman Craig"),
(3, 4, "Chet Ripley");

############################################ UPDATE DETAILS #################################################

UPDATE Movie SET
	Title = "Ghostbusters (1984)",
    ReleaseDate = STR_TO_DATE("6/8/1984", "%m/%d/%Y")
WHERE
	Title = "Ghostbusters";
    
DELETE FROM Movie
WHERE Title = "Rambo: First Blood";

ALTER TABLE Actor
	ADD COLUMN (DateofDeath Date);
    
UPDATE Actor SET
	DateofDeath = STR_TO_DATE("3/4/1994", "%m/%d/%Y")
WHERE
	FirstName = "John" AND Lastname = "Candy";