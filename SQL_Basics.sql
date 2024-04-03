--1)Simple Queries
CREATE TABLE TVSeries (SeriesID INT PRIMARY KEY IDENTITY(1,1), Title NVARCHAR(255) , ReleaseDate DATE , Genre NVARCHAR(100) )
INSERT INTO TVSeries (Title, ReleaseDate, Genre)
VALUES 
('Planet Earth II', '2016-11-06', 'Documentary'),
('Breaking Bad', '2008-01-20', 'Crime, Drama, Thriller'),
('Game of Thrones', '2011-04-17', 'Action, Adventure, Drama'),
('Stranger Things', '2016-07-15', 'Drama, Fantasy, Horror'),
('The Crown', '2016-11-04', 'Biography, Drama, History'),
('The Mandalorian', '2019-11-12', 'Action, Adventure, Sci-Fi'),
('The Witcher', '2019-12-20', 'Action, Adventure, Drama'),
('Westworld', '2016-10-02', 'Drama, Mystery, Sci-Fi')
----queries----
SELECT * FROM TVSeries
SELECT * FROM TVSeries WHERE ReleaseDate >= '2015'
SELECT * FROM TVSeries WHERE ReleaseDate>='2000' AND ReleaseDate<'2015'
---------------

--2)Creating database and quering
CREATE TABLE Store(item_id INT PRIMARY KEY IDENTITY(1,1), item_name NVARCHAR(255), price INT, quantity INT, status NVARCHAR(255))
INSERT INTO Store VALUES('marrygold',10,21,'avail')
INSERT INTO Store VALUES('milkbikis',10,32,'avail')
INSERT INTO Store VALUES('sweet',25,12,'avail')
INSERT INTO Store VALUES('kitkat',10,34,'avail')
INSERT INTO Store VALUES('munch',5,43,'avail')
INSERT INTO Store VALUES('dairymilk',10,21,'avail')
INSERT INTO Store VALUES('lays',5,76,'avail')
INSERT INTO Store VALUES('cheetos',5,23,'avail')
INSERT INTO Store VALUES('peppy',5,28,'avail')
INSERT INTO Store VALUES('bingo',10,12,'avail')
INSERT INTO Store VALUES('sunfeast',5,53,'avail')
INSERT INTO Store VALUES('bytes',10,65,'avail')
INSERT INTO Store VALUES('chocobar',15,43,'avail')
INSERT INTO Store VALUES('icecream',25,23,'avail')
INSERT INTO Store VALUES('oreo',20,23,'avail')
----queries----
SELECT * FROM Store ORDER BY item_id
---------------
SELECT SUM(price) AS TotalPrice,SUM(quantity) AS TotalStock FROM Store
---------------
SELECT item_name,price,
CASE
WHEN price>10 THEN 'costly'
ELSE 'cheap'
END as Nature
FROM Store
---------------

--3)In and Sub-query
CREATE TABLE Artists (artist_id INTEGER PRIMARY KEY IDENTITY(1,1), name NVARCHAR(255), country NVARCHAR(255), genre NVARCHAR(255))
INSERT INTO Artists VALUES ('Taylor Swift', 'US', 'Pop')
INSERT INTO Artists VALUES ('Led Zeppelin', 'US', 'Hard rock')
INSERT INTO Artists VALUES ('ABBA', 'Sweden', 'Disco')
INSERT INTO Artists VALUES ('Queen', 'UK', 'Rock')
INSERT INTO Artists VALUES ('Celine Dion', 'Canada', 'Pop')
INSERT INTO Artists VALUES ('Meatloaf', 'US', 'Hard rock')
INSERT INTO Artists VALUES ('Garth Brooks', 'US', 'Country')
INSERT INTO Artists VALUES ('Shania Twain', 'Canada', 'Country')
INSERT INTO Artists VALUES ('Rihanna', 'US', 'Pop')
INSERT INTO Artists VALUES ('Guns N'' Roses', 'US', 'Hard rock')
INSERT INTO Artists VALUES ('Gloria Estefan', 'US', 'Pop')
INSERT INTO Artists VALUES ('Bob Marley', 'Jamaica', 'Reggae')
---------------
CREATE TABLE Songs (id INTEGER PRIMARY KEY IDENTITY(1,1), artist NVARCHAR(255), title NVARCHAR(255))
INSERT INTO Songs VALUES ('Taylor Swift', 'Shake it off')
INSERT INTO Songs VALUES ('Rihanna', 'Stay')
INSERT INTO Songs VALUES ('Celine Dion', 'My heart will go on')
INSERT INTO Songs VALUES ('Celine Dion', 'A new day has come')
INSERT INTO Songs VALUES ('Shania Twain', 'Party for two')
INSERT INTO Songs VALUES ('Gloria Estefan', 'Conga')
INSERT INTO Songs VALUES ('Led Zeppelin', 'Stairway to heaven')
INSERT INTO Songs VALUES ('ABBA', 'Mamma mia')
INSERT INTO Songs VALUES ('Queen', 'Bicycle Race')
INSERT INTO Songs VALUES ('Queen', 'Bohemian Rhapsody')
INSERT INTO Songs VALUES ('Guns N'' Roses', 'Don''t cry')
---------------
SELECT title FROM songs WHERE artist IN ('Queen')
---------------
SELECT name FROM artists WHERE genre IN ('Pop')
---------------
SELECT title FROM songs WHERE artist IN(SELECT name FROM artists WHERE genre IN ('Pop'))
---------------

