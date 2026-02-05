1. Uppgiften var att sätta upp brandvägg som ska lastbalansera mellan två webbservrar med nftables och sist en SQL-databas
2. Vi(en) började med att konfigurera dockercompose.yml-filen: nätverk, databas, environment, portar. Vi skapade en egen fil för databas-åtkomsten (lösenord och användarnamn, port, host etc.)'
3. Konfigurerade dockerfile (alpine-image, RUN nftabels, COPY nftables.conf /entrypoint.sh, kör entrypoint-skriptet)
4. Konfigurerade entrypoint.sh: (startskrift för nftables lastbalanserarfunktion)
5. Konfigurerade och nftables.conf: regler för nftables: RR, port 80 (lastbalanserare) --> port 5000 (appen)
6. Konfigurerade init.sql: skapade databas (port 3306) och fantastiska föremål i den
7. Byggde image-filen (docker compose up -d --build)
8. Vi testade endpoints och hälsostatus på databasen, vilket lyckades. Vi testade att uppdatera databasen och lägga till föremål till den, men kunde inte ta bort föremål som den skulle.
9. Prövade att pinga från host till app (172.20.0.11), vilket misslyckades. Sen prövade vi att pinga från lastbalanseraren till app och det lyckades. Detta gjorde vi för att bekräfta att nftables fungerar (och det gjorde det)

Frågeställning: 
Varför ska användaren kunna lägga/uppdatera föremål i databasen utan inloggning? En brist i designen?