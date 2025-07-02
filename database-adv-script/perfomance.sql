
EXPLAIN ANALYZE
SELECT
    b.booking_id,
    b.property_id,
    b.start_date,
    b.end_date,
    b.user_id,
    u.first_name,
    u.last_name,
    u.email,
   p.property_id,
    p.name AS property_name,
    p.location,
    py.payment_id,
    py.payment_date,
    py.amount,
    py.payment_method
FROM
    bookings b
JOIN
    users u ON b.user_id = u.user_id
JOIN
    properties p ON b.property_id = p.property_id
 LEFT JOIN
    payments py ON b.booking_id = py.booking_id;
WHERE
    b.start_date >= '2025-07-01' AND b.start_date < '2025-08-01';
