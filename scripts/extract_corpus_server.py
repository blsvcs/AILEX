#!/usr/bin/env python3
"""
AILEX KL329 server-side corpus extractor.

Expected input:
  data/incoming/Anonimizets_nolemumi_030626.zip

Outputs:
  output/corpus_text/
  output/corpus_tables/
  output/corpus.sqlite
  output/corpus_summary.json
"""

from __future__ import annotations

import csv
import json
import re
import sqlite3
import sys
import zipfile
from pathlib import Path


def norm_ws(text: str) -> str:
    return re.sub(r"\s+", " ", text or "").strip()


def extract_pdf(path: Path) -> str:
    try:
        from pypdf import PdfReader
        reader = PdfReader(str(path))
        parts = []
        for page in reader.pages:
            try:
                parts.append(page.extract_text() or "")
            except Exception:
                parts.append("")
        return norm_ws("\n".join(parts))
    except Exception as exc:
        return f"[TEXT_EXTRACTION_FAILED: {type(exc).__name__}: {exc}]"


def extract_docx(path: Path) -> str:
    try:
        import docx
        doc = docx.Document(str(path))
        return norm_ws("\n".join(p.text for p in doc.paragraphs))
    except Exception as exc:
        return f"[TEXT_EXTRACTION_FAILED: {type(exc).__name__}: {exc}]"


def detect_case_ref(text: str, filename: str) -> str:
    source = filename + " " + text[:2000]
    patterns = [
        r"SKK[-–]?[A-Z]?\s*[-–]?\s*\d+[/\-–]\d{2,4}",
        r"SKK[-–]\d+[-–]\d{2,4}",
        r"\d{10,}",
    ]
    for pat in patterns:
        m = re.search(pat, source, re.I)
        if m:
            return m.group(0).replace(" ", "")
    return ""


def detect_year(text: str, filename: str) -> str:
    m = re.search(r"(20\d{2}|19\d{2})", filename + " " + text[:1000])
    return m.group(1) if m else ""


PATTERNS = {
    "institutions": {
        "VID": r"\bVID\b|Valsts ieņēmumu dienest",
        "Valsts policija": r"Valsts policij|policij",
        "Prokuratūra": r"prokuratūr|prokuror",
        "Tiesa/Tiesu administrācija": r"Tiesu administrāc|TIS|tiesa",
        "KNAB": r"\bKNAB\b|Korupcijas novēršanas",
        "PMLP": r"\bPMLP\b|Pilsonības un migrācijas",
        "CSDD": r"\bCSDD\b",
        "Valsts robežsardze": r"robežsardz|muita",
    },
    "systems": {
        "EDS": r"\bEDS\b|Elektroniskās deklarēšanas",
        "VID NIS": r"\bNIS\b|VID.*sistēm",
        "TIS": r"\bTIS\b|Tiesu informācijas sistēm",
        "Sodu reģistrs": r"Sodu reģistr|sodām",
        "PMLP": r"\bPMLP\b|Iedzīvotāju reģistr",
        "CSDD": r"\bCSDD\b",
        "DVS": r"\bDVS\b|dokumentu vadības",
    },
    "channels": {
        "WhatsApp": r"WhatsApp",
        "Signal": r"Signal",
        "SMS": r"\bSMS\b|īsziņ|isziņ",
        "E-pasts": r"e-?past|email",
        "Telefonsaruna": r"telefonsarun|zvan|telefona",
        "Mutiski": r"mutisk",
        "Ekrāna parādīšana": r"ekrān",
    },
    "information_types": {
        "Sodāmības dati": r"sodām|Sodu reģistr",
        "Nodokļu dati": r"nodokļ|deklarāc|VID|EDS",
        "TIS / tiesu dati": r"TIS|tiesas nolēm|neanonimiz",
        "Kriminālprocesa materiāli": r"kriminālproces|kriminālliet|fototabul",
        "Iepirkuma dokumenti": r"iepirkum|nolikum",
        "Personas dati": r"personas dat|dzīvesviet|deklarēt",
        "Robežkontroles/muitas dati": r"robež|muit|izceļo",
    },
    "evidence": {
        "Auditācijas dati": r"auditāc|auditācijas|žurnāl|log",
        "Liecinieku liecības": r"lieciniek|liecīb",
        "Telefonsarunas": r"telefonsarun|sarunu ierakst|noklaus",
        "SMS/čati": r"SMS|īsziņ|WhatsApp|Signal|sarakst",
        "E-pasts": r"e-?past|email",
        "Amata dokumenti/brīdinājumi": r"amata aprakst|brīdināj|neizpaušan|parakst",
        "Ierīču apskate/forensika": r"apskat|kratīšan|telefon|dator|XRY|Cellebrite|forensik",
    },
    "defence_arguments": {
        "Informācija publiski pieejama": r"publisk|pieejam",
        "Nav kaitējuma": r"kaitēj",
        "Nav izpaušanas": r"nav.*izpaud|neizpaud",
        "Nav nodoma": r"nodom|neapzināj",
        "Amata pienākumu ietvaros": r"amata pienākum|darba pienākum|tiesisk",
        "Pierādījumu nepietiekamība": r"nepietiekam|nav pierād",
    },
}


