ALTER DATABASE [learn_partitioning] ADD FILE (
    NAME = p_2019,
    FILENAME = '/var/opt/mssql/data/p_2019.ndf'
) TO FILEGROUP fg_2019;

ALTER DATABASE [learn_partitioning] ADD FILE (
    NAME = p_2020,
    FILENAME = '/var/opt/mssql/data/p_2020.ndf'
) TO FILEGROUP fg_2020;

ALTER DATABASE [learn_partitioning] ADD FILE (
    NAME = p_2021,
    FILENAME = '/var/opt/mssql/data/p_2021.ndf'
) TO FILEGROUP fg_2021;

ALTER DATABASE [learn_partitioning] ADD FILE (
    NAME = p_2022,
    FILENAME = '/var/opt/mssql/data/p_2022.ndf'
) TO FILEGROUP fg_2022;


SELECT
    fg.name,
    mf.name,
    mf.physical_name,
    mf.size /128 as size_in_mb
FROM
    sys.filegroups as fg
JOIN
    sys.master_files mf
        ON fg.data_space_id = mf.data_space_id
WHERE
    mf.database_id = DB_ID('learn_partitioning')