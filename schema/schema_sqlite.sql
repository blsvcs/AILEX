CREATE INDEX idx_case_terms_case ON case_terms(case_id)
CREATE INDEX idx_case_terms_type ON case_terms(term_type)
CREATE INDEX idx_cases_article ON cases(article_id)
CREATE INDEX idx_channels_case ON communication_channels(case_id)
CREATE INDEX idx_chunks_doc ON text_chunks(document_id)
CREATE INDEX idx_defence_case ON defence_arguments(case_id)
CREATE INDEX idx_devices_case ON devices(case_id)
CREATE INDEX idx_documents_case ON documents(case_id)
CREATE INDEX idx_documents_ecli ON documents(ecli)
CREATE INDEX idx_evidence_case ON evidence_items(case_id)
CREATE INDEX idx_institutions_name ON institutions(name)
CREATE INDEX idx_persons_case ON persons(case_id)
CREATE TABLE analytics_counts (
    metric_group TEXT,
    metric_name TEXT,
    metric_value INTEGER,
    rank INTEGER,
    source TEXT,
    PRIMARY KEY (metric_group, metric_name)
)
CREATE TABLE case_forensic_tools (
    case_id TEXT REFERENCES cases(case_id),
    document_id TEXT REFERENCES documents(document_id),
    tool_id TEXT REFERENCES forensic_tools(tool_id),
    role TEXT,
    PRIMARY KEY (case_id, document_id, tool_id, role)
)
CREATE TABLE case_systems (
    case_id TEXT REFERENCES cases(case_id),
    document_id TEXT REFERENCES documents(document_id),
    system_id TEXT REFERENCES information_systems(system_id),
    role TEXT,
    auditability_note TEXT,
    PRIMARY KEY (case_id, document_id, system_id, role)
)
CREATE TABLE case_terms (
    case_id TEXT REFERENCES cases(case_id),
    document_id TEXT REFERENCES documents(document_id),
    term_id TEXT REFERENCES controlled_terms(term_id),
    term_type TEXT,
    relation TEXT,
    source_field TEXT,
    confidence TEXT,
    PRIMARY KEY (case_id, document_id, term_id, relation)
)
CREATE TABLE cases (
    case_id TEXT PRIMARY KEY,
    article_id TEXT REFERENCES legal_articles(article_id),
    normalized_case_key TEXT,
    case_no TEXT,
    skk_no TEXT,
    ecli TEXT,
    first_known_date TEXT,
    court_primary TEXT,
    instance_primary TEXT,
    outcome_summary TEXT,
    primary_information_type_id TEXT,
    primary_information_type TEXT,
    primary_disclosure_channel TEXT,
    confidence TEXT,
    hash_group TEXT,
    notes_for_lawyer TEXT,
    created_at TEXT NOT NULL
)
CREATE TABLE communication_channels (
    channel_id TEXT PRIMARY KEY,
    case_id TEXT REFERENCES cases(case_id),
    document_id TEXT REFERENCES documents(document_id),
    person_from_id TEXT,
    person_to_id TEXT,
    channel_type TEXT,
    content_obtained INTEGER,
    metadata_obtained INTEGER,
    used_as_evidence INTEGER,
    court_assessment TEXT,
    defence_challenge TEXT,
    result TEXT,
    notes TEXT
)
CREATE TABLE controlled_terms (
    term_id TEXT PRIMARY KEY,
    term_type TEXT,
    label TEXT,
    normalized_label TEXT,
    description TEXT,
    source_basis TEXT
)
CREATE TABLE defence_arguments (
    argument_id TEXT PRIMARY KEY,
    case_id TEXT REFERENCES cases(case_id),
    document_id TEXT REFERENCES documents(document_id),
    argument_type TEXT,
    argument_subtype TEXT,
    argument_text TEXT,
    target_element TEXT,
    court_response TEXT,
    result TEXT,
    defence_value TEXT,
    repeatability TEXT,
    notes TEXT
)
CREATE TABLE devices (
    device_id TEXT PRIMARY KEY,
    case_id TEXT REFERENCES cases(case_id),
    document_id TEXT REFERENCES documents(document_id),
    person_id TEXT,
    device_type TEXT,
    brand_model TEXT,
    identifier TEXT,
    owner_or_user TEXT,
    seized INTEGER,
    examined INTEGER,
    forensic_tool_used TEXT,
    relevant_data_found TEXT,
    notes TEXT
)
CREATE TABLE document_texts (
    document_id TEXT PRIMARY KEY REFERENCES documents(document_id),
    text TEXT
)
CREATE VIRTUAL TABLE document_texts_fts USING fts5(document_id UNINDEXED, file_name UNINDEXED, case_no UNINDEXED, text, tokenize='unicode61')
CREATE TABLE 'document_texts_fts_config'(k PRIMARY KEY, v) WITHOUT ROWID
CREATE TABLE 'document_texts_fts_content'(id INTEGER PRIMARY KEY, c0, c1, c2, c3)
CREATE TABLE 'document_texts_fts_data'(id INTEGER PRIMARY KEY, block BLOB)
CREATE TABLE 'document_texts_fts_docsize'(id INTEGER PRIMARY KEY, sz BLOB)
CREATE TABLE 'document_texts_fts_idx'(segid, term, pgno, PRIMARY KEY(segid, term)) WITHOUT ROWID
CREATE TABLE documents (
    document_id TEXT PRIMARY KEY,
    case_id TEXT REFERENCES cases(case_id),
    map_id TEXT,
    file_name TEXT,
    extension TEXT,
    source_path TEXT,
    text_path TEXT,
    file_hash TEXT,
    unique_status TEXT,
    text_chars INTEGER,
    case_no TEXT,
    skk_no TEXT,
    ecli TEXT,
    decision_date_raw TEXT,
    court TEXT,
    instance_type TEXT,
    outcome_raw TEXT,
    is_duplicate INTEGER DEFAULT 0,
    anonymization_status TEXT DEFAULT 'anonymized',
    source_type TEXT DEFAULT 'uploaded_corpus'
)
CREATE TABLE evidence_items (
    evidence_id TEXT PRIMARY KEY,
    case_id TEXT REFERENCES cases(case_id),
    document_id TEXT REFERENCES documents(document_id),
    evidence_type TEXT,
    evidence_subtype TEXT,
    source TEXT,
    obtained_by TEXT,
    legal_basis TEXT,
    supports_element TEXT,
    accepted_by_court TEXT,
    challenged TEXT,
    challenge_type TEXT,
    challenge_result TEXT,
    strength_score REAL,
    notes TEXT
)
CREATE TABLE forensic_tools (
    tool_id TEXT PRIMARY KEY,
    name TEXT UNIQUE,
    tool_type TEXT,
    typical_output TEXT,
    notes TEXT
)
CREATE TABLE information_systems (
    system_id TEXT PRIMARY KEY,
    name TEXT UNIQUE,
    owner_institution_id TEXT,
    system_type TEXT,
    data_types TEXT,
    access_mode TEXT,
    auditability TEXT,
    is_public INTEGER,
    is_internal INTEGER,
    legal_regime TEXT,
    notes TEXT
)
CREATE TABLE institution_case_roles (
    case_id TEXT REFERENCES cases(case_id),
    document_id TEXT REFERENCES documents(document_id),
    institution_id TEXT REFERENCES institutions(institution_id),
    role TEXT,
    source_field TEXT,
    PRIMARY KEY (case_id, document_id, institution_id, role)
)
CREATE TABLE institutions (
    institution_id TEXT PRIMARY KEY,
    name TEXT UNIQUE,
    normalized_name TEXT,
    institution_type TEXT,
    sector TEXT,
    notes TEXT
)
CREATE TABLE legal_articles (
    article_id TEXT PRIMARY KEY,
    code TEXT NOT NULL,
    article_number TEXT NOT NULL,
    title TEXT,
    description TEXT,
    status TEXT DEFAULT 'active',
    pilot_module INTEGER DEFAULT 0
)
CREATE TABLE legal_findings (
    finding_id TEXT PRIMARY KEY,
    document_id TEXT REFERENCES documents(document_id),
    case_id TEXT REFERENCES cases(case_id),
    finding_type TEXT,
    legal_issue TEXT,
    finding_text TEXT,
    supports_prosecution INTEGER,
    supports_defence INTEGER,
    importance_score REAL,
    source_snippet TEXT
)
CREATE TABLE official_positions (
    position_id TEXT PRIMARY KEY,
    normalized_title TEXT,
    raw_title TEXT,
    institution_type TEXT,
    access_level TEXT,
    typical_systems TEXT,
    risk_profile TEXT
)
CREATE TABLE ontology_edges (
    edge_id TEXT PRIMARY KEY,
    source_node_id TEXT,
    relation TEXT,
    target_node_id TEXT,
    explanation TEXT,
    strength TEXT,
    source_basis TEXT
)
CREATE TABLE ontology_nodes (
    node_id TEXT PRIMARY KEY,
    node_type TEXT,
    label TEXT,
    definition TEXT,
    source_basis TEXT,
    lawyer_use TEXT,
    examples TEXT,
    status TEXT
)
CREATE TABLE persons (
    person_id TEXT PRIMARY KEY,
    case_id TEXT REFERENCES cases(case_id),
    document_id TEXT REFERENCES documents(document_id),
    anonymized_label TEXT,
    procedural_role TEXT,
    institution_role TEXT,
    official_status TEXT,
    position_title_raw TEXT,
    position_id TEXT,
    institution_id TEXT,
    is_state_official INTEGER,
    was_warned_about_confidentiality INTEGER,
    responsible_for_information_storage INTEGER,
    relationship_to_recipient TEXT,
    relationship_to_instigator TEXT,
    extraction_confidence TEXT DEFAULT 'auto',
    notes TEXT
)
CREATE TABLE schema_versions (
    version_id TEXT PRIMARY KEY,
    project TEXT NOT NULL,
    created_at TEXT NOT NULL,
    notes TEXT
)
CREATE TABLE supplementary_materials (
    material_id TEXT PRIMARY KEY,
    linked_case_id TEXT,
    linked_article_id TEXT,
    material_type TEXT,
    title TEXT,
    source TEXT,
    date_raw TEXT,
    storage_path TEXT,
    relevance TEXT,
    notes TEXT
)
CREATE TABLE text_chunks (
    chunk_id TEXT PRIMARY KEY,
    document_id TEXT REFERENCES documents(document_id),
    case_id TEXT REFERENCES cases(case_id),
    chunk_index INTEGER,
    section_type TEXT,
    chunk_text TEXT,
    char_start INTEGER,
    char_end INTEGER,
    tags TEXT
)
CREATE VIRTUAL TABLE text_chunks_fts USING fts5(chunk_id UNINDEXED, document_id UNINDEXED, case_id UNINDEXED, section_type UNINDEXED, chunk_text, tokenize='unicode61')
CREATE TABLE 'text_chunks_fts_config'(k PRIMARY KEY, v) WITHOUT ROWID
CREATE TABLE 'text_chunks_fts_content'(id INTEGER PRIMARY KEY, c0, c1, c2, c3, c4)
CREATE TABLE 'text_chunks_fts_data'(id INTEGER PRIMARY KEY, block BLOB)
CREATE TABLE 'text_chunks_fts_docsize'(id INTEGER PRIMARY KEY, sz BLOB)
CREATE TABLE 'text_chunks_fts_idx'(segid, term, pgno, PRIMARY KEY(segid, term)) WITHOUT ROWID
CREATE VIEW v_case_overview AS
SELECT c.case_id, c.case_no, c.skk_no, c.ecli, c.first_known_date, c.court_primary, c.instance_primary,
       c.primary_information_type, c.primary_disclosure_channel, c.outcome_summary, c.confidence,
       COUNT(DISTINCT d.document_id) AS document_count
