### Deployment & configuration
Er zijn veel manieren om je SSIS deployements te automatiseren: via Continuous Delivery, met installatiescripts via PowerShell, via SQL-scripts en nog veel meer. De stap die je als ontwikkelaar echter het meest zal moeten doen, is de deployment van packages naar je ontwikkel- of testserver. Dat is dan ook waar we hier op zullen richten.

Open het project “testsolution.sln”
Rechtsklik op de projectnaam, klik “Deploy”

Doorloop de wizard

Open SQL Server Management Studio

SSIS Catalogs -> SSISDB -> MyDeploymentFolder

Op een server gelden vaak net iets andere credentials en mappen dan op je lokale ontwikkelomgeving. Dat is ook één van de redenen waarom we packages dynamisch maken met package- en project-level parameters.

Op een SSIS Catalog worden de instellingen gegroepeerd op basis van:
* Environments. Dit is een verzameling van variabelen met specifieke waarden. Een voorbeeld van een “environment” kan “Ontwikkelserver” zijn.
* Variabelen. Deze bevinden zich binnen een environment, en bevatten de specifieke waarden voor die environment. Bijvoorbeeld variabele “DWServer” die op “rabo_dw_dev_001.rabobank.nl” staat.
* Environment references. Elk project dat gedeployd wordt kan refereren aan een environment. Dat betekent dat de waarden uit die specifieke environment gebruikt kunnen worden.

Binnen een project kunnen vervolgens de *package connection managers*, *project connection managers*, *package parameters* en *project parameters* geconfigureerd worden.
