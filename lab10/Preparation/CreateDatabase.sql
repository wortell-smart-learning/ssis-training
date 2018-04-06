CREATE DATABASE BITrainer_SSIS
GO

USE BITrainer_SSIS

GO

CREATE TABLE [dbo].[FactNewSales](
	[SalesOrderNumber] [nvarchar](20) NOT NULL,
	[ProductKey] [int] NOT NULL,
	[OrderDateKey] [date] NULL,
	[DueDateKey] [date] NULL,
	[ShipDateKey] [date] NULL,
	[CustomerKey] [int] NOT NULL,
	[SalesTerritoryKey] [int] NOT NULL,
	[RevisionNumber] [tinyint] NOT NULL,
	[OrderQuantity] [smallint] NOT NULL,
	[UnitPrice] [money] NOT NULL,
	[ExtendedAmount] [money] NOT NULL,
	[UnitPriceDiscountPct] [float] NOT NULL,
	[DiscountAmount] [float] NOT NULL,
	[SalesAmount] [money] NOT NULL,
	[TaxAmt] [money] NOT NULL,
	[Freight] [money] NOT NULL,
	[CarrierTrackingNumber] [nvarchar](25) NULL,
	[CustomerPONumber] [nvarchar](25) NULL
)
GO

CREATE TABLE [dbo].[FactOldSales](
	[ProductKey] [int] NOT NULL,
	[OrderDateKey] [date] NOT NULL,
	[DueDateKey] [date] NOT NULL,
	[ShipDateKey] [date] NOT NULL,
	[SalesOrderNumber] [nvarchar](20) NOT NULL,
	[RevisionNumber] [tinyint] NULL,
	[OrderQuantity] [smallint] NULL,
	[UnitPrice] [money] NULL,
	[ExtendedAmount] [money] NULL,
	[UnitPriceDiscountPct] [float] NULL,
	[DiscountAmount] [float] NULL,
	[SalesAmount] [money] NULL,
	[TaxAmt] [money] NULL,
	[Freight] [money] NULL,
	[CarrierTrackingNumber] [nvarchar](25) NULL,
	[SalesTerritoryKey] [int] NOT NULL
)

GO

CREATE TABLE [dbo].[dimProduct](
	[ProductKey] [int] IDENTITY(1,1) NOT NULL,
	[Product_SourceID] [int] NOT NULL,
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
	) 
)


GO

CREATE TABLE [dbo].[dimCustomer](
	[CustomerKey] [int] IDENTITY(1,1) NOT NULL,
	[Customer_SourceID] [int] NOT NULL,
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
	) 
)

GO

CREATE TABLE [dbo].[dimSalesTerritory](
	[SalesTerritoryKey] [int] IDENTITY(1,1) NOT NULL,
	[SalesTerritory_SourceID] [int] NOT NULL,
	[SalesTerritoryName] [nvarchar](50) NOT NULL,
	[SalesTerritoryCountryRegionCode] [nvarchar](3) NOT NULL,
	[SalesTerritoryGroup] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_dim_SalesTerritory] PRIMARY KEY CLUSTERED 
(
	[SalesTerritoryKey] ASC
)
)


GO

DECLARE @StartDate DATE = '20000101', @NumberOfYears INT = 30;

-- prevent set or regional settings from interfering with 
-- interpretation of dates / literals

SET DATEFIRST 7;
SET DATEFORMAT mdy;
SET LANGUAGE US_ENGLISH;

DECLARE @CutoffDate DATE = DATEADD(YEAR, @NumberOfYears, @StartDate);

-- this is just a holding table for intermediate calculations:

CREATE TABLE #dim
(
  [date]       DATE PRIMARY KEY, 
  [day]        AS DATEPART(DAY,      [date]),
  [month]      AS DATEPART(MONTH,    [date]),
  FirstOfMonth AS CONVERT(DATE, DATEADD(MONTH, DATEDIFF(MONTH, 0, [date]), 0)),
  [MonthName]  AS DATENAME(MONTH,    [date]),
  [week]       AS DATEPART(WEEK,     [date]),
  [ISOweek]    AS DATEPART(ISO_WEEK, [date]),
  [DayOfWeek]  AS DATEPART(WEEKDAY,  [date]),
  [quarter]    AS DATEPART(QUARTER,  [date]),
  [year]       AS DATEPART(YEAR,     [date]),
  FirstOfYear  AS CONVERT(DATE, DATEADD(YEAR,  DATEDIFF(YEAR,  0, [date]), 0)),
  Style112     AS CONVERT(CHAR(8),   [date], 112),
  Style101     AS CONVERT(CHAR(10),  [date], 101)
);

