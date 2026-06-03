# KL329 juridiskās validācijas slānis v1

Šis slānis pārbauda KL329 Full Version datu kvalitāti un atdala augstas pārliecības ierakstus no tiem, kuri vēl jāpārskata juristam.

## Kopsavilkums

- Lietu grupas kopā: **45**
- Automātiski augsti validētas: **15**
- Automātiski vidēji validētas: **18**
- Nepieciešama cilvēka pārbaude: **12**

## Biežākās pārbaudes karodziņu kategorijas

- `case_no_needs_review` — 14 lietas
- `missing_case_no` — 13 lietas
- `court_needs_review` — 12 lietas
- `missing_ecli` — 6 lietas
- `low_auto_confidence` — 5 lietas
- `missing_court_primary` — 4 lietas
- `missing_primary_disclosure_channel` — 3 lietas
- `information_type_needs_review` — 2 lietas
- `no_defence_arguments_detected` — 1 lieta
- `few_evidence_items` — 1 lieta

## Interpretācija

`validated_auto_high` nozīmē, ka pamata lauki ir aizpildīti, nav acīmredzamu metadatu kļūdu, ir pietiekams pierādījumu ierakstu skaits un automātiskā klasifikācijas pārliecība ir augsta.

`validated_auto_medium` nozīmē, ka ieraksts ir izmantojams analītikai, bet tam ir nelielas nepilnības vai ierobežota pārliecība.

`needs_human_review` nozīmē, ka pirms izmantošanas profesionālā produktā jāatver pilnais nolēmums un jāpārbauda konkrētie lauki.

## Izveidotie validācijas faili

Lokālajā validācijas pakotnē:

- `csv/case_validation_matrix.csv` — galvenā validācijas matrica pa lietām.
- `csv/field_validation_queue.csv` — lauku līmeņa pārbaudes rinda.
- `csv/manual_review_queue.csv` — tikai lietas, kurām vajag jurista pārbaudi.
- `csv/validated_auto_high.csv` — lietas ar augstu automātisko validāciju.
- `json/validation_summary.json` — mašīnlasāms kopsavilkums.
- `sqlite/lexu_kl329_pilot_validated.sqlite` — SQLite kopija ar validācijas tabulām.

## Svarīgs brīdinājums

Šī ir datu kvalitātes un juridiskās kartēšanas validācija, nevis galīga advokāta atzinuma aizstājējs. Lietās ar statusu `needs_human_review` datu izmantošana argumentācijā bez pilna nolēmuma pārbaudes nav ieteicama.
