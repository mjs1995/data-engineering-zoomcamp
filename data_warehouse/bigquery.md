# Bigquery
- external table
  - ![image](https://user-images.githubusercontent.com/47103479/232493636-a71af3c4-a720-4605-a835-34cd08168aa5.png)
  - ```sql
    CREATE OR REPLACE EXTERNAL TABLE `dtc-de-382512.dezoomcamp.external_yellow_tripdata`
    OPTIONS (
      format = 'CSV',
      uris = ['gs://prefect-de-zoom1/data/yellow/yellow_tripdata_2021-01.parquet']
    );
    ```
- 파티셔닝
  - ![image](https://user-images.githubusercontent.com/47103479/232501696-00ea7f8d-651e-4d3f-ac03-fd47736732d1.png)
  - 테이블을 조각으로 분할하면 검색해야 하는 데이터가 전체 테이블을 읽어야 하는 경우보다 훨씬 작기 때문에 쿼리 속도가 크게 향상됩니다.
  - 세 가지 유형의 파티셔닝
    - 정수 범위로 분할 
    - 시간 단위로 컬럼 분할 
    - 수집 시간으로 파티션 나누기 
  - ```sql
    CREATE OR REPLACE TABLE dtc-de-382512.dezoomcamp.yellow_tripdata_partitoned
    PARTITION BY
      DATE(tpep_pickup_datetime) AS
    SELECT * FROM dtc-de-382512.dezoomcamp.rides;
    ```
  - ![image](https://user-images.githubusercontent.com/47103479/232500962-5eab4ba7-c491-4e9a-b6ff-003a4b545faa.png)
- 클러스터링
  - ![image](https://user-images.githubusercontent.com/47103479/232501868-4e5b2fe4-ce71-4509-bf14-236555a229c0.png)
  - 하나 이상의 열(최대 4개)을 기준으로 테이블의 데이터를 재정렬합니다.
    - 열의 순서는 열의 우선 순위 결정과 관련이 있습니다.
    - 조건문 또는 집계 함수를 사용하는 쿼리의 성능 향상
  - 파티션과 동시에 클러스터를 생성할 수 있습니다.
    - ![image](https://user-images.githubusercontent.com/47103479/232502023-f1d1826d-ad85-48da-b896-4c6d5f7b9273.png)
  - ```sql
    CREATE OR REPLACE TABLE dtc-de-382512.dezoomcamp.yellow_tripdata_partitoned_clustered
    PARTITION BY DATE(tpep_pickup_datetime)
    CLUSTER BY VendorID AS
    SELECT * FROM dtc-de-382512.dezoomcamp.external_yellow_tripdata;
    ```
  - ![image](https://user-images.githubusercontent.com/47103479/232501479-485e3ce0-b860-408d-b423-ae623f78d6af.png)

# Bigquery ML 
- ![image](https://user-images.githubusercontent.com/47103479/232515215-5597ee65-236b-43d7-a4f4-762357cefe5d.png)
- ML을 위한 데이터셋을 만들어 줍니다.
  - ```sql
    -- CREATE A ML TABLE WITH APPROPRIATE TYPE
    CREATE OR REPLACE TABLE `taxi-rides-ny.nytaxi.yellow_tripdata_ml` (
    `passenger_count` INTEGER,
    `trip_distance` FLOAT64,
    `PULocationID` STRING,
    `DOLocationID` STRING,
    `payment_type` STRING,
    `fare_amount` FLOAT64,
    `tolls_amount` FLOAT64,
    `tip_amount` FLOAT64
    ) AS (
    SELECT passenger_count, trip_distance, cast(PULocationID AS STRING), CAST(DOLocationID AS STRING),
    CAST(payment_type AS STRING), fare_amount, tolls_amount, tip_amount
    FROM `taxi-rides-ny.nytaxi.yellow_tripdata_partitoned` WHERE fare_amount != 0
    );
    ```
- tip_amount을 예측하는 목적으로 선형 회귀 모델을 만들어줍니다.
  - ```sql
    CREATE OR REPLACE MODEL `taxi-rides-ny.nytaxi.tip_model`
    OPTIONS
    (model_type='linear_reg',
    input_label_cols=['tip_amount'],
    DATA_SPLIT_METHOD='AUTO_SPLIT') AS
    SELECT
    *
    FROM
    `taxi-rides-ny.nytaxi.yellow_tripdata_ml`
    WHERE
    tip_amount IS NOT NULL;
    ```
  - MODELE_TYPE='linear_reg'에서는 선형 회귀 모델을 만듭니다. 
  - INPUT_LABEL_COLS=['tip_amount']에서는 모델을 학습하고 사용하는 데 사용할 열 배열입니다.
  - DATA_SPLIT_METHOD='AUTO_SPLIT'에서는 데이터 세트를 훈련용과 테스트용(훈련/테스트)의 두 부분으로 자동 분할하도록 지정합니다.
  - ![image](https://user-images.githubusercontent.com/47103479/232517873-86bad0b3-58de-4848-abac-610d9e7e2ea5.png)
  - ![image](https://user-images.githubusercontent.com/47103479/232518057-f45b3e68-495c-4c3a-a496-d4ada6ee9712.png)
  - ![image](https://user-images.githubusercontent.com/47103479/232518257-2c1c64eb-b111-4ced-ab89-69b9b58a0807.png)
  - ![image](https://user-images.githubusercontent.com/47103479/232518292-db497219-4c66-4150-8498-cfc6c612284b.png)
- 변수를 확인합니다. 
  - ```sql
    SELECT * FROM ML.FEATURE_INFO(MODEL `taxi-rides-ny.nytaxi.tip_model`);
    ```
  - ![image](https://user-images.githubusercontent.com/47103479/232518696-6cf25ca6-e9da-408c-83fa-81e38a4daca9.png)
- 모델을 평가합니다.
  - ```sql
    SELECT
    *
    FROM
    ML.EVALUATE(MODEL `dtc-de-382512.dezoomcamp.tip_model`,
    (
    SELECT
    *
    FROM
    `dtc-de-382512.dezoomcamp.yellow_tripdata_ml`
    WHERE
    tip_amount IS NOT NULL
    ));
    ```
- 모델을 예측합니다.
  - ```sql
    SELECT
    *
    FROM
    ML.PREDICT(MODEL `dtc-de-382512.dezoomcamp.tip_model`,
    (
    SELECT
    *
    FROM
    `dtc-de-382512.dezoomcamp.yellow_tripdata_ml`
    WHERE
    tip_amount IS NOT NULL
    ));
    ```
  - ![image](https://user-images.githubusercontent.com/47103479/232519539-4ffecea8-f554-498f-a233-d0eb8bc34083.png)
- 모델을 예측하고 설명합니다.
  - ```sql
    SELECT
    *
    FROM
    ML.EXPLAIN_PREDICT(MODEL `dtc-de-382512.dezoomcamp.tip_model`,
    (
    SELECT
    *
    FROM
    `dtc-de-382512.dezoomcamp.yellow_tripdata_ml`
    WHERE
    tip_amount IS NOT NULL
    ), STRUCT(3 as top_k_features));
  - ![image](https://user-images.githubusercontent.com/47103479/232520057-5539027a-fc2f-494c-ad4a-700cffb9b1b2.png)
- 파라미터를 튜닝도 가능합니다.
  - ```sql
    CREATE OR REPLACE MODEL `dtc-de-382512.dezoomcamp.tip_hyperparam_model`
    OPTIONS
    (model_type='linear_reg',
    input_label_cols=['tip_amount'],
    DATA_SPLIT_METHOD='AUTO_SPLIT',
    num_trials=5,
    max_parallel_trials=2,
    l1_reg=hparam_range(0, 20),
    l2_reg=hparam_candidates([0, 0.1, 1, 10])) AS
    SELECT
    *
    FROM
    `dtc-de-382512.dezoomcamp.yellow_tripdata_ml`
    WHERE
    tip_amount IS NOT NULL;
    ```
  - ![image](https://user-images.githubusercontent.com/47103479/232520958-7da5d847-3626-4e6a-b89c-f0591cdef9b6.png)
  - ![image](https://user-images.githubusercontent.com/47103479/232524001-36848dfc-194b-421f-83ff-867505c18d7f.png)
  - ![image](https://user-images.githubusercontent.com/47103479/232524044-4237e79c-c7b7-4f78-a534-7779afe7bd6e.png)
  - ![image](https://user-images.githubusercontent.com/47103479/232524085-ecbe3634-f084-4844-aa79-00fb3052bc64.png)

# BigQuery Machine Learning Deployment
- <img width="309" alt="image" src="https://user-images.githubusercontent.com/47103479/233079775-f2475e00-3984-4f14-bd36-eaf59fcb90a7.png">
- > gcloud auth login
- > bq --project_id dtc-de-382512 extract -m dezoomcamp.tip_model gs://taxi_ml_model_js/tip_model : gs에 gcp의 모델을 만들어줍니다.
  - ![image](https://user-images.githubusercontent.com/47103479/233080011-45397fc5-43de-478e-b6e8-24f7258071af.png)
- > mkdir /tmp/model
- > gsutil cp -r gs://taxi_ml_model_js/tip_model /tmp/model
- > mkdir -p serving_dir/tip_model/1
- > cp -r /tmp/model/tip_model/* serving_dir/tip_model/1
- > docker pull tensorflow/serving
- > docker run -p 8501:8501 --mount type=bind,source=`pwd`/serving_dir/tip_model,target=/models/tip_model -e MODEL_NAME=tip_model -t tensorflow/serving &
- > curl -d '{"instances": [{"passenger_count":1, "trip_distance":12.2, "PULocationID":"193", "DOLocationID":"264","payment_type":"2","fare_amount":20.4,"tolls_amount":0.0}]}' -X POST http://localhost:8501/v1/models/tip_model:predict
- > http://localhost:8501/v1/models/tip_model
