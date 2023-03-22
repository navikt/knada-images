# Papermill

Dette er et Papermill image som forenkler prosessen med å kjøre Jupyter notebooks i Airflow.

## DAG eksempel

```
from airflow import DAG
from datetime import datetime

import os

with DAG('run-notebook', start_date=datetime(2023, 3, 22), schedule_interval="0 10 * * *") as dag:
    t1 = KubernetesPodOperator(
        task_id="hello pod",
        image=os.environ['PAPERMILL_IMAGE']
        arguments=[
            "--log-output",
            "/dags/dags/notebook.ipynb",
            "output.ipynb"
        ]
    )
```
