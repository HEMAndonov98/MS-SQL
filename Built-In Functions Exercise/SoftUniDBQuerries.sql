USE [SoftUni]
GO

-- Problem 1

SELECT [FirstName], [LastName]
FROM [Employees]
WHERE LEFT([FirstName], 2) = 'Sa'

GO

-- Problem 2

-- solution 1
SELECT [FirstName], [LastName]
FROM [Employees]
WHERE [LastName] LIKE '%ei%'

GO

-- solution 2
SELECT [FirstName], [LastName]
FROM [Employees]
WHERE CHARINDEX('ei', [LastName]) > 0

GO 

-- Problem 3

    SELECT [FirstName]
      FROM [Employees]
     WHERE [DepartmentID] IN (3, 10)
       AND DATEPART(YEAR, [HireDate]) BETWEEN 1995 AND 2005

GO

-- Problem 4

-- solution 1
SELECT [FirstName],
       [LastName]
  FROM [Employees]
 WHERE [JobTitle] NOT LIKE '%engineer%'

GO
 -- solution 2
 SELECT [FirstName],
        [LastName]
   FROM [Employees]
  WHERE CHARINDEX('engineer', [JobTitle]) = 0

GO

-- Problem 5

    SELECT [Name]
    FROM [Towns]
    WHERE LEN([Name]) BETWEEN 5 AND 6
 ORDER BY [Name]

GO

 -- Problem 6

    SELECT [TownID],
           [Name]
      FROM [Towns]
     WHERE LEFT([Name], 1) IN ('M', 'K', 'B', 'E')
  ORDER BY [Name]

GO

-- Problem 7

    SELECT [TownID],
           [Name]
      FROM [Towns]
     WHERE LEFT([Name], 1) NOT IN('R', 'B', 'D')
  ORDER BY [Name]

GO

-- Problem 8

CREATE VIEW [V_EmployeesHiredAfter2000] AS
SELECT [FirstName],
       [LastName]
 FROM [Employees]
WHERE DATEPART(YEAR, [HireDate]) > 2000;

GO
-- Problem 9

SELECT [FirstName],
       [LastName]
  FROM [Employees]
 WHERE LEN([LastName]) = 5

GO

-- Problem 10

    SELECT [EmployeeID],
           [FirstName],
           [LastName],
           [Salary],
           DENSE_RANK() OVER (PARTITION BY [Salary] ORDER BY [EmployeeID] ASC) AS Rank
      FROM [Employees]
     WHERE [Salary] BETWEEN 10000 AND 50000
  ORDER BY [Salary] DESC

GO

-- Problem 11

    SELECT e.[EmployeeID],
            e.[FirstName],
            e.[LastName],
            e.[Salary],
            e.[Rank]
     FROM   
            (
         SELECT [EmployeeID],
                [FirstName],
                [LastName],
                [Salary],
                DENSE_RANK() OVER (PARTITION BY [Salary] ORDER BY [EmployeeID] ASC) AS [Rank]
           FROM [Employees]
          WHERE [Salary] BETWEEN 10000 AND 50000) AS e
    WHERE [Rank] = 2
 ORDER BY [Salary] DESC

 GO

