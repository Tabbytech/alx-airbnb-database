Normalization Review and Explanation (3NF)

1. User Table
Attributes: user_id, first_name, last_name, email, password_hash, phone_number, role, created_at

Primary Key: user_id

1NF Check: All attributes are atomic (e.g., first_name and last_name are separate). No repeating groups. Passes 1NF.

2NF Check: All non-key attributes (first_name, last_name, email, password_hash, phone_number, role, created_at) are directly dependent on the user_id (the primary key). There are no composite keys, so partial dependencies are not an issue. Passes 2NF.

3NF Check: There are no non-key attributes that are transitively dependent on user_id through another non-key attribute. For example, role is directly about the user, not dependent on email. Passes 3NF.

2. Property Table
Attributes: property_id, host_id, name, description, location, pricepernight, created_at, updated_at

Primary Key: property_id

Foreign Key: host_id (references User.user_id)

1NF Check: All attributes are atomic. No repeating groups. Passes 1NF.

2NF Check: All non-key attributes (host_id, name, description, location, pricepernight, created_at, updated_at) are fully dependent on property_id. Passes 2NF.

3NF Check: There are no transitive dependencies. host_id is a foreign key, which is acceptable. location describes the property directly. Passes 3NF.

3. Booking Table
Attributes: booking_id, property_id, user_id, start_date, end_date, total_price, status, created_at

Primary Key: booking_id

Foreign Keys: property_id (references Property.property_id), user_id (references User.user_id)

1NF Check: All attributes are atomic. No repeating groups. Passes 1NF.

2NF Check: All non-key attributes (property_id, user_id, start_date, end_date, total_price, status, created_at) are fully dependent on booking_id. Passes 2NF.

3NF Check: There are no transitive dependencies. total_price is calculated based on pricepernight (from Property) and duration (start_date, end_date), but it's a direct attribute of the booking itself. Storing total_price directly here is generally acceptable for performance reasons, even if it could be derived. It represents a specific value at the time of booking which might not always perfectly align with current pricepernight if prices change. Passes 3NF.

4. Payment Table
Attributes: payment_id, booking_id, amount, payment_date, payment_method

Primary Key: payment_id

Foreign Key: booking_id (references Booking.booking_id)

1NF Check: All attributes are atomic. No repeating groups. Passes 1NF.

2NF Check: All non-key attributes (booking_id, amount, payment_date, payment_method) are fully dependent on payment_id. Passes 2NF.

3NF Check: No transitive dependencies. amount is directly related to the payment, and payment_method describes the payment. Passes 3NF.

5. Review Table
Attributes: review_id, property_id, user_id, rating, comment, created_at

Primary Key: review_id

Foreign Keys: property_id (references Property.property_id), user_id (references User.user_id)

1NF Check: All attributes are atomic. No repeating groups. Passes 1NF.

2NF Check: All non-key attributes (property_id, user_id, rating, comment, created_at) are fully dependent on review_id. Passes 2NF.

3NF Check: No transitive dependencies. rating and comment are direct attributes of the review. Passes 3NF.

6. Message Table
Attributes: message_id, sender_id, recipient_id, message_body, sent_at

Primary Key: message_id

Foreign Keys: sender_id (references User.user_id), recipient_id (references User.user_id)

1NF Check: All attributes are atomic. No repeating groups. Passes 1NF.

2NF Check: All non-key attributes (sender_id, recipient_id, message_body, sent_at) are fully dependent on message_id. Passes 2NF.

3NF Check: No transitive dependencies. message_body and sent_at are direct attributes of the message. Passes 3NF.

Conclusion on Normalization
The current database design already adheres to Third Normal Form (3NF).

There are no apparent redundancies or violations of 3NF principles in the provided schema. Each table's non-key attributes are directly dependent on its primary key and not on other non-key attributes. Foreign keys are used appropriately to establish relationships between entities without duplicating data unnecessarily.
