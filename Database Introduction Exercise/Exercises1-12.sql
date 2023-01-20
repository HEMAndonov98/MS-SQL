CREATE DATABASE Minions;
USE Minions;

CREATE TABLE Minions(
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100),
    Age INT
);

CREATE TABLE Towns(
    Id INT IDENTITY(1,1),
    Name NVARCHAR(100)
);

ALTER TABLE Towns ADD PRIMARY KEY(Id);

ALTER TABLE Minions
ADD TownID INT;

ALTER TABLE Minions
ADD CONSTRAINT FK_TownOrder
FOREIGN KEY(TownID) REFERENCES Towns(Id);

-- Towns
-- Id Name
-- 1 Sofia
-- Plovdiv
-- 3 Varna

DROP TABLE Minions;
DROP Table Towns;

CREATE TABLE Towns(
    Id INT PRIMARY KEY,
    Name NVARCHAR(100)
);

CREATE TABLE Minions(
    Id INT PRIMARY KEY,
    Name NVARCHAR(100),
    Age INT,
    TownId INT FOREIGN KEY REFERENCES Towns(Id)
);

INSERT INTO Towns(Id, Name)
VALUES
(1, 'Sofia'),
(2, 'Plovdiv'),
(3, 'Varna');

-- Id Name Age TownId
-- 1 Kevin 22 1
-- 2 Bob 15 3 2
-- 3 Steward NULL 2

INSERT INTO Minions(Id, Name, Age, TownId)
VALUES
(1, 'Kevin', 22 , 1),
(2, 'Bob', 15, 3),
(3, 'Steward', NULL, 2);

DROP TABLE Minions;

CREATE TABLE People(
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(200) NOT NULL,
    Picture VARBINARY(MAX) CHECK (DATALENGTH(Picture) <= 2097152),
    Height DECIMAL(5, 2),
    Weight DEC(5, 2),
    Gender VARCHAR(1) CHECK (CHARINDEX('m', Gender) != 0 OR CHARINDEX('f', Gender) != 0),
    Birthdate DATETIME2,
    Biography NVARCHAR(MAX)
);

ALTER TABLE People
ALTER COLUMN Gender VARCHAR(1) NOT NULL;

INSERT INTO People(Name, Picture, Height, Weight, Gender, Birthdate, Biography)
VALUES
('Jhon', NULL, 165.33, 85.65, 'm', '1998-12-25', NULL),
('Sarah', NULL, 133.33, 55.85, 'f', '1999-06-03', NULL),
('Dwight', NULL, 156.48, 89.85, 'm', '1982-03-05', NULL),
('Smith', NULL, 148.90, 105.85, 'f', '1976-11-30', NULL),
('Carly', NULL, 143.36, 49.85, 'f', '1999-08-29', NULL);

CREATE TABLE Users(
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Username VARCHAR(30) NOT NULL,
    Password VARCHAR(26) NOT NULL,
    ProfilePiccture VARBINARY(MAX) CHECK (DATALENGTH(ProfilePiccture) <= 900000),
    LastLoginTime DATETIME2,
    IsDeleted BIT
)

ALTER TABLE Users
ADD CONSTRAINT df_IsDeleted
DEFAULT 0 FOR IsDeleted;


INSERT INTO Users(Username, [Password], IsDeleted)
VALUES
('Jhon', 'Jhon123', 1),
('Sarah', 'Sarah123', 0),
('Dwight', 'Shrute69', 0),
('Smith', 'Mr555999', 0),
('Carly', 'MistressGreatness', 1);

ALTER TABLE Users
DROP CONSTRAINT PK__Users__3214EC074CF3B115;

ALTER TABLE Users
ADD CONSTRAINT PK_Users PRIMARY KEY(Id, Username);

ALTER TABLE Users
ADD CONSTRAINT CHK_PasswordLength CHECK (LEN(Password) >= 5);

ALTER TABLE Users
ADD CONSTRAINT df_LastLoginTIme
DEFAULT CURRENT_TIMESTAMP FOR LastLoginTime;

-- 12.

ALTER TABLE Users
DROP CONSTRAINT PK_Users;

ALTER TABLE Users
ADD CONSTRAINT PK_Users_Id
PRIMARY KEY(Id);

ALTER TABLE Users
ADD CONSTRAINT CHK_UsernameLen
CHECK (LEN(Username) >= 3);

-- 13.
