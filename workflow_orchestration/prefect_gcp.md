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
- prefect에서 Blocks를 만들고 코드를 실행시키는데 ValueError: Unable to find block document named zoom-gcs for block type gcs-bucket 에러가 발생했습니다.
  - ```bash
    pip install prefect --upgrade
    prefect orion database reset
    prefect block register -m prefect_gcp
    prefect block register -m prefect_sqlachemy 
    ```
  - <img width="402" alt="image" src="https://user-images.githubusercontent.com/47103479/230914586-12e63d30-5fbd-4e91-9603-907698d52300.png">
  - 그 후에 로컬 터미널이 아닌 vscode ssh 터미널을 이용해서 prefect orion start를 실행하고 다시 Blocks를 등록해줍니다. 여기서 서비스계정의 키도 신규로 추가했습니다.
  - <img width="792" alt="image" src="https://user-images.githubusercontent.com/47103479/230915556-93ef633d-0541-45ec-a0b8-e68745870abb.png">
  - ![image](https://user-images.githubusercontent.com/47103479/230914500-2d931fdd-449e-4880-be46-3fcdb9167d62.png)
  - ![image](https://user-images.githubusercontent.com/47103479/230923548-791238b0-5a7d-42e6-8c7d-a169720834be.png)
  - GCS 버킷에 데이터가 잘 적재된것을 확인할 수 있습니다.
  - ![image](https://user-images.githubusercontent.com/47103479/230915639-d49667c6-5aab-4ce8-a4e9-433d307867b6.png)
  - 위와 같은 에러가 발생한다면 먼저 Blocks에 Type이 잘 할당 되었는지 확인이 필요할 거같습니다.
    - > prefect blocks ls
    - <img width="770" alt="image" src="https://user-images.githubusercontent.com/47103479/230915992-fc2b0996-8256-4d2f-81bc-06cd7a1a90ff.png">
- 최종 코드는 다음과 같습니다.
- ```python
  from pathlib import Path
  import pandas as pd
  from prefect import flow, task
  from prefect_gcp.cloud_storage import GcsBucket


  @task(retries=3)
  #retries parametes tells how many times our task will restart in case of crash
  def fetch(dataset_url: str) -> pd.DataFrame:
      """Read data from web inmto pandas dataframe"""
      df = pd.read_csv(dataset_url)
      return df

  @task(log_prints=True)
  #log_prints will write logs to our console and UI
  def clean(df) -> pd.DataFrame:
      """Fix some dtype issues"""
      df["tpep_pickup_datetime"] = pd.to_datetime(df["tpep_pickup_datetime"]) 
      df["tpep_dropoff_datetime"] = pd.to_datetime(df["tpep_dropoff_datetime"])
      print(df.head(2))
      print(df.dtypes)
      print('Length of DF:', len(df))
      return df

  @task(log_prints=True)
  def export_data_local(df, color, dataset_file):
      path = Path(f"data/{color}/{dataset_file}.parquet")
      df.to_parquet(path, compression="gzip")
      return path


  @task()
  def write_local(df: pd.DataFrame, color: str, dataset_file: str) -> Path:
      """write df as a parquet file"""
      path = Path(f"data/{color}/{dataset_file}.parquet")
      if not path.parent.is_dir():
          path.parent.mkdir(parents=True)
      df.to_parquet(path, compression="gzip")
      return path

  @task()
  def write_gcs(path: Path) -> None:
      """Upload local parquet file to GCS"""
      gcs_block = GcsBucket.load("zoom-gcs")
      gcs_block.upload_from_path(from_path=path, to_path=path)
      return

  @flow()
  def etl_web_to_gcs()->None:
      """Main ETL function"""
      color = "yellow"
      year = 2021
      month = 1 
      dataset_file = f"{color}_tripdata_{year}-{month:02}"
      dataset_url = f"https://github.com/DataTalksClub/nyc-tlc-data/releases/download/{color}/{dataset_file}.csv.gz"

      df = fetch(dataset_url)
      df_clean = clean(df)
      path = write_local(df_clean, color, dataset_file)
      write_gcs(path)

  if __name__ == '__main__':
      etl_web_to_gcs()
  ```

# Cloud Storage에서 BigQuery로 Parquet 수집
- 데이터를 GCP로 수집하려면 Parquet 파일의 스키마를 사용하여 BigQuery에서 테이블을 생성해야 합니다
  - GCP > BigQuery > 추가 > Google Cloud Storage를 클릭합니다.
  - ![image](https://user-images.githubusercontent.com/47103479/230924740-8bdbbd73-7f4d-420c-9a8d-0b25af31034c.png)
