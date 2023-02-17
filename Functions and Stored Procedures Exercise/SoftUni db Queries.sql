USE [SoftUni]

GO

-- Problem 01

CREATE PROCEDURE [usp_GetEmployeesSalaryAbove35000]
              AS
                SELECT [FirstName], 
                       [LastName]
                  FROM [Employees]
                 WHERE [Salary] > 35000;

GO

-- Problem 02

CREATE PROCEDURE [usp_GetEmployeesSalaryAboveNumber] (@v_Salary DEC(18,4))
              AS 
                SELECT [FirstName],
                       [LastName]
                  FROM [Employees]
                 WHERE [Salary] >= @v_Salary;

GO

-- Problem 03

CREATE PROCEDURE [usp_GetTownsStartingWith] (@v_startLetter NVARCHAR(50))
              AS 
                SELECT [Name]
                  FROM [Towns]
                 WHERE [Name] LIKE CONCAT(@v_startLetter, '%');

GO

-- Problem 04

CREATE PROCEDURE [usp_GetEmployeesFromTown] (@v_townName NVARCHAR(50))
              AS
                SELECT [e].[FirstName] AS [First Name],
                       [e].[LastName] AS [Last Name]
                  FROM [Employees]
                    AS [e]
                  JOIN [Addresses]
                    AS [a]
                    ON [e].[AddressID] = [a].[AddressID]
                  JOIN [Towns]
                    AS [t]
                    ON [a].[TownID] = [t].[TownID]
                 WHERE [t].[Name] = @v_townName;


GO

-- Problem 05

CREATE FUNCTION [ufn_GetSalaryLevel] (@salary DECIMAL(18,4))
        RETURNS VARCHAR(10)
             AS
               BEGIN
                    DECLARE @p_salaryLevel VARCHAR(10) = 'Low'

                    BEGIN
                          IF @salary BETWEEN 30000 AND 50000
                         SET @p_salaryLevel = 'Average'
                        ELSE IF @salary > 50000
                         SET @p_salaryLevel = 'High'
                      END
                    RETURN @p_salaryLevel
               END;
GO

-- Problem 06

CREATE PROCEDURE [usp_EmployeesBySalaryLevel] (@p_salaryLevel VARCHAR(10))
              AS 
                SELECT [FirstName] AS [First Name],
                       [LastName] AS [Last Name]
                  FROM [Employees]
                 WHERE [dbo].[ufn_GetSalaryLevel] ([Salary]) = @p_salaryLevel;

GO

-- Problem 07

CREATE OR ALTER FUNCTION [ufn_IsWordComprised] (@setOfLetters NVARCHAR(50), @word NVARCHAR(50))
RETURNS BIT
    AS
    BEGIN
            DECLARE @wordIndex INT = 1
            WHILE(@wordIndex <= LEN(@word))
            BEGIN
                 DECLARE @currentCharacter CHAR = SUBSTRING(@word, @wordIndex, 1)
                 IF(CHARINDEX(@currentCharacter, @setOfLetters) = 0)
                 BEGIN
                        RETURN 0;
                 END
                 SET @wordIndex += 1
            END
            
            RETURN 1
    END;
     

GO

-- Problem 08

CREATE PROCEDURE [usp_DeleteEmployeesFromDepartment] (@departmentId INT)
              AS
           BEGIN
                DECLARE @employeesToDelete TABLE ([Id] INT)

                INSERT INTO @employeesToDelete 
                                  SELECT [EmployeeID] 
                                    FROM [Employees]
                                   WHERE [DepartmentID] = @departmentId


               DELETE FROM [EmployeesProjects]
               WHERE [EmployeeID] IN 
                                    (
                                        SELECT [Id]
                                          FROM @employeesToDelete
                                    );


             ALTER TABLE [Departments]
             ALTER COLUMN [ManagerID] INT 

             UPDATE [Departments]
                SET [ManagerID] = NULL
              WHERE [ManagerID] IN 
                                    (
                                        SELECT [Id]
                                         FROM @employeesToDelete
                                    );

            UPDATE [Employees]
               SET [ManagerID] = NULL
             WHERE [ManagerID] IN 
                                    (
                                        SELECT [Id]
                                          FROM @employeesToDelete
                                    );


            DELETE FROM [Employees]
            WHERE [DepartmentID] = @departmentId;

            DELETE FROM [Departments]
            WHERE [DepartmentID] = @departmentId;

            SELECT COUNT(*)
             FROM [Employees]
            WHERE [DepartmentID] = @departmentId
            END

GO

SELECT COUNT(*) FROM [Employees] WHERE [DepartmentID] = 1