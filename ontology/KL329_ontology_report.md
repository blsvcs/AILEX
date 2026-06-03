# KL 329. panta judikatūras ontoloģija
Versija 0.1, sagatavota no augšupielādētā nolēmumu korpusa un Senāta atziņu apkopojuma. Ontoloģijas mērķis nav tikai glabāt nolēmumus, bet ļaut juristam ātri atrast: sastāva elementu, informācijas tipu, pierādījumu, aizstāvības argumentu, tiesas reakciju un analoģiju.
## 1. Ontoloģijas kodols
KL 329 lieta tiek modelēta kā savienojums starp pieciem pamatelementiem: subjekts, neizpaužamas ziņas, izpaušanas darbība, izpaušanas brīdis/formālais sastāvs un tiešs nodoms. Katram elementam jāpiesaista pierādījumi un iespējami aizstāvības kontroles jautājumi.
### Sastāva elementi
- **Speciālais subjekts** – Valsts amatpersona, kas bijusi brīdināta par ziņu neizpaušanu vai saskaņā ar likumu ir atbildīga par ziņu glabāšanu.
- **Noziedzīgā nodarījuma priekšmets** – Neizpaužamas ziņas: informācija, kas nav attiecīgi aizsargājama kā konfidenciāla/slepena/sevišķi slepena valsts noslēpuma informācija, bet kurai normatīvajos aktos vai tiesiskā režīmā paredzēta īpaša izmantošanas kārtība vai izplatīšanas aizliegums.
- **Objektīvā puse: izpaušana** – Amata pienākumu dēļ pieejamas neizpaužamas informācijas nodošana vai izmantošana ārpus amata pienākumiem tā, ka tā nokļūst pie vēl vismaz vienas personas.
- **Formāls sastāvs** – Noziedzīgais nodarījums ir pabeigts ar izpaušanas brīdi neatkarīgi no sekām un izpaustā apjoma.
- **Subjektīvā puse: tiešs nodoms** – Persona apzinās informācijas aizsargāto raksturu un to, ka informācija tiek nodota ārpus tiesiskā pamata.

## 2. Kas ir neizpaužamas ziņas?
Neizpaužamas ziņas nav viena slēgta datu kategorija. Praktiski tās jāvērtē pēc tiesiskā režīma: vai informācijai ir normatīvi vai institucionāli noteikta izmantošanas kārtība, izplatīšanas aizliegums vai ierobežotas pieejamības statuss. Zemāk ir kontrolētais priekšmetu katalogs.
- **Nodokļu maksātāju ziņas** (`IT_TAXPAYER`): VID/NIS/EDS vai citās nodokļu sistēmās esoša informācija par nodokļu maksātājiem, iesniegumiem, atzinumiem, dokumentu projektiem. Piemēri: SKK-28/2023, SKK-8/2017, 2025 VID spriedums.
- **Kriminālprocesa ziņas** (`IT_CRIMPROC`): Ziņas par aizturēšanu, saukšanu pie kriminālatbildības, drošības līdzekli, meklēšanu vai procesuālām darbībām. Piemēri: SKK-191/2022, SKK-124/2022.
- **Sodāmības ziņas** (`IT_CONVICTIONS`): Informācija par personas sodāmību, spriedumu, sodu un sprieduma spēkā stāšanos. Piemēri: SKK-313/2022, SKK-J-221/2020.
- **Fiziskas personas dati** (`IT_PERSONAL_DATA`): Personas statuss, valstiskā piederība, deklarētā adrese, dzimšanas un mainītie personas dati, personas kodi. Piemēri: SKK-587/2022.
- **Privātā dzīve/laulība** (`IT_PRIVATE_LIFE`): Informācija par personas laulību, ģimenes vai privātās dzīves apstākļiem. Piemēri: SKK-216/2023.
- **Krimināllietas materiāli** (`IT_CASE_MATERIALS`): Fototabulas, lietas materiālu fotoattēli, izmeklēšanas materiāli un to fragmenti. Piemēri: SKK-576/2022.
- **Tiesu nolēmumi** (`IT_COURT_RULINGS`): Nepublicēti vai neanonimizēti tiesu nolēmumi, īpaši slēgtos procesos. Piemēri: SKK-720/2019.
- **Transportlīdzekļa īpašnieks** (`IT_VEHICLE_OWNER`): Ziņas par automašīnas īpašnieku, uzrādītāju tehniskajā apskatē, adresi, personas kodu. Piemēri: SKK-25/2019, SKK-289/2013, SKK-268/2013.
- **Robežkontrole/muita/izceļošana** (`IT_BORDER_CUSTOMS`): Robežsargu maiņas uzdevumi, personas pārbaude vilcienā, izsēdināšana, prāmju pasažieru saraksti. Piemēri: SKK-147/2017, SKK-270/2014, SKK-368/2019.
- **Operatīvās darbības ziņas** (`IT_OPERATIONAL`): Ziņas par iespējamiem operatīvās darbības pasākumiem vai tiesībaizsardzības iestāžu rīcībā esošām ziņām. Piemēri: SKK-[AS]/2014.
- **Kontroles/pārbaudes plāni** (`IT_CONTROL_PLAN`): Ziņas par plānotu tirdzniecības vai citas likumības kontroles laiku un vietu. Piemēri: SKK-375/2013.
- **Iepirkuma dokumenti/projekti** (`IT_PROCUREMENT`): Iepirkuma nolikuma projekti vai sagatavošanā esoša iepirkuma dokumentācija, ja tai noteikts aizsargāts režīms. Piemēri: SKK-175/2026.

