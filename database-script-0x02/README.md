Database Schema and Sample Data Explanation<br/>
This document provides a detailed explanation of the SQL schema for our booking platform and demonstrates how sample data populates these tables, illustrating real-world scenarios.<br/>

1. Database Schema (CREATE TABLE Statements)<br/>
The CREATE TABLE statements define the structure of our database. Each table represents a core entity in our booking system, with carefully selected data types, primary keys, foreign keys, and constraints to ensure data integrity and optimize performance.
<br/>
User Table<br/>
This table stores information about everyone who uses our platform, whether they are a 'guest' looking for a place to stay, a 'host' listing properties, or an 'admin' managing the system.<br/>

SQL<br/>

CREATE TABLE User (<br/>
    user_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),<br/>
    first_name VARCHAR(255) NOT NULL,<br/>
    last_name VARCHAR(255) NOT NULL,<br/>
    email VARCHAR(255) UNIQUE NOT NULL,<br/>
    password_hash VARCHAR(255) NOT NULL,<br/>
    phone_number VARCHAR(20),<br/>
    role ENUM('guest', 'host', 'admin') NOT NULL,<br/>
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP<br/>
);<br/>
CREATE INDEX idx_user_id ON User (user_id);<br/>
CREATE INDEX idx_user_email ON User (email);<br/>
user_id (Primary Key, UUID): A unique identifier for each user (e.g., 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11' for Alice Smith). Using UUIDs ensures global uniqueness without relying on sequential numbers.
<br/>
first_name, last_name: Standard text fields for names (e.g., 'Alice', 'Smith').<br/>

email (Unique, NOT NULL): Stores the user's email, which must be unique for each user (e.g., 'alice.smith@example.com'). Essential for login and communication.<br/>

password_hash: A secure, hashed version of the user's password (e.g., 'hashed_password_alice').<br/>

phone_number (Nullable): The user's phone number, optional for registration.<br/>

role (ENUM): Defines the user's role, restricted to 'guest', 'host', or 'admin'. This controls what actions a user can perform on the platform.<br/>

created_at: Automatically records when the user account was created.<br/>

Indexes (idx_user_id, idx_user_email): These speed up searches, especially when logging in or looking up users by their ID or email.<br/>

Property Table<br/>
This table lists all the properties available for booking on the platform, managed by a 'host' user.<br/>

SQL<br/>

CREATE TABLE Property (<br/>
    property_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),<br/>
    host_id UUID NOT NULL,<br/>
    name VARCHAR(255) NOT NULL,<br/>
    description TEXT NOT NULL,<br/>
    location VARCHAR(255) NOT NULL,<br/>
    pricepernight DECIMAL(10, 2) NOT NULL,<br/>
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,<br/>
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,<br/>
    FOREIGN KEY (host_id) REFERENCES User(user_id)<br/>
);
CREATE INDEX idx_property_id ON Property (property_id);<br/>
CREATE INDEX idx_property_host_id ON Property (host_id);<br/>
CREATE INDEX idx_property_location ON Property (location);<br/>
property_id (Primary Key, UUID): Unique identifier for each property (e.g., 'b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b11' for "Cozy Downtown Apartment").<br/>

host_id (Foreign Key): Links to the user_id in the User table, indicating which host owns this property (e.g., Alice Smith (a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11) owns the "Cozy Downtown Apartment").
<br/>
name, description: Details about the property (e.g., 'Cozy Downtown Apartment', 'A charming apartment...').<br/>

location: Where the property is located (e.g., 'New York, NY').<br/>

pricepernight: The cost to rent the property for one night (e.g., 150.00).<br/>

created_at, updated_at: Timestamps to track when the listing was created and last modified. updated_at automatically updates.<br/>

Indexes: Help find properties quickly by their ID, host, or location.<br/>

Booking Table<br/>
This table records specific reservations made by guests for properties.<br/>

SQL<br/>

