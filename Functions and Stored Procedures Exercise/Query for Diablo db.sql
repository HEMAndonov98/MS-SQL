-- Problem 13

USE [Diablo]

GO

CREATE FUNCTION [ufn_CashInUsersGames] (@p_gameName NVARCHAR(50))
        RETURNS TABLE
                   AS
               RETURN 
                        (
                            SELECT SUM([Cash]) AS [SumCash]
                              FROM 
                                    (
                                       SELECT [ug].[Cash],
                                       ROW_NUMBER() OVER (ORDER BY [ug].[Cash] DESC) AS [Rows]
                                         FROM [Games]
                                           AS [g]
                                         JOIN [UsersGames]
                                           AS [ug]
                                           ON [g].[Id] = [ug].[GameId]
                                        WHERE [g].[Name] = @p_gameName
                                    ) 
                                AS [GameRowsCashSubquery]
                             WHERE [Rows] % 2 <> 0
                        )

GO
