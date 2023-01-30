CREATE TABLE [ItemTypes](
    [ItemTypeID] INT IDENTITY(1,1) PRIMARY KEY,
    [Name] NVARCHAR(50) NOT NULL
)

GO 

CREATE TABLE [Items](
    [ItemID] INT IDENTITY(101, 1) PRIMARY KEY,
    [Name] NVARCHAR(50) NOT NULL,
    [ItemTypeID] INT FOREIGN KEY REFERENCES [ItemTypes]([ItemTypeID]) NOT NULL
)

GO

CREATE TABLE [Cities](
    [CityID] INT IDENTITY(1,1) PRIMARY KEY,
    [Name] NVARCHAR(50) NOT NULL
)

GO

CREATE TABLE [Customers](
    [CustomerID] INT IDENTITY(101, 1) PRIMARY KEY,
    [Name] NVARCHAR(50) NOT NULL,
    [Birthday] DATETIME2,
    [CityID] INT FOREIGN KEY REFERENCES [Cities]([CityID]) NOT NULL
)

GO

CREATE TABLE [Orders](
    [OrderID] INT IDENTITY(201, 1) PRIMARY KEY,
    [CustomerID] INT FOREIGN KEY REFERENCES [Customers]([CustomerID]) NOT NULL
)

GO

CREATE TABLE [OrderItems](
    [OrderID] INT NOT NULL,
    [ItemID] INT NOT NULL
)

GO

ALTER TABLE [OrderItems]
ADD CONSTRAINT PK_OrderItemsID PRIMARY KEY([OrderID], [ItemID])

GO

ALTER TABLE [OrderItems]
ADD CONSTRAINT FK_OrderID FOREIGN KEY ([OrderID]) REFERENCES [Orders](OrderID)

ALTER TABLE [OrderItems]
ADD CONSTRAINT FK_ItemID FOREIGN KEY ([ItemID]) REFERENCES [Items]([ItemID])

GO  

-- TESTING WITH VALUES

INSERT INTO [ItemTypes]([Name])
VALUES
('Clothes'),
('Watches')

INSERT INTO [Items]([Name], [ItemTypeID])
VALUES
('T-Shirt', 1),
('Seiko-5', 2)

INSERT INTO [Cities]([Name])
VALUES
('Sofia'),
('Plovdiv'),
('Varna')

INSERT INTO [Customers]([Name], [Birthday], [CityID])
VALUES
('Pesho', GETDATE(), 1),
('Gosho', GETDATE(), 2),
('Tanya', GETDATE(), 3)

INSERT INTO [Orders]([CustomerID])
VALUES
(101),
(101),
(103),
(102),
(103)

INSERT INTO [OrderItems]([OrderID], [ItemID])
VALUES
(201, 102),
(202, 101),
(203, 102),
(204, 101)

-- Testing the dbo with select querries

SELECT * FROM [OrderItems]

SELECT * FROM [Orders]

SELECT [Name]
FROM [Items]
WHERE [ItemID] IN (
        SELECT [ItemID]
        FROM [OrderItems]
        WHERE [OrderID] IN (201, 203, 204)
)

SELECT [Name], [Birthday]
FROM [Customers]
WHERE [CustomerID] IN (
    SELECT [CustomerID]
    FROM [Orders]
    WHERE [OrderID] IN (
        SELECT [OrderID]
        FROM [OrderItems]
        WHERE [ItemID] = 102
    )
)
