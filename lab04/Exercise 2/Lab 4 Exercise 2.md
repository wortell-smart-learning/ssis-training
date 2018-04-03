In addition to the data available in the database, our customer has some CSV files containing reseller sales data of 2014.

In the next lab, we will extend this ETL package so that all files in one folder can be processed.

In this lab, we are working towards this goal in three steps:
exercise 1: Create a static load package, to prove that the load logic works
exercise 2: Make this package dynamic by using parameters, variables and expressions
next lab: Make the package loop across all files in the folder using a ForEach-loop

In this exercise (exercise 2) we make the static structure dynamic by using parameters, variables and expressions.

Open "Lab 04 exercise 2 start.sln" from the "start" folder

Open the package "Load Fact Reseller Sales.dtsx"

Currently, the package reads a CSV file with a fixed filename (2014-01.csv) from a fixed path (C:\course\lab04\exports).
This is visisble when you click the connection manager, and view the properties window by pressing F4 on your keyboard (look for the property "ConnectionString")

It reads: 
`C:\course\lab04\exports\2014-01.csv` 

In three steps, we will make the file that is read dynamic:
1. We create a *parameter* that provides the path (currently `C:\course\lab04\exports\`)
2. We create a *variable* providing the filename (currently `2014-01.csv`)
3. We create an *expression* that replaces the ConnectionString of `FFC Reseller Sales` /each time the connection manager is called/. 

## Create a parameter to provide the path
* Switch to the Parameters tab

* Click "Add Parameter" button

* Provide the following details
  * Name: CsvFolder
  * Data type: String
  * Value: C:\course\lab04\exports\
  * Description: (think up a good description here)

## Create a variable for the filename
* Switch back to the Control Flow tab
* Right-click anywhere on the design canvas
* Click "Variables" to open the variables pane (it opens up in the bottom)

Inside the variables pane (which is currently empty) all variables in the current context are listed.

* Click "Add Variable"
* Provide the following details
  * Name: CSVFilename
  * Data type: String
  * Value: 2014-01.csv

## Create an expression to fill the Connection String dynamically
* Click on the Flat File Connection Manager
* Press F4 on your keyboard to open the properties pane
* Look for the property "Expressions". Click on it
* Click on the ellipsis (...) 

Now, the "Property Expressions Editor" opens. 
With this editor, you can provide expressions for all properties of an element, as long as they can be set dynamically at all.
* In the "Property" column, select "ConnectionString"
* In the "Expression"  column, click on the ellipsis

The Expression Builder opens.
Here, you have a small environment where you can see available variables and parameters, as well as several built-in functions in SSIS Expression Language.
* Open "Variables and Parameters"

Parameters are displayed like `$Package::` (or `$Project::`).
Variables are displayed like `User::`

* Drag `$Package::CsvFolder` to the Expression textbox.
* Click "Evaluate Expression" to inspect the parameter
* At the end of the current expression, add (without quotes) " + "
* Now, drag `User::CSVFileName` towards the end of the expression in the Expression textbox.
* Click "Evaluate Expression" to see the outcome of current parameter and variable values

* Click "OK" to close the Expression Builder window
* Click "OK" to close the Property Expression Editor window

Now, try running the package and inspect the outcome inside SSMS.
Furthermore, try to alter the variable value manually to "2014-02", to see if different data is loaded indeed.