FROM cases c LEFT JOIN documents d ON d.case_id = c.case_id
GROUP BY c.case_id
CREATE VIEW v_defence_argument_results AS
SELECT argument_type, result, COUNT(DISTINCT case_id) AS case_count, COUNT(*) AS mentions
FROM defence_arguments GROUP BY argument_type, result ORDER BY case_count DESC, mentions DESC
CREATE VIEW v_top_evidence AS
SELECT evidence_type, COUNT(DISTINCT case_id) AS case_count, COUNT(*) AS mentions
FROM evidence_items GROUP BY evidence_type ORDER BY case_count DESC, mentions DESC
CREATE VIEW v_top_information_sources AS
SELECT ct.label AS source, COUNT(DISTINCT ctmap.case_id) AS case_count, COUNT(*) AS mentions
FROM case_terms ctmap JOIN controlled_terms ct ON ct.term_id = ctmap.term_id
WHERE ct.term_type='information_source'
GROUP BY ct.term_id ORDER BY case_count DESC, mentions DESC
CREATE VIEW v_top_institutions AS
SELECT i.name, COUNT(DISTINCT icr.case_id) AS case_count, COUNT(*) AS mentions
FROM institution_case_roles icr JOIN institutions i ON i.institution_id = icr.institution_id
GROUP BY i.institution_id ORDER BY case_count DESC, mentions DESC