--4)HAVING statement
CREATE TABLE Books (id INT PRIMARY KEY IDENTITY(1,1), author NVARCHAR(255), title NVARCHAR(255), words INT)
INSERT INTO Books VALUES ('J.K. Rowling', 'Harry Potter and the Philosopher''s Stone', 79944)
INSERT INTO Books VALUES ('J.K. Rowling', 'Harry Potter and the Chamber of Secrets', 85141)
INSERT INTO Books VALUES ('J.K. Rowling', 'Harry Potter and the Prisoner of Azkaban', 107253)
INSERT INTO Books VALUES ('J.K. Rowling', 'Harry Potter and the Goblet of Fire', 190637)
INSERT INTO Books VALUES ('J.K. Rowling', 'Harry Potter and the Order of the Phoenix', 257045)
INSERT INTO Books VALUES ('J.K. Rowling', 'Harry Potter and the Half-Blood Prince', 168923)
INSERT INTO Books VALUES ('J.K. Rowling', 'Harry Potter and the Deathly Hallows', 197651)
INSERT INTO Books VALUES ('Stephenie Meyer', 'Twilight', 118501)
INSERT INTO Books VALUES ('Stephenie Meyer', 'New Moon', 132807)
INSERT INTO Books VALUES ('Stephenie Meyer', 'Eclipse', 147930)
INSERT INTO Books VALUES ('Stephenie Meyer', 'Breaking Dawn', 192196)
INSERT INTO Books VALUES ('J.R.R. Tolkien', 'The Hobbit', 95022)
INSERT INTO Books VALUES ('J.R.R. Tolkien', 'Fellowship of the Ring', 177227)
INSERT INTO Books VALUES ('J.R.R. Tolkien', 'Two Towers', 143436)
INSERT INTO Books VALUES ('J.R.R. Tolkien', 'Return of the King', 134462)
---------------
SELECT author,SUM(words) AS total_words from Books 
GROUP BY author 
HAVING SUM(words) > 1000000
---------------
SELECT author,avg(words) AS AVG_words from Books 
GROUP BY author 
HAVING avg(words) > 150000
---------------

--5)CASE Statement
CREATE TABLE StudentGrades (id INTEGER PRIMARY KEY IDENTITY(1,1), Name VARCHAR(255), NumberGrade INT, FractionCompleted REAL)
INSERT INTO StudentGrades VALUES ('Winston', 90, 0.805)
INSERT INTO StudentGrades VALUES ('Winnefer', 95, 0.901)
INSERT INTO StudentGrades VALUES ('Winsteen', 85, 0.906)
INSERT INTO StudentGrades VALUES ('Wincifer', 66, 0.7054)
INSERT INTO StudentGrades VALUES ('Winster', 76, 0.5013)
INSERT INTO StudentGrades VALUES ('Winstonia', 82, 0.9045)
---------------
SELECT Name, NumberGrade,ROUND(FractionCompleted * 100,2) as PercentCompleted FROM StudentGrades
---------------
WITH LetterGrades AS (SELECT id,
     CASE
        WHEN ROUND(FractionCompleted * 100, 2) > 90 THEN 'A'
        WHEN ROUND(FractionCompleted * 100, 2) > 80 THEN 'B'
        WHEN ROUND(FractionCompleted * 100, 2) > 70 THEN 'C'
        ELSE 'F'
      END AS LetterGradePersons
  FROM StudentGrades
)
SELECT COUNT(*) AS NumberOfStudents, LetterGrade
FROM LetterGrades
GROUP BY LetterGrade
---------------

