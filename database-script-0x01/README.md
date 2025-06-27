Entities and Attributes<br/>
User<br/>
user_id: Primary Key, UUID, Indexed<br/>
first_name: VARCHAR, NOT NULL<br/>
last_name: VARCHAR, NOT NULL<br/>
email: VARCHAR, UNIQUE, NOT NULL<br/>
password_hash: VARCHAR, NOT NULL<br/>
phone_number: VARCHAR, NULL<br/>
role: ENUM (guest, host, admin), NOT NULL<br/>
created_at: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP<br/>
Property<br/>
property_id: Primary Key, UUID, Indexed<br/>
host_id: Foreign Key, references User(user_id)<br/>
name: VARCHAR, NOT NULL<br/>
description: TEXT, NOT NULL<br/>
location: VARCHAR, NOT NULL<br/>
pricepernight: DECIMAL, NOT NULL<br/>
created_at: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP<br/>
updated_at: TIMESTAMP, ON UPDATE CURRENT_TIMESTAMP<br/>
Booking<br/>
booking_id: Primary Key, UUID, Indexed<br/>
property_id: Foreign Key, references Property(property_id)<br/>
user_id: Foreign Key, references User(user_id)<br/>
start_date: DATE, NOT NULL<br/>
end_date: DATE, NOT NULL<br/>
total_price: DECIMAL, NOT NULL<br/>
status: ENUM (pending, confirmed, canceled), NOT NULL<br/>
created_at: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP<br/>
Payment<br/>
payment_id: Primary Key, UUID, Indexed<br/>
booking_id: Foreign Key, references Booking(booking_id)<br/>
amount: DECIMAL, NOT NULL<br/>
payment_date: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP<br/>
payment_method: ENUM (credit_card, paypal, stripe), NOT NULL<br/>
Review<br/>
review_id: Primary Key, UUID, Indexed<br/>
property_id: Foreign Key, references Property(property_id)<br/>
user_id: Foreign Key, references User(user_id)<br/>
rating: INTEGER, CHECK: rating >= 1 AND rating <= 5, NOT NULL<br/>
comment: TEXT, NOT NULL<br/>
created_at: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP<br/>
Message<br/>
message_id: Primary Key, UUID, Indexed<br/>
sender_id: Foreign Key, references User(user_id)<br/>
recipient_id: Foreign Key, references User(user_id)<br/>
message_body: TEXT, NOT NULL<br/>
sent_at: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP<br/>
Constraints<br/>
User Table<br/>
Unique constraint on email.<br/>
Non-null constraints on required fields.<br/>
Property Table<br/>
Foreign key constraint on host_id.<br/>
Non-null constraints on essential attributes.<br/>
Booking Table<br/>
Foreign key constraints on property_id and user_id.<br/>
status must be one of pending, confirmed, or canceled.<br/>
Payment Table<br/>
Foreign key constraint on booking_id, ensuring payment is linked to valid bookings.<br/>
Review Table<br/>
Constraints on rating values (1-5).<br/>
Foreign key constraints on property_id and user_id.<br/>
Message Table<br/>
Foreign key constraints on sender_id and recipient_id.<br/>
Indexing<br/>
Primary Keys: Indexed automatically.<br/>
Additional Indexes:<br/>
email in the User table.<br/>
property_id in the Property and Booking tables.<br/>
booking_id in the Booking and Payment tables.<br/>
