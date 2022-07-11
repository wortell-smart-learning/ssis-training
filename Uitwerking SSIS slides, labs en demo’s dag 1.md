# Uitwerking SSIS slides, labs en demo’s dag 1

## Demo’s en labs dag 1

### Introductie

- Demo: Interface tour
Laten zien waar de onderdelen zitten:
* solution explorer
* properties
* design surface
* parameters
* event handlers
* package explorer
* connection managers
* variables
* toolbox
* “escape” truc?

### Data Flow Basics
- Demo: My First Data Flow
Dimensie: dimStore

### Control Flow Basics
- Demo: My First Control Flow

+ Lab: My First SSIS Package
ProductCategory vullen voor de dataflow 101.
Eerste transformation wordt dan het vertalen van de vier categorieën in vier talen (wat dus 16 transformaties zijn. Dirrrrty)

Control Flow 101 toevoegen van truncate stap

### Data Flow Intermediate
+ Lab: Lookup transformation
Mooie uitbreiding is om er een tabelletje voor in te richten (script aanleveren) en daarmee een lookup te doen bijv.

### Recap alles
- Lab: package maken voor nieuwe fact, plus lookup transformatie
- Bonuslab met missende waarden. Hoe hiermee om te gaan?

## Dag 1  uitgesplitst in methodes
### Introductie
	* Kennismaking
	* Recapituleren:
		* *gesprek* Verwachting van training
		* *gesprek* *whiteboard* Redenen voor DW
		* *whiteboard* Architectuur / opzet (wat is huidig landschap)
		* *whiteboard* Belangrijke componenten
		* *slides* Bespreken / begrip sterschema
	* *gesprek* Manieren om data te laden in SQL Server
		* bcp
		* T-SQL
		* Replicatie (third-party of MS)
		* SSIS (+ import / export data wizard)
	* Structuur SSIS
		* Feature SQL Server 
		* *slides* Control vs Data Flow
		* *slides* Project vs. package deployment
		* *demo* Interface tour (solution explorer, properties, design surfaces, parameters, event handlers, package explorer, connection managers, variables, toolbox)

### Data Flow Basics
	* *slides* Connection Managers
	* *slides* Sources, Targets en Transformations
	* *demo* My first data flow
### Control Flow Basics
	* *slides* Principe van tasks
	* *slides* Verhouding control vs. Data flow
	* *slides* Precedence constraints
	* *demo* my first control flow

*lab* My First SSIS package
	* Data flow maken op andere dimensie dan demo
	* Truncate van tabel vooraf
	* Kleine businessrule in een replace column oid



### Data Flow Intermediate
	* *gesprek* Recap lab
	* *gesprek* Recap connection managers
	* *slides* Uitleg lookup transformatie
	* *Lab* uitbreiden van bestaand fact-load-package met lookup transformatie

### Recap alles
* *Lab* Einde van de middag: ETL-package maken dat data laadt voor derde dimensie, en tweede feitentabel implementeert + lookup
* + bonuslab waarin extra dimensie wordt ingeladen, en de lookup wordt uitgebreid in de feitentabel-dataflow. Hierin missende waarden: wat nu? Hoe komt de fout, hoe ontdek je dit?