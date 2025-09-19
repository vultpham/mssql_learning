CREATE TABLE orders
(
    id INT,
    order_date DATE,
    sale INT,
) ON scheme_partition_by_year (order_date)
INSERT INTO orders (id, order_date, sale)
SELECT TOP (2000)
    ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS id,
    DATEADD(DAY, ABS(CHECKSUM(NEWID())) % 3650, '2020-01-01') AS order_date, -- random date between 2020 and ~2030
    ABS(CHECKSUM(NEWID())) % 1000 + 1 AS sale -- random sale amount between 1 and 1000
FROM sys.all_objects a
         CROSS JOIN sys.all_objects b;


SELECT *
INTO orders_without_partition
FROM orders;

SELECT
    p.partition_number,
    fg.name,
    p.rows
FROM sys.partitions p
JOIN sys.destination_data_spaces dds ON p.partition_number = dds.destination_id
JOIN sys.filegroups fg ON dds.data_space_id = fg.data_space_id
WHERE OBJECT_NAME(p.object_id) = 'orders'


SELECT id, order_date FROM orders_without_partition WHERE order_date = '2020-05-14';

SELECT id, order_date FROM orders WHERE order_date = '2020-05-14';