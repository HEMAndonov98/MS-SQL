CREATE DATABASE [EntityRelationsDemo2023]

GO

USE [EntityRelationsDemo2023]

GO

CREATE TABLE [Passports](
    [PassportID] INT IDENTITY(101, 1) PRIMARY KEY,
    [PassportNumber] NVARCHAR(20)
)

GO

--PersonID	FirstName	Salary	PassportID

CREATE TABLE [Persons](
    [PersonID] INT NOT NULL,
    [FirstName] NVARCHAR(50),
    [Salary] DEC(8,2),
    [PassportID] INT NOT NULL
)

GO


ALTER TABLE [Persons]
ADD CONSTRAINT PK_PersonID PRIMARY KEY (PersonID);

ALTER TABLE [Persons]
ADD CONSTRAINT FK_PassportsID
FOREIGN KEY([PassportID]) REFERENCES [Passports]([PassportID])


GO

INSERT INTO [Passports]([PassportNumber])
VALUES
     ('N34FG21B')
    ,('K65LO4R7')
    ,('ZE657QP2');


INSERT INTO [Persons]
VALUES
    (1, 'Roberto', 43300.00, 102),
    (2,	'Tom', 56100.00, 103),
    (3,	'Yana',	60200.00, 101);

GO



