USE SoftUni
GO

SELECT * FROM Departments
GO

SELECT [Name]
FROM Departments
GO

SELECT [FirstName], [LastName], [Salary]
FROM Employees
GO

SELECT [FirstName], [MiddleName], [LastName]
FROM Employees
GO

SELECT CONCAT([FirstName] + '.', [LastName], '@', 'softuni.bg')
AS [Full Email Address]
FROM Employees
GO

SELECT DISTINCT [Salary]
FROM Employees
GO

SELECT *
FROM Employees
WHERE [JobTitle] = 'Sales Representative'
GO

SELECT [FirstName], [LastName], [JobTitle]
FROM Employees
WHERE [Salary] BETWEEN 20000 AND 30000
GO

SELECT CONCAT([FirstName] + ' ', [MiddleName] + ' ', [LastName] )
AS [Full Name]
FROM Employees
WHERE [Salary] IN(25000, 14000, 12500, 23600)
GO

SELECT [FirstName], [LastName]
FROM Employees
WHERE [ManagerID] IS NULL
GO

SELECT [FirstName], [LastName], [Salary]
FROM Employees
WHERE [Salary] > 50000
ORDER BY [Salary] DESC
GO

SELECT TOP(5) [FirstName], [LastName]
FROM Employees
ORDER BY [Salary] DESC
GO

SELECT [FirstName], [LastName]
FROM Employees
WHERE [DepartmentID] NOT IN(
    SELECT [DepartmentID]
    FROM Departments
    WHERE [Name] = 'Marketing'
    )
GO

SELECT *
FROM Employees
ORDER BY 
[Salary] DESC,
[FirstName] ASC,
[LastName] DESC,
[MiddleName] ASC
GO

CREATE VIEW v_EmployeesSalaries
AS
    SELECT [FirstName], [LastName], [Salary]
    FROM Employees
GO

SELECT * FROM v_EmployeesSalaries
GO

CREATE VIEW v_EmployeeNameJobTitle
AS 
    SELECT [FirstName] + ' ' + ISNULL([MiddleName], '') + ' ' + [LastName]
    AS [Full Name],
    [JobTitle]
    FROM Employees
GO

SELECT * FROM v_EmployeeNameJobTitle
GO

SELECT DISTINCT [JobTitle]
FROM Employees
GO

SELECT TOP(10) * 
FROM Projects
ORDER BY [StartDate] ASC,
[Name] ASC
GO

SELECT TOP(7) [FirstName], [LastName], [HireDate]
FROM Employees
ORDER BY [HireDate] DESC
GO

SELECT [FirstName], [LastName], [Salary] 
FROM Employees
WHERE [DepartmentID] IN(
    SELECT [DepartmentID]
    FROM Departments
    WHERE [Name] IN('Engineering', 'Tool Design', 'Marketing', 'Information Services')
)
GO

BEGIN TRANSACTION
GO

UPDATE Employees
SET [Salary] += [Salary] * 0.12
WHERE [DepartmentID] IN(
    SELECT [DepartmentID]
    FROM Departments
    WHERE [Name] IN('Engineering', 'Tool Design', 'Marketing', 'Information Services')
)

SELECT [Salary]
FROM Employees
ROLLBACK

USE [Geography]
GO

SELECT [PeakName]
FROM Peaks
ORDER BY [PeakName] ASC
GO

SELECT TOP(30) [CountryName], [Population]
FROM Countries
WHERE [ContinentCode] = (
    SELECT [ContinentCode] 
    FROM Continents 
    WHERE [ContinentName] = 'Europe'
    )
ORDER BY [Population] DESC,
[CountryName] ASC
GO


SELECT  [CountryName],
        [CountryCode],
        [CurrencyCode] ,
        CASE [CurrencyCode]
        WHEN 'EUR' THEN 'Euro'
        ELSE 'Not Euro'
        END
        AS [Currency]
      FROM [Countries]
  ORDER BY [CountryName] ASC
GO

USE Diablo
GO

SELECT [Name]
FROM Characters
ORDER BY [Name]
GO