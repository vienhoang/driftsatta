1. Uppgiften var att sätta upp brandvägg som ska lastbalansera mellan två webbservrar med nftables och sist en SQL-databas
2. Vi(en) började med att konfigurera dockercompose.yml-filen: nätverk, databas, environment, portar. Vi skapade en egen fil för databas-åtkomsten (lösenord och användarnamn, port, host etc.)'
3. Konfigurerade dockerfile (alpine-image, RUN nftabels, COPY nftables.conf /entrypoint.sh, kör entrypoint-skriptet)
4. Konfigurerade entrypoint.sh: (startskrift för nftables lastbalanserarfunktion)
5. Konfigurerade och nftables.conf: regler för nftables: RR, port 80 (lastbalanserare) --> port 5000 (appen)
6. Konfigurerade init.sql: skapade databas (port 3306) och fantastiska föremål i den
7. Byggde image-filen (docker compose -up)
8. Vi tetade endpoints och hälsostatus på databasen, vilket lyckades. Vi testade att uppdatera databasen och lägga till föremål till den, men kunde inte ta bort föremål från den (se frågeställning)
9. Prövade att pinga från host till app (172.20.0.11), vilket misslyckades. Sen prövade vi att pinga från lastbalanseraren till app och det lyckades. Detta gjorde vi för att bekräfta att nftables fungerar (och det gjorde det)


Frågeställning: 
Varför kan man uppdatera databasen som användare men ej som developer/admin. Denne3 måste också gå in som användare. En brist i designen?
(Efter timmar av analys av vår kod kom vi fram till att svart finns på rad 34 i init.sql-filen)

Detta besvarar dock bara frågan hur det funkar rent tekniskt, inte syftet med funktionen. Lex PumpBase?