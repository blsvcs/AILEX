# Supabase deployment guide

This directory documents how to deploy the AILEX KL329 pilot database to Supabase and PostgreSQL.

## Create a Supabase project

Create a new Supabase project, for example `ailex-pilot`.

## Enable extensions

The schema uses `pgcrypto` and `vector`. Enable them in the Supabase dashboard before running the schema.

## Run schema

Open the Supabase SQL Editor and run the contents of `schema/schema_supabase_postgres.sql`.

## Import data

Recommended migration path:

1. Use the SQLite database in `data/kl329/` as the local seed.
2. Export SQLite tables to CSV.
3. Import the CSV files into matching Supabase tables.
4. Keep original documents in Supabase Storage.

## Suggested storage buckets

Create these buckets:

- `legal-documents` for original judgments and source files.
- `processed-text` for extracted text and markdown.
- `exports` for generated ZIP, XLSX and CSV packages.

## Recommended access model

For a pilot, keep access restricted. Before wider use, add role-based access for admin, legal reviewer, researcher and read-only user.

## Validation workflow

Every AI-generated field should have a review state: auto detected, needs review, human reviewed or verified.

## Production warning

Do not expose original documents publicly unless anonymization and legal basis have been reviewed.
