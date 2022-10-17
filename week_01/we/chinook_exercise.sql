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



/* TASK IV
Find the names of customers who live in the same city as the top employee (The one not managed by anyone).
*/



/* TASK V
Find the managers of employees supporting Brazilian customers.
*/



/* TASK VI
Which playlists have no Latin tracks?
*/