CREATE TABLE Booking (<br/>
    booking_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),<br/>
    property_id UUID NOT NULL,<br/>
    user_id UUID NOT NULL,<br/>
    start_date DATE NOT NULL,<br/>
    end_date DATE NOT NULL,<br/>
    total_price DECIMAL(10, 2) NOT NULL,<br/>
    status ENUM('pending', 'confirmed', 'canceled') NOT NULL,<br/>
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,<br/>
    FOREIGN KEY (property_id) REFERENCES Property(property_id),<br/>
    FOREIGN KEY (user_id) REFERENCES User(user_id),<br/>
    CHECK (end_date >= start_date)<br/>
);<br/>
CREATE INDEX idx_booking_id ON Booking (booking_id);<br/>
CREATE INDEX idx_booking_property_id ON Booking (property_id);<br/>
CREATE INDEX idx_booking_user_id ON Booking (user_id);<br/>
CREATE INDEX idx_booking_dates ON Booking (start_date, end_date);<br/>
booking_id (Primary Key, UUID): Unique identifier for each booking (e.g., 'c0eebc99-9c0b-4ef8-bb6d-6bb9bd380c11').<br/>
<br/>
property_id (Foreign Key): Links to the property_id in the Property table (e.g., Bob Johnson (a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a12) booked the "Cozy Downtown Apartment" (b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b11)).
<br/>
user_id (Foreign Key): Links to the user_id in the User table (e.g., Bob Johnson made the booking).<br/>

start_date, end_date: The period of the booking (e.g., '2024-07-01' to '2024-07-07').<br/>

total_price: The final calculated cost for the entire booking duration (e.g., 900.00).<br/>

status (ENUM): The current state of the booking ('pending', 'confirmed', or 'canceled').<br/>

created_at: Records when the booking was made.<br/>

CHECK (end_date >= start_date): Ensures that a booking's end date is not before its start date.<br/>

Indexes: Facilitate quick searches for bookings by ID, property, user, or date ranges.<br/>

Payment Table<br/>
This table tracks all payment transactions associated with bookings.<br/>

SQL<br/>

CREATE TABLE Payment (<br/>
    payment_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),<br/>
    booking_id UUID NOT NULL,<br/>
    amount DECIMAL(10, 2) NOT NULL,<br/>
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,<br/>
    payment_method ENUM('credit_card', 'paypal', 'stripe') NOT NULL,<br/>
    FOREIGN KEY (booking_id) REFERENCES Booking(booking_id)<br/>
);<br/>
CREATE INDEX idx_payment_id ON Payment (payment_id);<br/>
CREATE INDEX idx_payment_booking_id ON Payment (booking_id);<br/>
payment_id (Primary Key, UUID): Unique ID for each payment (e.g., 'd0eebc99-9c0b-4ef8-bb6d-6bb9bd380d11').<br/>

booking_id (Foreign Key): Links to the booking_id in the Booking table (e.g., this payment of 900.00 is for booking 'c0eebc99-9c0b-4ef8-bb6d-6bb9bd380c11').<br/>

amount: The amount paid (e.g., 900.00).<br/>

payment_date: The exact date and time the payment was processed.<br/>

payment_method (ENUM): How the payment was made ('credit_card', 'paypal', or 'stripe').<br/>

Indexes: Optimize retrieval of payments by ID or associated booking.<br/>

Review Table<br/>
This table stores feedback (ratings and comments) provided by guests about properties they have stayed in.<br/>

SQL<br/>

CREATE TABLE Review (<br/>
    review_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),<br/>
    property_id UUID NOT NULL,<br/>
    user_id UUID NOT NULL,<br/>
    rating INTEGER NOT NULL,<br/>
    comment TEXT NOT NULL,<br/>
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,<br/>
    FOREIGN KEY (property_id) REFERENCES Property(property_id),<br/>
    FOREIGN KEY (user_id) REFERENCES User(user_id),<br/>
    CHECK (rating >= 1 AND rating <= 5)<br/>
);<br/>
CREATE INDEX idx_review_id ON Review (review_id);<br/>
CREATE INDEX idx_review_property_id ON Review (property_id);<br/>
CREATE INDEX idx_review_user_id ON Review (user_id);<br/>
review_id (Primary Key, UUID): Unique ID for each review (e.g., 'e0eebc99-9c0b-4ef8-bb6d-6bb9bd380e11').<br/>

property_id (Foreign Key): Links to the property_id of the reviewed property (e.g., this review is for "Cozy Downtown Apartment" (b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b11)).<br/>

user_id (Foreign Key): Links to the user_id of the user who wrote the review (e.g., Bob Johnson (a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a12) wrote this review).<br/>

rating: An integer representing the rating (1-5 stars, e.g., 5).<br/>

comment: The written feedback from the user (e.g., 'Absolutely loved the apartment! Clean, cozy, and great location.').<br/>