## 3. Kā tās pierāda?
Pierādīšana parasti nav viens dokuments, bet ķēde: informācijas režīms + amatpersonas informētība + piekļuve/iegūšana + nodošanas kanāls + adresāts + nodoms.
- **Amata dokumenti un brīdinājumi** (`EV_DUTY_DOCS`): Amata apraksti, apliecinājumi, DVS uzdevums “iepazīties”, IS lietošanas noteikumi, iekšējie rīkojumi. Juridiskā nozīme: Pierāda subjektu, informētību un atbildību par ziņu glabāšanu.
- **Informācijas režīma dokumenti** (`EV_LEGAL_REGIME`): IAL, speciālie likumi, iestādes ierobežotas pieejamības saraksti, DVS pierādījumi par iepazīšanos. Juridiskā nozīme: Pierāda, ka konkrētajai ziņai ir neizpaužamas informācijas režīms.
- **IS auditācijas dati un piekļuves vēsture** (`EV_SYSTEM_LOGS`): Sistēmu lietotāju darbību žurnāli, pieslēgumi, “skatīts” ieraksti, saraksta/ieraksta logu analīze. Juridiskā nozīme: Pierāda piekļuvi vai palīdz izskaidrot, kāpēc piekļuve neparādās žurnālā.
- **IS funkcionalitātes demonstrācija** (`EV_SYSTEM_FUNCTION`): Sistēmas ekrānattēli, saraksta logi, speciālista liecības par to, kāda informācija redzama un kas netiek auditēts. Juridiskā nozīme: Ļoti noder, ja tieša auditācijas ieraksta nav, bet izpaustās ziņas sakrīt ar sistēmas attēlojumu.
- **Telefonsarunas** (`EV_PHONE_CALLS`): Telefonsarunu ieraksti, zvanu izdrukas, sarunu saturs, sarunu laika sakritība. Juridiskā nozīme: Bieži pierāda pieprasījumu, iegūšanu, izpaušanu un nodomu.
- **SMS/čati** (`EV_SMS_CHAT`): SMS, WhatsApp, Signal, Messenger, failu apmaiņa, ekrānattēli, čatu eksports. Juridiskā nozīme: Pierāda izpaustās informācijas tekstu vai nodošanas kanālu.
- **E-pasts** (`EV_EMAIL`): Darba vai privātā e-pasta vēstules, pielikumi, dokumentu projekti. Juridiskā nozīme: Pierāda dokumentu nodošanu un adresātu.
- **Ierīču digitālā ekspertīze** (`EV_DEVICE_FORENSICS`): MSAB XRY/Cellebrite loģiskās kopijas, telefonu apskates, ārējie diski, metadati. Juridiskā nozīme: Pierāda komunikāciju, failus, kontaktus un izmeklēšanas ķēdi.
- **Liecinieku liecības** (`EV_WITNESSES`): Adresātu, kolēģu, IT speciālistu, personāla un izmeklētāju liecības. Juridiskā nozīme: Svarīgas gan izpaušanas faktam, gan IS funkcionalitātei un informācijas režīmam.
- **Video/foto fiksācija** (`EV_VIDEO`): Videonovērošanas ieraksti, telefonu ekrāna foto, fototabulas, apskates foto. Juridiskā nozīme: Atbalsta darbību laika, vietas un fizisku priekšmetu pierādīšanu.
- **Operatīvi iegūtas ziņas** (`EV_OPERATIVE`): Operatīvā noklausīšanās, sevišķā veidā veikti ODP, tiesneša akcepts, KPL 127. panta ziņas. Juridiskā nozīme: Spēcīgs pierādījums, bet aizstāvībai jāpārbauda samērīgums un pieļaujamība.

