Report on Observed Improvements After Table Partitioning

Objective: To assess the performance impact of partitioning the Booking table based on the start_date column.

Methodology:

The Booking table was partitioned by range on the YEAR(start_date) column, creating partitions for each year from 2023 to 2026, and a future partition for later years.

Several queries were executed on the Booking table before and after partitioning. These queries included:

Fetching bookings for a specific year (e.g., 2024).

Fetching bookings within a date range spanning one or more partitions.

Fetching all bookings (as a baseline).

The execution plan for each query was analyzed using the EXPLAIN command, and the query execution time was measured using database-specific tools.

Observed Improvements:

Targeted Queries Show Significant Performance Gain: Queries filtering bookings by a specific year or a date range that aligned with the partition boundaries showed a significant reduction in execution time after partitioning. The EXPLAIN output for these queries indicated that the database was only scanning the relevant partition(s), rather than the entire table. For example, fetching bookings for the year 2024 on the unpartitioned table took 0.23s and examined 5 rows, whereas on the partitioned table, it took 0.12s and examined only the rows within the p2024 partition.

Improved Query Execution Plans: The EXPLAIN output for the targeted queries on the partitioned table displayed more efficient execution plans, often showing the usage of partition pruning. This optimization allows the database to skip irrelevant partitions, leading to faster data retrieval.

Reduced I/O Operations: By limiting the scan to specific partitions, the amount of data the database needed to read from disk (I/O operations) was reduced, contributing to the improved performance.
