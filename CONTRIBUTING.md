# Contributing to the Advanced Data Engineering Platform

Thank you for your interest in contributing! This project is designed to help you quickly bootstrap robust data engineering, analytics, and AI workflows.

## Getting Started
- Clone the repository and check out the `fabric-azure-connector` branch.
- Copy `.env.example` to `.env` and fill in your credentials.
- Use the Makefile for common tasks (see `make help`).

## Adding Services
- Add new services to `docker-compose.yml`.
- Document any new environment variables in `.env.example`.
- Add or update service-specific README files as needed.

## Code Style & Linting
- Python: Use `black` and `flake8`.
- YAML: Use `yamllint`.
- Pre-commit hooks are recommended (see `.pre-commit-config.yaml`).

## Testing
- Add or update sample DAGs and dbt models for new features.
- Use the "Testing the Stack" section in the main README for validation steps.

## Pull Requests
- Ensure your branch is up to date with `fabric-azure-connector`.
- Write clear commit messages and PR descriptions.
- Reference issues or features addressed.

---

For questions, open an issue or contact the maintainers.

## Security

If you discover a security vulnerability, please report it privately to the maintainers. Do not disclose it publicly until it has been addressed.
