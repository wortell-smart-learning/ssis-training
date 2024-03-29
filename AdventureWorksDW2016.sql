USE [AdventureworksDW2016_empty]
GO
/****** Object:  Schema [meta]    Script Date: 4-4-2018 12:01:59 ******/
CREATE DATABASE AdventureworksDW2016_empty
GO
CREATE SCHEMA [meta]
GO
/****** Object:  Table [dbo].[dim_Customer]    Script Date: 4-4-2018 12:01:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dim_Customer](
	[CustomerKey] [int] IDENTITY(1,1) NOT NULL,
	[CustomerAlternateKey] [int] NOT NULL,
	[AccountNumber] [varchar](10) NOT NULL,
	[PersonType] [nchar](2) NULL,
	[NameStyle] [bit] NULL,
	[Title] [nvarchar](8) NULL,
	[FirstName] [nvarchar](50) NULL,
	[MiddleName] [nvarchar](50) NULL,
	[LastName] [nvarchar](50) NULL,
	[Suffix] [nvarchar](10) NULL,
 CONSTRAINT [PK_dim_Customer] PRIMARY KEY CLUSTERED 
(
	[CustomerKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dim_Product]    Script Date: 4-4-2018 12:01:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dim_Product](
	[ProductKey] [int] IDENTITY(1,1) NOT NULL,
	[ProductAlternateKey] [int] NOT NULL,
	[EnglishProductName] [nvarchar](50) NOT NULL,
	[SpanishProductName] [nvarchar](50) NULL,
	[FrenchProductName] [nvarchar](50) NULL,
	[ProductNumber] [nvarchar](25) NULL,
	[Color] [nvarchar](15) NULL,
	[Size] [nvarchar](5) NULL,
	[SizeUnitMeasureCode] [nchar](3) NULL,
	[ListPrice] [decimal](30, 2) NULL,
	[StandardCost] [decimal](30, 2) NULL,
	[Weight] [decimal](8, 2) NULL,
	[WeightUnitMeasureCode] [nchar](3) NULL,
	[Class] [nchar](2) NULL,
	[Style] [nchar](2) NULL,
	[ProductSubcategoryKey] [int] NULL,
 CONSTRAINT [PK_dim_ProductPRIMARY] PRIMARY KEY CLUSTERED 
(
	[ProductKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dim_ProductCategory]    Script Date: 4-4-2018 12:01:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dim_ProductCategory](
	[ProductCategoryKey] [int] IDENTITY(1,1) NOT NULL,
	[ProductCategoryAlternateKey] [int] NOT NULL,
	[EnglishProductCategoryName] [nvarchar](50) NOT NULL,
	[SpanishProductCategoryName] [nvarchar](50) NULL,
	[FrenchProductCategoryName] [nvarchar](50) NULL,
 CONSTRAINT [PK_dim_ProductCategoryPRIMARY] PRIMARY KEY CLUSTERED 
(
	[ProductCategoryKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dim_ProductSubcategory]    Script Date: 4-4-2018 12:01:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dim_ProductSubcategory](
	[ProductSubcategoryKey] [int] IDENTITY(1,1) NOT NULL,
	[ProductSubcategoryAlternateKey] [int] NOT NULL,
	[EnglishProductSubcategoryName] [nvarchar](50) NOT NULL,
	[SpanishProductSubcategoryName] [nvarchar](50) NULL,
	[FrenchProductSubcategoryName] [nvarchar](50) NULL,
	[ProductKey] [int] NULL,
 CONSTRAINT [PK_dim_ProductSubcategoryPRIMARY] PRIMARY KEY CLUSTERED 
(
	[ProductSubcategoryKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dim_SalesTerritory]    Script Date: 4-4-2018 12:01:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dim_SalesTerritory](
	[SalesTerritoryKey] [int] IDENTITY(1,1) NOT NULL,
	[SalesTerritoryAlternateKey] [int] NOT NULL,
	[SalesTerritoryName] [nvarchar](50) NOT NULL,
	[SalesTerritoryCountryRegionCode] [nvarchar](3) NOT NULL,
	[SalesTerritoryGroup] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_dim_SalesTerritory] PRIMARY KEY CLUSTERED 
(
	[SalesTerritoryKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dim_Store]    Script Date: 4-4-2018 12:01:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dim_Store](
	[StoreKey] [bigint] IDENTITY(1,1) NOT NULL,
	[StoreAlternateKey] [int] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[AddressType] [nvarchar](50) NOT NULL,
	[AddressLine1] [nvarchar](60) NOT NULL,
	[AddressLine2] [nvarchar](60) NULL,
	[City] [nvarchar](30) NOT NULL,
	[StateProvinceName] [nvarchar](50) NOT NULL,
	[PostalCode] [nvarchar](15) NOT NULL,
	[CountryRegionName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_dim_store_StoreKey] PRIMARY KEY CLUSTERED 
(
	[StoreKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[errfact_ResellerSalesErrors]    Script Date: 4-4-2018 12:01:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[errfact_ResellerSalesErrors](
	[Flat File Source Error Output Column] [varchar](max) NULL,
	[ErrorCode] [int] NULL,
	[ErrorColumn] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[fact_InternetSales]    Script Date: 4-4-2018 12:01:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[fact_InternetSales](
	[TotalDue] [decimal](30, 4) NULL,
	[SubTotal] [decimal](30, 4) NULL,
	[TaxAmt] [decimal](30, 4) NULL,
	[Freight] [decimal](30, 4) NULL,
	[ProductKey] [int] NULL,
	[CustomerKey] [int] NULL,
	[SalesTerritoryKey] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[fact_ResellerSales]    Script Date: 4-4-2018 12:01:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[fact_ResellerSales](
	[TotalDue] [decimal](30, 4) NULL,
	[SubTotal] [decimal](30, 4) NULL,
	[TaxAmt] [decimal](30, 4) NULL,
	[Freight] [decimal](30, 4) NULL,
	[ProductKey] [int] NULL,
	[StoreKey] [bigint] NULL,
	[SalesTerritoryKey] [int] NULL,
	[OrderDate] [date] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[factAgg_InternetSales]    Script Date: 4-4-2018 12:01:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[factAgg_InternetSales](
	[TotalDue] [decimal](30, 4) NULL,
	[SubTotal] [decimal](30, 4) NULL,
	[TaxAmt] [decimal](30, 4) NULL,
	[Freight] [decimal](30, 4) NULL,
	[ProductCategoryKey] [int] NULL,
	[CustomerKey] [int] NULL,
	[SalesTerritoryKey] [int] NULL
) ON [PRIMARY]
GO
