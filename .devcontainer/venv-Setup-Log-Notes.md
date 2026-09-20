# GitHub Codespaces Setup Log
**Repo:** SarhadGautam/AI-Data-Engineer-Portfolio  
**Date:** 2026-09-20  
**Codespace Name:** crispy space tribble

---

## Environment

| Component | Version |
|-----------|---------|
| OS | Ubuntu 22.04.5 LTS |
| Python | 3.11 (devcontainer) / 3.14.2 (default) |
| pip | 26.2.1 |
| Docker | 29.8.0 |

---

## Step 1 — Created devcontainer.json

**File:** `.devcontainer/devcontainer.json`

**First attempt (caused error):**
```json
{
  "name": "AI Data Engineer",
  "image": "mcr.microsoft.com/devcontainers/python:3.11",
  "features": {
    "ghcr.io/devcontainers/features/docker-in-docker:2": {}
  },
  "postCreateCommand": "pip install apache-airflow dbt-duckdb great-expectations pandas sqlalchemy psycopg2-binary",
  "customizations": {
    "vscode": {
      "extensions": [
        "ms-python.python",
        "ms-azuretools.vscode-docker",
        "innoverio.vscode-dbt-power-user",
        "mtxr.sqltools"
      ]
    }
  },
  "forwardPorts": [8080, 5432, 6333]
}
```

**Error:**
```
The 'moby' option is not supported on debian 'trixie' because 
'moby-cli' and related system packages are not available in that distribution.
ERROR: Feature "Docker (Docker-in-Docker)" failed to install!
```

**Root Cause:**  
The `docker-in-docker` feature defaults to installing Moby-flavoured Docker. 
Moby packages are not available on Debian Trixie (which Python 3.11 devcontainer uses).

**Fix:** Add `"moby": false` to use Docker CE instead of Moby.

**Fixed devcontainer.json:**
```json
{
  "name": "AI Data Engineer",
  "image": "mcr.microsoft.com/devcontainers/python:3.11",
  "features": {
    "ghcr.io/devcontainers/features/docker-in-docker:2": {
      "moby": false
    }
  },
  "postCreateCommand": "pip install apache-airflow dbt-duckdb great-expectations pandas sqlalchemy psycopg2-binary",
  "customizations": {
    "vscode": {
      "extensions": [
        "ms-python.python",
        "ms-azuretools.vscode-docker",
        "innoverio.vscode-dbt-power-user",
        "mtxr.sqltools"
      ]
    }
  },
  "forwardPorts": [8080, 5432, 6333]
}
```

**Resolution:** Rebuild container → Success ✅  
**Ports forwarded:** 5432 (Postgres), 6333 (Qdrant), 8080 (Airflow)

---

## Step 2 — Airflow Installation

**Command used:**
```bash
pip install apache-airflow --constraint \
"https://raw.githubusercontent.com/apache/airflow/constraints-2.9.1/constraints-3.11.txt"
```

**Warning received (not an error):**
```
WARNING - cannot load CLI commands from auth manager
WARNING - Authentication manager is not configured
```

**Root Cause:**  
These are expected warnings when running Airflow CLI without a full 
Airflow database/config initialised. Airflow itself installed correctly.

**Resolution:** Warnings are expected at this stage. Airflow will be 
properly configured later using Docker Compose. ✅

---

## Step 3 — dbt Installation & Dependency Conflicts

**Command:**
```bash
pip install --upgrade typing_extensions
dbt --version
```

**Errors:**
```
dbt-common requires opentelemetry-api<3.0,>=1.26, have 1.24.0
dbt-core requires click<9.0,>=8.3.0, have 8.1.7
dbt-core requires protobuf<8.0,>=6.0, have 4.25.3
dbt-core requires sqlparse<0.7.0,>=0.5.5, have 0.5.0
apache-airflow-task-sdk requires tenacity>=8.3.0, have 8.2.3
```

**Root Cause:**  
Airflow and dbt require conflicting versions of shared packages 
(protobuf, opentelemetry-api, click, sqlparse, tenacity).
Installing both in the same environment causes version conflicts.

**Fix:** Use separate Python virtual environments for each tool.

**Resolution (in progress):**
```bash
# dbt virtual environment
python -m venv ~/.venvs/dbt-env
source ~/.venvs/dbt-env/bin/activate
pip install dbt-duckdb
dbt --version
deactivate

# Airflow virtual environment
python -m venv ~/.venvs/airflow-env
source ~/.venvs/airflow-env/bin/activate
pip install apache-airflow --constraint \
"https://raw.githubusercontent.com/apache/airflow/constraints-2.9.1/constraints-3.11.txt"
airflow --version
deactivate
```

---

## Ports Reference

| Port | Service | Status |
|------|---------|--------|
| 8080 | Apache Airflow UI | Forwarded ✅ |
| 5432 | PostgreSQL | Forwarded ✅ |
| 6333 | Qdrant Vector DB | Forwarded ✅ |

---

## Virtual Environments Reference

| Path | Tool | Purpose |
|------|------|---------|
| `~/.venvs/dbt-env` | dbt + DuckDB | Project 02 - Data Warehouse |
| `~/.venvs/airflow-env` | Apache Airflow | Project 01 - ETL Pipeline |

**To activate:**
```bash
source ~/.venvs/dbt-env/bin/activate      # for dbt work
source ~/.venvs/airflow-env/bin/activate  # for Airflow work
deactivate                                 # to exit any venv
```

