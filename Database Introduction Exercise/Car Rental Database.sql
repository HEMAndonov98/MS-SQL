CREATE DATABASE CarRental;

USE CarRental;


CREATE TABLE Categories(
    Id INT IDENTITY(1,1) PRIMARY KEY,
    CategoryName NVARCHAR(100),
    DailyRate DEC(6, 2),
    WeeklyRate DEC(7, 2),
    MonthlyRate DEC(8, 2),
    WeekendRate DEC(6,2)
);

ALTER TABLE Categories
ADD CONSTRAINT UC_CategoryName
UNIQUE(CategoryName);

INSERT INTO Categories(CategoryName, DailyRate, WeeklyRate, MonthlyRate, WeekendRate)
VALUES
('SUV', 50.69, 430.69, 1200.76, 90.38),
('Sports', 100.20, 600.74, 2500.6, 150.35),
('Industrial', 400.34, 2500.38, 10000.52, 630.25);


CREATE TABLE Cars(
    Id INT IDENTITY(1,1) PRIMARY KEY,
    PlateNumber NVARCHAR(8) UNIQUE,
    Manufacturer NVARCHAR(100),
    Model NVARCHAR(100),
    CarYear DATETIME2,
    CategoryId INT FOREIGN KEY REFERENCES Categories(Id),
    Doors TINYINT,
    Picture VARBINARY(MAX) CHECK (DATALENGTH(Picture) <=  2097152),
    Condition TINYINT CHECK (Condition <= 100),
    Available BIT
);

INSERT INTO Cars(PlateNumber, Manufacturer, Model, CategoryId, Doors, Condition, Available)
VALUES
('CB6710PC', 'Alfa Romeo', 'Gulia GTAM', 2, 2, 100, 1),
('RC700CC', 'Audi', 'RS8', 2, 4, 100, 0),
('PT1166', 'Lamborghini', 'RAT-AM800', 3, 2, 80, 1);


CREATE TABLE Employees(
    Id INT IDENTITY(1,1) PRIMARY KEY,
    FirstName NVARCHAR(155) NOT NULL,
    LastName NVARCHAR(155) NOT NULL,
    Title NVARCHAR(100),
    Notes NVARCHAR(MAX)
);

INSERT INTO Employees(FirstName, LastName, Title)
VALUES
('Dwight', 'Shrute', 'Sales'),
('Jhon', 'Smith', 'Manager'),
('Kelly', 'Long', 'HR');



CREATE TABLE Customers(
    Id INT IDENTITY(1,1) PRIMARY KEY,
    DriverLicenceNumber BIGINT,
    FullName NVARCHAR(200),
    Address NVARCHAR(200),
    City NVARCHAR(100),
    ZipCode INT,
    Notes NVARCHAR(MAX)
);


ALTER TABLE Customers
ALTER COLUMN DriverLicenceNumber BIGINT NOT NULL;

ALTER TABLE Customers
ADD CONSTRAINT UQ_DriverLicenceNumber
UNIQUE(DriverLicenceNumber);

INSERT INTO Customers(DriverLicenceNumber, FullName, Address, City, ZipCode)
VALUES
(9806036665, 'Sebastian.H.Gaylord', NULL, 'Sofia', 1000),
(6205313355, 'WU.Pepa.Teatre', 'Not Your Business.st', 'NY', 3344),
(5211113435, 'Jhon.S.Stanley', 'FifthAve.st', 'Boston', 3567);


CREATE TABLE RentalOrders(
    Id INT IDENTITY(1,1) PRIMARY KEY,
    EmployeeId INT FOREIGN KEY REFERENCES Employees(Id),
    CustomerId INT FOREIGN KEY REFERENCES Customers(id),
    CarId INT FOREIGN KEY REFERENCES Cars(Id),
    TankLevel INT,
    KilometrageStart INT NOT NULL,
    KilometrageEnd INT,
    TotalKilometrage INT,
    StartDate DATETIME2,
    EndDate DATETIME2,
    TotalDays INT,
    RateApplied DEC(8, 2),
    TaxRate DEC(4, 2),
    OrderStatus NVARCHAR(100),
    Notes NVARCHAR(MAX)
);

ALTER TABLE RentalOrders
ADD CONSTRAING CHK_TankLevel
CHECK (TankLevel <= 100);

INSERT INTO RentalOrders(EmployeeId, CustomerId, CarId, TankLevel, KilometrageStart, OrderStatus)
VALUES
(1, 3, 2, 100, 133000, 'pending'),
(2, 1, 3, 65, 260000, 'complete'),
(1, 1, 1, 100, 65000, 'in-progress');

