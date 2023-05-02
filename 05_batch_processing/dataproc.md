# Dataproc 
- Cloud Dataproc
  - ![image](https://user-images.githubusercontent.com/47103479/235684790-bae8b0c5-d48f-4ffb-887a-4ebf477571e3.png)
    - https://cloudplatform.googleblog.com/2015/09/Google-Cloud-Dataproc-Making-Spark-and-Hadoop-Easier-Faster-and-Cheaper.html
  - 클라우드 네이트브 아파치 하둡 및 아파치 스파크 서비스
  - 완전 관리형 클라우드 서비스이기에 더 간단하고 효율적으로 하둡 및 스파크 클러스터를 생성할 수 있습니다. 환경 구축을 위해서 몇 시간에서 며칠씩 걸리던 작업이 몇 분에서 몇 초만에 끝나게 됩니다.
  - 클러스터 배포, 로깅, 모니터링과 같은 관리는 GCP에서 자동으로 지원해주기 때문에 직접 인프라 관리를 할 필요 없이 사용자는 작업과 데이터에 집중할 수 있으며, 언제든 클러스터를 만들고 다양한 가상 머신 유형, 디스크 크기, 노드 수, 네트워킹 옵션 등 여러 리소스를 최적화하고 확장할 수 있습니다.
  - 다수의 마스터 노드를 사용해 클러스터를 실행하고 실패해도 다시 시작되도록 설정을 할 수 있기 때문에 높은 가용성을 보장합니다. 사용하기 쉬운 Web UI, Cloud SDK, RESTful API 등 다양한 방식으로 클러스터를 관리할 수 있습니다.
  - 클러스터 모드
    - 단일 노드(마스터 1, 작업자 0) : 마스터 노드 하나만 설정함
    - 표준 (마스터 1, 작업자 N) : 마스터 노드 1개와 작업자 노드 N개를 설정함
    - 고가용성 (마스터 3, 작업자 N) : 마스터 노드 3개와 작업자 노드 N개를 설정함
- Dataproc은 대규모 데이터 처리 작업을 쉽고 빠르게 수행할 수 있는 Google Cloud 서비스로 대량의 데이터를 병렬로 처리할 수 있는 도구입니다.
- Dataproc을 사용하면 클라우드 컴퓨팅 클러스터를 만들고 일괄 처리, 분석, 머신러닝과 같은 데이터 처리 작업을 실행할 수 있습니다.
- Dataproc을 검색한뒤에 API를 활성화 해줍니다.
- ![image](https://user-images.githubusercontent.com/47103479/235668801-553cac06-71dc-428e-85a5-e42bfe59d156.png)
- Compute Engine의 신규 클러스터를 생성해 줍니다.
- ![image](https://user-images.githubusercontent.com/47103479/235669017-46cf1271-748d-45fe-9067-e9043b8ffa7f.png)
- ![image](https://user-images.githubusercontent.com/47103479/235669243-b091b710-f2d4-4ac4-aa7a-993f6ae60575.png)
- 단일 노드를 선택하고 jupyter notebook과 Docker를 구성요소로 포함해 준 뒤 클러스터를 생성해 줍니다.
- ![image](https://user-images.githubusercontent.com/47103479/235669758-b8000813-9c36-44ad-b08d-bf6b700c9288.png)
- ![image](https://user-images.githubusercontent.com/47103479/235669778-4fffcda6-4367-4396-83ce-4d7b34a850e7.png)

# Spark Job 실행
- Dataproc에서 spark 코드를 제출하려고 합니다. 전체 코드는 다음과 같습니다.
- ```python
  #!/usr/bin/env python
  # coding: utf-8

  import argparse
  import pyspark
  from pyspark.sql import SparkSession
  from pyspark.sql import functions as F

  parser = argparse.ArgumentParser()

  parser.add_argument('--input_green', required=True)
  parser.add_argument('--input_yellow', required=True)
  parser.add_argument('--output', required=True)

  args = parser.parse_args()

  input_green = args.input_green
  input_yellow = args.input_yellow
  output = args.output

  spark = SparkSession.builder \
      .appName('test') \
      .getOrCreate()

  df_green = spark.read.csv(input_green, header=True, inferSchema=True)
  df_green = df_green \
      .withColumnRenamed('lpep_pickup_datetime', 'pickup_datetime') \
      .withColumnRenamed('lpep_dropoff_datetime', 'dropoff_datetime')

  df_yellow = spark.read.csv(input_yellow, header=True, inferSchema=True)
  df_yellow = df_yellow \
      .withColumnRenamed('tpep_pickup_datetime', 'pickup_datetime') \
      .withColumnRenamed('tpep_dropoff_datetime', 'dropoff_datetime')

  common_colums = [
      'VendorID',
      'pickup_datetime',
      'dropoff_datetime',
      'store_and_fwd_flag',
      'RatecodeID',
      'PULocationID',
      'DOLocationID',
      'passenger_count',
      'trip_distance',
      'fare_amount',
      'extra',
      'mta_tax',
      'tip_amount',
      'tolls_amount',
      'improvement_surcharge',
      'total_amount',
      'payment_type',
      'congestion_surcharge'
  ]

  df_green_sel = df_green \
      .select(common_colums) \
      .withColumn('service_type', F.lit('green'))

  df_yellow_sel = df_yellow \
      .select(common_colums) \
      .withColumn('service_type', F.lit('yellow'))

  df_trips_data = df_green_sel.unionAll(df_yellow_sel)
  df_trips_data.registerTempTable('trips_data')
  df_result = spark.sql("""
  SELECT 
      -- Reveneue grouping 
      PULocationID AS revenue_zone,
      date_trunc('month', pickup_datetime) AS revenue_month, 
      service_type, 

      -- Revenue calculation 
      SUM(fare_amount) AS revenue_monthly_fare,
      SUM(extra) AS revenue_monthly_extra,
      SUM(mta_tax) AS revenue_monthly_mta_tax,
      SUM(tip_amount) AS revenue_monthly_tip_amount,
      SUM(tolls_amount) AS revenue_monthly_tolls_amount,
      SUM(improvement_surcharge) AS revenue_monthly_improvement_surcharge,
      SUM(total_amount) AS revenue_monthly_total_amount,
      SUM(congestion_surcharge) AS revenue_monthly_congestion_surcharge,

      -- Additional calculations
      AVG(passenger_count) AS avg_montly_passenger_count,
      AVG(trip_distance) AS avg_montly_trip_distance
  FROM
      trips_data
  GROUP BY
      1, 2, 3
  """)

  df_result.coalesce(1) \
      .write.parquet(output, mode='overwrite')
  ```
- Dataproc 클러스터를 선택한 뒤에 작업을 제출해줍니다.
- 작업 유형읜 Pyspark, 기본 Python 파일에는 gcs에 있는 .py 코드를 지정해줍니다.
- ![image](https://user-images.githubusercontent.com/47103479/235675821-66e1d4f0-e237-4a63-aac4-485d9cd7a0af.png)
- 코드를 짤때 만들어줬던 argument 부분도 넣어줍니다.
- ```bash
  --input_green=gs://prefect-de-zoom1/data/green/*/
  --input_yellow=gs://prefect-de-zoom1/data/yellow/*/
  --output=gs://prefect-de-zoom1/report-2020
  ```
- ![image](https://user-images.githubusercontent.com/47103479/235673235-030ae3d1-ccfd-43e3-a480-3f1ac9cc77fc.png)
- 해당 작업을 제출하면 모니터링과 로그를 확인할 수 있습니다.
- ![image](https://user-images.githubusercontent.com/47103479/235677125-2badd3f0-966c-4f5b-a02b-1779ebcdf18d.png)
- ![image](https://user-images.githubusercontent.com/47103479/235677267-7e556304-e23d-472c-9439-8f993ea949a1.png)
- 해당 Job의 결과로 parquet 파일이 잘 생성된것을 확인할 수 있습니다.
- ![image](https://user-images.githubusercontent.com/47103479/235677973-5016e1ac-49a2-443b-98cb-e1be996836c7.png)

# gcloud SDK로 Spark 작업 실행
- IAM에서 서비스 계정에서 Dataproc 관리자 역할을 부여해줍니다.
- ![image](https://user-images.githubusercontent.com/47103479/235679390-3b2b2030-6475-43ba-81b8-8ee0171240ea.png)
- Dataproc 클러스터에서 완료한 작업 세부내역에서 동등한 REST를 클릭해주고 argument를 확인해줍니다.
- ![image](https://user-images.githubusercontent.com/47103479/235678273-c693ecc2-87ff-4dfa-bd18-c83d2561706b.png)
- ![image](https://user-images.githubusercontent.com/47103479/235678418-57b7a77b-d116-4781-8931-f9fce3d0c7b3.png)
- [작업 제출](https://cloud.google.com/dataproc/docs/guides/submit-job?hl=ko#dataproc-submit-job-gcloud) 해당 가이드 문서를 참고하시면 됩니다.
- gcloud 명령어를 이용하여 spark job을 submit 해줍니다.
- ```bash
  gcloud dataproc jobs submit pyspark \
    --cluster=de-zoomcamp-cluster \
    --region=us \
    gs://prefect-de-zoom1/code/06_spark_sql.py \
    -- \
        --input_green=gs://prefect-de-zoom1/data/green/*/ \
        --input_yellow=gs://prefect-de-zoom1/data/yellow/*/ \
        --output=gs://prefect-de-zoom1/report-2020
  ```

# gcloud dataproc을 이용해서 Big Query 연동
- 기존의 코드에서 spark.write부분을 bigquery로 변경해 줍니다.
- ```python
  df_result.write.format('bigquery') \
    .option('table', output) \
    .save()
  ```
- [BigQuery 커넥터를 Spark와 함께 사용](https://cloud.google.com/dataproc/docs/tutorials/bigquery-connector-spark-example?hl=ko) 해당 가이드 문서를 참고하시면 됩니다.
- gcloud 명령어를 이용하여 spark job을 submit 해 준 뒤에 빅쿼리에서 테이블로 확인할 수 있습니다.
- ```bash
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
