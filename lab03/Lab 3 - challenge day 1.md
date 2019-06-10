# Challenge day 1

## Description

Inside the exercises, you usually practice small steps. The larger "Challenges" bring together multiple concepts you've learned so far, enabling you to practice.
Also, there's no "step-by-step" instructions this time, which means you'll get one step closer to the real world.
Of course, you're encouraged to look up how you did things earlier on and use search engines to look up everything.

## What to deliver

Populate a small star scheme consisting of:

* 1 fact table
* 3 dimensions

Load the data via a "refresh (i.e. 'truncate-insert')"

First, load all dimensions.

Then, load the fact. Lookup dimension keys via the Lookup transformation.

Each table should get a separate Data Flow Task.

Sources are provided for in the following views:

* dbo.factAgg_InternetSales
* dbo.dim_ProductCategory
* dbo.dim_Customer
* dbo.dim_SalesTerritory

Be aware that you'll have to store the "ID" fields from all dimension views into a corresponding "AlternateKey" field inside the dimension table.

## Bonus challenge

Sometimes, even the "challenge" is little challenge to you - so you need some extra challenging challenges. Well, here you go:

As a bonus, load the snowflaked dimensions "Product", "ProductSubcategory" and "ProductCategory", as well as the fact table on product level
The extra views you'll need are:

* dbo.dim_ProductSubcategory
* dbo.dim_Product
* dbo.fact_InternetSales