created_at: Records when the review was submitted.<br/>

CHECK (rating >= 1 AND rating <= 5): Enforces that ratings are always between 1 and 5.<br/>

Indexes: Allow efficient lookup of reviews by ID, property, or reviewer.<br/>

Message Table<br/>
This table facilitates direct communication between users on the platform.<br/>

SQL<br/>

CREATE TABLE Message (<br/>
    message_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),<br/>
    sender_id UUID NOT NULL,<br/>
    recipient_id UUID NOT NULL,<br/>
    message_body TEXT NOT NULL,<br/>
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,<br/>
    FOREIGN KEY (sender_id) REFERENCES User(user_id),<br/>
    FOREIGN KEY (recipient_id) REFERENCES User(user_id)<br/>
);<br/>
CREATE INDEX idx_message_id ON Message (message_id);<br/>
CREATE INDEX idx_message_sender_id ON Message (sender_id);<br/>
CREATE INDEX idx_message_recipient_id ON Message (recipient_id);<br/>
CREATE INDEX idx_message_sent_at ON Message (sent_at);<br/>
message_id (Primary Key, UUID): Unique ID for each message (e.g., 'f0eebc99-9c0b-4ef8-bb6d-6bb9bd380f11').<br/>

sender_id (Foreign Key): Links to the user_id of the message sender (e.g., Bob Johnson (a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a12) sent this message).<br/>

recipient_id (Foreign Key): Links to the user_id of the message recipient (e.g., Alice Smith (a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11) received this message).<br/>

message_body: The actual content of the message (e.g., 'Hi Alice, is the apartment available for July 1-7?').<br/>

sent_at: Records the date and time the message was sent.<br/>

Indexes: Aid in quickly retrieving messages by ID, sender, recipient, or chronological order.<br/>

2. Populating with Sample Data (INSERT Statements)<br/>
These INSERT statements demonstrate how data would be stored in the tables, simulating typical user interactions on our booking platform.<br/>

Users<br/>
We create a few users with different roles:<br/>

Alice Smith: A 'host' who lists properties.<br/>

Bob Johnson, Charlie Brown: 'guest' users who book properties.<br/>

Diana Prince: Another 'host'.<br/>

Eve Adams: An 'admin' user.<br/>

SQL<br/>

