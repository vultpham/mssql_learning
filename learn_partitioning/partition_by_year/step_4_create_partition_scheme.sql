CREATE PARTITION SCHEME scheme_partition_by_year
AS PARTITION partition_by_year
TO (fg_2019, fg_2020, fg_2021, fg_2022)