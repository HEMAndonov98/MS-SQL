-- Towns (Id, Name)
-- • Addresses (Id, AddressText, TownId)
-- • Departments (Id, Name)
-- • Employees (Id, FirstName, MiddleName, LastName, JobTitle, DepartmentId, HireDate, Salary,
-- AddressId)

CREATE DATABASE SoftUni;
USE [SoftUni];

CREATE TABLE Towns(
    Id INT IDENTITY(1,1) PRIMARY KEY,
    [Name] NVARCHAR(50) NOT NULL
);

CREATE TABLE Addresses(
    Id INT IDENTITY(1,1) PRIMARY KEY,
    AdressText NVARCHAR(155) NOT NULL,
    TownId INT FOREIGN KEY REFERENCES Towns([Id]) NOT NULL
);

ALTER TABLE Addresses
ALTER COLUMN [TownId] INT;

CREATE TABLE Departments(
    Id INT IDENTITY(1,1) PRIMARY KEY,
    [Name] NVARCHAR(155) NOT NULL
)

CREATE TABLE Employees(
    Id INT IDENTITY(1,1) PRIMARY KEY,
    [FirstName] NVARCHAR(100) NOT NULL,
    [MiddleName] NVARCHAR(100),
    [LastName] NVARCHAR(100) NOT NULL,
    [JobTitle] NVARCHAR(100) NOT NULL,
    [DepartmentId] INT FOREIGN KEY REFERENCES Departments([Id]) NOT NULL,
    [HireDate] DATETIME2 NOT NULL,
    [Salary] DEC(10, 2),
    [AddressId] INT FOREIGN KEY REFERENCES Addresses([Id])
);