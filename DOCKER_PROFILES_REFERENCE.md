# Quick Reference: Docker Compose Profiles

## Usage Scenarios

### Local Development (Azurite)
- **GPU:**
  ```bash
  docker-compose --profile gpu --profile local up
  ```
- **CPU:**
  ```bash
  docker-compose --profile cpu --profile local up
  ```

### Production (Fabric/Azure)
- **GPU:**
  ```bash
  docker-compose --profile gpu --profile azure up
  ```
- **CPU:**
  ```bash
  docker-compose --profile cpu --profile azure up
  ```

## Service Profiles
- `local`: Azurite (local blob storage emulation)
- `azure`: Fabric (Azure Data Lake, prod)
- `gpu`: OCR with GPU
- `cpu`: OCR with CPU

## Notes
- You can combine profiles as needed.
- Airflow and dbt run by default with any profile.
- To run only a specific service, use its profile and omit others.

---
For more details, see `docker-compose.yml` or ask your AI assistant.
