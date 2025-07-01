--bookings made by each user, using the COUNT function and GROUP BY clause.
SELECT  u.user_id, u.first_name, u.last_name, u.email,
FROM User AS u
LEFT JOIN booking AS b  ON u.user_id = b.user_id
GROUP BY   u.user_id, u.first_name,  u.last_name, u.email
ORDER BY u.user_id ;
--a window function (ROW_NUMBER, RANK) to rank properties based on the total number of bookings they have received.
SELECT p.property_id,p.name, COUNT(b.booking_id) AS TotalBookings,
    ROW_NUMBER() OVER(ORDER BY COUNT(b.booking_id() DESC) AS "row_number",
     RANK() OVER (ORDER BY  COUNT (b.booking_id) DESC) AS booking_rank
FROM property p
LEFT JOIN booking b ON p.property_id = b.property_id
GROUP BY property_id, p.name
ORDER BY booking_rank, "row_number";
