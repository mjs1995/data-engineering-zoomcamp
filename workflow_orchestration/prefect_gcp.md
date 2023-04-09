# Prefect
- Cloud Storage 에서 BigQuery 데이터 베이스 로 Parquet 데이터를 수집하기 위해 Prefect을 쓰려고 합니다.
- ```python
  conda create -n zoomcamp python=3.9
  conda activate zoomcamp
  pip install -r requirements.txt
  ```
- requirements.txt 파일의 경우 다음과 같습니다.
  ```shell
  pandas==1.5.2
  prefect==2.7.7
  prefect-sqlalchemy==0.2.2
  prefect-gcp[cloud_storage]==0.2.3
  protobuf==4.21.11
  pyarrow==10.0.1
  pandas-gbq==0.19.0
  ```
- > prefect orion start : GUI 환경으로 접속합니다.
  - <img width="629" alt="image" src="https://user-images.githubusercontent.com/47103479/230773998-57bb9b1c-0b31-4bb9-bed8-fec442d66bba.png">

# GCS Pipeline 연결
- 버킷을 신규로 생성합니다.
  - ![image](https://user-images.githubusercontent.com/47103479/230776777-ae03788c-20a1-4288-be85-a3017c69ba64.png)
- prefect 내부에서 Block를 눌러 다양한 커넥터를 확인합니다.
  - ![image](https://user-images.githubusercontent.com/47103479/230776923-8cf1aaf3-d387-4ab8-b00d-037d45451b70.png)
- Google Cloud Platform 용 Prefect 커넥터를 등록합니다.
  - > prefect block register -m prefect_gcp
  - <img width="859" alt="image" src="https://user-images.githubusercontent.com/47103479/230776975-d6f69474-2c83-4678-ab2c-c43df569ee39.png">
- prefect GUI 환경에서 GCS 등록해줍니다.
  - 먼저 구글 IAM에서 서비스계정을 신규로 만듭니다. 
    - ![image](https://user-images.githubusercontent.com/47103479/230777361-6d9e7224-bfeb-4911-9404-4ae3b507450f.png)
    - ![image](https://user-images.githubusercontent.com/47103479/230777406-25386711-2a7c-448c-abc8-c472ee5edc8e.png)
    - 생성된 서비스 계정에 신규로 키를 등록해주고 prefect에도 등록해줍니다.
  - ![image](https://user-images.githubusercontent.com/47103479/230777536-65050b6d-c46b-45e7-840a-9ec38b1a8f2f.png)
  - ![image](https://user-images.githubusercontent.com/47103479/230777601-ab0ec9ff-b714-445c-bf28-65c2a33e03d5.png)
