#!/bin/bash

echo "=========================================="
echo " AI Data Engineer - Environment Setup"
echo "=========================================="

# ── Create virtual environments ──────────────
echo ""
echo ">>> Creating virtual environments..."
python -m venv ~/.venvs/airflow-env
python -m venv ~/.venvs/dbt-env
echo "Virtual environments created ✅"

# ── Install Airflow ───────────────────────────
echo ""
echo ">>> Installing Apache Airflow 2.9.3..."
source ~/.venvs/airflow-env/bin/activate
pip install --quiet apache-airflow --constraint \
  "https://raw.githubusercontent.com/apache/airflow/constraints-2.9.1/constraints-3.11.txt"
deactivate
echo "Airflow installed ✅"

# ── Install dbt ───────────────────────────────
echo ""
echo ">>> Installing dbt + DuckDB..."
source ~/.venvs/dbt-env/bin/activate
pip install --quiet dbt-duckdb
deactivate
echo "dbt + DuckDB installed ✅"

# ── Install common packages ───────────────────
echo ""
echo ">>> Installing common packages..."
pip install --quiet \
  pandas \
  sqlalchemy \
  psycopg2-binary \
  great-expectations
echo "Common packages installed ✅"

# ── Done ──────────────────────────────────────
echo ""
echo "=========================================="
echo " Setup complete! Run health check:"
echo ""
echo " source ~/.venvs/dbt-env/bin/activate && dbt --version && deactivate"
echo " source ~/.venvs/airflow-env/bin/activate && airflow version && deactivate"
echo "=========================================="
