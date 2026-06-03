# GitHub-only architecture

This project can run with GitHub as the only mandatory infrastructure.

## What GitHub stores

GitHub stores:

- original documents and source ZIP archives;
- generated SQLite database;
- SQL schemas;
- ontology JSON and CSV files;
- case-to-ontology mappings;
- legal playbooks and documentation;
- validation scripts;
- example SQL queries.

## Operating model

The repository is the source of truth. Users can clone or download the repository and work locally with the SQLite database.

No Supabase project is required for the pilot.

## Local workflow

1. Clone or download the repository.
2. Install Python dependencies.
3. Run validation scripts.
4. Query the SQLite database locally.
5. Commit updated data and generated reports back to GitHub.

## Scaling path

GitHub-only mode is sufficient for the pilot and for a small legal research team.

Later migration options:

- keep GitHub as source control and archive;
- mirror structured data to Supabase/PostgreSQL;
- add a web UI;
- add vector search;
- add reviewer roles and audit trails.

## Repository as database package

The repository should contain these main directories:

```text
data/kl329/
schema/
queries/
ontology/
case_ontology/
originals/
docs/
scripts/
.github/workflows/
```

## Data validation principle

Each generated field should include or preserve a review status where possible:

- auto_detected;
- needs_review;
- human_reviewed;
- verified.

## Legal reliability principle

The SQLite database and ontology are research aids. Before use in a real legal matter, the relevant judgment and source document must be reviewed in full.
