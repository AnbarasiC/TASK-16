--Create table for Movie
CREATE TABLE Movie (
    movie_id INT PRIMARY KEY,
    movie_name VARCHAR(255),
    release_date DATE,
    director VARCHAR(255),
    rating DECIMAL(2,1)
);

--Create table for Media
CREATE TABLE Media (
    media_id INT PRIMARY KEY,
    movie_id INT,
    media_type ENUM,
    media_url VARCHAR(255),
    FOREIGN KEY (movie_id) REFERENCES Movie(movie_id)
);

--Create table for Genre
CREATE TABLE Genre (
    genre_id INT PRIMARY KEY,
    genre_name VARCHAR(255)
);

--Create table for Movie_Genre
CREATE TABLE Movie_Genre (
    movie_id INT,
    genre_id INT,
    PRIMARY KEY (movie_id, genre_id),
    FOREIGN KEY (movie_id) REFERENCES Movie(movie_id),
    FOREIGN KEY (genre_id) REFERENCES Genre(genre_id)
);

--Create table for User
CREATE TABLE User (
    user_id INT PRIMARY KEY,
    username VARCHAR(255),
    email VARCHAR(255)
);

--Create table for Review
CREATE TABLE Review (
    review_id INT PRIMARY KEY,
    movie_id INT,
    user_id INT,
    title VARCHAR(255),
    content TEXT,
    rating DECIMAL(2,1),
    FOREIGN KEY (movie_id) REFERENCES Movie(movie_id),
    FOREIGN KEY (user_id) REFERENCES User(user_id)
);

--Create table for Artist
CREATE TABLE Artist (
    artist_id INT PRIMARY KEY,
    artist_name VARCHAR(255),
    birth_date DATE
);

--Create table for Skill
CREATE TABLE Skill (
    skill_id INT PRIMARY KEY,
    skill_name VARCHAR(255)
);

--Create table for Artist_Skill
CREATE TABLE Artist_Skill (
    artist_id INT,
    skill_id INT,
    PRIMARY KEY (artist_id, skill_id),
    FOREIGN KEY (artist_id) REFERENCES Artist(artist_id),
    FOREIGN KEY (skill_id) REFERENCES Skill(skill_id)
);

--Create table for Role
CREATE TABLE Role (
    role_id INT PRIMARY KEY,
    role_name VARCHAR(255)
);

--Create table for Artist_Role
CREATE TABLE Artist_Role (
    artist_id INT,
    movie_id INT,
    role_id INT,
    PRIMARY KEY (artist_id, movie_id, role_id),
    FOREIGN KEY (artist_id) REFERENCES Artist(artist_id),
    FOREIGN KEY (movie_id) REFERENCES Movie(movie_id),
    FOREIGN KEY (role_id) REFERENCES Role(role_id)
);

--Insert required data-1 into the respective tables
INSERT INTO Movie (movie_id, movie_name, release_date, director, rating)
VALUES (1, 'Movie 1', '2022-01-01', 'Director 1', 8.2);

INSERT INTO Media (media_id, movie_id, media_type, media_url)
VALUES (1, 1, 'Video', 'http://example.com/video1.mp4');

INSERT INTO Genre (genre_id, genre_name)
VALUES (1, 'Action, Thriller');

INSERT INTO Movie_Genre (movie_id, genre_id)
VALUES (1, 1);

INSERT INTO User (user_id, username, email)
VALUES (1, 'Ram', 'ram@example.com');

INSERT INTO Review (review_id, movie_id, user_id, title, content, rating)
VALUES (1, 1, 1, 'Great Movie', 'This movie was awesome!', 9.0);

INSERT INTO Artist (artist_id, artist_name, birth_date)
VALUES (1, 'Artist 1', '1990-01-01');

INSERT INTO Skill (skill_id, skill_name)
VALUES (1, 'Acting, Singing');

INSERT INTO Artist_Skill (artist_id, skill_id)
VALUES (1, 1);

INSERT INTO Role (role_id, role_name)
VALUES (1, 'Actor, Singer');

INSERT INTO Artist_Role (artist_id, movie_id, role_id)
VALUES (1, 1, 1);

--Insert required data-2 into the respective tables
INSERT INTO Movie (movie_id, movie_name, release_date, director, rating)
VALUES (2, 'Movie 2', '2022-05-11', 'Director 2', 9.3);

INSERT INTO Media (media_id, movie_id, media_type, media_url)
VALUES (2, 2, 'Video', 'http://example.com/Image.jpg');

INSERT INTO Genre (genre_id, genre_name)
VALUES (2, 'Drama');

INSERT INTO Movie_Genre (movie_id, genre_id)
VALUES (2, 2);

INSERT INTO User (user_id, username, email)
VALUES (2, 'Meera', 'meera@example.com');

INSERT INTO User (user_id, username, email)
VALUES (3, 'Sita', 'sita@example.com');

INSERT INTO Review (review_id, movie_id, user_id, title, content, rating)
VALUES (2, 2, 2, 'Feel good Movie', 'This is not just a movie, It is an emotion!', 9.5);

INSERT INTO Review (review_id, movie_id, user_id, title, content, rating)
VALUES (3, 2, 3, 'Not bad', 'One time watch', 7.5);

INSERT INTO Artist (artist_id, artist_name, birth_date)
VALUES (2, 'Artist 2', '1991-01-11');

INSERT INTO Skill (skill_id, skill_name)
VALUES (2, 'Acting, Dancing, Memorization');

INSERT INTO Artist_Skill (artist_id, skill_id)
VALUES (2, 2);

INSERT INTO Role (role_id, role_name)
VALUES (2, 'Actor, Director');

INSERT INTO Artist_Role (artist_id, movie_id, role_id)
VALUES (2, 2, 2);

-- 1) Movie should have multiple media (Video or Image).
SELECT Movie.movie_name, media_type, media_url 
FROM Movie INNER JOIN Media 
ON Movie.movie_id = Media.movie_id;

-- 2) Movie can belongs to multiple Genre.
SELECT Movie.movie_name, Genre.genre_name 
FROM Movie INNER JOIN Movie_Genre 
ON Movie.movie_id = Movie_Genre.movie_id 
INNER JOIN Genre ON Movie_Genre.genre_id = Genre.genre_id;

-- 3) Movie can have multiple reviews and Review can belongs to a user.
SELECT Movie.movie_name, Review.rating, Review.content, User.username 
FROM Movie INNER JOIN Review ON Movie.movie_id = Review.movie_id 
INNER JOIN User ON Review.user_id = User.user_id;

-- 4) Artist can have multiple skills.
SELECT Artist.artist_name, Skill.skill_name 
FROM Artist INNER JOIN Artist_Skill ON Artist.artist_id = Artist_Skill.artist_id 
INNER JOIN Skill ON Artist_Skill.skill_id = Skill.skill_id;

-- 5) Artist can perform multiple role in a single film.
SELECT Artist.artist_name, Movie.movie_name, Role.role_name 
FROM Artist INNER JOIN Artist_Role ON Artist.artist_id = Artist_Role.artist_id 
INNER JOIN Movie ON Artist_Role.movie_id = Movie.movie_id 
INNER JOIN Role ON Artist_Role.role_id = Role.role_id;