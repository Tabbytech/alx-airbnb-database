Database Schema: Entities and Attributes<br/>
Here are the defined entities and their respective attributes, including data types and constraints:<br/>
1. User Entity<br/>
Description: Represents individual users of the system (guests, hosts, admins).<br/>
Attributes:<br/>
user_id: Primary Key, UUID, Indexed<br/>
first_name: VARCHAR, NOT NULL<br/>
last_name: VARCHAR, NOT NULL<br/>
email: VARCHAR, UNIQUE, NOT NULL<br/>
password_hash: VARCHAR, NOT NULL<br/>
phone_number: VARCHAR, NULL<br/>
role: ENUM (guest, host, admin), NOT NULL<br/>
created_at: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP<br/>
2. Property Entity<br/>
Description: Represents a property listed for booking.<br/>
Attributes:<br/>
property_id: Primary Key, UUID, Indexed<br/>
host_id: Foreign Key (references User.user_id)<br/>
name: VARCHAR, NOT NULL<br/>
description: TEXT, NOT NULL<br/>
location: VARCHAR, NOT NULL<br/>
pricepernight: DECIMAL, NOT NULL<br/>
created_at: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP<br/>
updated_at: TIMESTAMP, ON UPDATE CURRENT_TIMESTAMP<br/>
3. Booking Entity<br/>
Description: Represents a reservation made by a user for a property.<br/>
Attributes:<br/>
booking_id: Primary Key, UUID, Indexed<br/>
property_id: Foreign Key (references Property.property_id)<br/>
user_id: Foreign Key (references User.user_id)<br/>
start_date: DATE, NOT NULL<br/>
end_date: DATE, NOT NULL<br/>
total_price: DECIMAL, NOT NULL<br/>
status: ENUM (pending, confirmed, canceled), NOT NULL<br/>
created_at: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP<br/>
4. Payment Entity<br/>
Description: Records payment transactions for bookings.<br/>
Attributes:<br/>
payment_id: Primary Key, UUID, Indexed<br/>
booking_id: Foreign Key (references Booking.booking_id)<br/>
amount: DECIMAL, NOT NULL<br/>
payment_date: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP<br/>
payment_method: ENUM (credit_card, paypal, stripe), NOT NULL<br/>
5. Review Entity<br/>
Description: Stores reviews given by users for properties.<br/>
Attributes:<br/>
review_id: Primary Key, UUID, Indexed<br/>
property_id: Foreign Key (references Property.property_id)<br/>
user_id: Foreign Key (references User.user_id)<br/>
rating: INTEGER, CHECK: rating >= 1 AND rating <= 5, NOT NULL<br/>
comment: TEXT, NOT NULL<br/>
created_at: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP<br/>
6. Message Entity<br/>
Description: Stores messages exchanged between users.<br/>
Attributes:<br/>
message_id: Primary Key, UUID, Indexed<br/>
sender_id: Foreign Key (references User.user_id)<br/>
recipient_id: Foreign Key (references User.user_id)<br/>
message_body: TEXT, NOT NULL<br/>
sent_at: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP<br/>
RELATIONSHIPS BETWEEN ENTITIES.<br/>
The relationships define how different entities are connected through their primary and foreign keys.<br/>
User to Property (One-to-Many):<br/>
A User can be a host and own multiple Properties.<br/>
The Property table has a host_id (Foreign Key) that references User.user_id.<br/>
User to Booking (One-to-Many):<br/>
A User can make multiple Bookings.<br/>
The Booking table has a user_id (Foreign Key) that references User.user_id.<br/>
Property to Booking (One-to-Many):<br/>
A Property can have multiple Bookings.<br/>
The Booking table has a property_id (Foreign Key) that references Property.property_id.<br/>
Booking to Payment (One-to-One / One-to-Many):<br/>
Typically, a Booking would have one or more Payments associated with it (e.g., initial payment, remaining payment). From this schema, it appears to be a One-to-Many relationship, where one booking can have multiple payment records (e.g., for partial payments, refunds, etc.).
The Payment table has a booking_id (Foreign Key) that references Booking.booking_id.<br/>
User to Review (One-to-Many):<br/>
A User can write multiple Reviews.<br/>
The Review table has a user_id (Foreign Key) that references User.user_id.<br/>
Property to Review (One-to-Many):<br/>
A Property can receive multiple Reviews.<br/>
The Review table has a property_id (Foreign Key) that references Property.property_id.<br/>
User to Message (Self-Referencing, Many-to-Many via two One-to-Many):<br/>
A User can send multiple Messages (sender_id).<br/>
A User can receive multiple Messages (recipient_id).<br/>
The Message table has sender_id (Foreign Key) and recipient_id (Foreign Key), both referencing User.user_id. This creates a relationship where users can message each other.<br/>
