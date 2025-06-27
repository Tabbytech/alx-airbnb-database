```sql
-- Create the User table
CREATE TABLE User (
    user_id UUID PRIMARY KEY DEFAULT gen_random_uuid(), -- Primary Key, UUID, Default to a new UUID
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL, -- Unique constraint for email
    password_hash VARCHAR(255) NOT NULL,
    phone_number VARCHAR(20), -- NULLable
    role ENUM('guest', 'host', 'admin') NOT NULL, -- ENUM constraint
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- Default to current timestamp
);

-- Index on user_id for optimal performance (already implied by Primary Key, but explicit index can be beneficial for some DBs)
CREATE INDEX idx_user_id ON User (user_id);
-- Index on email for fast lookups
CREATE INDEX idx_user_email ON User (email);


-- Create the Property table
CREATE TABLE Property (
    property_id UUID PRIMARY KEY DEFAULT gen_random_uuid(), -- Primary Key, UUID
    host_id UUID NOT NULL, -- Foreign Key
    name VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    location VARCHAR(255) NOT NULL,
    pricepernight DECIMAL(10, 2) NOT NULL, -- DECIMAL for currency, 10 total digits, 2 after decimal
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- Automatically updates on row modification
    
    -- Foreign Key constraint referencing User table
    FOREIGN KEY (host_id) REFERENCES User(user_id)
);

-- Index on property_id
CREATE INDEX idx_property_id ON Property (property_id);
-- Index on host_id for efficient lookups of properties by host
CREATE INDEX idx_property_host_id ON Property (host_id);
-- Index on location for location-based searches
CREATE INDEX idx_property_location ON Property (location);


-- Create the Booking table
CREATE TABLE Booking (
    booking_id UUID PRIMARY KEY DEFAULT gen_random_uuid(), -- Primary Key, UUID
    property_id UUID NOT NULL, -- Foreign Key
    user_id UUID NOT NULL, -- Foreign Key
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    status ENUM('pending', 'confirmed', 'canceled') NOT NULL, -- ENUM constraint
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    -- Foreign Key constraints
    FOREIGN KEY (property_id) REFERENCES Property(property_id),
    FOREIGN KEY (user_id) REFERENCES User(user_id),

    -- Constraint to ensure end_date is after start_date
    CHECK (end_date >= start_date)
);

-- Index on booking_id
CREATE INDEX idx_booking_id ON Booking (booking_id);
-- Index on property_id for bookings related to a property
CREATE INDEX idx_booking_property_id ON Booking (property_id);
-- Index on user_id for bookings made by a user
CREATE INDEX idx_booking_user_id ON Booking (user_id);
-- Index on start_date and end_date for date range queries
CREATE INDEX idx_booking_dates ON Booking (start_date, end_date);


-- Create the Payment table
CREATE TABLE Payment (
    payment_id UUID PRIMARY KEY DEFAULT gen_random_uuid(), -- Primary Key, UUID
    booking_id UUID NOT NULL, -- Foreign Key
    amount DECIMAL(10, 2) NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_method ENUM('credit_card', 'paypal', 'stripe') NOT NULL, -- ENUM constraint

    -- Foreign Key constraint referencing Booking table
    FOREIGN KEY (booking_id) REFERENCES Booking(booking_id)
);

-- Index on payment_id
CREATE INDEX idx_payment_id ON Payment (payment_id);
-- Index on booking_id for payments related to a booking
CREATE INDEX idx_payment_booking_id ON Payment (booking_id);


-- Create the Review table
CREATE TABLE Review (
    review_id UUID PRIMARY KEY DEFAULT gen_random_uuid(), -- Primary Key, UUID
    property_id UUID NOT NULL, -- Foreign Key
    user_id UUID NOT NULL, -- Foreign Key
    rating INTEGER NOT NULL,
    comment TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    -- Foreign Key constraints
    FOREIGN KEY (property_id) REFERENCES Property(property_id),
    FOREIGN KEY (user_id) REFERENCES User(user_id),

    -- Check constraint for rating
    CHECK (rating >= 1 AND rating <= 5)
);

-- Index on review_id
CREATE INDEX idx_review_id ON Review (review_id);
-- Index on property_id for reviews of a property
CREATE INDEX idx_review_property_id ON Review (property_id);
-- Index on user_id for reviews by a user
CREATE INDEX idx_review_user_id ON Review (user_id);


-- Create the Message table
CREATE TABLE Message (
    message_id UUID PRIMARY KEY DEFAULT gen_random_uuid(), -- Primary Key, UUID
    sender_id UUID NOT NULL, -- Foreign Key
    recipient_id UUID NOT NULL, -- Foreign Key
    message_body TEXT NOT NULL,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    -- Foreign Key constraints
    FOREIGN KEY (sender_id) REFERENCES User(user_id),
    FOREIGN KEY (recipient_id) REFERENCES User(user_id)
);

-- Index on message_id
CREATE INDEX idx_message_id ON Message (message_id);
-- Index on sender_id for messages sent by a user
CREATE INDEX idx_message_sender_id ON Message (sender_id);
-- Index on recipient_id for messages received by a user
CREATE INDEX idx_message_recipient_id ON Message (recipient_id);
-- Index on sent_at for chronological message retrieval
CREATE INDEX idx_message_sent_at ON Message (sent_at);
```