-- use the catalog views to generate as many rows as we need

INSERT #dim([date]) 
SELECT d
FROM
(
  SELECT d = DATEADD(DAY, rn - 1, @StartDate)
  FROM 
  (
    SELECT TOP (DATEDIFF(DAY, @StartDate, @CutoffDate)) 
      rn = ROW_NUMBER() OVER (ORDER BY s1.[object_id])
    FROM sys.all_objects AS s1
    CROSS JOIN sys.all_objects AS s2
    -- on my system this would support > 5 million days
    ORDER BY s1.[object_id]
  ) AS x
) AS y;

GO

IF OBJECT_ID('dbo.Dim_Date', 'U') IS NOT NULL
	DROP TABLE dbo.Dim_Date

CREATE TABLE dbo.Dim_Date
(
  DateKey             INT         NOT NULL PRIMARY KEY,
  [Date]              DATE        NOT NULL,
  [Day]               TINYINT     NOT NULL,
  DaySuffix           CHAR(2)     NOT NULL,
  [Weekday]           TINYINT     NOT NULL,
  WeekDayName         VARCHAR(10) NOT NULL,
  IsWeekend           BIT         NOT NULL,
  IsHoliday           BIT         NOT NULL,
  HolidayText         VARCHAR(64) SPARSE,
  DOWInMonth          TINYINT     NOT NULL,
  [DayOfYear]         SMALLINT    NOT NULL,
  WeekOfMonth         TINYINT     NOT NULL,
  WeekOfYear          TINYINT     NOT NULL,
  ISOWeekOfYear       TINYINT     NOT NULL,
  [Month]             TINYINT     NOT NULL,
  [MonthName]         VARCHAR(10) NOT NULL,
  [Quarter]           TINYINT     NOT NULL,
  QuarterName         VARCHAR(6)  NOT NULL,
  [Year]              INT         NOT NULL,
  MMYYYY              CHAR(6)     NOT NULL,
  MonthYear           CHAR(7)     NOT NULL,
  FirstDayOfMonth     DATE        NOT NULL,
  LastDayOfMonth      DATE        NOT NULL,
  FirstDayOfQuarter   DATE        NOT NULL,
  LastDayOfQuarter    DATE        NOT NULL,
  FirstDayOfYear      DATE        NOT NULL,
  LastDayOfYear       DATE        NOT NULL,
  FirstDayOfNextMonth DATE        NOT NULL,
  FirstDayOfNextYear  DATE        NOT NULL
);
GO

INSERT dbo.Dim_Date WITH (TABLOCKX)
SELECT
  DateKey       = CONVERT(INT, Style112),
  [Date]        = [date],
  [Day]         = CONVERT(TINYINT, [day]),
  DaySuffix     = CONVERT(CHAR(2), CASE WHEN [day] / 10 = 1 THEN 'th' ELSE 
                  CASE RIGHT([day], 1) WHEN '1' THEN 'st' WHEN '2' THEN 'nd' 
	              WHEN '3' THEN 'rd' ELSE 'th' END END),
  [Weekday]     = CONVERT(TINYINT, [DayOfWeek]),
  [WeekDayName] = CONVERT(VARCHAR(10), DATENAME(WEEKDAY, [date])),
  [IsWeekend]   = CONVERT(BIT, CASE WHEN [DayOfWeek] IN (1,7) THEN 1 ELSE 0 END),
  [IsHoliday]   = CONVERT(BIT, 0),
  HolidayText   = CONVERT(VARCHAR(64), NULL),
  [DOWInMonth]  = CONVERT(TINYINT, ROW_NUMBER() OVER 
                  (PARTITION BY FirstOfMonth, [DayOfWeek] ORDER BY [date])),
  [DayOfYear]   = CONVERT(SMALLINT, DATEPART(DAYOFYEAR, [date])),
  WeekOfMonth   = CONVERT(TINYINT, DENSE_RANK() OVER 
                  (PARTITION BY [year], [month] ORDER BY [week])),
  WeekOfYear    = CONVERT(TINYINT, [week]),
  ISOWeekOfYear = CONVERT(TINYINT, ISOWeek),
  [Month]       = CONVERT(TINYINT, [month]),
  [MonthName]   = CONVERT(VARCHAR(10), [MonthName]),
  [Quarter]     = CONVERT(TINYINT, [quarter]),
  QuarterName   = CONVERT(VARCHAR(6), CASE [quarter] WHEN 1 THEN 'First' 
                  WHEN 2 THEN 'Second' WHEN 3 THEN 'Third' WHEN 4 THEN 'Fourth' END), 
  [Year]        = [year],
  MMYYYY        = CONVERT(CHAR(6), LEFT(Style101, 2)    + LEFT(Style112, 4)),
  MonthYear     = CONVERT(CHAR(7), LEFT([MonthName], 3) + LEFT(Style112, 4)),
  FirstDayOfMonth     = FirstOfMonth,
  LastDayOfMonth      = MAX([date]) OVER (PARTITION BY [year], [month]),
  FirstDayOfQuarter   = MIN([date]) OVER (PARTITION BY [year], [quarter]),
  LastDayOfQuarter    = MAX([date]) OVER (PARTITION BY [year], [quarter]),
  FirstDayOfYear      = FirstOfYear,
  LastDayOfYear       = MAX([date]) OVER (PARTITION BY [year]),
  FirstDayOfNextMonth = DATEADD(MONTH, 1, FirstOfMonth),
  FirstDayOfNextYear  = DATEADD(YEAR,  1, FirstOfYear)
