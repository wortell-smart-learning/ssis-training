# Opzet training SSIS 

## Vergelijkbare programma’s

Microsoft biedt binnen zijn MOC 20767 een deel SSIS aan. In mijn optiek is dit een wat magere introductie tot ETL-development, maar geeft wel een goed beeld van wat er volgens Microsoft belangrijk is:

* Module 6: Implementing ETL (= SSIS intro + Data Flows)
* Module 7: Implementing Control Flow
* Module 8: Debug SSIS packages
* Module 9: Incremental ETL (CDC e.d.)
* Module 10: DQS
* Module 11: MDS
* Module 13: Deploy & configure

Ik wil daarnaast nog een stukje over BIML erbij doen:

* BIML syntax
* SSIS control flow genereren
* SSIS data flow met BIML
* BIML uitbreiden en automatiseren met C# primers
* Metadata-driven BIML

## Mijn opzet

Mijn opzet is met name gericht op een SSIS introductie. Tool en ervaring hiermee opdoen is dus key.

### Voorkennis

Als voorkennis veronderstel ik:

* Toepasbare kennis over dimensioneel modelleren
  * Minimaal: binnen een training een keer een dimensioneel model zelfstandig gemaakt
  * Optimaal: praktijkervaring met een dimensioneel model
* Kennis over de inrichting van een Data Warehouse
	* Het hoe en waarom van een DW
	* Globale kennis van hoe dit bij een klant aangepakt wordt
		* Modellering
		* Verantwoordelijkheden
		* Doel van het DW dat er staat
* Kennis over SQL en SQL Server
	* Kennis over structuur van SQL Server
		* Schemas
		* Tabellen
		* Views
		* Stored procedures
		* Datatypes (NVARCHAR vs VARCHAR, DECIMAL, INT, etc.)
	* Kunnen basis DML-queries goed lezen en schrijven
		* INSERT, SELECT, UPDATE, DELETE
### Structuur van labs
De structuur wordt sterk opgezet vanuit de labs. Alles valt stap-voor-stap uit te leggen, maar de ervaring is belangrijk.

Idee voor de volgorde van labs is daarom:
1. Data flow basics (dimensie herladen)
2. Control flow basics (truncate) - basis precedence constraints
3. Data flow & transformation basics (source -> target + basistransformatie)
4. Data flow “advanced” transformation (lookup)
5. Outside the “happy flow” 
	1. Failure constraints
	2. Error paths (lookup no result)
6. Intermezzo: data profiling & cleansing (DQS)
7. Extra oefenlab: dimensies & feiten laden vanaf scratch, met foutafhandeling. Bepaalde metrics naar logging-database (en wellicht een DQS-oefening?)
8. Dynamisch maken van packages
	1. Variabelen (filename)
	2. Parameters (folder path)
	3. Property-expression (full path)
9. Debugging (variabele heeft onverwachte waarde)
	1. Breakpoints
	2. Watch / variables in scope
10. Deployment (project)
	1. Environments
	2. Projects / folders
11. Incrementele ETL primer (Change Tracking / CDC)
12. BIML control flow
13. BIML data flow

## Structuur van gehele training
* *Introductie* 
	* Kennismaking
	* Recapituleren:
		* Verwachting van training
		* Redenen voor DW
		* Architectuur / opzet (wat is huidig landschap)
		* Belangrijke componenten
		* *slides* Bespreken / begrip sterschema
	* Manieren om data te laden in SQL Server
		* bcp
		* T-SQL
		* Replicatie (third-party of MS)
		* SSIS (+ import / export data wizard)
	* Structuur SSIS
		* Feature SQL Server 
		* Control vs Data Flow
		* Project vs. package deployment
		* Interface tour (solution explorer, properties, design surfaces, parameters, event handlers, package explorer, connection managers, variables, toolbox)

Snelle koffie

* *Data Flow Basics*
	* Connection Managers
	* Sources, Targets en Transformations
	* *demo* My first data flow
* *Control Flow Basics*
	* Principe van tasks
	* Verhouding control vs. Data flow
	* Precedence constraints
	* *demo* my first control flow
* *Lab* My First SSIS package
	* Data flow maken op andere dimensie dan demo
	* Truncate van tabel vooraf
	* Kleine businessrule in een replace column oid

Lunch

* *Data Flow Intermediate*
	* Recap lab
	* Recap connection managers
	* Uitleg lookup transformatie
	* *Lab* uitbreiden van bestaand fact-load-package met lookup transformatie

* *Lab* Einde van de middag: ETL-package maken dat data laadt voor derde dimensie, en tweede feitentabel implementeert + lookup
* + bonuslab waarin extra dimensie wordt ingeladen, en de lookup wordt uitgebreid in de feitentabel-dataflow. Hierin missende waarden: wat nu? Hoe komt de fout, hoe ontdek je dit?

* *The not-so-happy-flow*
* Not-so-happy control flow: Failed tasks
* Not-so-happy data flow: Error flows
* *Lab* error handling in control & data flow
* Extra: debugging (data viewer, variables in scope, breakpoints)

* Koffie

* Dynamische packages
	* Variabelen
	* Parameters
	* Expressions
	* Demo: foreach-loop ophalen van bestanden uit map van parameter
* *Lab*: gebruik van variabelen, parameters, expressions
	* Variabelen: foreach loop

* Lunch

* Middag: groter lab (integratie van tot nu toe behandeld)

* Eind middag: logging basics (demo + possible events to log)

Laatste dag:
* Deployment & configuration
* *Lab* deploying and configuring SSIS packages


 
* BIML primer
* *lab* invullen van voorbeelden in BIML

* Lunch

* Middaglab: volledige implementatie van SSIS-opzet. Naar keuze in BIML of “plain” SSIS.

