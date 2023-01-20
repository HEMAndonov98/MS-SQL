CREATE DATABASE Hotel;
USE Hotel;

--• Employees (Id, FirstName, LastName, Title, Notes)


CREATE TABLE Employees(
    Id INT IDENTITY(1,1) PRIMARY KEY,
    FirstName NVARCHAR(100) NOT NULL,
    LastName NVARCHAR(100) NOT NULL,
    Title NVARCHAR(100) NOT NULL,
    Notes NVARCHAR(MAX)
);


-- Customers (AccountNumber, FirstName, LastName, PhoneNumber, EmergencyName,
-- EmergencyNumber, Notes)

CREATE TABLE Customers(
    AccountNumber BIGINT PRIMARY KEY NOT NULL,
    FirstName NVARCHAR(100) NOT NULL,
    LastName NVARCHAR(100) NOT NULL,
    PhoneNumber VARCHAR(20) NOT NULL,
    EmergencyName NVARCHAR(100),
    EmergencyNumber VARCHAR(20),
    Notes NVARCHAR(MAX)
);

-- RoomStatus (RoomStatus, Notes)

CREATE TABLE RoomStatus(
    RoomStatus NVARCHAR(100) NOT NULL,
    Notes NVARCHAR(MAX)
);

ALTER TABLE RoomStatus
ADD CONSTRAINT PK_RoomStatus
PRIMARY KEY(RoomStatus);

-- • RoomTypes (RoomType, Notes)

CREATE TABLE RoomTypes(
    RoomType NVARCHAR(50) PRIMARY KEY NOT NULL,
    Notes NVARCHAR(MAX)
)
--BedTypes (BedType, Notes)


CREATE TABLE BedTypes(
    BedType NVARCHAR(100) NOT NULL,
    Notes NVARCHAR(MAX)
)

ALTER TABLE BedTypes
ADD CONSTRAINT PK_BedType
PRIMARY KEY(BedType);

-- Rooms (RoomNumber, RoomType, BedType, Rate, RoomStatus, Notes)

CREATE TABLE Rooms(
    RoomNumber INT PRIMARY KEY NOT NULL,
    RoomType NVARCHAR(50) NOT NULL,
    BedType NVARCHAR(100) FOREIGN KEY REFERENCES BedTypes(BedType) NOT NULL,
    Rate DEC(9,2),
    RoomStatus NVARCHAR(100) FOREIGN KEY REFERENCES RoomStatus(RoomStatus) NOT NULL,
    Notes NVARCHAR(MAX)
);

ALTER TABLE Rooms
ADD CONSTRAINT FK_RoomType
FOREIGN KEY (RoomType) REFERENCES RoomTypes (RoomType);

-- Payments (Id, EmployeeId, PaymentDate, AccountNumber, FirstDateOccupied,
-- LastDateOccupied, TotalDays, AmountCharged, TaxRate, TaxAmount, PaymentTotal, Notes)


CREATE TABLE Payments(
    Id INT IDENTITY(1,1) PRIMARY KEY,
    EmployeeId INT FOREIGN KEY REFERENCES Employees(Id) NOT NULL,
    PaymentDate DATETIME2 NOT NULL,
    AccountNumber BIGINT FOREIGN KEY REFERENCES Customers(AccountNumber) NOT NULL,
    FirstDateOccupied DATETIME2 NOT NULL,
    LastDateOccupied DATETIME2 NOT NULL,
    TotalDays AS DATEDIFF(DAY, FirstDateOccupied, LastDateOccupied),
    AmountCharged DEC(9,2),
    TaxRate Dec(9,1),
    TaxAmount DEC(9,2),
    PaymentTotal DEC(9,2),
    Notes NVARCHAR(MAX)
)

-- Occupancies (Id, EmployeeId, DateOccupied, AccountNumber, RoomNumber, RateApplied,
-- PhoneCharge, Notes)

CREATE TABLE  Occupancies(
    Id INT IDENTITY(1,1) PRIMARY KEY,
    EmployeeId INT FOREIGN KEY REFERENCES Employees(Id) NOT NULL,
    DateOccupied DATETIME2 NOT NULL,
    AccountNumber BIGINT FOREIGN KEY REFERENCES Customers(AccountNumber) NOT NULL,
    RoomNumber INT FOREIGN KEY REFERENCES Rooms(RoomNumber) NOT NULL,
    RateApplied DEC(9,2),
    PhoneCharge DEC(9,2),
    Notes NVARCHAR(MAX),
)

INSERT INTO Employees (FirstName, LastName, Title)
VALUES
('Steven', 'Smith', 'GM'),
('Stephany', 'Cochelle', 'Receptionist'),
('Peter', 'Quill', 'HaouseMan');

INSERT INTO Customers (AccountNumber, FirstName, LastName, PhoneNumber)
VALUES
(6095842389, 'Pesho', 'Peshev', '+359 0987553421'),
(8577623461, 'Gosho', 'Peshev', '+44 44443355615'),
(2678934509, 'Pesho', 'Peshev', '+32 9898553212');

INSERT INTO RoomStatus (RoomStatus)
VALUES
('Occupied'),
('Available'),
('Maintenance');

INSERT INTO RoomTypes(RoomType)
VALUES
('Small'),
('Medium'),
('Large');


INSERT INTO BedTypes (BedType)
VALUES
('Double'),
('King'),
('Queen');

INSERT INTO Rooms (RoomNumber, RoomType, BedType, Rate, RoomStatus)
VALUES
(321, 'Medium', 'Queen', 59.88, 'Available'),
(666, 'Large', 'King', 66.66, 'Maintenance'),
(059, 'Small', 'Double', 36.51, 'Occupied');

INSERT INTO Payments (EmployeeId, PaymentDate, AccountNumber, FirstDateOccupied, LastDateOccupied, PaymentTotal)
VALUES
(1, '2023-01-18', 6095842389, '2022-11-30', '2022-12-7', 346.56),
(3, '2022-12-18', 2678934509, '2022-11-30', '2022-12-15', 456.36),
(1, '2022-06-03', 8577623461, '2022-05-15', '2022-05-22', 150.41);

INSERT INTO Occupancies (EmployeeId, DateOccupied, AccountNumber, RoomNumber)
VALUES
(3, '2023-03-03', 6095842389, 321),
(1, '2021-08-16', 8577623461, 059),
(2, '2022-07-10', 2678934509, 666);