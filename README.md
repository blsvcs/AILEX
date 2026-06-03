# AILEX

AILEX is a scalable legal analytics project. The first pilot module is KL 329: neizpauzamu zinu izpausana.

## Upload contents

- `data/kl329/` - SQLite database, summaries, index files and generated packages.
- `schema/` - SQLite and Supabase/PostgreSQL schema, data dictionary.
- `queries/` - example SQL queries.
- `ontology/` - KL329 ontology nodes, edges and JSON.
- `case_ontology/` - case-to-ontology mappings and lawyer playbook.
- `originals/` - source uploaded documents and ZIP archive.
- `docs/` - analysis notes.

## Suggested cloud path

Use Supabase/PostgreSQL as the primary cloud database, keep original documents in object storage, and import structured files from this bundle.
