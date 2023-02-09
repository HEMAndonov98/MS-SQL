USE [SoftUni]

GO

-- Problem 01

    SELECT
    TOP(5) [e].[EmployeeID],
           [e].[JobTitle],
           [a].[AddressID],
           [a].[AddressText]
      FROM [Employees]
        AS [e]
INNER JOIN  [Addresses]
        AS [a]
        ON [e].[AddressID] = [a].[AddressID]
  ORDER BY [e].[AddressID]

GO

-- Problem 02

    SELECT 
  TOP (50) [e].[FirstName],
           [e].[LastName],
           [t].[Name] AS [Town],
           [a].[AddressText]
      FROM [Employees]
        AS [e]
INNER JOIN [Addresses]
        AS [a]
        ON [e].[AddressID] = [a].[AddressID]
INNER JOIN [Towns]
        AS [t]
        ON [a].[TownID] = [t].[TownID]
  ORDER BY [e].[FirstName] ASC,
           [e].[LastName]

GO

-- Problem 03

    SELECT [e].[EmployeeID],
           [e].[FirstName],
           [e].[LastName],
           [d].[Name]
      FROM [Employees] 
        AS [e]
INNER JOIN [Departments]
        AS [d]
        ON [e].[DepartmentID] = [d].[DepartmentID]
     WHERE [d].[Name] = 'Sales'
  ORDER BY [e].[EmployeeID] ASC

GO

-- Problem 04

    SELECT 
    TOP (5) [e].[EmployeeID],
            [e].[FirstName],
            [e]. [Salary],
            [d].[Name]
      FROM [Employees]
        AS [e]
INNER JOIN [Departments]
        AS [d]
        ON [e].[DepartmentID] = [d].[DepartmentID]
     WHERE [e].[Salary] > 15000
  ORDER BY [d].[DepartmentID]

GO

-- Problem 05

    SELECT 
   TOP (3) [e].[EmployeeID],
           [e].[FirstName]
      FROM [Employees] 
        AS [e]
 LEFT JOIN [EmployeesProjects]
        AS [ep]
        ON [e].[EmployeeID] = [ep].[EmployeeID]
     WHERE [ep].[EmployeeID] IS NULL
  ORDER BY [e].[EmployeeID]

GO

-- Problem 06

    SELECT [e].[FirstName],
           [e].[LastName],
           [e].[HireDate],
           [d].[Name] AS [DeptName]
      FROM [Employees]
        AS [e]
INNER JOIN [Departments]
        AS [d]
        ON [e].[DepartmentID] = [d].[DepartmentID]
     WHERE [e].[HireDate] > '01-01-1999'
       AND [d].[Name] IN ('Sales', 'Finance')
  ORDER BY [e].[HireDate] ASC

GO

-- Problem 07

      SELECT 
      TOP (5) [e].[EmployeeID],
              [e].[FirstName],
              [p].[Name] AS [ProjectName]
         FROM [Employees]
           AS [e]
   INNER JOIN [EmployeesProjects]
           AS [ep]
           ON [e].[EmployeeID] = [ep].[EmployeeID]
   INNER JOIN [Projects]
           AS [p]
           ON [ep].[ProjectID] = [p].[ProjectID]
        WHERE [p].[StartDate] > '08-13-2002'
          AND [p].[EndDate] IS NULL
     ORDER BY [e].[EmployeeID] ASC

GO


-- Problem 08

        SELECT [e].[EmployeeID],
               [e].[FirstName],
          CASE
                WHEN DATEPART(YEAR, [p].[StartDate]) >= 2005 THEN NULL
                ELSE [p].[NAME]
           END 
           AS [ProjectName]
          FROM [Employees]
            AS [e]
    INNER JOIN [EmployeesProjects]
            AS [ep]
            ON [e].[EmployeeID] = [ep].[EmployeeID]
    INNER JOIN [Projects]
            AS [p]
            ON [ep].[ProjectID] = [p].[ProjectID]
         WHERE [e].[EmployeeID] = 24

GO

-- Problem 09

    SELECT [e].[EmployeeID],
           [e].[FirstName],
           [e].[ManagerID],
           [em].[FirstName]
      FROM [Employees]
        AS [e]
INNER JOIN [Employees]
        AS [em]
        ON [e].[ManagerID] = [em].[EmployeeID]
     WHERE [em].[EmployeeID] IN (3, 7)
  ORDER BY [e].[EmployeeID] ASC

GO


-- Problem 10

        SELECT 
      TOP (50) [e].[EmployeeID],
      CONCAT_WS(' ', [e].[FirstName], [e].[LastName]) AS [EmployeeName],
      CONCAT_WS(' ', [em].[FirstName], [em].[LastName]) AS [ManagerName],
               [d].[Name] AS [DepartmentName] 
          FROM [Employees]
            AS [e]
    INNER JOIN [Employees]
            AS [em]
            ON [e].[ManagerID] = [em].[EmployeeID]
     LEFT JOIN [Departments]
            AS [d]
            ON [e].[DepartmentID] = [d].[DepartmentID]
      ORDER BY [e].[EmployeeID]

GO

-- Problem 11

 -- Without subquery
        SELECT 
        TOP(1) AVG([e].Salary) AS [MinAverageSalary]
          FROM [Employees]
            AS [e]
    INNER JOIN [Departments]
            AS [d]
            ON [e].[DepartmentID] = [d].[DepartmentID]
      GROUP BY [d].[Name]
      ORDER BY [MinAverageSalary]

GO
 -- With subquery
      SELECT 
        MIN([MinAverage].[MinAverageS]) 
          AS [MinAverageSalary]
        FROM 
            (
                        SELECT AVG([e].Salary) AS [MinAverageS]
                          FROM [Employees]
                            AS [e]
                    INNER JOIN [Departments]
                            AS [d]
                            ON [e].[DepartmentID] = [d].[DepartmentID]
                      GROUP BY [d].[Name]
            )
          AS [MinAverage]

GO