# Uitwerking SSIS slides, labs en demo’s dag 2
#training #SSIS #eigen-training
## Demo’s en labs dag 2
Todo: toevoegen datum aan fact
### Dynamische packages
- demo: foreach-loop voor ophalen bestanden uit map van parameter
+ lab: gebruik van variabelen, parameters, expressions
+ lab: implementeren foreach-loop

Standaard-oplossing (foreach file, pad afhankelijk van bijv. datum)

### The not-so-happy-flow
- Lab: error handling in control & data flow
	- Exercise 1: Foutafhandeling
	- Exercise 2: Redirect w/ error flow

Ga verder met het package waar je de vorige keer aan gewerkt hebt, of open abcd.sln
Bekijk package pkg.dtsx. Zoals je ziet verwijst deze nog naar de map van het vorige lab. Inmiddels hebben we echter nieuwe data gekregen, die staat in de map nieuwe-map. 
Wijzig het pad in de package parameter, en voer het package uit.

Zoals je ziet faalt het package. Kun je al enigszins zien wat er fout gaat?

We gaan deze fout in drie stappen oplossen.
1. Fouten afvangen in de control flow, zodat onvoorziene fouten op een nette manier inzichtelijk gemaakt worden (en het package deze netjes afhandelt)
2. Foute regels identificeren in de data flow, zodat specifiek zichtbaar wordt wat er fout gaat in een package
3. Fout bij de bron aanpakken: package aanpassen of bronbestand opnieuw laten aanleveren

#### Fouten afvangen in de control flow
Allereerst voegen we een stuk foutoplossing toe, waardoor het package onvoorziene fouten op een nette manier afhandelt. In dit geval zullen we bestanden waar het inlezen fout gaat in een aparte map zetten.

Maak de container FEL wat groter, en voeg hier een “File System Task” toe. Deze moet het gegeven bestand verplaatsen naar de map waarin we het bestand ingelezen hebben, gevolgd door “\error”. Wanneer de map dus “C:\inleesmap\aanlevering1” was, komen de foute bestanden terecht in “C:\inleesmap\aanlevering1\error”. 

Met behulp van een precedence constraint zorgen we ervoor dat deze taak alleen wordt uitgevoerd wanneer de DFT faalt.

Voer het package opnieuw uit. We kunnen nu zien welke bestanden er niet standaard ingelezen kunnen worden.

Wanneer je het package nu opnieuw uitvoert, zul je zien dat er opnieuw een fout optreedt: het bestand kan niet gekopieerd worden naar de “error” map, omdat het bestand al bestaat. Hier kun je twee zaken tegen doen:
* basaal: maak de “error” map leeg alvorens ernaartoe te schrijven (of zorg ervoor dat bestaande bestanden overschreven worden). Dit is uiteraard niet echt wenselijk, aangezien je nu kennis kwijtraakt over wat er eerder fout is gegaan.
* gewenst: zorg ervoor dat binnen de map “error” een submap wordt aangemaakt voor elke load met fouten. Een gebruikelijke manier hiervoor is om deze map de naam van de datum en tijd te geven op het moment dat het package startte. Hiervoor heb je drie zaken nodig:
	1. De system variable met de starttijd- en datum
	2. Een expressie die deze variabele omzet in een bruikbare string
	3. Een taak die de map aanmaakt als deze nog niet bestaat

Implementeer, afhankelijk van hoeveel uitdaging je zoekt, optie 1 of twee in je package.

#### Foute regels identificeren de data flow
Binnen de data flow kunnen de foute regels een eigen behandeling krijgen, door de zogenaamde “error output” van een component.

*#Uitzoeken* waar komt een fout in een bestand naar voren? Kan een onverwachte waarde binnen een getal-kolom bij het inlezen aangepakt worden?

We gaan nu de “error output” van de SRC-component pakken, en stoppen deze in tabel “ingelezen_data_error”. Kijk goed naar deze tabel en vergelijk met de tabel “ingelezen_data” (waar de correcte data terecht komt). 
* Wat valt op? 
* Waarom denk je dat dit gebeurt?
* Kun je op basis hiervan bedenken welke fouten er wel / niet afgevangen worden?
	* Een decimaal getal als “1,345.12” (US notatie) dat geschreven is als “1.345,12” (Europese notatie)
	* Een CSV-bestand dat als scheidingsteken geen komma  “kolom1,kolom2,kolom3” maar een puntkomma “kolom1;kolom2;kolom3” gebruikt

Voer het package uit, en bekijk de rijen die terecht gekomen zijn in de tabel “ingelezen_data_error”. Wat valt op?

