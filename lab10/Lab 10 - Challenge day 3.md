### Groter integratie-lab
In dit grotere integratie-lab proberen we diverse stukken kennis die we voorheen hebben behandeld samen te voegen in één oplossing. Dit doen we in de volgende stappen:

1. Maak een “plain” truncate-insert data flow aan van de dimensies “klant”, “medewerker” en “datum”. Van tabel naar tabel
2. Probeer een manier te bedenken om deze data flow kapot te maken. Als je een idee nodig hebt, zie script abcd.sql
3. Breid de inlees-actie uit met een aanlevering van data voor de feittabel.
	1. Koppel deze aan de bestaande dimensies
	2. Bonus: eigenlijk is de leidende datum niet de “betaaldatum” zoals deze in de kolom “betaaldatum” staat, maar de “leverdatum”. Deze staat niet in het bestand zelf, maar in de bestandsnaam. Fix dat.
4. Maak deze tweede aanlevering dynamisch via parameters
