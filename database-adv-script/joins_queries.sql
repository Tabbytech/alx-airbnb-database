--all bookings and the respective users who made those bookings.
--INNER JOIN
SELECT * FROM booking
INNER JOIN User 
  ON booking.user_id = user.user_id;

--all properties and their reviews, including properties that have no reviews.
--LEFT JOIN
 SELECT * FROM Property 
  LEFT JOIN Review 
  ON property.property_id = review.property_id
   ORDER BY property.property_id;

--all users and all bookings, even if the user has no booking or a booking is not linked to a user.
--FULL OUTER JOIN
SELECT * FROM User 
FULL OUTER JOIN Booking 
  ON user.user_id = booking.user_id;