## 4. Kādi pierādījumi tiesā parasti nostrādā?
Visstiprāk strādā kombinācijas, nevis izolēti pierādījumi. Tipiskās kombinācijas:
- **Amata dokumenti + DVS iepazīšanās + iekšējais ierobežotas pieejamības saraksts**: pierāda subjekta statusu un apzināšanos.
- **IS auditācijas dati + IT speciālista liecība + sistēmas ekrānattēli**: pierāda piekļuves iespēju un sistēmā redzamo ziņu apjomu.
- **Telefonsarunas/SMS/čati + zvanu laiki + ierīces spoguļkopija**: pierāda pieprasījumu, nodošanas kanālu un saturu.
- **E-pasts ar pielikumu + dokumenta režīms**: pierāda dokumenta nodošanu un adresātu.
- **Liecinieki + digitālā pēda**: palīdz nostiprināt izpaušanas faktu un noraidīt alternatīvas versijas.

## 5. Aizstāvības argumentu karte
- **Nav pierādīts, ka ziņas bija neizpaužamas** (`DA_NOT_PROTECTED`): Prasīt precīzu ziņu režīmu, izplatīšanas aizliegumu, izmantošanas kārtību un to attiecināmību uz konkrēto ziņu kombināciju. Statuss praksē: `mixed`.
- **Nav izpaušanas, tikai piekļuve/apskate** (`DA_NO_DISCLOSURE`): Prasīt pierādījumus, ka ziņas nonāca pie konkrēta adresāta, nevis tikai tika skatītas sistēmā. Statuss praksē: `mixed`.
- **Rīcība veikta amata pienākumu vai konkrēta darba uzdevuma ietvaros** (`DA_LAWFUL_DUTY`): Pierādīt tiesisku pamatu: administratīvā lieta, darba uzdevums, tiesisks informācijas aprites kanāls. Statuss praksē: `mixed`.
- **Informācija bija publiski pieejama vai adresātam jau zināma** (`DA_PUBLIC_INFO`): Jāpierāda precīza publiskā pieejamība izpaušanas brīdī un tas, ka amatpersona neizmantoja dienesta resursu. Statuss praksē: `usually_rejected`.
- **Adresātam pašam bija tiesības iegūt informāciju** (`DA_RECIPIENT_RIGHT`): Senāts prasa vērtēt izmantošanas kārtību, ne tikai teorētisku tiesību iegūt informāciju. Statuss praksē: `usually_rejected`.
- **Nav tieša nodoma** (`DA_NO_INTENT`): Balstīt uz neskaidriem noteikumiem, kļūdu par tiesisko pamatu, apmācības trūkumu, neskaidru uzdevumu. Statuss praksē: `mixed`.
- **Pierādījumi nepieļaujami** (`DA_EVIDENCE_INADMISSIBLE`): Uzbrukt ODP, telefonu spoguļkopiju, kratīšanas/apskates protokolu, datu ķēdes, tiesneša akcepta un samērīguma jautājumiem. Statuss praksē: `often_effective_if_specific`.
- **Nepareiza kumulatīva kvalifikācija ar KL 318** (`DA_318_COMPETITION`): Ja viena darbība kvalificēta gan pēc 318., gan 329. panta, vērtēt normu konkurenci. Statuss praksē: `effective`.
- **Apelācija nav izvērtējusi būtiskus argumentus** (`DA_UNMOTIVATED_APPEAL`): Norādīt uz KPL 564. panta prasībām par motivāciju un aizstāvības argumentu izvērtēšanu. Statuss praksē: `effective`.
- **Nav uzkūdīšanas – tikai vispārīgs jautājums/interese** (`DA_INSTIGATION_ONLY_REQUEST`): Jāanalizē, vai lūgums bija konkrēts, vai lūdzējs zināja par dienesta resursu, vai nodeva identificējošus datus. Statuss praksē: `mixed`.

