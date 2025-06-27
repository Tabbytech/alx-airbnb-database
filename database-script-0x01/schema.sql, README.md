Design Database Schema (DDL)<br/>
-- Create the User table<br/>
CREATE TABLE User (<br/>
    user_id UUID PRIMARY KEY DEFAULT gen_random_uuid(), -- Primary Key, UUID, Default to a new UUID<br/>
    first_name VARCHAR(255) NOT NULL,<br/>
    last_name VARCHAR(255) NOT NULL,<br/>
    email VARCHAR(255) UNIQUE NOT NULL, -- Unique constraint for email<br/>
    password_hash VARCHAR(255) NOT NULL,<br/>
    phone_number VARCHAR(20), -- NULLable<br/>
    role ENUM('guest', 'host', 'admin') NOT NULL, -- ENUM constraint<br/>
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- Default to current timestamp<br/>
);<br/>

-- Index on user_id for optimal performance (already implied by Primary Key, but explicit index can be beneficial for some DBs)<br/>
CREATE INDEX idx_user_id ON User (user_id);<br/>
-- Index on email for fast lookups<br/>
CREATE INDEX idx_user_email ON User (email);<br/>


-- Create the Property table<br/>
CREATE TABLE Property (<br/>
    property_id UUID PRIMARY KEY DEFAULT gen_random_uuid(), -- Primary Key, UUID<br/>
    host_id UUID NOT NULL, -- Foreign Key<br/>
    name VARCHAR(255) NOT NULL,<br/>
    description TEXT NOT NULL,<br/>
    location VARCHAR(255) NOT NULL,<br/>
    pricepernight DECIMAL(10, 2) NOT NULL, -- DECIMAL for currency, 10 total digits, 2 after decimal<br/>
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,<br/>
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- Automatically updates on row modification<br/>
    
    -- Foreign Key constraint referencing User table<br/>
    FOREIGN KEY (host_id) REFERENCES User(user_id)<br/>
);<br/>

-- Index on property_id<br/>
CREATE INDEX idx_property_id ON Property (property_id);<br/>
-- Index on host_id for efficient lookups of properties by host<br/>
CREATE INDEX idx_property_host_id ON Property (host_id);<br/>
-- Index on location for location-based searches<br/>
CREATE INDEX idx_property_location ON Property (location);<br/>


-- Create the Booking table<br/>
CREATE TABLE Booking (<br/>
    booking_id UUID PRIMARY KEY DEFAULT gen_random_uuid(), -- Primary Key, UUID<br/>
    property_id UUID NOT NULL, -- Foreign Key<br/>
    user_id UUID NOT NULL, -- Foreign Key<br/>
    start_date DATE NOT NULL,<br/>
    end_date DATE NOT NULL,<br/>
    total_price DECIMAL(10, 2) NOT NULL,<br/>
    status ENUM('pending', 'confirmed', 'canceled') NOT NULL, -- ENUM constraint<br/>
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,<br/>

    -- Foreign Key constraints<br/>
    FOREIGN KEY (property_id) REFERENCES Property(property_id),<br/>
    FOREIGN KEY (user_id) REFERENCES User(user_id),<br/>

    -- Constraint to ensure end_date is after start_date<br/>
    CHECK (end_date >= start_date)<br/>
);<br/>

-- Index on booking_id<br/>
CREATE INDEX idx_booking_id ON Booking (booking_id);<br/>
-- Index on property_id for bookings related to a property<br/>
CREATE INDEX idx_booking_property_id ON Booking (property_id);<br/>
-- Index on user_id for bookings made by a user<br/>
CREATE INDEX idx_booking_user_id ON Booking (user_id);<br/>
-- Index on start_date and end_date for date range queries<br/>
CREATE INDEX idx_booking_dates ON Booking (start_date, end_date);<br/>


-- Create the Payment table<br/>
CREATE TABLE Payment (<br/>
    payment_id UUID PRIMARY KEY DEFAULT gen_random_uuid(), -- Primary Key, UUID<br/>
    booking_id UUID NOT NULL, -- Foreign Key<br/>
    amount DECIMAL(10, 2) NOT NULL,<br/>
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,<br/>
    payment_method ENUM('credit_card', 'paypal', 'stripe') NOT NULL, -- ENUM constraint<br/>

    -- Foreign Key constraint referencing Booking table<br/>
    FOREIGN KEY (booking_id) REFERENCES Booking(booking_id)<br/>
);<br/>

-- Index on payment_id<br/>
CREATE INDEX idx_payment_id ON Payment (payment_id);<br/>
-- Index on booking_id for payments related to a booking<br/>
CREATE INDEX idx_payment_booking_id ON Payment (booking_id);<br/>


-- Create the Review table<br/>
CREATE TABLE Review (<br/>
    review_id UUID PRIMARY KEY DEFAULT gen_random_uuid(), -- Primary Key, UUID<br/>
    property_id UUID NOT NULL, -- Foreign Key<br/>
    user_id UUID NOT NULL, -- Foreign <br/>
    rating INTEGER NOT NULL,<br/>
    comment TEXT NOT NULL,<br/>
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,<br/>

    -- Foreign Key constraints<br/>
    FOREIGN KEY (property_id) REFERENCES Property(property_id),<br/>
    FOREIGN KEY (user_id) REFERENCES User(user_id),<br/>

    -- Check constraint for rating<br/>
    CHECK (rating >= 1 AND rating <= 5)<br/>
);<br/>

Index on review_id<br/>
CREATE INDEX idx_review_id ON Review (review_id);<br/>
Index on property_id for reviews of a property<br/>
CREATE INDEX idx_review_property_id ON Review (property_id);<br/>
Index on user_id for reviews by a user<br/>
CREATE INDEX idx_review_user_id ON Review (user_id);<br/>


Create the Message table<br/>
CREATE TABLE Message (<br/>
    message_id UUID PRIMARY KEY DEFAULT gen_random_uuid(), -- Primary Key, UUID<br/>
    sender_id UUID NOT NULL, -- Foreign Key<br/>
    recipient_id UUID NOT NULL, -- Foreign Key<br/>
    message_body TEXT NOT NULL,<br/>
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,<br/>

    -- Foreign Key constraints<br/>
    FOREIGN KEY (sender_id) REFERENCES User(user_id),<br/>
    FOREIGN KEY (recipient_id) REFERENCES User(user_id)<br/>
);<br/>
-- Index on message_id<br/>
CREATE INDEX idx_message_id ON Message (message_id);<br/>
-- Index on sender_id for messages sent by a user<br/>
CREATE INDEX idx_message_sender_id ON Message (sender_id);<br/>
-- Index on recipient_id for messages received by a user<br/>
CREATE INDEX idx_message_recipient_id ON Message (recipient_id);<br/>
-- Index on sent_at for chronological message retrieval<br/>
CREATE INDEX idx_message_sent_at ON Message (sent_at);<br/>