---

## Lessons Learned

1. **Moby vs Docker CE** — devcontainer `docker-in-docker` feature defaults 
   to Moby. On Debian Trixie, always set `"moby": false`.

2. **Airflow warnings are not errors** — Airflow CLI shows auth manager 
   warnings when no database is initialised. This is expected behaviour.

3. **Airflow + dbt conflict** — Never install Airflow and dbt in the same 
   Python environment. Always use separate virtual environments.

4. **Constraint files** — Always install Airflow with the official constraint 
   file for your Python version to avoid dependency hell.

---

## Next Steps

- [ ] Verify dbt and Airflow install correctly in their venvs
- [ ] Commit `.devcontainer/devcontainer.json` to GitHub
- [ ] Start Project 01 — ETL Pipeline with Airflow + Postgres

---

## Step 4 — Virtual Environment Persistence in Codespaces

**Question:** Do venvs need to be recreated every time Codespaces is opened?

**Answer:** Yes and No.

**When venvs get wiped:**
- When Codespace is **rebuilt** (e.g. devcontainer.json changes)
- When Codespace is **deleted and recreated**
- When GitHub **auto-cleans** inactive Codespaces after 30 days

**When venvs persist:**
- Normal open/close of an existing Codespace ✅
- Reopening a paused Codespace ✅

---

### Permanent Fix — Automate venv creation via setup.sh

Instead of manually creating venvs, we use a `setup.sh` script that 
runs automatically every time the container is built.

**Updated devcontainer.json postCreateCommand:**
```json
"postCreateCommand": "bash .devcontainer/setup.sh"
```

**Create `.devcontainer/setup.sh`:**
```bash
#!/bin/bash

# Create virtual environments
python -m venv ~/.venvs/airflow-env
python -m venv ~/.venvs/dbt-env

# Install Airflow in its venv
source ~/.venvs/airflow-env/bin/activate
pip install apache-airflow --constraint \
"https://raw.githubusercontent.com/apache/airflow/constraints-2.9.1/constraints-3.11.txt"
deactivate

# Install dbt in its venv
source ~/.venvs/dbt-env/bin/activate
pip install dbt-duckdb
deactivate

# Install common packages in base environment
pip install pandas sqlalchemy psycopg2-binary great-expectations
```

**Benefits:**
- Every Codespace rebuild → setup runs automatically
- No manual installation needed ever again
- Anyone who forks the repo gets identical environment
- Consistent, reproducible environment every time

---

### Quick Reference — Activating Virtual Environments

```bash
# Activate dbt environment
source ~/.venvs/dbt-env/bin/activate

# Activate Airflow environment  
source ~/.venvs/airflow-env/bin/activate

# Check which venv is active
which python

# Deactivate any venv
deactivate
```


---

## Step 5 — Verifying venvs After Codespace Session Timeout

**Scenario:** Codespace auto-suspends after 30 minutes of inactivity.
After logging back in, always verify venvs are still intact.

**Check dbt venv:**
```bash
source ~/.venvs/dbt-env/bin/activate
dbt --version
deactivate
```

**Check Airflow venv:**
```bash
source ~/.venvs/airflow-env/bin/activate
airflow --version
deactivate
```

**Expected outcomes:**

| Outcome | Meaning | Action |
|---------|---------|--------|
| ✅ Version prints correctly | venv persisted through session pause | Continue working |
| ❌ No such file or directory | venv got wiped (rebuild/recreation) | Re-run setup.sh |
| ❌ Command not found | Package not installed in venv | Re-run pip install inside venv |

**Note:** A simple session timeout/pause will NOT wipe venvs.
venvs only get wiped on full container rebuild or Codespace deletion.

---

### Always Run This Health Check When Returning to Codespace

```bash
# Quick health check script — run after every login
source ~/.venvs/dbt-env/bin/activate && dbt --version && deactivate && echo "dbt ✅" || echo "dbt ❌ - needs reinstall"
source ~/.venvs/airflow-env/bin/activate && airflow --version && deactivate && echo "Airflow ✅" || echo "Airflow ❌ - needs reinstall"
docker --version && echo "Docker ✅" || echo "Docker ❌"
python --version && echo "Python ✅" || echo "Python ❌"
```


---

## Step 6 — Health Check Script Fix

**Issue:** Health check script incorrectly flagged Airflow as ❌  
**Root Cause:** `airflow --version` is wrong syntax — Airflow uses `airflow version` (no dashes)

**Corrected health check script:**
```bash
source ~/.venvs/dbt-env/bin/activate && dbt --version && deactivate && echo "dbt ✅" || echo "dbt ❌ - needs reinstall"
source ~/.venvs/airflow-env/bin/activate && airflow version && deactivate && echo "Airflow ✅" || echo "Airflow ❌ - needs reinstall"
docker --version && echo "Docker ✅" || echo "Docker ❌"
python --version && echo "Python ✅" || echo "Python ❌"
```

**Verified versions after session timeout:**

| Tool | Version | Status |
|------|---------|--------|
| dbt | latest | ✅ Persisted |
| Airflow | 2.9.3 | ✅ Persisted |
| Docker | 29.8.1 | ✅ Persisted |
| Python | 3.11.16 | ✅ Persisted |

**Conclusion:** All venvs and tools survived the Codespace session timeout successfully.

---

## Important — Airflow CLI Syntax

| Wrong ❌ | Correct ✅ |
|----------|-----------|
| `airflow --version` | `airflow version` |