### Bieži noraidītie argumenti
- Informācija ir kaut kur publiski atrodama vai adresāts to varēja iegūt pats. Senāta loģika: jāvērtē konkrētais izmantošanas režīms un tas, vai informācija nodota tiesiskā kārtībā.
- Netika izpausta pilna informācija vai nebija juridiskas terminoloģijas. Senāta loģika: formāls sastāvs un pietiek ar daļēju izpaušanu, ja burtiskais saturs satur aizsargātās ziņas.
- Tiek apstrīdēti fakti, nevis tiesību piemērošana. Kasācijā tas bieži tiek noraidīts kā mēģinājums panākt atkārtotu pierādījumu vērtēšanu.

### Argumenti, kas devuši rezultātu
- Operatīvās darbības rezultātu pieļaujamība un samērīgums, īpaši vecākajās lietās, kad KL 329 bija kriminālpārkāpums.
- Apelācijas nolēmuma nepietiekama motivācija un būtisku aizstāvības argumentu neizvērtēšana.
- Normu konkurence ar KL 318, ja viena un tā pati izpaušana aptverta plašākā dienesta ļaunprātības sastāvā ar būtisku kaitējumu.
- Pierādījumu izslēgšana, pēc kuras lietā nepaliek pietiekams pierādījumu kopums.

## 6. Iestādes un informācijas avoti
### Iestādes
- **VID / nodokļu administrācija** (`ORG_VID`): Nodokļu informācijas sistēmas, EDS, nodokļu maksātāju dati, iekšējās drošības pārbaudes.
- **Valsts policija / Iekšlietu sistēma** (`ORG_POLICE`): Personu dati, Sodu reģistrs, operatīvās darbības, kriminālprocesa ziņas.
- **Prokuratūra** (`ORG_PROSECUTION`): Kriminālprocesa ziņas, aizturēšana, augstāka prokurora funkcijas, īpaši pilnvaroti prokurori.
- **Tiesas / Tiesu administrācija** (`ORG_COURTS`): TIS, nepublicēti vai neanonimizēti tiesu nolēmumi, lietu materiāli.
- **Valsts robežsardze / muita** (`ORG_BORDER`): Robežkontroles uzdevumi, pasažieru dati, izceļošana, vilciena pārbaude.
- **CSDD / transportlīdzekļu datubāzes** (`ORG_CSDD`): Transportlīdzekļa īpašnieki, tehniskās apskates uzrādītāji.
- **Pasūtītāji iepirkumos** (`ORG_PROCUREMENT`): Iepirkuma dokumentu projekti un sagatavošanas informācija.

