# Uitwerking SSIS slides, labs en demo’s dag 2
## Demo’s en labs dag 2


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