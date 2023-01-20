USE SoftUni;

INSERT INTO Towns([Name])
VALUES ('Sofia'),
('Plovdiv'),
('Varna'),
('Burgas');


INSERT INTO Departments([Name])
VALUES ('Engineering'),
('Sales'),
('Marketing'),
('Software Development'),
('Quality Assurance');

INSERT INTO Employees([FirstName],
[MiddleName],
[LastName],
[JobTitle],
[DepartmentId],
[HireDate],
[Salary])
VALUES
('Ivan', 'Ivanov', 'Ivanov', '.NET Developer', (SELECT [Id] FROM Departments WHERE [Name] = 'Software Development'), '2013-02-01', 3500.00),
('Petar', 'Petrov', 'Petrov','Senior Engineer', (SELECT [Id] FROM Departments WHERE [Name] = 'Engineering'), '2004-03-02', 4000.00),
('Maria', 'Petrova', 'Ivanova', 'Intern', (SELECT [Id] FROM Departments WHERE [Name] = 'Quality Assurance'), '2016-08-28', 525.25),
('Georgi', 'Teziev', 'Ivanov', 'CEO', (SELECT [Id] FROM Departments WHERE [Name] = 'Sales'), '2007-12-09', 3000.00),
('Peter', 'Pan', 'Pan', 'Intern', (SELECT [Id] FROM Departments WHERE [Name] = 'Marketing'), '2016-08-28', 599.88);


SELECT * FROM Towns 

SELECT * FROM Departments 

SELECT * FROM Employees 


SELECT * FROM Towns ORDER BY [Name] ASC

SELECT * FROM Departments ORDER BY [Name] ASC

SELECT * FROM Employees ORDER BY [Salary] DESC


SELECT [Name] FROM Towns ORDER BY [Name] ASC

SELECT [Name] FROM Departments ORDER BY [Name] ASC

SELECT [FirstName], [LastName], [JobTitle], [Salary] FROM Employees ORDER BY [Salary] DESC


BEGIN TRANSACTION

UPDATE Employees
SET [Salary] = [Salary] * 1.1
WHERE [Id] BETWEEN 1 AND 5

SELECT[Salary]
FROM Employees

COMMIT;

USE Hotel;

UPDATE Payments
SET [TaxRate] = [TaxRate] - ([TaxRate] * 0.03)

SELECT [TaxRate]
FROM Payments;

BEGIN TRANSACTION

TRUNCATE TABLE Occupancies

SELECT * 
FROM Occupancies

COMMIT;