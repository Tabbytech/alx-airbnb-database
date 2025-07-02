## Performance Monitoring and Refinement report
##Objective
Thie report outline the process for continuously monitoring and refining database performance by analyzing query execution plans and making necessary schema adjustments. The goal 
is to ensure database remains efficient as the applicatio scales.
<br/>
## Monitoring   Query Performance
T o monitor query performance we use EXPLAIN, ANALYZE, which provides a detailed execution plan and performance statistics. For example;<br/>
Select<br/>
r.review_id,<br/>
r.rating,<br/>
r.comment,<br/>
u.first_name,<br/>
u,last_name,<br/>
FROM<br/>
 review r<br/>
 JOIN<br/>
  users u ON  r.user_id<br/>
  WHERE<br/>
  r.property_id=123;<br/>
  To analyze this query we run:<br/>
  EXPLAIN ANALYZE.<br/>
  # I dentifying bottlenecks
  After running EXPLAIN ANALYZE,we might see an execution plan that includes a sequentialscan on the revews table.
  This means the database is scanning the entire table to find reviews for the specified property_id, which is efficeint, especially as the number of
  reviews grows.<br/>
  Boottleneck: The lack of index on the property_id column in the reviews table is causing sloow performance.<br/>
  ## Implementing Changes
  To address the bottlenck, we can create an index on the reviews(property_id) column. This will allow the database to quickly loacate the reviews for the 
  specific property withot scanning the entire table.<br/>
  CREATE INDEX idx_reviews_<br/>
  ##Reporting improvements
  After creating the index, we cann run EXPLAIN ANALYZE again on the same query. The new execution plan should show an Index Scan instead of a sequential
  scan.This indicates that the database is now using the index to speed up the query.<br/>
  
  ## Expected Improvements
  1. Lower execution time: The query will run significally faster
  2. Improved scalability: The application will be more scalable, as the performance of this qury will not degrade as rapidly as the reviewa table grows.<br/>
  3.Reduced coast: The application will be moe scalable, as the performance of this query will not degrade as rapidly as the reviews table grows.
<br/>
By following this processes we can ensure database continues to perform optimally over time.
  
