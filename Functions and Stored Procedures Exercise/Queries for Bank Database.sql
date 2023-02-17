USE Bank

GO
-- Problem 09

CREATE PROCEDURE [usp_GetHoldersFullName]
              AS
           BEGIN
                SELECT CONCAT_WS(' ', [FirstName], [LastName])
                  FROM [AccountHolders]

             END

GO

-- Problem 10

CREATE PROCEDURE [usp_GetHoldersWithBalanceHigherThan] (@p_money MONEY)
              AS
           BEGIN
                SELECT [FirstName] AS [First Name],
                       [LastName] AS [Last Name]
                  FROM 
                        (
                            SELECT DISTINCT [FirstName],
                                            [LastName],
                                        SUM([Balance]) OVER (PARTITION BY [ah].[Id]) AS [Total Money]
                                       FROM [Accounts]
                                         AS [a]
                                       JOIN [AccountHolders]
                                         AS [ah]
                                         ON [a].[AccountHolderId] = [ah].[Id]
                        ) AS [totalMoneySub]
                 WHERE [Total Money] > @p_money
              ORDER BY [First Name],
                       [Last Name]


             END
GO

-- Problem 11


CREATE OR ALTER FUNCTION [ufn_CalculateFutureValue] (@p_sum DECIMAL(12,2), @p_yearlyInterestRate FLOAT, @p_years INT)
RETURNS DECIMAL(12, 4)
     AS 
        BEGIN
            DECLARE @v_interest FLOAT = @p_yearlyInterestRate + 1;
            DECLARE @v_futureValue DECIMAL(12,4) = @p_sum * POWER(@v_interest, @p_years)
            RETURN ROUND(@v_futureValue, 4)
        END;

GO

-- Problem 12

CREATE PROCEDURE [usp_CalculateFutureValueForAccount] (@p_acountId INT, @p_yearlyInterestRate FLOAT)
              AS
                BEGIN
                     SELECT [ah].[Id] AS [Account Id],
                            [ah].[FirstName] AS [First Name],
                            [ah].[LastName] AS [Last Name],
                            [a].[Balance] AS [Current Balance],
                            [dbo].[ufn_CalculateFutureValue] ([a].[Balance], @p_yearlyInterestRate, 5) AS [Balance in 5 years]
                       FROM [AccountHolders]
                         AS [ah]
                       JOIN [Accounts]
                         AS [a]
                         ON [ah].[Id] = [a].[AccountHolderId]
                      WHERE [a].[Id] = @p_acountId

                END;

GO