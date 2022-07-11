# Uitwerking SSIS slides, labs en demo’s dag 2
#training #SSIS #eigen-training
## Demo’s en labs dag 2
### The not-so-happy-flow
- Lab: error handling in control & data flow
Fact table met lookup failure, of dimensie met vertaalfout (nvarchar -> varchar bijv.).
Initieel niet oplossen, maar foutafhandeling.
Daarna meer finetunen met error flow
Ten slotte “echt” oplossen.

- Lab: debugging
Fout in een for-loop (bijv. for gebruiken voor map 1 t/m 5, waarbij 3 ontbreekt)
Breakpoint uitproberen, ontdekken waar het fout gaat

Map 3 toevoegen, maar in map 4 zit een fout in de data
Oplossen met data viewer

### Dynamische packages
- demo: foreach-loop voor ophalen bestanden uit map van parameter
- lab: gebruik van variabelen, parameters, expressions
Standaard-oplossing (foreach file, pad afhankelijk van bijv. datum)

### Groter integratie-lab
- lab: “plain” truncate-insert data flow van eenvoudige dimensie
- lab: handmatig stukmaken van de data flow (nieuwe data toevoegen) en oplossen met error flow
- lab: uitbreiding tweede aanlevering van tekstbestanden met foreach-loop. Niet in te lezen bestanden via een precedence constraint verplaatsen naar error-map
- lab: dynamisch maken van tweede aanlevering via parameters

### Logging basics




## Dag 2 uitgesplitst in methodes

### The not-so-happy-flow
* *slides* Not-so-happy control flow: Failed tasks
* *slides* Not-so-happy data flow: Error flows
* *Lab* error handling in control & data flow
* Extra: debugging (data viewer, variables in scope, breakpoints)

### Dynamische packages
	* *slides* Variabelen
	* *slides* Parameters
	* *slides* Expressions
	* *demo* foreach-loop ophalen van bestanden uit map van parameter
* *Lab*: gebruik van variabelen, parameters, expressions
	* Variabelen: foreach loop

### Groter integratie-lab
* Middag: groter lab (integratie van tot nu toe behandeld)

### Logging basics
* Eind middag: logging basics (demo + possible events to log)