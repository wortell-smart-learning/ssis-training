USE [AdventureWorks2016]
GO

/****** Object:  View [dbo].[dim_Customer]    Script Date: 4-4-2018 12:04:06 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[dim_Customer]
AS
SELECT CustomerID, AccountNumber, PersonType, NameStyle, Title, FirstName, MiddleName, LastName, Suffix
FROM AdventureWorks2016.Sales.Customer
LEFT JOIN AdventureWorks2016.Person.Person
	ON Customer.PersonID = Person.BusinessEntityID;

GO


USE [AdventureWorks2016]
GO

/****** Object:  View [dbo].[dim_Product]    Script Date: 4-4-2018 12:04:11 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[dim_Product]
AS
SELECT ProductID, [Name], ProductNumber, Color, Size, SizeUnitMeasureCode, ListPrice, StandardCost, Weight, WeightUnitMeasureCode, Class, Style, ProductSubcategoryID
FROM AdventureWorks2016.Production.Product;
GO


USE [AdventureWorks2016]
GO

/****** Object:  View [dbo].[dim_ProductCategory]    Script Date: 4-4-2018 12:04:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[dim_ProductCategory]
AS
SELECT ProductCategoryID, [Name]
FROM AdventureWorks2016.Production.ProductCategory;

GO


USE [AdventureWorks2016]
GO

/****** Object:  View [dbo].[dim_ProductSubCategory]    Script Date: 4-4-2018 12:04:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[dim_ProductSubCategory]
AS
SELECT ProductSubcategoryID, ProductCategoryID, [Name]
FROM AdventureWorks2016.Production.ProductSubCategory;

GO


USE [AdventureWorks2016]
GO

/****** Object:  View [dbo].[dim_SalesTerritory]    Script Date: 4-4-2018 12:04:23 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[dim_SalesTerritory]
AS
SELECT TerritoryID, [Name], CountryRegionCode, [Group]
FROM AdventureWorks2016.Sales.SalesTerritory;

GO


USE [AdventureWorks2016]
GO

/****** Object:  View [dbo].[fact_InternetSales]    Script Date: 4-4-2018 12:04:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[fact_InternetSales]
AS
SELECT SUM(SalesOrderHeader.TotalDue) TotalDue
	, SUM(SalesOrderHeader.SubTotal) SubTotal
	, SUM(SalesOrderHeader.TaxAmt) TaxAmt
	, SUM(SalesOrderHeader.Freight) Freight
	, Product.ProductID
	, Customer.CustomerID
	, SalesTerritory.TerritoryID
FROM AdventureWorks2016.Sales.SalesOrderHeader
LEFT JOIN AdventureWorks2016.Sales.SalesOrderDetail
	ON SalesOrderHeader.SalesOrderID = SalesOrderDetail.SalesOrderID
LEFT JOIN AdventureWorks2016.Production.Product
	ON SalesOrderDetail.ProductID = Product.ProductID
LEFT JOIN AdventureWorks2016.Production.ProductSubcategory
	ON Product.ProductSubcategoryID = ProductSubcategory.ProductSubcategoryID
LEFT JOIN AdventureWorks2016.Production.ProductCategory
	ON ProductSubcategory.ProductCategoryID = ProductCategory.ProductCategoryID
LEFT JOIN AdventureWorks2016.Sales.Customer
	ON SalesOrderHeader.CustomerID = Customer.CustomerID
LEFT JOIN AdventureWorks2016.Sales.SalesTerritory
	ON Customer.TerritoryID = SalesTerritory.TerritoryID
WHERE SalesOrderHeader.OnlineOrderFlag = 1
GROUP BY Product.ProductID
		, Customer.CustomerID
		, SalesTerritory.TerritoryID;
GO


USE [AdventureWorks2016]
GO

/****** Object:  View [dbo].[factAgg_InternetSales]    Script Date: 4-4-2018 12:04:29 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[factAgg_InternetSales]
AS
SELECT SUM(SalesOrderHeader.TotalDue) TotalDue
	, SUM(SalesOrderHeader.SubTotal) SubTotal
	, SUM(SalesOrderHeader.TaxAmt) TaxAmt
	, SUM(SalesOrderHeader.Freight) Freight
	, ProductCategory.ProductCategoryID
	, Customer.CustomerID
	, SalesTerritory.TerritoryID
FROM AdventureWorks2016.Sales.SalesOrderHeader
LEFT JOIN AdventureWorks2016.Sales.SalesOrderDetail
	ON SalesOrderHeader.SalesOrderID = SalesOrderDetail.SalesOrderID
LEFT JOIN AdventureWorks2016.Production.Product
	ON SalesOrderDetail.ProductID = Product.ProductID
LEFT JOIN AdventureWorks2016.Production.ProductSubcategory
	ON Product.ProductSubcategoryID = ProductSubcategory.ProductSubcategoryID
LEFT JOIN AdventureWorks2016.Production.ProductCategory
	ON ProductSubcategory.ProductCategoryID = ProductCategory.ProductCategoryID
LEFT JOIN AdventureWorks2016.Sales.Customer
	ON SalesOrderHeader.CustomerID = Customer.CustomerID
LEFT JOIN AdventureWorks2016.Sales.SalesTerritory
	ON Customer.TerritoryID = SalesTerritory.TerritoryID
WHERE SalesOrderHeader.OnlineOrderFlag = 1
GROUP BY ProductCategory.ProductCategoryID
		, Customer.CustomerID
		, SalesTerritory.TerritoryID;
GO


