Advanced Query Scripts
This repository contains SQL query examples demonstrating common data retrieval operations for a booking platform database. These queries utilize INNER JOIN, LEFT JOIN, and FULL OUTER JOIN to combine data from various tables.<br/>
 an INNER JOIN to combine data from the Booking and User tables. It returns information about each booking along with the first_name, last_name, and email of the user who made that booking. Only bookings that have a corresponding user will be returned.<br/>
<br/>
a LEFT JOIN to combine data from the Property and Review tables. It returns all properties, and if a property has associated reviews, those review details will also be included. Properties without any reviews will still appear in the result set, with NULL values for the review-related columns.<br/>
 a FULL OUTER JOIN to combine data from the User and Booking tables. It returns all users and all bookings.
If a user has bookings, their details will be matched with the booking details.
If a user has no bookings, they will still appear in the result set with NULL values for booking-related columns.
If a booking exists that is not linked to any user (e.g., due to data inconsistency), it will also appear in the result set with NULL values for user-related columns.
<br/>

SUB-QUERIES.<b><br/>
Sub-queries.sql demonstrates use of both correlated and non-correlated subqueries;<br/>
1.  Non-Correlated Subqueries
A non-correlated subquery is completely independent of the outer query. It executes once and returns a result set that the outer query then uses. Its execution does not depend on the rows being processed by the outer query.<br/>
 2. Correlated Subqueries
A correlated subquery is dependent on the outer query. It executes once for each row processed by the outer query. The subquery uses values from the current row of the outer query, creating a "correlation" between the two. This type of subquery can be less efficient than non-correlated ones for large datasets due to its row-by-row execution.


