CREATE DATABASE partition_by_year_example;
USE partition_by_year_example;


-- Create a partition function
CREATE PARTITION FUNCTION partition_by_year(date)
AS RANGE RIGHT
FOR VALUES ('2021-01-01', '2022-01-01', '2023-01-01');

SELECT * FROM sys.partition_functions;
------------------


-- Create a partition scheme
CREATE PARTITION SCHEME scheme_partition_by_year
AS PARTITION partition_by_year
ALL TO ([PRIMARY])
------------------


-- Create a table with a partition column
CREATE TABLE transactions (
    id INT IDENTITY(1,1),
    transaction_date DATE
) ON scheme_partition_by_year(transaction_date);

SELECT * FROM sys.partitions WHERE object_id = OBJECT_ID('transactions');

INSERT INTO transactions (transaction_date) VALUES ('2021-02-01');
------------------


-- Insert data into the table
;WITH N AS
      (
          SELECT TOP (1000000) ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
          FROM sys.all_objects a
                   CROSS JOIN sys.all_objects b
      )
INSERT INTO transactions (transaction_date)
SELECT
 DATEADD(DAY, (n % 365), DATEFROMPARTS(2020 + (n % 4), 1, 1))  -- distribute across years
FROM N;
------------------


-- Create a table to store the data without partitioning
SELECT *
INTO transactions_without_partition
FROM transactions;
------------------


SELECT * FROM transactions_without_partition WHERE transaction_date = '2021-02-01'


SELECT * FROM transactions WHERE transaction_date = '2021-02-01'

















