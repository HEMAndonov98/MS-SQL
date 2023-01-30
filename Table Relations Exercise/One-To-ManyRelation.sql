CREATE TABLE [Manufacturers](
    [ManufacturerID] INT IDENTITY(1,1) PRIMARY KEY,
    [Name] NVARCHAR(50) NOT NULL,
    [EstablishedOn] DATETIME2
)

GO
-- ModelID	Name	ManufacturerID
CREATE TABLE [Models](
    [ModelID] INT IDENTITY(101, 1) PRIMARY KEY,
    [Name] NVARCHAR(50) NOT NULL,
    [ManufacturerID] INT
)

ALTER TABLE [Models]
ADD CONSTRAINT FK_Manufacturer
FOREIGN KEY([ManufacturerID]) REFERENCES [Manufacturers]([ManufacturerID]);

GO


INSERT INTO [Manufacturers]([Name], [EstablishedOn])
VALUES
    ('BMW', CONVERT(varchar, '07/03/1916', 1)),
    ('Tesla',	 CONVERT(varchar, '01/01/2003', 1)),
    ('Lada',  CONVERT(varchar, '01/05/1966', 1));


INSERT INTO [Models]([Name], [ManufacturerID])
VALUES
    ('X1',	1)
    ,('i6',	1)
    ,('Model S', 2)
    ,('Model X', 2)
    ,('Model 3', 2)
    ,('Nova', 3);