DATA SEEDING
 1. Populate the User table

INSERT INTO User (user_id, first_name, last_name, email, password_hash, phone_number, role, created_at) VALUES
('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'Alice', 'Smith', 'alice.smith@example.com', 'hashed_password_alice', '111-222-3333', 'host', '2023-01-15 10:00:00'),
('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a12', 'Bob', 'Johnson', 'bob.johnson@example.com', 'hashed_password_bob', NULL, 'guest', '2023-02-01 11:30:00'),
('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a13', 'Charlie', 'Brown', 'charlie.brown@example.com', 'hashed_password_charlie', '444-555-6666', 'guest', '2023-03-10 14:00:00'),
('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a14', 'Diana', 'Prince', 'diana.prince@example.com', 'hashed_password_diana', '777-888-9999', 'host', '2023-04-20 09:15:00'),
('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a15', 'Eve', 'Adams', 'eve.adams@example.com', 'hashed_password_eve', NULL, 'admin', '2023-05-01 16:45:00');


 2. Populate the Property table

INSERT INTO Property (property_id, host_id, name, description, location, pricepernight, created_at) VALUES
('b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b11', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'Cozy Downtown Apartment', 'A charming apartment in the heart of the city, perfect for couples.', 'New York, NY', 150.00, '2023-01-20 12:00:00'),
('b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b12', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a14', 'Spacious Family Villa', 'Beautiful villa with a large garden and pool, ideal for family vacations.', 'Miami, FL', 300.00, '2023-04-25 10:30:00'),
('b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b13', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'Seaside Cottage', 'Quaint cottage with stunning ocean views, just steps from the beach.', 'Malibu, CA', 220.50, '2023-02-15 09:00:00');


3. Populate the Booking table

INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, total_price, status, created_at) VALUES
('c0eebc99-9c0b-4ef8-bb6d-6bb9bd380c11', 'b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b11', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a12', '2024-07-01', '2024-07-07', 900.00, 'confirmed', '2024-06-15 14:30:00'),
('c0eebc99-9c0b-4ef8-bb6d-6bb9bd380c12', 'b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b12', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a13', '2024-08-10', '2024-08-20', 3000.00, 'pending', '2024-06-20 10:00:00'),
('c0eebc99-9c0b-4ef8-bb6d-6bb9bd380c13', 'b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b11', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a13', '2024-09-01', '2024-09-05', 600.00, 'canceled', '2024-06-22 11:00:00'),
('c0eebc99-9c0b-4ef8-bb6d-6bb9bd380c14', 'b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b13', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a12', '2024-10-15', '2024-10-20', 1102.50, 'confirmed', '2024-06-25 09:00:00');


4. Populate the Payment table

INSERT INTO Payment (payment_id, booking_id, amount, payment_date, payment_method) VALUES
('d0eebc99-9c0b-4ef8-bb6d-6bb9bd380d11', 'c0eebc99-9c0b-4ef8-bb6d-6bb9bd380c11', 900.00, '2024-06-15 14:35:00', 'credit_card'),
('d0eebc99-9c0b-4ef8-bb6d-6bb9bd380d12', 'c0eebc99-9c0b-4ef8-bb6d-6bb9bd380c12', 3000.00, '2024-06-20 10:05:00', 'paypal'),
('d0eebc99-9c0b-4ef8-bb6d-6bb9bd380d13', 'c0eebc99-9c0b-4ef8-bb6d-6bb9bd380c14', 1102.50, '2024-06-25 09:05:00', 'stripe');


5. Populate the Review table
INSERT INTO Review (review_id, property_id, user_id, rating, comment, created_at) VALUES
('e0eebc99-9c0b-4ef8-bb6d-6bb9bd380e11', 'b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b11', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a12', 5, 'Absolutely loved the apartment! Clean, cozy, and great location.', '2024-07-08 10:00:00'),
('e0eebc99-9c0b-4ef8-bb6d-6bb9bd380e12', 'b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b13', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a12', 4, 'Beautiful seaside cottage. The views were incredible. A bit small for a family of four.', '2024-10-21 11:30:00');


 6. Populate the Message table

INSERT INTO Message (message_id, sender_id, recipient_id, message_body, sent_at) VALUES
('f0eebc99-9c0b-4ef8-bb6d-6bb9bd380f11', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a12', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'Hi Alice, is the apartment available for July 1-7?', '2024-06-14 10:00:00'),
('f0eebc99-9c0b-4ef8-bb6d-6bb9bd380f12', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a12', 'Yes, Bob! It is available. You can proceed with the booking.', '2024-06-14 10:15:00'),
('f0eebc99-9c0b-4ef8-bb6d-6bb9bd380f13', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a13', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a14', 'Hello Diana, I am interested in your Miami villa for August. Is it still open?', '2024-06-18 09:00:00');

