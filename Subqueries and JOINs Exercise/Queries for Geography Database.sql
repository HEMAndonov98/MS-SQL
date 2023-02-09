USE [Geography]

GO 

-- Problem 12

        SELECT [mc].[CountryCode],
               [m].[MountainRange],
               [p].[PeakName],
               [p].[Elevation]
          FROM [Countries]
            AS [c]
    INNER JOIN [MountainsCountries]
            AS [mc]
            ON [c].[CountryCode] = [mc].[CountryCode]
    INNER JOIN [Mountains]
            AS [m]
            ON [mc].[MountainId] = [m].[Id]
    INNER JOIN [Peaks]
            AS [p]
            ON [p].[MountainId] = [m].[Id]
         WHERE [c].[CountryName] = 'Bulgaria'
           AND [p].[Elevation] > 2835
      ORDER BY [p].[Elevation] DESC

GO

-- Problem 13

        SELECT [c].[CountryCode],
        COUNT([m].[MountainRange])
            AS [MountainRanges]
          FROM [Countries]
            AS [c]
    LEFT JOIN [MountainsCountries]
           AS [mc]
           ON [mc].[CountryCode] = [c].[CountryCode]
    LEFT JOIN [Mountains]
           AS [m]
           ON [mc].[MountainId] = [m].[Id]
        WHERE [c].[CountryName] IN ('United States', 'Russia', 'Bulgaria')
     GROUP BY [c].[CountryCode]

GO

     -- Technically you dont need to join with mountains table
     -- because the maping table already holds all mountain range ids for a given country
     -- so you can just use it for the count function and shorten the query

        SELECT [c].[CountryCode],
        COUNT([mc].[MountainId])
            AS [MountainRanges]
          FROM [Countries]
            AS [c]
    LEFT JOIN [MountainsCountries] -- Left join because there are countries without any mountains and we want to reflect them in the result
           AS [mc]
           ON [mc].[CountryCode] = [c].[CountryCode]
        WHERE [c].[CountryName] IN ('United States', 'Russia', 'Bulgaria')
     GROUP BY [c].[CountryCode]

GO

-- third way of solving with subquery

     SELECT [CountryCode],
        COUNT([MountainId]) AS [MountainRanges]
       FROM [MountainsCountries]
      WHERE [CountryCode] IN 
                            (
                                SELECT [CountryCode]
                                  FROM [Countries]
                                 WHERE [CountryName] IN ('United States', 'Russia', 'Bulgaria')
                            )
   GROUP BY [CountryCode]


-- forth method using HAVING and subquery

     SELECT [CountryCode],
        COUNT([MountainId]) AS [MountainRanges]
       FROM [MountainsCountries]
   GROUP BY [CountryCode]
     HAVING [CountryCode] IN 
                            (
                                SELECT [CountryCode]
                                  FROM [Countries]
                                 WHERE [CountryName] IN ('United States', 'Russia', 'Bulgaria')
                            )

GO


-- Problem 14

        SELECT 
      TOP (5) [c].[CountryName],
              [r].[RiverName]
         FROM [Countries]
           AS [c]
    LEFT JOIN [CountriesRivers]
           AS [cr]
           ON [cr].[CountryCode] = [c].[CountryCode]
    LEFT JOIN [Rivers]
           AS [r]
           ON [cr].[RiverId] = [r].[Id]
        WHERE [c].[ContinentCode] = -- Because I do not need any fields from the continents table just to use if as a reference I didn't include it in a JOIN
                                    (
                                        SELECT [ContinentCode]
                                          FROM [Continents]
                                         WHERE [ContinentName] = 'Africa'
                                    )
     ORDER BY [c].[CountryName] ASC

-- Problem 15

  -- Part 1 of Solution finding how many times each continent uses a given currency
        SELECT [ContinentCode], 
               [CurrencyCode],
               COUNT([CurrencyCode]) 
            AS [CurrencyUsage]
          FROM [Countries]
      GROUP BY [ContinentCode], [CurrencyCode]
        HAVING COUNT(*) > 1

