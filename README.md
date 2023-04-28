# [Data Engineering Zoomcamp](https://github.com/DataTalksClub/data-engineering-zoomcamp)

# Architecture diagram
- ![image](https://user-images.githubusercontent.com/47103479/235180265-48ae11eb-3d73-4f88-86d6-cf118564de63.png)


## Technologies
* *Google Cloud Platform (GCP)*: Cloud-based auto-scaling platform by Google
  * *Google Cloud Storage (GCS)*: Data Lake
  * *BigQuery*: Data Warehouse
* *Terraform*: Infrastructure-as-Code (IaC)
* *Docker*: Containerization
* *SQL*: Data Analysis & Exploration
* *Prefect*: Workflow Orchestration
* *dbt*: Data Transformation
* *Spark*: Distributed Processing
* *Kafka*: Streaming

## Tools
* Docker and Docker-Compose
* Python 3 (e.g. via [Anaconda](https://www.anaconda.com/products/individual))
* Google Cloud SDK
* Terraform

# Project
## [01: Introduction & Prerequisites](01_basics_n_setup)
* Introduction to GCP
* Docker and docker-compose
* Running Postgres locally with Docker
* Setting up infrastructure on GCP with Terraform
* Preparing the environment for the course

## [02: Workflow Orchestration](02_workflow_orchestration/)
* Workflow orchestration
* Introduction to Prefect
* ETL with GCP & Prefect
* Parametrizing workflows
* Prefect Cloud and additional resources

## [03: Data Warehouse](03_data_warehouse)
* BigQuery
* Partitioning and clustering
* BigQuery best practices
* Internals of BigQuery
* BigQuery Machine Learning

## [04: Analytics engineering](04_analytics_engineering/)
* dbt (data build tool)
* BigQuery and dbt
* Postgres and dbt
* dbt models
* Testing and documenting
* Deployment to the cloud and locally
* Visualizing the data with google data studio and metabase

## [05: Batch processing](05_batch_processing)
* Batch processing
* Spark Dataframes
* Spark SQL
* Internals: GroupBy and joins

## [06: Streaming](06_stream_processing)
* Introduction to Kafka
* Schemas (avro)
* Kafka Streams
* Kafka Connect and KSQL