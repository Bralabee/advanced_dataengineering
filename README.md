
# Advanced Data Engineering Platform

> **Note:** This branch (`fabric-azure-connector`) is dedicated to setting up the foundational stack. Other developers can use this state to quickly bootstrap their own data engineering, analytics, or AI workflows. Clone this branch to get a ready-to-use, production-like environment for your projects.

## Overview
This platform is a modular, production-ready data engineering stack designed for end-to-end ETL, analytics, and AI workflows. It leverages modern open-source and Azure-compatible tools, orchestrated via Docker Compose for local and cloud development.

## Architecture Diagram

```
+-------------------+         +-------------------+         +-------------------+
|    Azurite        | <-----> |   Fabric Service  | <-----> |   OCR (GPU/CPU)   |
| (Blob Emulator)   |         | (Azure/Local)     |         |   (PaddleOCR)     |
+-------------------+         +-------------------+         +-------------------+
        |                           |                             |
        v                           v                             v
+-------------------+         +-------------------+         +-------------------+
|     Postgres      | <-----> |     Airflow       | <-----> |       dbt         |
| (Metadata Store)  |         | (Orchestration)   |         | (Analytics/ELT)   |
+-------------------+         +-------------------+         +-------------------+
```

## Components & Interdependencies

- **Postgres**: Central metadata store for Airflow. All orchestration state and credentials are stored here.
- **Airflow**: Orchestrates ETL, ML, and analytics workflows. Uses Postgres for metadata. Runs as both webserver and scheduler.
- **dbt**: Analytics engineering and data transformation. Can be triggered by Airflow DAGs.
- **OCR (GPU/CPU)**: PaddleOCR-based service for document/image text extraction. Can be invoked by Airflow tasks or Fabric pipelines. GPU and CPU profiles available.
- **Fabric**: (Optional) Azure-compatible data science/AI environment. Connects to Azurite for local blob storage and can interact with Airflow/dbt.
- **Azurite**: Local emulator for Azure Blob, Queue, and Table storage. Used for development and integration testing.

## How the Stack Works Together

- Airflow DAGs can trigger dbt models, OCR jobs, and Fabric pipelines.
- All data and workflow state is tracked in Postgres.
- Azurite provides a local Azure-like storage endpoint for Fabric and other services.
- The OCR service can be used independently or as part of orchestrated workflows.
- Fabric can read/write from Azurite and be orchestrated by Airflow.

## Running the Platform

1. **Start the stack (GPU profile):**
   ```bash
   docker-compose --profile gpu up -d --build
   ```
   For CPU-only OCR:
   ```bash
   docker-compose --profile cpu up -d --build
   ```
2. **Access Airflow UI:**
   - http://localhost:8084 (default admin user is auto-created)
3. **Access Azurite:**
   - Blob: http://localhost:10000
   - Queue: http://localhost:10001
   - Table: http://localhost:10002

## Development Notes
- All persistent data (Postgres, Airflow, Azurite) is stored in local volumes and excluded from git.
- Admin user for Airflow is created automatically at startup.
- Add your DAGs to `airflow/dags/` and dbt models to `dbt/`.
- Fabric and OCR services can be extended for custom ML/data science workflows.

## Extending the Stack
- Add new services to `docker-compose.yml` as needed.
- Integrate with Azure by swapping Azurite for real Azure Storage and updating credentials.
- Use Airflow to orchestrate any combination of ETL, ML, and analytics tasks.

---

For detailed service configuration, see the individual README files in each service directory.
