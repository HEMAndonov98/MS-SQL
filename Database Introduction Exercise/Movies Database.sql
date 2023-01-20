CREATE TABLE Directors(
    Id INT IDENTITY(1,1) PRIMARY KEY,
    DirectorName NVARCHAR(100),
    Notes NVARCHAR(MAX)
)

INSERT INTO Directors(DirectorName)
VALUES
('Pesho'),
('Gosho'),
('Nedelcho'),
('Cameron'),
('Philip')

CREATE TABLE Genres(
    Id INT IDENTITY(1,1) PRIMARY KEY,
    GenreName  NVARCHAR(100),
    Notes NVARCHAR(MAX)
)

INSERT INTO Genres(GenreName)
VALUES
('Horror'),
('Sci-Fi'),
('Documentary'),
('Anime'),
('Cosmic Horror')


CREATE TABLE Categories(
    Id INT IDENTITY(1,1) PRIMARY KEY,
    CategoryName NVARCHAR(100),
    Notes NVARCHAR(MAX)
)

INSERT INTO Categories(CategoryName)
VALUES
('Series'),
('Experiences'),
('Feature-Length'),
('Thriller'),
('Romance')

CREATE TABLE Movies(
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Title NVARCHAR(100),
    DirectorId INT FOREIGN KEY REFERENCES Directors(Id),
    CopyrightYear DATETIME2,
    Length INT,
    GenreId INT FOREIGN KEY REFERENCES Genres(Id),
    CategoryId INT FOREIGN KEY REFERENCES Categories(Id),
    Rating TINYINT CHECK (Rating <= 10),
    Notes NVARCHAR(MAX)
)


INSERT INTO MOVIES(Title, DirectorId, CopyrightYear, Length, GenreId, CategoryId, Rating)
VALUES
('The One Below', 1, '2013-06-25', 126, 1, 4, 5),
('The Movie', 3, '1999-11-18', 60, 4, 1, 7),
('Before it happened', 5, '2020-01-18', 200, 2, 5, 4),
('The Revenge of The Sith', 2, '1970-12-30', 180, 2, 2, 8),
('The Fifth Element', 4, '1989-08-15', 89, 2, 4, 9);


