# AILEX KL329 Similar Case Engine — P4

P4 ievieš faktu balstītu līdzīgo lietu meklēšanas modeli KL329 Gold Cases korpusam.

## Rezultāts

- Izveidoti **15 Gold Case profili**.
- Izveidoti indeksi pēc iestādēm, sistēmām, informācijas tipiem, kanāliem, pierādījumiem un atziņām.
- Izveidoti **5 testa scenāriji**.
- Izveidota `similarity_rules.yaml` svaru metodika.
- Izveidoti CSV, JSON un SQLite dati.
- SQLite pārbaude: `integrity_check = ok`.

## Svara modelis

| Elements | Svars |
|---|---:|
| Iestāde | 20 |
| Sistēma | 20 |
| Informācijas tips | 25 |
| Izpaušanas kanāls | 15 |
| Pierādījumi | 10 |
| Atziņas | 10 |

## Testa scenāriji

1. VID + EDS + WhatsApp + nodokļu dati
2. TIS + neanonimizēts nolēmums + e-pasts
3. Sodu reģistrs + SMS + sodāmība
4. Signal + iepirkuma projekts
5. Kriminālprocesa materiāli + WhatsApp/Signal

## Piemērs

Lietotājs ievada:

`VID + EDS + WhatsApp + nodokļu dati`

AILEX atgriež:

- līdzīgākās Gold Cases;
- atbilstošās Gold Findings;
- tipiskos pierādījumus;
- iespējamos aizstāvības argumentus;
- riska virzienus.

## Statuss

Šī ir P4 pirmā strukturētā versija. Līdzības svari vēl jākalibrē ar jurista validāciju un reāliem lietotāju scenārijiem.

## Nākamais solis

P5 — AI Copilot, kas izmantos P1 Gold Cases, P2 Gold Findings, P3 Questions/Rules un P4 Similar Case Engine vienotā jurista darba režīmā.
