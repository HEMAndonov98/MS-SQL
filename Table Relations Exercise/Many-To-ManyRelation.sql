USE EntityRelationsDemo2023

GO

CREATE TABLE [Students](
    [StudentID] INT IDENTITY(1,1) PRIMARY KEY
    , [Name] NVARCHAR(50) NOT NULL
);
CREATE TABLE [Exams](
    [ExamID] INT IDENTITY(101, 1) PRIMARY KEY
    ,[Name] NVARCHAR(50) NOT NULL
);

CREATE TABLE [StudentsExams](
    [StudentID] INT FOREIGN KEY REFERENCES [Students]([StudentID]) NOT NULL
    ,[ExamID] INT FOREIGN KEY REFERENCES [Exams]([ExamID]) NOT NULL
);

GO

ALTER TABLE [StudentsExams]
ADD CONSTRAINT PK_StudentExamID PRIMARY KEY([StudentID], [ExamID]) 

GO

INSERT INTO [Students]([Name])
VALUES
    ('Mila')
    ,('Toni')
    ,('Ron')

GO

INSERT INTO [Exams]([Name])
VALUES
    ('SpringMVC')
    ,('Neo4j')
    ,('Oracle 11g')

GO

INSERT INTO [StudentsExams]([StudentID], [ExamID])
VALUES
    (1, 101)
    ,(1, 102)
    ,(2, 101)
    ,(3, 103)
    ,(2, 102)
    ,(2, 103)

GO