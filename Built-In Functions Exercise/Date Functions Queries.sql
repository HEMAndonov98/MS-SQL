USE [Orders]

GO

-- Problem 18

SELECT [ProductName],
       [OrderDate],
       DATEADD(DAY, 3, [OrderDate]) AS [Pay Due],
       DATEADD(MONTH, 1, [OrderDate]) AS [Deliver Due]
  FROM [Orders]

GO

-- Problem 19

CREATE TABLE [People](
    [Id] INT IDENTITY(1,1) PRIMARY KEY,
    [Name] NVARCHAR(50) NOT NULL,
    [Birthdate] DATETIME2 NOT NULL
)

GO

INSERT INTO [People] ([Name], [Birthdate])
     VALUES ('Victor', '2000-12-07'),
            ('Steven', '1992-09-10'),
            ('Stephen', '1910-09-19'),
            ('Jhon', '2010-01-06')

GO

SELECT * FROM [People]

SELECT [Name],
       DATEDIFF(YEAR, [Birthdate], GETDATE()) AS [Age in Years],
       DATEDIFF(MONTH, [Birthdate], GETDATE()) AS [Age in Months],
       DATEDIFF(DAY, [Birthdate], GETDATE()) AS [Age in Days],
       DATEDIFF(MINUTE, [Birthdate], GETDATE()) AS [Age in Minutes]
  FROM [People]

GO