from pathlib import Path
import pandas as pd
from prefect import flow, task
from prefect_gcp.cloud_storage import GcsBucket
from prefect.tasks import task_input_hash
from datetime import timedelta
from prefect_gcp import GcpCredentials


##########################################################
######## parent flow ########
##########################################################
@flow()
def etl_parent_flow(months: list[int] = [1,2], year: int = 2021, color: str = "yellow"):
    for month in months:
        etl_web_to_gcs(year, month, color)
        etl_gcs_to_bq(year, month, color)
    

if __name__ == "__main__":
    color="yellow"
    months=[1,2,3]
    year=2021
    etl_parent_flow(months, year, color)

