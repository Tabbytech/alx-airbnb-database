-- Index on Property.host_id
-- Improves performance for queries filtering properties by host or joining with the User table on host_id.
CREATE INDEX idx_property_host_id ON Property (host_id);

-- Index on Booking.user_id
-- Speeds up queries retrieving bookings made by a specific user or joining with the User table on user_id.
CREATE INDEX idx_booking_user_id ON Booking (user_id);

-- Index on Booking.status
-- Enhances performance for queries filtering bookings based on their status (e.g., 'pending', 'confirmed').
CREATE INDEX idx_booking_status ON Booking (status);

-- Index on Booking.start_date
-- Crucial for efficient date range queries and sorting bookings by their start date.
CREATE INDEX idx_booking_start_date ON Booking (start_date);

-- Index on Review.user_id
-- Improves performance for queries retrieving reviews made by a specific user.
CREATE INDEX idx_review_user_id ON Review (user_id);

-- Index on Review.rating
-- Useful for queries filtering reviews by rating or aggregating ratings (e.g., calculating average rating for a property).
CREATE INDEX idx_review_rating ON Review (rating);

-- Index on Message.sender_id
-- Accelerates retrieval of messages sent by a particular user.
CREATE INDEX idx_message_sender_id ON Message (sender_id);

-- Index on Message.recipient_id
-- Accelerates retrieval of messages received by a particular user.
CREATE INDEX idx_message_recipient_id ON Message (recipient_id);