### Informācijas avoti
- **TIS** (`SRC_TIS`): Tiesu informācijas sistēma: tiesu nolēmumi, lietu dati, sodāmības informācija atsevišķos kontekstos.
- **Sodu reģistrs / IeM IC** (`SRC_SODU`): Ziņas par sodāmību, aizturēšanu, meklēšanu, drošības līdzekļiem.
- **PMLP Personu datu pārlūks** (`SRC_PMLP`): Iedzīvotāju reģistra/personas dati, laulības un citi privātās dzīves dati.
- **VID/NIS/EDS/Sistēma A** (`SRC_VID_IS`): Nodokļu maksātāju dati, saraksta logi, īpašumu/nodokļu informācija.
- **CSDD IS** (`SRC_CSDD`): Transportlīdzekļa un īpašnieka dati.
- **DVS/Koplietošanas krātuve** (`SRC_DVS`): Iepazīšanās ar rīkojumiem, ierobežotas pieejamības saraksti, amata dokumenti.
- **E-pasts** (`SRC_EMAIL`): Darba/privātais e-pasts, pielikumi, dokumentu projekti.
- **Telefons** (`SRC_PHONE`): Zvani, SMS, kontaktu nosaukumi un zvanu metadati.
- **WhatsApp** (`SRC_WHATSAPP`): Sarakstes, faili, ziņas un komunikācijas metadati ierīcē.
- **Signal** (`SRC_SIGNAL`): Šifrēta saziņa; saturs parasti pieejams no ierīces, nevis operatora.
- **Messenger** (`SRC_MESSENGER`): Fotogrāfiju vai dokumentu nosūtīšana.
- **Lursoft/publiskie avoti** (`SRC_LURSOFT`): Publiski vai maksas reģistri; svarīgi pārbaudīt, vai precīzā ziņu kombinācija bija publiski iegūstama.

## 7. Kompetences jautājumi produktam
- **CQ1. Vai konkrētā ziņa ir KL 329 priekšmets?** Atbildi veido IT_* kategorija + EV_LEGAL_REGIME + normatīvais/iekšējais režīms.
- **CQ2. Vai pierādīta izpaušana, nevis tikai piekļuve?** Jāmeklē EL_ACT un pierādījumi EV_PHONE_CALLS/EV_SMS_CHAT/EV_EMAIL/EV_WITNESSES/EV_SYSTEM_FUNCTION.
- **CQ3. Vai amatpersona bija brīdināta vai atbildīga par glabāšanu?** Jāmeklē EV_DUTY_DOCS, DVS iepazīšanās, amata apraksts, likuma norma.
- **CQ4. Vai publiska pieejamība var būt aizstāvība?** Parasti tikai tad, ja precīzā ziņu kombinācija bija publiski pieejama un nav izmantots dienesta resursu režīms; citādi Senāts to noraida.
- **CQ5. Vai operatīvie pierādījumi ir pieļaujami?** Jāvērtē pasākuma pamats, tiesneša akcepts, datu nodošanas ķēde, samērīgums un KL 329 klasifikācija konkrētajā laikā.
- **CQ6. Vai piemērojams KL 318, nevis KL 329?** Ja izpaušana ir daļa no dienesta ļaunprātības ar būtisku kaitējumu, jāvērtē normu konkurence.
- **CQ7. Vai lūgums iegūt informāciju ir uzkūdīšana?** Jāvērtē lūguma konkrētība, nodotie identifikācijas dati un lūdzēja izpratne par informācijas dienesta avotu.

## 8. Datu kvalitātes piezīme
Šī ir ontoloģijas sākotnējā versija. Daļa korpusa statistikas ir automātiski iegūta pēc teksta pazīmēm, tāpēc konkrētas lietas stratēģijā vienmēr jāatver attiecīgais nolēmums un jāpārbauda, vai atslēgvārds dokumentā apzīmē lietas faktu, Senāta citētu piemēru vai aizstāvības argumentu.
