--before index creation
'EXPLAIN ANALYZE' select u.user_id,u.first_name, COUNT(b.booking_id)AS total_bookings FROM user u LEFT JOIN booking b ON u.user_id = b.user_id GROUP BY  u.user_id,u.first_name
ORDER BY u.user_id;
--most columns on user table
--user_id as primary key index is AUTOMATICALLY created
CREATE INDEX idx_user_first_name ON user(first_name);
--most columns on property table
---property_id as PK index is automaticallycreated
CREATE INDEX idx_property_name ON property(name)
-
--- Property after creation
'EXPLAIN ANALYZE' SELECT u.user_id, u.first_name, COUNT(b.booking_id) 
AS total_bookings FROM  user   u LEFT JOIN booking b
ON u.user_id= b.user_id
GROUP BY u.user_id, u.first_name
ORDER BY u.user_id;

EXPLAIN ANALYZE SELECT u.user_id, u.first_name, COUNT(b.booking_id) AS total_bookings
FROM user u
LEFT JOIN booking b ON u.user_id = b.user_id
GROUP BY u.user_id, u.first_name
ORDER BY u.user_id;
