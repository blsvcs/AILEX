-- Lexu / KL329 pilot database schema for Supabase/PostgreSQL
-- This is cloud-oriented DDL. For production, add Row Level Security policies, storage buckets, and pgvector embeddings.

CREATE EXTENSION IF NOT EXISTS pgcrypto;
CREATE EXTENSION IF NOT EXISTS vector;

CREATE TABLE legal_articles (
  article_id text PRIMARY KEY,
  code text NOT NULL,
  article_number text NOT NULL,
  title text,
  description text,
  status text DEFAULT 'active',
  pilot_module boolean DEFAULT false,
  created_at timestamptz DEFAULT now()
);

CREATE TABLE cases (
  case_id text PRIMARY KEY,
  article_id text REFERENCES legal_articles(article_id),
  normalized_case_key text,
  case_no text,
  skk_no text,
  ecli text,
  first_known_date text,
  court_primary text,
  instance_primary text,
  outcome_summary text,
  primary_information_type_id text,
  primary_information_type text,
  primary_disclosure_channel text,
  confidence text,
  hash_group text,
  notes_for_lawyer text,
  created_at timestamptz DEFAULT now()
);

CREATE TABLE documents (
  document_id text PRIMARY KEY,
  case_id text REFERENCES cases(case_id),
  file_name text,
  extension text,
  storage_path text,
  text_path text,
  file_hash text,
  unique_status text,
  text_chars integer,
  ecli text,
  decision_date_raw text,
  court text,
  instance_type text,
  outcome_raw text,
  is_duplicate boolean DEFAULT false,
  anonymization_status text DEFAULT 'anonymized',
  source_type text DEFAULT 'uploaded_corpus',
  created_at timestamptz DEFAULT now()
);

CREATE TABLE controlled_terms (
  term_id text PRIMARY KEY,
  term_type text NOT NULL,
  label text NOT NULL,
  normalized_label text,
  description text,
  source_basis text,
  UNIQUE(term_type, label)
);

CREATE TABLE case_terms (
  case_id text REFERENCES cases(case_id),
  document_id text REFERENCES documents(document_id),
  term_id text REFERENCES controlled_terms(term_id),
  term_type text,
  relation text,
  source_field text,
  confidence text,
  PRIMARY KEY(case_id, document_id, term_id, relation)
);

CREATE TABLE persons (
  person_id text PRIMARY KEY,
  case_id text REFERENCES cases(case_id),
  document_id text REFERENCES documents(document_id),
  anonymized_label text,
  procedural_role text,
  institution_role text,
  official_status text,
  position_title_raw text,
  position_id text,
  institution_id text,
  is_state_official boolean,
  was_warned_about_confidentiality boolean,
  responsible_for_information_storage boolean,
  relationship_to_recipient text,
  relationship_to_instigator text,
  extraction_confidence text DEFAULT 'auto',
  notes text
);

CREATE TABLE official_positions (
  position_id text PRIMARY KEY,
  normalized_title text,
  raw_title text,
  institution_type text,
  access_level text,
  typical_systems text,
  risk_profile text
);

CREATE TABLE institutions (
  institution_id text PRIMARY KEY,
  name text UNIQUE,
  normalized_name text,
  institution_type text,
  sector text,
  notes text
);

CREATE TABLE institution_case_roles (
  case_id text REFERENCES cases(case_id),
  document_id text REFERENCES documents(document_id),
  institution_id text REFERENCES institutions(institution_id),
  role text,
  source_field text,
  PRIMARY KEY(case_id, document_id, institution_id, role)
);

CREATE TABLE information_systems (
  system_id text PRIMARY KEY,
  name text UNIQUE,
  owner_institution_id text REFERENCES institutions(institution_id),
  system_type text,
  data_types text,
  access_mode text,
  auditability text,
  is_public boolean,
  is_internal boolean,
  legal_regime text,
  notes text
);

CREATE TABLE devices (
  device_id text PRIMARY KEY,
  case_id text REFERENCES cases(case_id),
  document_id text REFERENCES documents(document_id),
  person_id text REFERENCES persons(person_id),
  device_type text,
  brand_model text,
  identifier text,
  owner_or_user text,
  seized boolean,
  examined boolean,
  forensic_tool_used text,
  relevant_data_found text,
  notes text
);

CREATE TABLE forensic_tools (
  tool_id text PRIMARY KEY,
  name text UNIQUE,
  tool_type text,
  typical_output text,
  notes text
);

CREATE TABLE communication_channels (
  channel_id text PRIMARY KEY,
  case_id text REFERENCES cases(case_id),
  document_id text REFERENCES documents(document_id),
  person_from_id text REFERENCES persons(person_id),
  person_to_id text REFERENCES persons(person_id),
  channel_type text,
  content_obtained boolean,
  metadata_obtained boolean,
  used_as_evidence boolean,
  court_assessment text,
  defence_challenge text,
  result text,
  notes text
);

CREATE TABLE evidence_items (
  evidence_id text PRIMARY KEY,
  case_id text REFERENCES cases(case_id),
  document_id text REFERENCES documents(document_id),
  evidence_type text,
  evidence_subtype text,
  source text,
  obtained_by text,
  legal_basis text,
  supports_element text,
  accepted_by_court text,
  challenged text,
  challenge_type text,
  challenge_result text,
  strength_score numeric,
  notes text
);

CREATE TABLE defence_arguments (
  argument_id text PRIMARY KEY,
  case_id text REFERENCES cases(case_id),
  document_id text REFERENCES documents(document_id),
  argument_type text,
  argument_subtype text,
  argument_text text,
  target_element text,
  court_response text,
  result text,
  defence_value text,
  repeatability text,
  notes text
);

CREATE TABLE ontology_nodes (
  node_id text PRIMARY KEY,
  node_type text,
  label text,
  definition text,
  source_basis text,
  lawyer_use text,
  examples text,
  status text
);

CREATE TABLE ontology_edges (
  edge_id text PRIMARY KEY,
  source_node_id text,
  relation text,
  target_node_id text,
  explanation text,
  strength text,
  source_basis text
);

CREATE TABLE legal_findings (
  finding_id text PRIMARY KEY,
  document_id text REFERENCES documents(document_id),
  case_id text REFERENCES cases(case_id),
  finding_type text,
  legal_issue text,
  finding_text text,
  supports_prosecution boolean,
  supports_defence boolean,
  importance_score numeric,
  source_snippet text
);

CREATE TABLE text_chunks (
  chunk_id text PRIMARY KEY,
  document_id text REFERENCES documents(document_id),
  case_id text REFERENCES cases(case_id),
  chunk_index integer,
  section_type text,
  chunk_text text,
  char_start integer,
  char_end integer,
  tags text,
  embedding vector(1536)
);

CREATE INDEX idx_text_chunks_fts ON text_chunks USING gin (to_tsvector('simple', chunk_text));
CREATE INDEX idx_cases_article ON cases(article_id);
CREATE INDEX idx_documents_case ON documents(case_id);
CREATE INDEX idx_case_terms_type ON case_terms(term_type);