FROM #dim
OPTION (MAXDOP 1);

;WITH x AS 
(
  SELECT DateKey, [Date], IsHoliday, HolidayText, FirstDayOfYear,
    DOWInMonth, [MonthName], [WeekDayName], [Day],
    LastDOWInMonth = ROW_NUMBER() OVER 
    (
      PARTITION BY FirstDayOfMonth, [Weekday] 
      ORDER BY [Date] DESC
    )
  FROM dbo.Dim_Date
)
UPDATE x SET IsHoliday = 1, HolidayText = CASE
  WHEN ([Date] = FirstDayOfYear) 
    THEN 'New Year''s Day'
  WHEN ([DOWInMonth] = 3 AND [MonthName] = 'January' AND [WeekDayName] = 'Monday')
    THEN 'Martin Luther King Day'    -- (3rd Monday in January)
  WHEN ([DOWInMonth] = 3 AND [MonthName] = 'February' AND [WeekDayName] = 'Monday')
    THEN 'President''s Day'          -- (3rd Monday in February)
  WHEN ([LastDOWInMonth] = 1 AND [MonthName] = 'May' AND [WeekDayName] = 'Monday')
    THEN 'Memorial Day'              -- (last Monday in May)
  WHEN ([MonthName] = 'July' AND [Day] = 4)
    THEN 'Independence Day'          -- (July 4th)
  WHEN ([DOWInMonth] = 1 AND [MonthName] = 'September' AND [WeekDayName] = 'Monday')
    THEN 'Labour Day'                -- (first Monday in September)
  WHEN ([DOWInMonth] = 2 AND [MonthName] = 'October' AND [WeekDayName] = 'Monday')
    THEN 'Columbus Day'              -- Columbus Day (second Monday in October)
  WHEN ([MonthName] = 'November' AND [Day] = 11)
    THEN 'Veterans'' Day'            -- Veterans' Day (November 11th)
  WHEN ([DOWInMonth] = 4 AND [MonthName] = 'November' AND [WeekDayName] = 'Thursday')
    THEN 'Thanksgiving Day'          -- Thanksgiving Day (fourth Thursday in November)
  WHEN ([MonthName] = 'December' AND [Day] = 25)
    THEN 'Christmas Day'
  END
WHERE 
  ([Date] = FirstDayOfYear)
  OR ([DOWInMonth] = 3     AND [MonthName] = 'January'   AND [WeekDayName] = 'Monday')
  OR ([DOWInMonth] = 3     AND [MonthName] = 'February'  AND [WeekDayName] = 'Monday')
  OR ([LastDOWInMonth] = 1 AND [MonthName] = 'May'       AND [WeekDayName] = 'Monday')
  OR ([MonthName] = 'July' AND [Day] = 4)
  OR ([DOWInMonth] = 1     AND [MonthName] = 'September' AND [WeekDayName] = 'Monday')
  OR ([DOWInMonth] = 2     AND [MonthName] = 'October'   AND [WeekDayName] = 'Monday')
  OR ([MonthName] = 'November' AND [Day] = 11)
  OR ([DOWInMonth] = 4     AND [MonthName] = 'November' AND [WeekDayName] = 'Thursday')
  OR ([MonthName] = 'December' AND [Day] = 25);

UPDATE d SET IsHoliday = 1, HolidayText = 'Black Friday'
FROM dbo.Dim_Date AS d
INNER JOIN
(
  SELECT DateKey, [Year], [DayOfYear]
  FROM dbo.Dim_Date 
  WHERE HolidayText = 'Thanksgiving Day'
) AS src 
ON d.[Year] = src.[Year] 
AND d.[DayOfYear] = src.[DayOfYear] + 1;