def find_matches(text: str, category: str) -> list[str]:
    out: list[str] = []
    for label, pat in PATTERNS[category].items():
        if re.search(pat, text, re.I):
            out.append(label)
    return out


def write_csv(path: Path, rows: list[dict]) -> None:
    if not rows:
        path.write_text("", encoding="utf-8")
        return
    with path.open("w", encoding="utf-8", newline="") as fp:
        fieldnames = list(rows[0].keys())
        writer = csv.DictWriter(fp, fieldnames=fieldnames)
        writer.writeheader()
        for row in rows:
            cleaned = {k: ";".join(v) if isinstance(v, list) else v for k, v in row.items()}
            writer.writerow(cleaned)


def main() -> int:
    input_zip = Path(sys.argv[1]) if len(sys.argv) > 1 else Path("data/incoming/Anonimizets_nolemumi_030626.zip")
    out_dir = Path(sys.argv[2]) if len(sys.argv) > 2 else Path("output")
    extract_dir = out_dir / "originals"
    text_dir = out_dir / "corpus_text"
    tables_dir = out_dir / "corpus_tables"
    text_dir.mkdir(parents=True, exist_ok=True)
    tables_dir.mkdir(parents=True, exist_ok=True)
    extract_dir.mkdir(parents=True, exist_ok=True)

    if not input_zip.exists():
        print(f"Missing input ZIP: {input_zip}")
        return 2

    with zipfile.ZipFile(input_zip, "r") as zf:
        zf.extractall(extract_dir)

    files = [p for p in extract_dir.rglob("*") if p.is_file()]
    documents = []
    case_records = []

    for idx, path in enumerate(files, start=1):
        ext = path.suffix.lower()
        text = ""
        if ext == ".pdf":
            text = extract_pdf(path)
        elif ext == ".docx":
            text = extract_docx(path)
        elif ext == ".txt":
            text = path.read_text(encoding="utf-8", errors="ignore")
        elif ext == ".doc":
            text = "[DOC_BINARY_TEXT_EXTRACTION_NOT_SUPPORTED_IN_THIS_WORKFLOW]"
        else:
            text = "[UNSUPPORTED_EXTENSION]"

        doc_id = f"DOC{idx:03d}"
        text_path = text_dir / f"{doc_id}.txt"
        text_path.write_text(text, encoding="utf-8")

        doc = {
            "doc_id": doc_id,
            "filename": path.name,
            "relative_path": str(path.relative_to(extract_dir)),
            "extension": ext,
            "size_bytes": path.stat().st_size,
            "case_ref": detect_case_ref(text, path.name),
            "year": detect_year(text, path.name),
            "is_senate_candidate": bool(re.search(r"SKK|Senat", path.name, re.I)),
            "text_chars": len(text),
            "text_file": str(text_path.relative_to(out_dir)),
        }
        documents.append(doc)

        case_records.append({
            **doc,
            "institutions": find_matches(text, "institutions"),
            "systems": find_matches(text, "systems"),
            "channels": find_matches(text, "channels"),
            "information_types": find_matches(text, "information_types"),
            "evidence": find_matches(text, "evidence"),
            "defence_arguments": find_matches(text, "defence_arguments"),
            "snippet": text[:800],
        })

    write_csv(tables_dir / "documents.csv", documents)
    write_csv(tables_dir / "case_records.csv", case_records)
    (tables_dir / "documents.json").write_text(json.dumps(documents, ensure_ascii=False, indent=2), encoding="utf-8")
    (tables_dir / "case_records.json").write_text(json.dumps(case_records, ensure_ascii=False, indent=2), encoding="utf-8")

    db_path = out_dir / "corpus.sqlite"
    conn = sqlite3.connect(db_path)
    cur = conn.cursor()
    cur.execute("""CREATE TABLE IF NOT EXISTS case_records (
        doc_id TEXT PRIMARY KEY, filename TEXT, relative_path TEXT, extension TEXT, size_bytes INTEGER,
        case_ref TEXT, year TEXT, is_senate_candidate INTEGER, text_chars INTEGER, text_file TEXT,
        institutions TEXT, systems TEXT, channels TEXT, information_types TEXT, evidence TEXT, defence_arguments TEXT, snippet TEXT
    )""")
    cur.execute("DELETE FROM case_records")
    for r in case_records:
        cur.execute("INSERT INTO case_records VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)", (
            r["doc_id"], r["filename"], r["relative_path"], r["extension"], r["size_bytes"], r["case_ref"], r["year"],
            int(r["is_senate_candidate"]), r["text_chars"], r["text_file"], ";".join(r["institutions"]), ";".join(r["systems"]),
            ";".join(r["channels"]), ";".join(r["information_types"]), ";".join(r["evidence"]), ";".join(r["defence_arguments"]), r["snippet"]
        ))
    conn.commit()
    integrity = cur.execute("PRAGMA integrity_check").fetchone()[0]
    conn.close()

    summary = {
        "documents_total": len(documents),
        "senate_candidates": sum(1 for d in documents if d["is_senate_candidate"]),
        "text_chars_total": sum(d["text_chars"] for d in documents),
        "sqlite_integrity_check": integrity,
    }
    (out_dir / "corpus_summary.json").write_text(json.dumps(summary, ensure_ascii=False, indent=2), encoding="utf-8")
    print(json.dumps(summary, ensure_ascii=False, indent=2))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
