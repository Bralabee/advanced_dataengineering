from airflow import DAG
from airflow.operators.bash import BashOperator
from datetime import datetime

default_args = {
    'start_date': datetime(2023, 1, 1),
}

dag = DAG(
    'example_dag',
    default_args=default_args,
    schedule_interval=None,
    catchup=False
)

task = BashOperator(
    task_id='print_hello',
    bash_command='echo Hello from Airflow!',
    dag=dag
)
