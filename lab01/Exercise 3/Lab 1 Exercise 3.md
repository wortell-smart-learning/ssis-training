# Lab 1 - Exercise 3

## Description

In lab 1, you will create a first SSIS package. 

Although we already verified that the package "Load_dimProductCategory.dtsx" worked in exercise 1, we also saw that:

* columns "SpanishProductCategoryName"  and "FrenchProductCategoryName" were empty
* the package always adds all rows available in source

In exercise 2, we fixed the second issue by refreshing the table.
In this exercise (exercise 3), we will add a very basic translation for product category names.

## Steps

### Open solution

1. Open solution "Lab 01 Exercise 3 Start" from the "Start" folder (or continue where you left off after exercise 2)

2. Open Load_dimProductCategory.dtsx

### Extend the Data Flow Task

3. Open DFT Load dim_ProductCategory
4. Remove the data flow arrow between OLE_SRC Production ProductCategory and OLE_DST DimProductCategory.
5. Add a Derived Column transformation to the data flow canvas
6. Drag the output from OLE_SRC Production ProductCategory towards the new Derived Column transformation.
7. Open the Derived Column
8. Add two columns, with the following properties:

Column 1:

  * Derived Column Name: SpanishProductCategoryName
  * Derived Column: add as new column
  * Expression: `REPLACE( [Name] , "Bikes", "Bicicleta")`

Column 2:

  * Derived Column Name: FrenchProductCategoryName
  * Derived Column: add as new column
  * Expression: `REPLACE( [Name] , "Bikes", "V�lo")`

9. Click "OK" to apply the changes and close the window

10. Rename "Derived Column" to "DER Translate ProductCategoryName"
11. Drag the output from "Derived Column" towards "OLE_DST Dim_ProductCategory"
12. Open "OLE_DST Dim_ProductCategory"
13. Open the "Mappings" page
14. Map the new columns towards their destination:

* FrenchProductCategoryName -> FrenchProductCategoryName
* SpanishProductCategoryName -> SpanishProductCategoryName

15. Click "Ok"  to apply the changes and close the window

16. Notice the yellow exclamation mark besides the OLE_DST. Can you figure out why this happens?

### Test 

17. Run the package, and check the results using SQL Server Management Studio. Is this what you expected?

### Bonus exercise 1

18. Can you extend the translations towards the other product category names?

Below you find category names in English (En), Spanish (Es) and French (Fr):

* En: Components, Es: Componente, Fr: Composant
* En: Clothing, Es: Prenda, Fr: V�tements
* En: Accessories, Es: Accesorio, Fr: Accessoire

### Bonus exercise 2

19. Remove the yellow exclamation mark. In order to do this, you have to figure out how type casts work inside an SSIS expression (type casts are basically ways of transforming one data type into another)

## Review

As you might have guessed, this is a rather unusual way of adding translations. Later on, we will explore more efficient ways to do this.

## Next steps

This is the end of lab 01. Have a coffee, discuss your findings about SSIS, and continue with [Lab 2](../../lab02/Exercise%201)!