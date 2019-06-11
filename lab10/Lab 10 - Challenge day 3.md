# Final Challenge

## Description

This final challenge is meant to bring together all subjects covered earlier in this course.
It's up to you to build it in SSIS, or to try and build in BIML. Another option would (of course) be to construct everything in SSIS, then try to see if you can reach the same result using BIML.

## Requirements

Inside the folder "preparation" you will find some SQL-files that construct a simple star scheme (some dimensions as well as facts). This will create a new database called "BITrainer_SSIS"

Your task is to fill these tables using SSIS. In order to get there, you'll need the following sources:

* Dimensions Customer and Product are delivered from within SQL Server the way you're used to (two views inside the AdventureWorks2016 database)
* Dimension Date is already present in the Data Warehouse - you don't have to fill this one
* Fact NewSales is delivered using CSV files. These might contain incorrect rows, which have to end up in the NewSales_errors table (you need to create any error tables yourself).
* Fact OldSales is delivered from a TSV file (tab separated value). This works almost like a CSV (but with a different delimiter)
* Be sure not only to include the due date and ship date, but also the order date. This date can *not* be found inside the files, but is contained in the file- and folder names. With some expression help you will succeed.

The development standards in our team include:

* Every data flow needs to have its own package, and a "master package" to orchestrate all other packages
* We don't load data from fixed paths - configure a parameter to let the package know where the files live
* Whenever possible, use project level connection managers
* Name the Master-packages with a prefix of "100_", the "slave" packages with a prefix of "200_"
* Make sure non-matching keys don't throw in errors, but are linked to a separate dimension member where all missing keys can be linked unto. You'll have to add a special row to your dimension after loading ("refreshing") your dimension.

## Some advice

Try to start small in this challenge! It's a somewhat larger project, so just start with some dimensions (not too much logic). For example:

* At first, don't use the TransactionDate (from the filename), but first use the PaymentDate. 
* Initially, don't use the error flows for the data to land on different places, just ignore it.
* Don't start with a ForEach-loop, first make sure one file will load correctly
* etc.

As soon as you got the basic flow working, you can extend your functionality.

* You won't be able to fill all fields using simple mappings!
  * For example, extended amount = unit price * order quantity
  * Also, take a look at the unit price discount. Is it the percentage or absolute? (you'll need both)
  * Sales amount is extended amount - discount.
  * PO stands for PurchaseOrder

## BONUS

As always, there is some bonus challenge involved. For the bonus, improve your solution so that it doesn't just *refresh* the data, but will load incrementally.
In order to do that, I'd strongly advise to create a staging area.

You can do this in three levels:

1. Basic bonus. Your ETL process checks which data is already in your DW. Only new data is loaded.
2. Intermediate bonus. Your ETL process checks not only if rows are new (source system id is currently unknown inside the DW), but also checks whether previously loaded data has been updated. Updates are processed in a "type 1" way of slowly changing dimensions: changes are simply overwritten. Facts are never updated.
3. Bonus-bonus. Try to model a "type 2" dimension (don't try this unless you've completed bonus 2)
