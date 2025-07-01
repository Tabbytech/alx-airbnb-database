-- Before Index Creation

EXPLAIN ANALYZE
SELECT
    u.user_id,
    u.first_name,
    COUNT(b.booking_id) AS total_bookings
FROM
    user u
LEFT JOIN
    booking b ON u.user_id = b.user_id
GROUP BY
    u.user_id,
    u.first_name
ORDER BY
    u.user_id;

-- Notes:
-- Most columns on user table.
-- user_id as primary key index is AUTOMATICALLY created.
-- At this point, no other custom indexes exist.

-- Index Creation (These are your DDL statements)
CREATE INDEX idx_user_first_name ON user(first_name);
-- Most columns on property table.
-- property_id as PK index is automatically created.
CREATE INDEX idx_property_name ON property(name);

-- After Index Creation

EXPLAIN ANALYZE
SELECT
    u.user_id,
    u.first_name,
    COUNT(b.booking_id) AS total_bookings
FROM
    user u
LEFT JOIN
    booking b ON u.user_id = b.user_id
GROUP BY
    u.user_id,
    u.first_name
ORDER BY
    u.user_id;

