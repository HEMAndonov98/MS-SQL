USE [Geography]

GO

-- Problem 12

    SELECT [CountryName] AS [Country Name],
           [IsoCode] AS [ISO Code]
      FROM [Countries]
     WHERE [CountryName] LIKE '%A%A%A%'
  ORDER BY [IsoCode]

GO   

-- Problem 13

    SELECT [p].[PeakName],
           [r].[RiverName],
           LOWER(CONCAT(LEFT([PeakName], LEN([PeakName]) - 1), [RiverName])) AS [Mix]
      FROM [Peaks] AS [p],
           [Rivers] AS [r]
     WHERE LOWER(RIGHT([PeakName], 1)) = LOWER(LEFT([RiverName], 1))
  ORDER BY [Mix]

GO
