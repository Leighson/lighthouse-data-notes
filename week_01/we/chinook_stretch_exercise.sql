/* SQL Stretch Exercise
====================================================================
We will be working with database chinook.db
You can download it here: https://drive.google.com/file/d/0Bz9_0VdXvv9bWUtqM0NBYzhKZ3c/view?usp=sharing&resourcekey=0-7zGUhDz0APEfX58SA8UKog

 The Chinook Database is about an imaginary video and music store. Each track is stored using one of the digital formats and has a genre. The store has also some playlists, where a single track can be part of several playlists. Orders are recorded for customers, but are called invoices. Every customer is assigned a support employee, and Employees report to other employees.
*/

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
How many audio tracks in total were bought by German customers? And what was the total price paid for them?
hint: use subquery to find all of tracks with their prices
*/

/* Check tracks bought by German customers */
SELECT
    tracks.Name AS 'Track',
    media_types.Name AS 'Type',
    invoices.BillingCountry AS 'Country',
    invoice_items.UnitPrice AS 'UnitPrice'
FROM invoices
JOIN customers ON customers.CustomerId=invoices.CustomerId
JOIN invoice_items ON invoice_items.InvoiceId=invoices.InvoiceId
JOIN tracks ON tracks.TrackId=invoice_items.TrackId
JOIN media_types ON media_types.MediaTypeId=tracks.MediaTypeId
WHERE tracks.TrackID IN (
    SELECT tracks.TrackID FROM tracks
    JOIN media_types ON media_types.MediaTypeId=tracks.MediaTypeId
    WHERE media_types.Name IS NOT 'Protected MPEG-4 video file')
AND customers.Country='Germany';

/* Sum and count of invoice items */
SELECT COUNT(*) AS 'NumberOfTracks', SUM(tracks.UnitPrice) AS 'TotalPricePaid' FROM invoices
JOIN customers ON customers.CustomerId=invoices.CustomerId
JOIN invoice_items ON invoice_items.InvoiceId=invoices.InvoiceId
JOIN tracks ON tracks.TrackId=invoice_items.TrackId
JOIN media_types ON media_types.MediaTypeId=tracks.MediaTypeId
WHERE tracks.TrackID IN (
    SELECT tracks.TrackID FROM tracks
    JOIN media_types ON media_types.MediaTypeId=tracks.MediaTypeId
    WHERE media_types.Name IS NOT 'Protected MPEG-4 video file')
AND customers.Country='Germany';

/* TASK II
What is the space, in bytes, occupied by the playlist “Grunge”, and how much would it cost?
(Assume that the cost of a playlist is the sum of the price of its constituent tracks).
*/

SELECT SUM(tracks.Bytes), SUM(tracks.UnitPrice) FROM tracks
WHERE tracks.TrackId IN (
    SELECT playlist_track.TrackId FROM playlists
    JOIN playlist_track ON playlist_track.PlaylistId=playlists.PlaylistId
    WHERE playlists.Name IS 'Grunge'
    );

/* TASK III
List the names and the countries of those customers who are supported by an employee who was younger than 35 when hired. 
*/

SELECT (customers.FirstName || ' ' || customers.LastName) AS Name, customers.Country FROM customers
WHERE customers.SupportRepId IN (
    SELECT employees.EmployeeId FROM employees
    WHERE employees.HireDate-employees.BirthDate < 35
    )
ORDER BY customers.LastName;