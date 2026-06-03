# AILEX project plan

## Direction

AILEX is designed as a scalable legal knowledge platform. KL 329 is the pilot module, but the schema is intentionally multi-article and can later support other Criminal Law articles and other practice areas.

## Pilot scope: KL 329

The KL 329 pilot structures:

- cases and decisions;
- court and procedural metadata;
- institutions and roles;
- officials and procedural participants;
- information systems and data sources;
- devices and forensic tools;
- communication channels;
- evidence items;
- defence arguments;
- ontology nodes and relations;
- full-text chunks for search.

## Cloud direction

Recommended deployment target:

- Supabase/PostgreSQL for structured data;
- object storage for original documents;
- full-text search first;
- vector search later;
- human validation workflow for professional reliability.

## Validation statuses

Fields should support review states:

- auto_detected;
- needs_review;
- human_reviewed;
- verified.

## Next modules

Candidate future modules:

- KL 318;
- KL 327;
- KL 320;
- KL 323;
- KL 94;
- procedural/evidence admissibility practice.
