# Sarhad Gautam — AI Data Engineer Portfolio

> Building production-grade data pipelines, vector search systems, and AI-powered data platforms.

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-0A66C2?style=flat&logo=linkedin)](https://www.linkedin.com/in/sarhad-gautam-89b95112b/)
[![GitHub](https://img.shields.io/badge/GitHub-SarhadGautam-181717?style=flat&logo=github)](https://github.com/SarhadGautam/AI-Data-Engineer-Portfolio)

---

## About Me

I'm an AI Data Engineer with professional experience in data engineering and a growing specialisation in AI-powered data systems — from traditional SQL warehouses to vector databases and RAG pipelines.

**What I build:**
- End-to-end ETL/ELT pipelines (Airflow, dbt, Spark)
- Vector databases and semantic search systems (pgvector, Qdrant, Chroma)
- RAG (Retrieval-Augmented Generation) pipelines with LLMs
- DataOps stacks with CI/CD, data quality, and observability

**Tech Stack:**

| Layer | Tools |
|-------|-------|
| Orchestration | Apache Airflow, GitHub Actions |
| Transformation | dbt, PySpark, pandas |
| Storage | PostgreSQL, DuckDB, Qdrant, pgvector |
| AI / Embeddings | LangChain, LlamaIndex, OpenAI, HuggingFace |
| DataOps | Docker, Great Expectations, Prometheus, Grafana |
| Language | Python (primary), SQL |

**Open to:** AI Data Engineer · Data Engineer · MLOps Engineer roles  
**Locations:** India · Australia (Visa Sponsorship welcome)

---

## Repository Structure

```
AI-Data-Engineer-Portfolio/
│
├── .github/
│   └── workflows/                   ← CI/CD pipelines (paths updated per project)
│
├── guided/                          ← Built step by step with guidance
│   ├── 01-etl-pipeline/             ← Airflow + Postgres ETL
│   ├── 02-dbt-warehouse/            ← dbt + DuckDB warehouse
│   ├── 03-vector-db-benchmark/      ← Vector DB comparison
│   ├── 04-rag-pipeline/             ← RAG + FastAPI
│   ├── 05-dataops-stack/            ← Docker + Monitoring
│   └── 06-capstone/                 ← End-to-end platform
│
└── independent/                     ← Your own projects built solo
    └── (your own projects)
```

---

## Guided Projects

> Step-by-step projects covering the full AI Data Engineer stack.

### 01 · ETL Pipeline with Airflow + Postgres
> Automated data ingestion pipeline with orchestration, data quality checks, and CI/CD

- Ingests real-world open dataset via Python
- Orchestrated with Apache Airflow (Dockerised)
- Loads into PostgreSQL with schema validation
- Data quality checks via Great Expectations
- GitHub Actions CI runs tests on every push

**Stack:** Python · Airflow · PostgreSQL · Docker · Great Expectations · GitHub Actions  
📁 [View Project](./guided/01-etl-pipeline/)

---

### 02 · Data Warehouse with dbt + DuckDB
> Modern analytics warehouse with layered dbt models and auto-generated documentation

- Staging → Intermediate → Mart layer architecture
- Star schema design with fact and dimension tables
- dbt tests on every model
- Auto-generated dbt docs published to GitHub Pages

**Stack:** dbt · DuckDB · SQL · GitHub Pages  
📁 [View Project](./guided/02-dbt-warehouse/)

---

### 03 · Vector DB Benchmark
> Systematic comparison of leading vector databases on real embedding workloads

- Benchmarks Qdrant, Chroma, Weaviate, pgvector
- Measures latency, recall@k, throughput, and index size
- Uses real text embeddings (HuggingFace sentence-transformers)
- Results published as a visual report

**Stack:** Python · Qdrant · Chroma · pgvector · HuggingFace · Pandas  
📁 [View Project](./guided/03-vector-db-benchmark/)

---

### 04 · RAG Pipeline with FastAPI
> Production-style Retrieval-Augmented Generation pipeline with REST API serving

- Document ingestion → chunking → embedding → vector store
- Hybrid search (dense + BM25)
- FastAPI serving layer with query endpoint
- Streamlit demo UI

**Stack:** Python · LangChain · Qdrant · FastAPI · Streamlit · OpenAI / HuggingFace  
📁 [View Project](./guided/04-rag-pipeline/)

---

### 05 · DataOps Stack
> Fully Dockerised data platform with CI/CD, monitoring, and alerting

- One-command startup via Docker Compose
- Airflow + Postgres + Vector DB in a single stack
- Prometheus metrics + Grafana dashboards
- Pipeline SLA alerting and data quality reporting

**Stack:** Docker Compose · Airflow · Prometheus · Grafana · GitHub Actions  
📁 [View Project](./guided/05-dataops-stack/)

---

### 06 · Capstone — AI-Powered Data Platform
> End-to-end platform: ingest → transform → store → serve → monitor

- Kafka ingestion → dbt/Spark transformation
- Postgres + pgvector storage
- FastAPI RAG serving layer
- Grafana observability
- Full CI/CD with GitHub Actions
- Runs entirely on free tier infrastructure

**Stack:** Kafka · dbt · Spark · PostgreSQL · pgvector · FastAPI · Grafana · Docker  
📁 [View Project](./guided/06-capstone/)

---

## Independent Projects

> Projects built independently, applying skills from guided track and beyond.

📁 [View Projects](./independent/)

---

## Free Infrastructure Used

All projects run on free-tier infrastructure — no credit card required:

| Service | Used For |
|---------|----------|
| GitHub Codespaces | Development environment (60 hrs/month free) |
| GitHub Actions | CI/CD pipelines |
| Oracle Cloud Free Tier | Persistent VM for vector DB and services |
| Fly.io / Render | FastAPI app hosting |
| DuckDB | In-process analytics warehouse |

---

## Connect

- LinkedIn: [sarhad-gautam-89b95112b](https://www.linkedin.com/in/sarhad-gautam-89b95112b/)
- GitHub: [SarhadGautam](https://github.com/SarhadGautam)
