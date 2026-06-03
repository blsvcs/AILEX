-- Piemēra vaicājumi Lexu/KL329 datubāzei

-- 1. Lietas pārskats
SELECT * FROM v_case_overview LIMIT 20;

-- 2. Iestāžu tops
SELECT * FROM v_top_institutions LIMIT 20;

-- 3. Pierādījumu tops
SELECT * FROM v_top_evidence LIMIT 20;

-- 4. Aizstāvības argumenti, kas identificēti kā noraidīti vai sekmīgi
SELECT argument_type, result, COUNT(*) AS mentions
FROM defence_arguments
GROUP BY argument_type, result
ORDER BY mentions DESC;

-- 5. Pilnteksta meklēšana dokumentos: WhatsApp
SELECT file_name, case_no, snippet(document_texts_fts, 3, '[', ']', '...', 12) AS snippet
FROM document_texts_fts
WHERE document_texts_fts MATCH 'WhatsApp'
LIMIT 20;

-- 6. Pilnteksta meklēšana fragmentos: auditācijas dati
SELECT document_id, section_type, snippet(text_chunks_fts, 4, '[', ']', '...', 15) AS snippet
FROM text_chunks_fts
WHERE text_chunks_fts MATCH 'auditācijas'
LIMIT 20;

-- 7. Lietas, kur ir VID + telefonsaruna + publiskuma arguments
SELECT DISTINCT c.case_id, c.case_no, c.ecli, c.primary_information_type, c.primary_disclosure_channel
FROM cases c
JOIN case_terms ti ON ti.case_id=c.case_id
JOIN controlled_terms i ON i.term_id=ti.term_id AND i.term_type='institution'
JOIN case_terms td ON td.case_id=c.case_id
JOIN controlled_terms d ON d.term_id=td.term_id AND d.term_type='defence_argument'
WHERE i.label LIKE '%VID%'
  AND c.primary_disclosure_channel LIKE '%Telefon%'
  AND d.label LIKE '%publiska%';
