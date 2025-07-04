Index Performanance
This document summarizes the result of adding indexes to commonly used columns in the Airbnb Clone database.<br/>
Indexes added<br>
According to the analysis of ['database_index.sql'] ( ./database index.sql), The following indexexs were created:<br/>
-**User Table**
 -'user_id': Primary key (index created automatically)
- 'first name': Custom index created
  '''sql
  CREATE INDEX idx_user_first_name ON user (first_name);
  '''

  -**Booking Table**
  'booking_id': Primary key(index created automatically)
   'name': Customindex created
   '''sql
  - CREATE INDEX idx_property_name ON property(name);'''
    
Performance Impact<b><br>
Adding indexes to frequently queried column improved query performance, more so for joins involving  user.first_name and property.name and searches.<br/>
Performance Explanation.<br/>

Before indexing the query execution was slow compared to after indexing where query execution time was reduced and there was improved efficiency.
Indexes are crucial optimization for the large datasets and should be chosen based on query patterns and workload.