--6)Inner Join
CREATE TABLE Persons (id INTEGER PRIMARY KEY IDENTITY(1,1), Name VARCHAR(255), Age INT)    
INSERT INTO Persons VALUES ('Bobby McBobbyFace', 12)
INSERT INTO Persons VALUES ('Lucy BoBucie', 25)
INSERT INTO Persons VALUES ('Banana FoFanna', 14)
INSERT INTO Persons VALUES ('Shish Kabob', 20)
INSERT INTO Persons VALUES ('Fluffy Sparkles', 8)
INSERT INTO Persons VALUES ('Ragzz',24)
---------------
CREATE table Hobbies (id INTEGER PRIMARY KEY IDENTITY(1,1), PersonID INT, Name VARCHAR(255)) 
INSERT INTO Hobbies VALUES (1, 'drawing')
INSERT INTO Hobbies VALUES (1, 'coding')
INSERT INTO Hobbies VALUES (2, 'dancing')
INSERT INTO Hobbies VALUES (2, 'coding')
INSERT INTO Hobbies VALUES (3, 'skating')
INSERT INTO Hobbies VALUES (3, 'rowing')
INSERT INTO Hobbies VALUES (3, 'drawing')
INSERT INTO Hobbies VALUES (4, 'coding')
INSERT INTO Hobbies VALUES (4, 'dilly-dallying')
INSERT INTO Hobbies VALUES (4, 'meowing')
INSERT INTO Hobbies VALUES (5,'talking')
---------------
SELECT Persons.Name, Hobbies.Name FROM Persons JOIN Hobbies ON Persons.id = Hobbies.PersonID
---------------
SELECT Persons.Name, Hobbies.Name FROM Persons JOIN hobbies ON Persons.id = Hobbies.PersonID WHERE Persons.Name IN ('Bobby McBobbyFace','Banana FoFanna')
---------------

--6)Outter Join
CREATE TABLE Customers (id INT PRIMARY KEY IDENTITY(1,1), Name VARCHAR(255), Email VARCHAR(255))
INSERT INTO Customers VALUES ('Doctor Who', 'doctorwho@timelords.com')
INSERT INTO Customers VALUES ('Harry Potter', 'harry@potter.com')
INSERT INTO Customers VALUES ('Captain Awesome', 'captain@awesome.com')
CREATE TABLE Orders (id INTEGER PRIMARY KEY IDENTITY(1,1), Customer_id INT, Item VARCHAR(255), Price REAL)
INSERT INTO Orders VALUES (1, 'Sonic Screwdriver', 1000.00)
INSERT INTO Orders VALUES (2, 'High Quality Broomstick', 40.00)
INSERT INTO Orders VALUES (1, 'TARDIS', 1000000.00)
---------------
SELECT Customers.Name, Customers.Email, Orders.Item, Orders.Price FROM Customers LEFT OUTER JOIN Orders ON Customers.id = Orders.Customer_id
---------------
SELECT Customers.Name, Customers.Email, SUM(Orders.Price) as 'TOTAL_SPENT' FROM Customers LEFT OUTER JOIN Orders ON Customers.id = Orders.Customer_id  GROUP BY Customers.Name, Customers.Email  ORDER BY SUM(Orders.Price) DESC 
---------------

--7)UPDATE and DELETE statements
CREATE TABLE Documents (id INTEGER PRIMARY KEY IDENTITY(1,1), Author VARCHAR(255), Title VARCHAR(255), Content VARCHAR(255))
INSERT INTO Documents VALUES ('Puff T.M. Dragon', 'Fancy Stuff', 'Ceiling wax, dragon wings, etc.')
INSERT INTO Documents VALUES ('Puff T.M. Dragon', 'Living Things', 'They''re located in the left ear, you know.')
INSERT INTO Documents VALUES ('Jackie Paper', 'Pirate Recipes', 'Cherry pie, apple pie, blueberry pie.')
INSERT INTO Documents VALUES ('Jackie Paper', 'Boat Supplies', 'Rudder - guitar. Main mast - bed post.')
INSERT INTO Documents VALUES ('Jackie Paper', 'Things I''m Afraid Of', 'Talking to my parents, the sea, giant pirates, heights.')
SELECT * FROM Documents
---------------
UPDATE Documents SET author= 'Jackie Draper' WHERE id=3
UPDATE Documents SET author= 'Jackie Draper' WHERE id=4
UPDATE Documents SET author= 'Jackie Draper' WHERE id=5
SELECT * FROM Documents
---------------
DELETE FROM Documents WHERE Title LIKE 'Things I''m Afraid Of'
SELECT * FROM Documents
---------------

--8)ALTER statement
CREATE TABLE clothes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    type TEXT,
    design TEXT);
    
INSERT INTO clothes (type, design)
    VALUES ("dress", "pink polka dots");
INSERT INTO clothes (type, design)
    VALUES ("pants", "rainbow tie-dye");
INSERT INTO clothes (type, design)
    VALUES ("blazer", "black sequin");
    
ALTER TABLE clothes ADD price INTEGER;

SELECT * FROM clothes;

UPDATE clothes SET price= 10 WHERE id=1;
UPDATE clothes SET price= 20 WHERE id=2;
UPDATE clothes SET price= 30 WHERE id=3;

SELECT * FROM clothes;

INSERT INTO clothes (type, design,price)
    VALUES ("dress", "pink chudi",40);
    
SELECT * FROM clothes;
