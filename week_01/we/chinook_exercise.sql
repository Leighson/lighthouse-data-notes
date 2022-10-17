/* SQL Exercise
====================================================================
We will be working with database chinook.db
You can download it here: https://drive.google.com/file/d/0Bz9_0VdXvv9bWUtqM0NBYzhKZ3c/view?usp=sharing&resourcekey=0-7zGUhDz0APEfX58SA8UKog

 The Chinook Database is about an imaginary video and music store. Each track is stored using
 one of the digital formats and has a genre. The store has also some playlists, where a single track
 can be part of several playlists. Orders are recorded for customers, but are called invoices. Every
 customer is assigned a support employee, and Employees report to other employees.
*/


-- MAKE YOURSELF FAIMLIAR WITH THE DATABASE AND TABLES HERE

SELECT * FROM artists;
SELECT * FROM albums;
SELECT * FROM customers;
SELECT * FROM genres;
SELECT * FROM employees;
SELECT * FROM invoices;
SELECT * FROM media_types;
SELECT * FROM invoice_items;
SELECT * FROM playlists;
SELECT * FROM playlist_track;
SELECT * FROM tracks;

--==================================================================
/* TASK I
Which artists did not make any albums at all? Include their names in your answer.
*/

SELECT artists.Name, albums.Title FROM artists
  LEFT JOIN albums ON albums.ArtistID=artists.ArtistId
  WHERE Title IS NULL
  ORDER BY Name;

/* TASK II
Which artists recorded any tracks of the Latin genre?
tracks, artists, genre*/

SELECT DISTINCT artists.Name AS 'Artist' FROM artists
  JOIN albums ON albums.ArtistId=artists.ArtistId
  JOIN tracks ON tracks.AlbumId=albums.AlbumId
  JOIN genres ON genres.GenreId=tracks.GenreId
  WHERE genres.Name='Latin';

/* TASK III
Which video track has the longest length?
media_types.MediaTypeId IS 3 for video, tracks.Milliseconds, */

SELECT tracks.Name, media_types.Name, tracks.Milliseconds AS 'Duration' FROM media_types
  JOIN tracks ON tracks.MediaTypeId=media_types.MediaTypeId
  WHERE media_types.Name LIKE '%video%'
  ORDER BY Duration DESC
  LIMIT 1;

/* TASK IV
Find the names of customers who live in the same city as the top employee
(The one not managed by anyone).
*/

SELECT
  customers.FirstName AS 'CustFirst',
  customers.LastName AS 'CustLast',
  customers.City AS 'CustCity',
  employees.FirstName AS 'EmpFirst',
  employees.LastName AS 'EmpLast',
  employees.City AS 'EmpCity'
FROM customers, employees
  WHERE ReportsTo IS NULL
    AND CustCity=EmpCity;

/* Check the customer directory for customers living in Edmonton */
SELECT * FROM customers
WHERE customers.City='Edmonton';

/* TASK V
Find the managers of employees supporting Brazilian customers.
*/

SELECT
  A.FirstName AS 'EmpFirst',
  A.LastName AS 'EmpLast',
  A.Title AS 'Title',
  A.ReportsTo AS 'ReportsTo',
  customers.FirstName AS 'CustFirst',
  customers.LastName AS 'CustLast',
  customers.City AS 'City',
  customers.Country AS 'Country'
FROM employees AS 'A', employees AS 'B'
JOIN customers ON A.EmployeeId=customers.SupportRepId
WHERE customers.Country='Brazil';

SELECT
  A.FirstName AS 'EmpFirst',
  A.LastName AS 'EmpLast',
  A.Title AS 'Title',
  B.FirstName AS 'MngrFirst',
  B.LastName As 'MngrLast',
  customers.Country AS 'SupportedCountry'
FROM employees AS 'A', employees AS 'B'
JOIN customers ON A.EmployeeId=customers.SupportRepId
WHERE customers.Country='Brazil' AND A.ReportsTo=B.EmployeeId;

/* TASK VI
Which playlists have no Latin tracks?
*/

SELECT DISTINCT PlaylistId FROM playlist_track
JOIN tracks ON tracks.TrackId=playlist_track.TrackId
JOIN genres ON genres.GenreId=tracks.GenreId
WHERE genres.Name IS NOT 'Latin'
ORDER BY PlaylistId;