USE [SoftUni]

GO

-- Problem 13

        SELECT [DepartmentID], 
           SUM([Salary])
            AS [TotalSalary]
          FROM [Employees]
      GROUP BY [DepartmentID]
      ORDER BY [DepartmentID]

GO

-- Problem 14

       SELECT [DepartmentID],
          MIN([Salary])
           AS [MinimumSalary]
         FROM [Employees]
        WHERE [HireDate] > '01-01-2000'
     GROUP BY [DepartmentID]
       HAVING [DepartmentID] IN (2, 5, 7)

GO

-- Problem 15

    SELECT * 
      INTO [NewTable]
      FROM [Employees]
     WHERE [Salary] >  30000 

GO

    DELETE 
      FROM [NewTable]
     WHERE [ManagerID] = 42

GO

    UPDATE [NewTable]
       SET [Salary] += 5000
     WHERE [DepartmentID] = 1


GO
     SELECT [DepartmentID],
        AVG([Salary])
         AS [AverageSalary]
       FROM [NewTable]
   GROUP BY [DepartmentID]

GO

DROP TABLE [NewTable]

GO

-- Problem 16

        SELECT [DepartmentID],
           MAX([Salary])
          FROM [Employees]
      GROUP BY [DepartmentID]
    HAVING MAX([Salary]) NOT BETWEEN 30000 AND 70000

GO

-- Problem 17

        SELECT COUNT(*)
            AS [Count]
          FROM [Employees]
         WHERE [ManagerID] IS NULL

GO


-- Problem 18

          SELECT
        DISTINCT [DepartmentID],
                 [Salary] 
              AS [ThirdHighestSalary]
            FROM 
                (
                    SELECT [DepartmentID],
                           [Salary],
                           DENSE_RANK() OVER(PARTITION BY [DepartmentID] ORDER BY [Salary] DESC)
                        AS [SalaryRanking]
                      FROM [Employees]
                ) 
            AS [SalaryRankingSubquery]
         WHERE [SalaryRanking] = 3

GO

-- Problem 19

-- My solution involves creating a table viea subquery where i display all the departments and their average salary
-- and joining it with the table employees by comparing the department ids
-- so in the joined table against every employee i have two additional columns
-- one of the id matching the id of the joined table and the other is the average salary for this department id
-- afterwards I only have to filter with a where clause so that i get the results im looking for

      SELECT
     TOP(10) [FirstName],
             [LastName],
             [e].[DepartmentID]
        FROM 
            (
                SELECT [DepartmentID],
                   AVG([Salary])
                    AS [AverageSalary]
                  FROM [Employees]
              GROUP BY [DepartmentID]
            ) 
         AS [AverageSalarySub]
       JOIN [Employees] 
         AS [e]
         ON [e].[DepartmentID] = [AverageSalarySub].[DepartmentID]
      WHERE [e].[Salary] > [AverageSalary]
   ORDER BY [e].[DepartmentID]

-- Solution 2

    SELECT 
   TOP(10) [e].[FirstName],
           [e].[LastName],
           [e].[DepartmentID]
      FROM [Employees]
        AS [e]
     WHERE [e].[Salary] > 
                            (
                                SELECT 
                                   AVG([Salary])
                                  FROM [Employees]
                                    AS [eSub]
                                 WHERE [eSub].[DepartmentID] = [e].[DepartmentID]
                              GROUP BY [DepartmentID]
                            )
 ORDER BY [e].[DepartmentID]
