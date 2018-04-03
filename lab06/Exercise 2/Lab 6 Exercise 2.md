# Lab 6 Exercise 1

## Description
In lab 5, we developed an ETL package to load some extra sales data from CSV files.
However, apparently the data isn't always present. How do we handle that in a good way?

In exercise 1 we will implement error handling inside the control flow
In exercise 2 (current exercise) we will extend the error handling using "error flows" inside a data flow

## Steps

### Getting ready
1. Open "Lab 06 Exercise 2 start.sln" from the "start" folder, or continue where you left off after finishing lab 6 exercise 1.
2. Open package "Load Fact Reseller Sales.dtx"

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
 