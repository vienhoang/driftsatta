# Säker Nätverksarkitektur — Gruppuppgift

## Scenario

Ett utvecklingsteam har byggt ett REST API för inventariehantering och lämnat över det till er — DevOps-teamet. Er uppgift är att driftsätta applikationen med fokus på **nätverkssäkerhet**, **lastbalansering** och **principen om minsta privilegium**.

## Repostruktur

```
SoftwareDevopsTeam/
├── app-repo/              ← Applikationen (rör inte denna kod)
│   ├── app/               ← Flask-applikation med Dockerfile
│   ├── db/                ← Databasschema
│   └── README.md          ← Dokumentation från utvecklingsteamet
│
└── infra-repo/            ← Här arbetar ni
    ├── docker-compose.yml ← Skelett — fyll i TODO:erna
    ├── loadbalancer/      ← Lastbalanserare (nftables)
    ├── mariadb/           ← Databasinitiering
    ├── docs/              ← Uppgiftsbeskrivning och ledtrådar
    └── README.md          ← Detaljerade instruktioner
```

## Kom igång

1. **Läs** `app-repo/README.md` — förstå vad applikationen gör och behöver
2. **Läs** `infra-repo/docs/ASSIGNMENT.md` — den fullständiga uppgiftsbeskrivningen
3. **Arbeta** i `infra-repo/` — fyll i alla filer markerade med `TODO`
4. **Testa** er lösning enligt instruktionerna i uppgiftsbeskrivningen

## Viktiga filer

| Fil | Beskrivning |
|-----|-------------|
| `app-repo/README.md` | API-dokumentation från utvecklingsteamet |
| `infra-repo/docs/ASSIGNMENT.md` | Fullständig uppgiftsbeskrivning |
| `infra-repo/docs/HINTS.md` | Ledtrådar (använd vid behov) |
| `infra-repo/README.md` | Tekniska instruktioner |

## Rapportera buggar och föreslå förbättringar

Om ni hittar något som inte fungerar som förväntat — i applikationskoden, i skelettfilerna eller i dokumentationen — skapa en **Issue** i repot. Det är en viktig del av att arbeta med kod i team och i open source-projekt.

### Varför issues?

Issues är det primära sättet att kommunicera problem och idéer i ett projekt. En välskriven issue sparar tid för alla inblandade och visar att ni förstår problemet ni rapporterar.

### Så skriver ni en bra issue

En bra issue innehåller tillräckligt med information för att någon annan ska kunna **förstå problemet utan att fråga er**.

**Titel:** Kort och beskrivande. Undvik vaga titlar som "Funkar inte".

| Bra titel | Dålig titel |
|-----------|-------------|
| `app: /health returnerar 500 när databasen inte nåbar` | `Healthcheck trasig` |
| `docker-compose: MariaDB startar inte med init.sql` | `Problem med databasen` |
| `docs: HINTS.md ledtråd 3 saknar port i exempel` | `Fel i dokumentationen` |

**Innehåll:** Strukturera er issue med följande delar:

```markdown
## Beskrivning
Vad är problemet? Beskriv kort vad ni observerar.

## Steg för att återskapa
1. Kör `docker compose up -d --build`
2. Vänta 15 sekunder
3. Kör `curl http://localhost/items`
4. Observera felmeddelandet

## Förväntat beteende
Vad borde ha hänt?

## Faktiskt beteende
Vad hände istället? Klistra in felmeddelanden och relevant output.

## Miljö
- OS: (t.ex. Ubuntu 22.04 / macOS 14 / Windows 11 + WSL2)
- Docker version: (kör `docker --version`)
- Docker Compose version: (kör `docker compose version`)

## Egen analys
Vad har ni undersökt? Vad tror ni orsaken är?
Visa gärna vilka loggar ni tittat på (`docker logs <container>`).

## Förslag på lösning (valfritt)
Om ni har en idé på hur det kan lösas, beskriv den här.
```

### Tips

- **Inkludera felmeddelanden** — Kopiera text, inte skärmdumpar av terminaltext
- **Var specifik** — "Fungerar inte" säger ingenting. *Vad* fungerar inte, *när*, och *hur* märker ni det?
- **Visa vad ni redan testat** — Det visar att ni försökt lösa det själva och hjälper andra undvika att föreslå saker ni redan provat
- **En issue per problem** — Blanda inte flera orelaterade problem i samma issue
- **Använd labels** om repot har dem — t.ex. `bug`, `documentation`, `enhancement`

### Exempel på en komplett issue

> **Titel:** `loadbalancer: nftables-regler laddas inte vid uppstart`
>
> **Beskrivning:**
> Lastbalanseraren startar men vidarebefordrar ingen trafik. Curl mot port 80 ger "connection refused".
>
> **Steg för att återskapa:**
> 1. `docker compose up -d --build`
> 2. `curl http://localhost/items`
> 3. Svar: `curl: (7) Failed to connect to localhost port 80`
>
> **Förväntat beteende:** Svar med JSON-data från en av appinstanserna.
>
> **Faktiskt beteende:** Connection refused.
>
> **Egen analys:**
> Kollade loggar med `docker logs loadbalancer` — inga felmeddelanden. Körde `docker exec loadbalancer nft list ruleset` och fick tomt resultat, vilket tyder på att nftables.conf inte laddas. Misstänker att sökvägen i entrypoint.sh är fel.
>
> **Förslag:** Ändra sökvägen i entrypoint.sh från `/etc/nftables.conf` till `/etc/nftables/nftables.conf`.

## Förkunskaper

- Docker och Docker Compose
- Grundläggande nätverkskunskap (TCP/IP, subnät)
- SQL
- Linux-kommandon
