# Final Challenge

## Description

This final challenge is meant to bring together all subjects covered earlier in this course.
It's up to you to build it in SSIS, or to try and build in BIML. Another option would (of course) be to construct everything in SSIS, then try to see if you can reach the same result using BIML.

## Requirements

Inside the folder "preparation" you will find some SQL-files that construct a simple star scheme (some dimensions as well as facts). Execute this SQL script on your AdventureWorksDW2016_empty-database.

Your task is to fill these tables using SSIS. In order to get there, you'll need the following sources:

* Dimensions Customer and Product are delivered from within SQL Server
* Dimension Date is already present in the Data Warehouse - you don't have to fill this one
* Fact NewSales is delivered using CSV files. These might contain incorrect rows, which have to end up in the NewSales_errors table.
* Fact OldSales is delivered from a TSV file (tab separated value). This works almost like a CSV (but with a different delimiter)
* The correct date to join on is not the PaymentDate (which is a column inside the file), but the TransactionDate (which is identical to the file name)

The development standards in our team include: 

* Every data flow needs to have its own package, and a "master package" to orchestrate all other packages
* We don't load data from fixed paths - configure a parameter to let the package know where the files live
* Use only project-level connection managers
* Name the Master-packages with a prefix of "100_", the "slave" packages with a prefix of "200_"
* Make sure non-matching keys don't throw in errors

## Some advice

Try to start small in this challenge! It's a somewhat larger project, so just start with some dimensions (not too much logic). For example: 

* At first, don't use the TransactionDate (from the filename), but first use the PaymentDate. 
* Initially, don't use the error flows for the data to land on different places, just ignore it.
* Don't start with a ForEach-loop, first make sure one file will load correctly
* etc.

As soon as you got the basic flow working, you can extend your functionality.