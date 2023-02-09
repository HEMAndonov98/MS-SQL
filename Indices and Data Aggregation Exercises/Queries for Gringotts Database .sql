USE [Gringotts]

GO

-- Problem 01

    SELECT 
    COUNT(*)
      AS [Count]
    FROM [WizzardDeposits]

GO

-- Problem 02

    SELECT
      MAX([MagicWandSize])
        AS [LongestMagicWand]
      FROM [WizzardDeposits]

GO
-- Problem 03

    SELECT [DepositGroup],
       MAX([MagicWandSize])
        AS [LongestMagicWand]
      FROM [WizzardDeposits]
  GROUP BY [DepositGroup]

GO

-- Problem 04

    SELECT 
   TOP (2) [DepositGroup]
      FROM [WizzardDeposits]
  GROUP BY [DepositGroup]
  ORDER BY AVG([MagicWandSize]) ASC

GO

-- Problem 05

    SELECT [DepositGroup],
       SUM([DepositAmount])
        AS [TotalSum]
      FROM [WizzardDeposits]
  GROUP BY [DepositGroup]

GO

-- Problem 06

    SELECT [DepositGroup],
       SUM([DepositAmount])
        AS [TotalSum]
      FROM [WizzardDeposits]
     WHERE [MagicWandCreator] = 'Ollivander family'
  GROUP BY [DepositGroup]

GO


-- Problem 07

    SELECT [DepositGroup],
       SUM([DepositAmount])
        AS [TotalSum]
      FROM [WizzardDeposits]
     WHERE [MagicWandCreator] = 'Ollivander family'
  GROUP BY [DepositGroup]
HAVING SUM([DepositAmount]) < 150000
  ORDER BY [TotalSum] DESC

GO

-- Problem 08

    SELECT [DepositGroup],
           [MagicWandCreator],
       MIN([DepositCharge])
        AS [MinDepositCharge]
      FROM [WizzardDeposits]
  GROUP BY [DepositGroup],
           [MagicWandCreator]
  ORDER BY [MagicWandCreator] ASC,
           [DepositGroup]

GO

-- Problem 09

          SELECT [AgeGroup],
          COUNT (*)
              AS [WizzardCount]
            FROM 
                (
                        SELECT 
                          CASE 
                                WHEN [Age] BETWEEN 0 AND 10 THEN '[0-10]'
                                WHEN [Age] BETWEEN 11 AND 20 THEN '[11-20]'
                                WHEN [Age] BETWEEN 21 AND 30 THEN '[21-30]'
                                WHEN [Age] BETWEEN 31 AND 40 THEN '[31-40]'
                                WHEN [Age] BETWEEN 41 AND 50 THEN '[41-50]'
                                WHEN [Age] BETWEEN 51 AND 60 THEN '[51-60]'
                                ELSE '[61+]'
                          END
                           AS [AgeGroup]
                         FROM [WizzardDeposits]
                )
              AS [AgeGroupSuq]
        GROUP BY [AgeGroup]

GO

-- Problem 10

        SELECT 
      DISTINCT 
          LEFT([FirstName], 1)
            AS [FirstLetter]
          FROM [WizzardDeposits]
         WHERE [DepositGroup] = 'Troll Chest' 
      ORDER BY [FirstLetter]	  

GO

-- Problem 11

      SELECT [DepositGroup],
             [IsDepositExpired],
         AVG([DepositInterest])
          AS [AverageInterest]
        FROM [WizzardDeposits]
       WHERE [DepositStartDate] > '01-01-1985'
    GROUP BY [DepositGroup],
             [IsDepositExpired]
    ORDER BY [DepositGroup] DESC,
             [IsDepositExpired] ASC

GO


-- Problem 12

-- Solution 1

      SELECT [wd1].[DepositAmount]
          AS [Host Wizard deposit],
             [wd2].[DepositAmount]
          AS [Guest Wizard deposit]
        FROM [WizzardDeposits]
          AS [wd1]
  INNER JOIN [WizzardDeposits]
          AS [wd2]
          ON [wd1].[Id] + 1 = [wd2].[Id]


      SELECT 
         SUM([Host Wizard deposit] - [Guest Wizard deposit])
          AS [SumDifference]
        FROM 
            (
                    SELECT [wd1].[DepositAmount]
                        AS [Host Wizard deposit],
                           [wd2].[DepositAmount]
                        AS [Guest Wizard deposit]
                      FROM [WizzardDeposits]
                        AS [wd1]
                INNER JOIN [WizzardDeposits]
                        AS [wd2]
                        ON [wd1].[Id] + 1 = [wd2].[Id]
            ) AS [WizardDepositsSubquery]
GO

-- Solution 2


        SELECT 
           SUM([Difference])
           AS [SumDifference]
         FROM 
            (
                      SELECT 
                            [DepositAmount] - LEAD([DepositAmount]) OVER(ORDER BY [Id])
                         AS [Difference]
                        FROM [WizzardDeposits]
            ) AS [DifferenceSuvquery]

GO


