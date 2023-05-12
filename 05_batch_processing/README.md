# 가이드 
- [dataproc.md](dataproc.md) : 프로젝트 구축에 대한 가이드 

# Dataproc
작업 매개변수

* `--input_green=gs://prefect-de-zoom1/data/green/*/`
* `--input_yellow=gs://prefect-de-zoom1/data/yellow/*/`
* `--output=gs://prefect-de-zoom1/report-2020`

Dataproc에 제출하기 위해 Google Cloud SDK 사용

[작업 제출](https://cloud.google.com/dataproc/docs/guides/submit-job?hl=ko#dataproc-submit-job-gcloud) 해당 가이드 문서를 참고하시면 됩니다.

```bash
gcloud dataproc jobs submit pyspark \
--cluster=de-zoomcamp-cluster \
--region=us \
gs://prefect-de-zoom1/code/06_spark_sql.py \
-- \
    --input_green=gs://prefect-de-zoom1/data/green/*/ \
    --input_yellow=gs://prefect-de-zoom1/data/yellow/*/ \
    --output=gs://prefect-de-zoom1/report-2020
```

# Big Query 
[BigQuery 커넥터를 Spark와 함께 사용](https://cloud.google.com/dataproc/docs/tutorials/bigquery-connector-spark-example?hl=ko) 해당 가이드 문서를 참고하시면 됩니다.

```bash
gcloud dataproc jobs submit pyspark \
--cluster=de-zoomcamp-cluster \
--region=us \
--jars=gs://spark-lib/bigquery/spark-bigquery-latest_2.12.jar \
gs://prefect-de-zoom1/code/06_spark_sql_big_query.py \
-- \
    --input_green=gs://prefect-de-zoom1/data/green/*/ \
    --input_yellow=gs://prefect-de-zoom1/data/yellow/*/ \
    --output=gs://prefect-de-zoom1/report-2020
```