INSERT INTO User (user_id, first_name, last_name, email, password_hash, phone_number, role, created_at) VALUES<br/>
('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'Alice', 'Smith', 'alice.smith@example.com', 'hashed_password_alice', '111-222-3333', 'host', '2023-01-15 10:00:00'),<br/>
('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a12', 'Bob', 'Johnson', 'bob.johnson@example.com', 'hashed_password_bob', NULL, 'guest', '2023-02-01 11:30:00'),<br/>
('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a13', 'Charlie', 'Brown', 'charlie.brown@example.com', 'hashed_password_charlie', '444-555-6666', 'guest', '2023-03-10 14:00:00'),<br/>
('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a14', 'Diana', 'Prince', 'diana.prince@example.com', 'hashed_password_diana', '777-888-9999', 'host', '2023-04-20 09:15:00'),<br/>
('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a15', 'Eve', 'Adams', 'eve.adams@example.com', 'hashed_password_eve', NULL, 'admin', '2023-05-01 16:45:00');<br/>
Properties<br/>
We list properties owned by our hosts:<br/>

Cozy Downtown Apartment: Listed by Alice.<br/>

Spacious Family Villa: Listed by Diana.<br/>

Seaside Cottage: Also listed by Alice.<br/>

SQL<br/>

INSERT INTO Property (property_id, host_id, name, description, location, pricepernight, created_at) VALUES<br/>
('b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b11', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'Cozy Downtown Apartment', 'A charming apartment in the heart of the city, perfect for couples.', 'New York, NY', 150.00, '2023-01-20 12:00:00'),<br/>
('b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b12', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a14', 'Spacious Family Villa', 'Beautiful villa with a large garden and pool, ideal for family vacations.', 'Miami, FL', 300.00, '2023-04-25 10:30:00'),<br/>
('b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b13', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'Seaside Cottage', 'Quaint cottage with stunning ocean views, just steps from the beach.', 'Malibu, CA', 220.50, '2023-02-15 09:00:00');<br/>
Bookings<br/>
Here, we simulate various booking scenarios:<br/>

Bob books Alice's Downtown Apartment (confirmed).<br/>

Charlie attempts to book Diana's Miami Villa (pending).<br/>

Charlie also books Alice's Downtown Apartment but then cancels.<br/>

Bob books Alice's Seaside Cottage (confirmed).<br/>

SQL

INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, total_price, status, created_at) VALUES<br/>
('c0eebc99-9c0b-4ef8-bb6d-6bb9bd380c11', 'b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b11', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a12', '2024-07-01', '2024-07-07', 900.00, 'confirmed', '2024-06-15 14:30:00'),<br/>
('c0eebc99-9c0b-4ef8-bb6d-6bb9bd380c12', 'b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b12', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a13', '2024-08-10', '2024-08-20', 3000.00, 'pending', '2024-06-20 10:00:00'),<br/>
('c0eebc99-9c0b-4ef8-bb6d-6bb9bd380c13', 'b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b11', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a13', '2024-09-01', '2024-09-05', 600.00, 'canceled', '2024-06-22 11:00:00'),<br/>
('c0eebc99-9c0b-4ef8-bb6d-6bb9bd380c14', 'b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b13', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a12', '2024-10-15', '2024-10-20', 1102.50, 'confirmed', '2024-06-25 09:00:00');<br/>
Payments
Payments are recorded for confirmed bookings:<br/>

Payment for Bob's Downtown Apartment booking (credit card).<br/>

Payment for Charlie's Miami Villa booking (Paypal - even though pending, some systems might require payment upfront for pending).<br/>

Payment for Bob's Seaside Cottage booking (Stripe).<br/>

SQL<br/>

INSERT INTO Payment (payment_id, booking_id, amount, payment_date, payment_method) VALUES<br/>
('d0eebc99-9c0b-4ef8-bb6d-6bb9bd380d11', 'c0eebc99-9c0b-4ef8-bb6d-6bb9bd380c11', 900.00, '2024-06-15 14:35:00', 'credit_card'),<br/>
('d0eebc99-9c0b-4ef8-bb6d-6bb9bd380d12', 'c0eebc99-9c0b-4ef8-bb6d-6bb9bd380c12', 3000.00, '2024-06-20 10:05:00', 'paypal'),<br/>
('d0eebc99-9c0b-4ef8-bb6d-6bb9bd380d13', 'c0eebc99-9c0b-4ef8-bb6d-6bb9bd380c14', 1102.50, '2024-06-25 09:05:00', 'stripe');v
Reviews
Guests leave reviews after their stays:<br/>

Bob gives 5 stars to Alice's Downtown Apartment.<br/>

Bob gives 4 stars to Alice's Seaside Cottage.<br/>

SQL

INSERT INTO Review (review_id, property_id, user_id, rating, comment, created_at) VALUES<br/>
('e0eebc99-9c0b-4ef8-bb6d-6bb9bd380e11', 'b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b11', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a12', 5, 'Absolutely loved the apartment! Clean, cozy, and great location.', '2024-07-08 10:00:00'),<br/>
('e0eebc99-9c0b-4ef8-bb6d-6bb9bd380e12', 'b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b13', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a12', 4, 'Beautiful seaside cottage. The views were incredible. A bit small for a family of four.', '2024-10-21 11:30:00');<br/>
Messages<br/>
Simulating conversations between guests and hosts:<br/>

Bob asks Alice about apartment availability.<br/>

Alice replies to Bob.<br/>

Charlie inquires Diana about her Miami villa.<br/>

SQL<br/>

INSERT INTO Message (message_id, sender_id, recipient_id, message_body, sent_at) VALUES<br/>
('f0eebc99-9c0b-4ef8-bb6d-6bb9bd380f11', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a12', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'Hi Alice, is the apartment available for July 1-7?', '2024-06-14 10:00:00'),<br/>
('f0eebc99-9c0b-4ef8-bb6d-6bb9bd380f12', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a12', 'Yes, Bob! It is available. You can proceed with the booking.', '2024-06-14 10:15:00'),<br/>
('f0eebc99-9c0b-4ef8-bb6d-6bb9bd380f13', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a13', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a14', 'Hello Diana, I am interested in your Miami villa for August. Is it still open?', '2024-06-18 09:00:00');<br/>
This sample data set provides a realistic foundation for testing queries and understanding the relationships between different parts of the booking platform<br/>
