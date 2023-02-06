USE [Diablo]

GO

-- Problem 14

-- more readable if using format() function but CLR must be enabled to work.

    SELECT TOP(50)
            [Name],
            CONVERT(varchar(20), [Start], 23) AS [Start]
       FROM [Games]
      WHERE DATEPART(YEAR, [Start]) BETWEEN 2011 AND 2012
   ORDER BY [Start] ASC,
            [Name] ASC

GO

-- Problem 15

    SELECT [Username],
           SUBSTRING([Email], CHARINDEX('@', [Email]) + 1, LEN([Email]) - CHARINDEX('@', [Email]) + 1) AS [Email Provider]
      FROM [Users]
  ORDER BY [Email Provider],
           [Username]

GO

-- Problem 16

    SELECT [Username],
           [IpAddress] AS [IP Address]
      FROM [Users]
     WHERE [IpAddress] LIKE '___.1%.%.___'
  ORDER BY [Username]

GO

-- Problem 17

    SELECT [Name] AS [Game],
           CASE 
                WHEN DATEPART(HOUR, [Start]) BETWEEN 0 AND 11 THEN 'Morning'
                WHEN DATEPART(HOUR, [Start]) BETWEEN 12 AND 17 THEN 'Afternoon'
                WHEN DATEPART(HOUR, [Start]) BETWEEN 18 AND 23 THEN 'Evening'
            END AS [Part of the Day],
           CASE
                WHEN [Duration] BETWEEN 0 AND 3 THEN 'Extra Short'
                WHEN [Duration] BETWEEN 4 AND 6 THEN 'Short'
                WHEN [Duration] > 6 THEN 'Long'
                WHEN [Duration] IS NULL THEN 'Extra Long'
            END AS [Duration]
      FROM [Games]
  ORDER BY [Name],
           [Duration],
           [Part of the Day]

GO