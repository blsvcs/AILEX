# AILEX KL329 AI Copilot — P5

P5 apvieno P1 Gold Cases, P2 Gold Findings, P3 Questions/Rules un P4 Similar Case Engine vienotā jurista darba režīmā.

## Rezultāts

- Izveidoti Copilot prompti.
- Izveidots faktu izvilkšanas modelis.
- Izveidots KL329 riska dzinējs.
- Izveidots rekomendāciju dzinējs.
- Izveidoti Copilot aktivizācijas noteikumi.
- Izveidoti juridiskā atzinuma, aizstāvības stratēģijas un apsūdzības perspektīvas izvades šabloni.
- Izveidoti 3 testa scenāriji.
- SQLite konfigurācijas pārbaude: `integrity_check = ok`.

## Repo pakotnes struktūra

```text
copilot/
├── prompts/
│   ├── system_prompt.md
│   ├── kl329_prompt.md
│   ├── defence_prompt.md
│   └── prosecution_view_prompt.md
├── analyzers/
│   ├── fact_extractor.yaml
│   ├── risk_engine.yaml
│   └── recommendation_engine.yaml
├── rules/
│   ├── copilot_rules.json
│   └── copilot_rules.csv
├── schemas/
│   ├── case_input_schema.json
│   └── copilot_output_schema.json
├── outputs/
│   ├── legal_opinion.md
│   ├── defence_strategy.md
│   └── prosecution_view.md
└── tests/
    ├── copilot_test_scenarios.json
    └── TESTS.md
```

## Copilot darba plūsma

1. Lietotājs ievada faktus vai augšupielādē materiālus.
2. Fact Extractor identificē iestādes, sistēmas, kanālus, informācijas tipus un pierādījumus.
3. Risk Engine pārbauda KL329 sastāva elementus.
4. P4 Similar Case Engine atrod līdzīgākās Gold Cases.
5. Recommendation Engine piesaista Gold Findings un AI Rules.
6. Copilot sagatavo juridisko analīzi, aizstāvības virzienus un nākamos soļus.

## Testa scenāriji

1. VID darbinieks nosūtīja paziņam informāciju no EDS WhatsApp.
2. Tiesas darbinieks nosūtīja neanonimizētu nolēmumu pa e-pastu personai ārpus procesa.
3. Policijas amatpersona SMS nosūtīja ziņas par personas sodāmību.

## Statuss

P5 ir pirmā funkcionālā Copilot arhitektūras pakotne. Tā vēl nav pilna web aplikācija, bet tā jau definē, kā AILEX jādomā un jāatbild KL329 lietās.

## Nākamais solis

Savienot P5 ar UX prototipu: izveidot vienu klikšķināmu darba plūsmu, kur lietotājs ievada faktus un redz Copilot ģenerētu juridisko analīzi.