-- Part 2 of Solution ranking the currency usage so that we can see which is used the most
        SELECT *,
        DENSE_RANK() OVER (PARTITION BY [ContinentCode] ORDER BY [CurrencyUsage] DESC)
            AS [CurrencyUsageRank]
          FROM 
            (
                SELECT [ContinentCode], 
                       [CurrencyCode],
                        COUNT(*) 
                   AS [CurrencyUsage]
                 FROM [Countries]
             GROUP BY [ContinentCode], [CurrencyCode]
               HAVING COUNT(*) > 1
            ) AS [CurrencyUsageSubquery]


-- Part 3 Filtering so that we can see the needed data and only the most used currencies
        SELECT [ContinentCode],
               [CurrencyCode],
               [CurrencyUsage]
          FROM 
                (
                    SELECT *,
                     DENSE_RANK() OVER (PARTITION BY [ContinentCode] ORDER BY [CurrencyUsage] DESC)
                        AS [CurrencyUsageRank]
                      FROM 
                            (
                              SELECT [ContinentCode], 
                                     [CurrencyCode],
                                     COUNT(*) 
                                  AS [CurrencyUsage]
                                FROM [Countries]
                            GROUP BY [ContinentCode], [CurrencyCode]
                            HAVING COUNT(*) > 1
                            ) 
                        AS [CurrencyUsageSubquery]
                ) 
            AS [CurrencyUsageRankSubquery]
         WHERE [CurrencyUsageRank] = 1
      ORDER BY [ContinentCode]

GO

-- Problem 16


         SELECT COUNT(*)
            AS [Count]
          FROM [Countries]
            AS [c]
     LEFT JOIN [MountainsCountries]
            AS [mc]
            ON [mc].[CountryCode] = [c].[CountryCode]
         WHERE [mc].[MountainId] IS NULL

GO

-- Problem 17


        SELECT 
        TOP(5)    [c].[CountryName],
                  MAX([p].[Elevation])
               AS [HighestPeakElevation],
                  MAX([r].[Length])
                AS [LongestRiverLength]
              FROM [Countries]
                AS [c]
         LEFT JOIN [MountainsCountries]
                AS [mc]
                ON [mc].[CountryCode] = [c].[CountryCode]
         LEFT JOIN [Mountains]
                AS [m]
                ON [mc].[MountainId] = [m].[Id]
         LEFT JOIN [Peaks]
                AS [p]
                ON [p].[MountainId] = [m].[Id]
         LEFT JOIN [CountriesRivers]
                AS [cr]
                ON [cr].[CountryCode] = [c].[CountryCode]
         LEFT JOIN [Rivers]
                AS [r]
                ON [cr].[RiverId] = [r].[Id]
          GROUP BY [c].[CountryName]
          ORDER BY [HighestPeakElevation] DESC,
                   [LongestRiverLength] DESC,
                   [c].[CountryName]

-- Problem 18

          SELECT 
          TOP (5) [CountryName] 
               AS [Country],
           ISNULL([PeakName], '(no highest peak)')
               AS [Highest Peak Name],
           ISNULL([Elevation], 0)
               AS [Highest Peak Elevation],
           ISNULL([MountainRange], '(no mountain)')
            FROM 
                (
                   SELECT [c].[CountryName],
                          [p].[PeakName],
                          [p].[Elevation],
                          [m].[MountainRange],
                      DENSE_RANK() OVER (PARTITION BY [c].[CountryName] ORDER BY [p].[Elevation] DESC)
                        AS [PeakRank]
                      FROM [Countries]
                        AS [c]
                 LEFT JOIN [MountainsCountries]
                        AS [mc]
                        ON [mc].[CountryCode] = [c].[CountryCode]
                 LEFT JOIN [Mountains]
                        AS [m]
                        ON [mc].[MountainId] = [m].[Id]
                 LEFT JOIN [Peaks]
                        AS [p]
                        ON [p].[MountainId] = [m].[Id]
                ) 
             AS [PeakRankSubquery]
          WHERE [PeakRank] = 1
       ORDER BY [CountryName],
                [Highest Peak Name]