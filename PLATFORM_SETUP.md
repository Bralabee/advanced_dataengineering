# Platform Setup

## Overview
This document describes the setup, configuration, and usage of the ETL platform, which includes Airflow, dbt, OCR (GPU-enabled), and a Python/conda-based fabric service. The platform is fully containerized using Docker Compose and supports both CPU and GPU workloads.

---

## Prerequisites
- **Docker** (v20.10+ recommended)
- **Docker Compose** (v2.0+ recommended)
- **NVIDIA GPU** (for OCR service, optional for others)
- **NVIDIA Container Toolkit** (for GPU support)
- **Linux OS** (tested on Ubuntu 20.04/22.04)

---

## Directory Structure
```
project-root/
├── airflow/
│   ├── dags/
│   └── plugins/
├── dbt/
├── ocr/
│   └── Dockerfile
├── fabric/
│   └── Dockerfile
├── docker-compose.yml
└── ...
```

---

## Service Descriptions

### 1. Airflow
- **Image:** `apache/airflow:2.9.2-python3.11`
- **Port:** 8084 (host) → 8080 (container)
- **Volumes:**
  - `./airflow/dags:/usr/local/airflow/dags`
  - `./airflow/plugins:/usr/local/airflow/plugins`
- **Startup:** Initializes the Airflow DB and starts the webserver automatically.
- **Access:** http://localhost:8084

### 2. dbt
- **Image:** `ghcr.io/dbt-labs/dbt-core:1.8.1`
- **Volumes:**
  - `./dbt:/usr/app`
- **Working Directory:** `/usr/app`
- **Startup:** Prints dbt version by default (customize command as needed).

### 3. OCR Service Options
- **GPU-enabled:**
  - **Service Name:** `ocr-gpu`
  - **Base Image:** `nvidia/cuda:12.2.0-base-ubuntu22.04`
  - **Runtime:** `nvidia` (requires NVIDIA GPU and drivers)
  - **Environment:** `NVIDIA_VISIBLE_DEVICES=all`
- **CPU-only:**
  - **Service Name:** `ocr-cpu`
  - **Base Image:** `ubuntu:22.04`
  - **No GPU required**
  - **Both services:** `python3`, `python3-pip`, `tesseract-ocr`, `libtesseract-dev`, `libgl1`, `paddleocr`

### 4. Fabric (Python/conda)
- **Base Image:** `mambaorg/micromamba:1.5.8`
- **Python Version:** 3.11 (via micromamba)
- **Key Packages:** `azure-storage-file-datalake` (installed via pip)
- **Volumes:**
  - `./fabric:/app`

---

## Setup Steps

### 1. Clone the Repository
```bash
git clone <repo-url>
cd <repo-root>
```

### 2. Configure NVIDIA Container Toolkit (for GPU)
- Install NVIDIA drivers for your GPU.
- Install NVIDIA Container Toolkit:
  ```bash
  sudo apt-get install -y nvidia-docker2
  sudo systemctl restart docker
  ```
- Ensure `/etc/docker/daemon.json` contains:
  ```json
  {
    "default-runtime": "runc",
    "runtimes": {
      "nvidia": {
        "path": "nvidia-container-runtime",
        "runtimeArgs": []
      }
    }
  }
  ```

### 3. Build and Start the Platform
```bash
# For GPU systems:
docker-compose --profile gpu up --build
# For CPU-only systems:
docker-compose --profile cpu up --build
```
- All services will build and start according to the selected profile.
- Airflow will initialize its database and start the webserver.
- dbt will print its version (customize as needed).
- OCR and fabric containers will print a ready message and exit (customize as needed).

### 4. Accessing Services
- **Airflow UI:** http://localhost:8084
- **dbt:** Attach to the container or customize the command in `docker-compose.yml`.
- **OCR/Fabric:** Extend with your own scripts or pipelines.

---

## Customization
- **Airflow:** Add DAGs to `airflow/dags/` and plugins to `airflow/plugins/`.
- **dbt:** Place your dbt project in the `dbt/` directory.
- **OCR:** Add/modify scripts in the `ocr/` directory and update the appropriate Dockerfile (`Dockerfile` for GPU, `Dockerfile.cpu` for CPU) as needed.
- **Fabric:** Add/modify scripts in the `fabric/` directory and update the Dockerfile as needed.

---

## Troubleshooting
- **Port Conflicts:** Change the host port in `docker-compose.yml` if 8084 is in use.
- **GPU Errors:** Ensure NVIDIA drivers and container toolkit are installed and configured (only needed for GPU profile).
- **OCR Build Fails (No GPU):** Use the CPU profile to build and run the OCR service on systems without a GPU.
- **Airflow DB Error:** If Airflow fails to start, ensure the database is initialized (`airflow db init`).
- **Python Version:** All services use Python 3.11 for maximum compatibility.

---

## References
- [Airflow Docs](https://airflow.apache.org/docs/)
- [dbt Docs](https://docs.getdbt.com/docs/introduction)
- [PaddleOCR](https://github.com/PaddlePaddle/PaddleOCR)
- [Micromamba](https://mamba.readthedocs.io/en/latest/user_guide/micromamba.html)
- [Azure Storage SDK](https://pypi.org/project/azure-storage-file-datalake/)

---

## Authors
- Platform setup and automation by Sanmi Ibitoye | : Data Engineer @ HS2.
