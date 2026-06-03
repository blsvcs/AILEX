# AILEX KL329 Questions + AI Rules — P3

P3 pārvērš Gold Findings bibliotēku praktiski izmantojamās atbildēs un AI noteikumos.

## Rezultāts

- Izveidoti **15 praktiskie jautājumi**.
- Izveidoti **20 AI noteikumi**.
- Katra atbilde sasaistīta ar Gold Findings un Gold Cases.
- Izveidoti Markdown, CSV, JSON un SQLite dati.
- SQLite pārbaude: `integrity_check = ok`.

## Praktisko jautājumu saraksts

| ID | Jautājums | Findings | Rules |
|---|---|---|---|
| Q001 | Vai lietvedības kārtība ir neizpaužama informācija? | FIND001, FIND005, FIND008 | RULE001, RULE005 |
| Q002 | Vai tiesas nolēmuma rezolutīvā daļa ir ierobežotas pieejamības informācija? | FIND009, FIND001, FIND006 | RULE006, RULE009 |
| Q003 | Vai WhatsApp sarakste var būt pietiekams pierādījums? | FIND014, FIND004 | RULE014, RULE004 |
| Q004 | Vai Signal sarakste var būt pietiekams pierādījums? | FIND015, FIND004 | RULE015, RULE004 |
| Q005 | Vai KL329 lietā nepieciešams pierādīt kaitējumu? | FIND003 | RULE003 |
| Q006 | Vai publiski pieejama informācija izslēdz KL329? | FIND006, FIND001 | RULE006 |
| Q007 | Kā pierāda izpaušanu? | FIND004, FIND013, FIND016, FIND017 | RULE004, RULE013 |
| Q008 | Kā pierāda neizpaužamo ziņu statusu? | FIND005, FIND001, FIND008 | RULE005, RULE001 |
| Q009 | Kā izmeklētāji pārbauda WhatsApp? | FIND014, FIND004 | RULE014 |
| Q010 | Kā izmeklētāji pārbauda Signal? | FIND015 | RULE015 |
| Q011 | Vai tikai informācijas apskate sistēmā ir KL329? | FIND002, FIND004, FIND013 | RULE002, RULE013 |
| Q012 | Vai e-pasts ar dokumentu ir izpaušana? | FIND017, FIND020 | RULE017, RULE020 |
| Q013 | Vai informācijas nodošana amata pienākumu ietvaros izslēdz KL329? | FIND020, FIND011, FIND017 | RULE020 |
| Q014 | Vai KL329 var konkurēt ar KL318? | FIND019 | RULE019 |
| Q015 | Kas jāpārbauda advokātam pirmajās 24 stundās KL329 lietā? | FIND001, FIND002, FIND004, FIND005, FIND007, FIND013 | RULE001, RULE002, RULE004, RULE005, RULE007 |

## AI Rules Engine

P3 noteikumu slānis ļauj AILEX atbildēt uz jautājumiem ne tikai ar dokumentu sarakstu, bet ar strukturētu juridisku secinājumu.

Piemēri:

- RULE003: kaitējuma neesība pati par sevi neizslēdz KL329.
- RULE006: publiska līdzīgas informācijas pieejamība pati par sevi neattaisno dienesta sistēmas datu izpaušanu.
- RULE013: auditācijas dati pierāda piekļuvi, bet ne vienmēr izpaušanu.
- RULE020: tiesiska nodošana amata vai procesa pienākuma ietvaros var izslēgt KL329 risku.

## Nākamais solis

P4 — līdzīgo lietu meklētājs, kur lietotājs var ievadīt faktu kombināciju, piemēram:

`VID + EDS + WhatsApp + privātpersona`

un AILEX atrod līdzīgākās Gold Cases, atziņas, pierādījumus un aizstāvības argumentus.
