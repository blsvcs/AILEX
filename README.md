# AILEX

AILEX is a pilot legal analytics project for structured Latvian case-law analysis.

## Pilot module

The first pilot module is focused on **Kriminallikuma 329. pants**: neizpauzamu zinu izpausana.

The goal is to move from a document archive to a structured, scalable knowledge base for lawyers, legal researchers and private persons.

## Repository structure

```text
schema/
  schema_sqlite.sql
  schema_supabase_postgres.sql
  data_dictionary.csv
queries/
  example_queries.sql
data/kl329/
  database_summary.json
  notes.md
```

## Current status

This repository has been initialized from the KL329 pilot package created in ChatGPT. The next step is to upload or regenerate the larger binary artifacts, including the SQLite database and ZIP package, if needed.

## Key design principles

- multi-article architecture, not limited to KL 329;
- structured metadata for cases, documents, institutions, officials, devices and evidence;
- ontology layer for legal concepts and relationships;
- jurist validation layer for professional use;
- cloud-ready PostgreSQL/Supabase schema;
- full-text and future vector search support.
