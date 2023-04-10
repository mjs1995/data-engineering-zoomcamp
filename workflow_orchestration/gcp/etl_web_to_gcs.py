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
