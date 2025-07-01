Index Performanance
This document summarizes the result of adding indexes to commonly used columns in the Airbnb Clone database.<br/>
Indexes added<br>
According to the analysis of database_index.sql, The following indexexs were created:<br/>
1.idx_property_host_id: An index on the host_id column in the Property table.<br/>

2.idx_booking_user_id: An index on the user_id column in the Booking table.<br/>

3.idx_booking_status: An index on the status column in the Booking table.<br/>

4.idx_booking_start_date: An index on the start_date column in the Booking table.<br/>

5.idx_review_user_id: An index on the user_id column in the Review table.<br/>

6.idx_review_rating: An index on the rating column in the Review table.<br/>

7.idx_message_sender_id: An index on the sender_id column in the Message table.<br/>

8.idx_message_recipient_id: An index on the recipient_id column in the Message table.<br/>
Performance Impact<b><br>
Adding indexes to frequently queried column improved query performance, more so for joins involving  user.first_name and property.name and searches.<br/>
Indexes are crucial optimization for the large datasets and should be chosen based on query patterns and workload.
