CREATE DATABASE [University]
GO

USE [University]

GO

CREATE TABLE [Majors](
    [MajorID] INT IDENTITY(1,1) PRIMARY KEY
    ,[Name] NVARCHAR(100) NOT NULL
)

GO

CREATE TABLE [Subjects](
    [SubjectID] INT IDENTITY(101, 1) PRIMARY KEY
    ,[Name] NVARCHAR(100) NOT NULL
)

GO

CREATE TABLE [Students](
    [StudentID] INT IDENTITY(201, 1) PRIMARY KEY,
    [StudentNumber] VARCHAR(20) UNIQUE,
    [StudentName] NVARCHAR(50) NOT NULL,
    [MajorID] INT FOREIGN KEY REFERENCES [Majors]([MajorID]) NOT NULL
)

GO

CREATE TABLE [Agenda](
    [StudentID] INT FOREIGN KEY REFERENCES [Students]([StudentID]),
    [SubjectID] INT FOREIGN KEY REFERENCES [Subjects]([SubjectID]),
    CONSTRAINT PK_Agenda PRIMARY KEY([StudentID], [SubjectID])
)

GO

CREATE TABLE [Payments](
    [PaymentID] INT IDENTITY(301,1) PRIMARY KEY,
    [PaymentDate] DATETIME2 NOT NULL,
    [PaymentAmount] DEC(8,2),
    [StudentID] INT FOREIGN KEY REFERENCES [Students]([StudentID])
)

GO