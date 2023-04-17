-- Create temp_table
CREATE OR REPLACE TABLE dtc-de-382512.dezoomcamp.rides_temp AS 
SELECT CAST(VendorID AS INT64) AS VendorID
FROM dtc-de-382512.dezoomcamp.rides;

-- Creating external table referring to gcs path
CREATE OR REPLACE EXTERNAL TABLE `dtc-de-382512.dezoomcamp.external_yellow_tripdata_old`
OPTIONS (
  format = 'CSV',
  uris = ['gs://prefect-de-zoom1/data/yellow/yellow_tripdata_2021-01.parquet']
);

-- Check yello trip data
SELECT * FROM dtc-de-382512.dezoomcamp.rides limit 10;

-- Create a non partitioned table from external table
CREATE OR REPLACE TABLE dtc-de-382512.dezoomcamp.yellow_tripdata_non_partitoned AS
SELECT * FROM dtc-de-382512.dezoomcamp.rides;

-- Create a partitioned table from external table
CREATE OR REPLACE TABLE dtc-de-382512.dezoomcamp.yellow_tripdata_partitoned
PARTITION BY
  DATE(tpep_pickup_datetime) AS
SELECT * FROM dtc-de-382512.dezoomcamp.rides;

-- Impact of partition
-- Scanning 1.6GB of data
SELECT DISTINCT(VendorID)
FROM dtc-de-382512.dezoomcamp.yellow_tripdata_non_partitoned
WHERE DATE(tpep_pickup_datetime) BETWEEN '2021-01-01' AND '2021-01-30';

-- Scanning ~106 MB of DATA
SELECT DISTINCT(VendorID)
FROM dtc-de-382512.dezoomcamp.yellow_tripdata_partitoned
WHERE DATE(tpep_pickup_datetime) BETWEEN '2021-01-01' AND '2021-01-30';

-- Let's look into the partitons
SELECT table_name, partition_id, total_rows
FROM `dezoomcamp.INFORMATION_SCHEMA.PARTITIONS`
WHERE table_name = 'yellow_tripdata_partitoned'
ORDER BY total_rows DESC;

-- Creating a partition and cluster table
CREATE OR REPLACE TABLE dtc-de-382512.dezoomcamp.yellow_tripdata_partitoned_clustered
PARTITION BY DATE(tpep_pickup_datetime)
CLUSTER BY VendorID AS
SELECT * FROM dtc-de-382512.dezoomcamp.external_yellow_tripdata;

-- Query scans 1.1 GB
SELECT count(*) as trips
FROM dtc-de-382512.dezoomcamp.yellow_tripdata_partitoned
WHERE DATE(tpep_pickup_datetime) BETWEEN '2021-01-01' AND '2021-01-31'
  AND VendorID=1;

-- Query scans 864.5 MB
SELECT count(*) as trips
FROM dtc-de-382512.dezoomcamp.yellow_tripdata_partitoned_clustered
WHERE DATE(tpep_pickup_datetime) BETWEEN '2021-01-01' AND '2021-01-31'
  AND VendorID=1;

