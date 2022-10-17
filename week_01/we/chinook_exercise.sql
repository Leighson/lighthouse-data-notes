/* SQL Exercise
====================================================================
We will be working with database chinook.db
You can download it here: https://drive.google.com/file/d/0Bz9_0VdXvv9bWUtqM0NBYzhKZ3c/view?usp=sharing&resourcekey=0-7zGUhDz0APEfX58SA8UKog

 The Chinook Database is about an imaginary video and music store. Each track is stored using one of the digital formats and has a genre. The store has also some playlists, where a single track can be part of several playlists. Orders are recorded for customers, but are called invoices. Every customer is assigned a support employee, and Employees report to other employees.
*/


-- MAKE YOURSELF FAIMLIAR WITH THE DATABASE AND TABLES HERE

/*SELECT * FROM artists ORDER BY Name;
SELECT * FROM albums;
SELECT * FROM customers;
SELECT * FROM genres;
SELECT * FROM employees;
SELECT * FROM invoices;
SELECT * FROM media_types;
SELECT * FROM invoice_items;*/

SELECT genres.Name,* FROM playlist_track
  JOIN tracks ON playlist_track.TrackID=tracks.TrackId
  JOIN genres ON genres.GenreId=tracks.GenreId
 WHERE PlaylistId=1 AND genres.Name='Latin';

SELECT * FROM playlists WHERE Name='Music Videos';
SELECT * FROM tracks;

--==================================================================
/* TASK I
Which artists did not make any albums at all? Include their names in your answer.
*/
SELECT artists.Name AS No_Albums FROM artists
  LEFT OUTER JOIN albums ON artists.ArtistId=albums.ArtistId
  GROUP BY Name HAVING COUNT(albums.AlbumId)=0
  ORDER BY Name;

/* TASK II
Which artists recorded any tracks of the Latin genre?
tracks, artists, genre*/
SELECT artists.Name FROM artists
  JOIN albums ON albums.ArtistId=artists.ArtistId
  JOIN tracks ON tracks.AlbumID=albums.AlbumId
  JOIN genres ON genres.GenreID=tracks.GenreId
 GROUP BY artists.Name HAVING genres.Name = 'Latin';

/* TASK III
Which video track has the longest length?
media_types.MediaTypeId IS 3 for video, tracks.Milliseconds, */
SElECT tracks.Name, MAX(tracks.Milliseconds) AS Track_Length FROM tracks
  JOIN media_types ON media_types.MediaTypeId=tracks.MediaTypeId
 WHERE media_types.MediaTypeId=3;

/* TASK IV
Find the names of customers who live in the same city as the top employee (The one not managed by anyone).
*/
SELECT
    customers.FirstName || ' ' || customers.LastName AS Customer,
    employees.FirstName || ' ' || employees.LastName AS Employee,
    employees.City
    FROM customers
  JOIN employees ON customers.City=employees.City;

/* TASK V
Find the managers of employees supporting Brazilian customers.
*/

SELECT slaves.FirstName, manager.FirstName || ' ' || manager.LastName AS Manager, customers.Country
  FROM employees manager
  JOIN employees slaves ON manager.EmployeeId=slaves.ReportsTo
  JOIN customers ON SupportRepId=slaves.EmployeeId
 WHERE customers.Country='Brazil';

/* TASK VI
Which playlists have no Latin tracks?
*/

SELECT playlists.Name, playlists.PlaylistId FROM playlists
  JOIN playlist_track ON playlist_track.PlaylistId= playlists.PlaylistId
  JOIN tracks ON tracks.TrackID=playlist_track.TrackId
  JOIN genres ON genres.GenreId=tracks.GenreId
 WHERE genres.Name!='Latin'
 ORDER BY playlists.Name;