#### Fout aanpakken bij de bron
In de aangeleverde bestanden blijkt een afwijking te zitten ten opzichte van wat er afgesproken is. De meest eenvoudige oplossing is dan om bij de aanleverende partij dit aan te kaarten en te vragen om correcte data aan te leveren. 

Hieronder staan twee scenario’s beschreven: het standaardscenario en het “emergency” bonus-scenario. Kies naar gelang de uitdaging die je zoekt.

Standaardscenario:
Klant heeft een nieuwe aanlevering gedaan. Deze staat in map A\B. Wijzig de parameter in “A\B” en verifieer dat de data flow nu goed gaat.

Bonus-scenario:
Klant gaat de aanlevering aanpassen, maar dit vereist een aanpassing in het systeem, die nog een maand duurt. In de bestandsnaam is echter te zien dat er een andere notatie is door de toevoeging “_alt.csv”.
* Maak een tweede data flow aan, die goed kan omgaan met deze “_alt.csv” bestanden. 
* Zorg er met een expressie in een precedence constraint voor dat de juiste dataflow wordt gekozen.
Als je het nóg netter wilt oplossen, maak dan een voorsortering:
* Alle “_alt.csv” bestanden worden verplaatst naar de submap “1”
* Alle overige “.csv” bestanden worden verplaatst naar de submap “2”
* Voor elk van de mappen is een aparte FEL en DFT die de bestanden afhandelt
 

### Lab: debugging
Hoewel het goed is om vooraf rekening te houden met mogelijk optredende fouten, kun je niet alles voor zijn. In de praktijk zul je daarom soms moeten “Debuggen”. 
* Open solution lab12345.sln
* Voer uit
Zoals je ziet gaat er opnieuw iets fout bij het inlezen van de bestanden
De for-loop maakt het lastig om te zien wannéér het exact fout gaat
Voeg een breakpoint toe aan het begin van de for-loop
Voer het package opnieuw uit, zie waar het fout gaat. Kun je achterhalen wat er mis is?

De for-loop itereert over de mappen “1” t/m “5”. Echter, map “3” ontbreekt in de mappenstructuur. 
Voeg deze toe in Windows Verkenner (uiteraard zou je hiervoor een stuk logica kunnen bouwen, maar voor nu kiezen we voor de snelle weg)

Voer het package opnieuw uit. 

Zoals je ziet gaat het nog steeds niet 100% correct. 

Om in te zien wat er fout gaat, openen we de DFT, en voegen tussen componenten X en Y een Data Viewer toe. In component Y wordt een dataconversie gedaan van gegevens uit component X.

Start het package

De Data Viewer komt naar voren. Klik op het pijltje om de volgende set data te bekijken, net zolang tot je een fout tegenkomt.

Kun je achterhalen wat er fout gaat?


### Groter integratie-lab
In dit grotere integratie-lab proberen we diverse stukken kennis die we voorheen hebben behandeld samen te voegen in één oplossing. Dit doen we in de volgende stappen:

1. Maak een “plain” truncate-insert data flow aan van de dimensies “klant”, “medewerker” en “datum”. Van tabel naar tabel
2. Probeer een manier te bedenken om deze data flow kapot te maken. Als je een idee nodig hebt, zie script abcd.sql
3. Breid de inlees-actie uit met een aanlevering van data voor de feittabel.
	1. Koppel deze aan de bestaande dimensies
	2. Bonus: eigenlijk is de leidende datum niet de “betaaldatum” zoals deze in de kolom “betaaldatum” staat, maar de “leverdatum”. Deze staat niet in het bestand zelf, maar in de bestandsnaam. Fix dat.
4. Maak deze tweede aanlevering dynamisch via parameters

### Logging basics
- Demo: basis van loggen
- Demo: uitbreiding van loggen

## Dag 2 uitgesplitst in methodes
### Dynamische packages
	* *slides* Variabelen
	* *slides* Parameters
	* *slides* Expressions
	* *demo* foreach-loop ophalen van bestanden uit map van parameter
* *Lab*: gebruik van variabelen, parameters, expressions
	* Variabelen: foreach loop


### The not-so-happy-flow
* *slides* Not-so-happy control flow: Failed tasks
* *slides* Not-so-happy data flow: Error flows
* *Lab* error handling in control & data flow
* Extra: debugging (data viewer, variables in scope, breakpoints)



### Groter integratie-lab
* *Lab* Middag: groter lab (integratie van tot nu toe behandeld)

### Logging basics
* *Lab* Eind middag: logging basics (demo + possible events to log)