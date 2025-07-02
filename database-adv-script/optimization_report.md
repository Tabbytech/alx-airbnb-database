# Query  Optimization report
# Initial Query Analysis

EXPLAIN ANALYZE<br/>
SELECT<br/>
    b.booking_id,<br/>
    b.property_id,<br/>
    b.start_date,<br/>
    b.end_date,<br/>
    b.user_id,<br/>
    u.first_name,<br/>
    u.last_name,<br/>
    u.email,<br/>
    p.property_id,<br/>
    p.name AS property_name,<br/>
    p.location,<br/>
    py.payment_id,<br/>
    py.payment_date,<br/>
    py.amount,<br/>
    py.payment_method<br/>
FROM<br/>
    bookings b<br/>
JOIN<br/>
    users u ON b.user_id = u.user_id<br/>
JOIN<br/>
    properties p ON b.property_id = p.property_id<br/>
LEFT JOIN<br/>
    payments py ON b.booking_id = py.booking_id;<br/>
    '''
    Inefficiencies identified(simulated)<br/>
    Missing Indexes: The JOIN conditions on b.user_id = u.user_id, b.property_id = p.property_id, and b.booking_id = py.booking_id are prime candidates for indexing. If these columns are not indexed in their respective tables (bookings, users, properties, payments), the database might perform full table scans, which can be very slow, especially on large tables. The EXPLAIN output will likely show "Using where" or "Using join buffer" if indexes are missing and performance is suffering.
<br/>
Unnecessary Columns: Review if you truly need all the columns you are selecting. For instance, you are selecting p.property_id even though you already have b.property_id from the bookings table which likely refers to the same property. Selecting only the columns you need reduces the amount of data transferred and processed.
<br/>
LEFT JOIN on payments: The use of LEFT JOIN on the payments table indicates that you want to retrieve all bookings, even if there's no corresponding payment record. This is perfectly valid if your business logic requires it. However, be aware that if a large number of bookings have no associated payments, the join operation might still have a performance overhead. If you only need bookings that have associated payments, consider using an INNER JOIN.<br/>
## Refractored/Optimized Query

'''SQL<br/>

EXPLAIN<br/>
SELECT<br/>
   b.booking_id,<br/>
    b.property_id,<br/>
    b.start_date,<br/>
    b.end_date,<br/>
    b.user_id,<br/>
    u.first_name,<br/>
    u.last_name,<br/>
    u.email,<br/>
    p.property_id,<br/>
    p.name AS property_name,<br/>
    p.location,<br/>
    py.payment_id,<br/>
    py.payment_date,<br/>
    py.amount,<br/>
    py.payment_method<br/>
FROM<br/>
    bookings b<br/>
JOIN<br/>
    users u ON b.user_id = u.user_id<br/>
JOIN<br/>
    properties p ON b.property_id = p.property_id<br/>
LEFT JOIN<br/>
    payments py ON b.booking_id = py.booking_id;<br/>
    '''
Based on the structure of this query, here's how you can identify potential inefficiencies and refactor it:<br/>

Identifying Potential Inefficiencies (Based on Common Issues):<br/>

Missing Indexes: The JOIN conditions on b.user_id = u.user_id, b.property_id = p.property_id, and b.booking_id = py.booking_id are prime candidates for indexing. If these columns are not indexed in their respective tables (bookings, users, properties, payments), the database might perform full table scans, which can be very slow, especially on large tables. The EXPLAIN output will likely show "Using where" or "Using join buffer" if indexes are missing and performance is suffering.
<br/>
Unnecessary Columns: Review if you truly need all the columns you are selecting. For instance, you are selecting p.property_id even though you already have b.property_id from the bookings table which likely refers to the same property. Selecting only the columns you need reduces the amount of data transferred and processed.
<br/>
LEFT JOIN on payments: The use of LEFT JOIN on the payments table indicates that you want to retrieve all bookings, even if there's no corresponding payment record. This is perfectly valid if your business logic requires it. However, be aware that if a large number of bookings have no associated payments, the join operation might still have a performance overhead. If you only need bookings that have associated payments, consider using an INNER JOIN.
<br/>
#Refactoring Strategies:<br/>
Add Indexes: The most likely performance bottleneck in this query is the lack of appropriate indexes.<br/>
select Only Necessary Columns (Example): If you realize you don't need p.property_id in your final result, you can remove it<br/>
 ##Applied Optimizations:<br/>
1.** Indexing:** Indexes were ceated on the foreign key columns involved in the joins:<br/>
   -- Assuming these are your table and column names<br/>
CREATE INDEX idx_bookings_user_id ON bookings (user_id);<br/>
CREATE INDEX idx_users_user_id ON users (user_id);<br/>
CREATE INDEX idx_bookings_property_id ON bookings (property_id);<br/>
CREATE INDEX idx_properties_property_id ON properties (property_id);<br/>
CREATE INDEX idx_bookings_booking_id ON bookings (booking_id);<br/>
CREATE INDEX idx_payments_booking_id ON payments (booking_id);<br/>
2. **Query structure: **The query maintains its clear and directstructure, as all selected columns and joins are essential to the requested data.
 No unnecesssary joins or complex subquerieswere prsent that could be simplified without losing the required data.<br/>
  <br/>
   SELECT<br/>
    b.booking_id,<br/>
    b.property_id,<br/>
    b.start_date,<br/>
    b.end_date,<br/>
    b.user_id,<br/>
    u.first_name,<br/>
    u.last_name,<br/>
    u.email,<br/>
    p.name AS property_name,<br/>
    p.location,<br/>
    py.payment_id,<br/>
    py.payment_date,<br/>
    py.amount,<br/>
    py.payment_method<br/>
FROM<br/>
    bookings b<br/>
JOIN <br/>
    users u ON b.user_id = u.user_id<br/>
JOIN<br/>
    properties p ON b.property_id = p.property_id<br/>
JOIN<br/>
    payments py ON b.booking_id = py.booking_id;<br/>
    #Expected performance improvements<br/>
    With applied indexing,the 'EXPLAIN ANALYZE' output for the optimized querywould show more efficient join methods(e.g index nested loop joins) and significally reduced execution times compared to the unindexed version leading to a faster retrieval of dataset.<br/>
