CREATE PARTITION FUNCTION myRangePF1 (datetime2(0))
    AS RANGE RIGHT FOR VALUES ('2022-04-01', '2022-05-01', '2022-06-01') ;
GO

CREATE PARTITION SCHEME myRangePS1
    AS PARTITION myRangePF1
    ALL TO ('PRIMARY') ;
GO

CREATE TABLE dbo.PartitionTable (col1 datetime2(0) PRIMARY KEY, col2 char(10))
    ON myRangePS1 (col1) ;
GO

SELECT * FROM sys.database_files;

SELECT * FROM sys.partitions WHERE object_id = OBJECT_ID('dbo.PartitionTable');

SELECT * FROM sys.partition_schemes;
-- SELECT * FROM sys.filegroups;