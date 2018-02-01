--Table schema
--CREATE TABLE [dbo].[FactInternetSales] (
--    [ProductKey]            INT           NOT NULL,
--    [OrderDateKey]          INT           NOT NULL,
--    [DueDateKey]            INT           NOT NULL,
--    [ShipDateKey]           INT           NOT NULL,
--    [CustomerKey]           INT           NOT NULL,
--    [PromotionKey]          INT           NOT NULL,
--    [CurrencyKey]           INT           NOT NULL,
--    [SalesTerritoryKey]     INT           NOT NULL,
--    [SalesOrderNumber]      NVARCHAR (20) NOT NULL,
--    [SalesOrderLineNumber]  TINYINT       NOT NULL,
--    [RevisionNumber]        TINYINT       NOT NULL,
--    [OrderQuantity]         SMALLINT      NOT NULL,
--    [UnitPrice]             MONEY         NOT NULL,
--    [ExtendedAmount]        MONEY         NOT NULL,
--    [UnitPriceDiscountPct]  FLOAT (53)    NOT NULL,
--    [DiscountAmount]        FLOAT (53)    NOT NULL,
--    [ProductStandardCost]   MONEY         NOT NULL,
--    [TotalProductCost]      MONEY         NOT NULL,
--    [SalesAmount]           MONEY         NOT NULL,
--    [TaxAmt]                MONEY         NOT NULL,
--    [Freight]               MONEY         NOT NULL,
--    [CarrierTrackingNumber] NVARCHAR (25) NULL,
--    [CustomerPONumber]      NVARCHAR (25) NULL,
--    [OrderDate]             DATETIME      NULL,
--    [DueDate]               DATETIME      NULL,
--    [ShipDate]              DATETIME      NULL,
--    CONSTRAINT [PK_FactInternetSales_SalesOrderNumber_SalesOrderLineNumber] PRIMARY KEY CLUSTERED ([SalesOrderNumber] ASC, [SalesOrderLineNumber] ASC),
--    CONSTRAINT [FK_FactInternetSales_DimCurrency] FOREIGN KEY ([CurrencyKey]) REFERENCES [dbo].[DimCurrency] ([CurrencyKey]),
--    CONSTRAINT [FK_FactInternetSales_DimCustomer] FOREIGN KEY ([CustomerKey]) REFERENCES [dbo].[DimCustomer] ([CustomerKey]),
--    CONSTRAINT [FK_FactInternetSales_DimDate] FOREIGN KEY ([OrderDateKey]) REFERENCES [dbo].[DimDate] ([DateKey]),
--    CONSTRAINT [FK_FactInternetSales_DimDate1] FOREIGN KEY ([DueDateKey]) REFERENCES [dbo].[DimDate] ([DateKey]),
--    CONSTRAINT [FK_FactInternetSales_DimDate2] FOREIGN KEY ([ShipDateKey]) REFERENCES [dbo].[DimDate] ([DateKey]),
--    CONSTRAINT [FK_FactInternetSales_DimProduct] FOREIGN KEY ([ProductKey]) REFERENCES [dbo].[DimProduct] ([ProductKey]),
--    CONSTRAINT [FK_FactInternetSales_DimPromotion] FOREIGN KEY ([PromotionKey]) REFERENCES [dbo].[DimPromotion] ([PromotionKey]),
--    CONSTRAINT [FK_FactInternetSales_DimSalesTerritory] FOREIGN KEY ([SalesTerritoryKey]) REFERENCES [dbo].[DimSalesTerritory] ([SalesTerritoryKey])
--);

--Check for price variations
SELECT * FROM dbo.FactInternetSales
WHERE UnitPrice != ExtendedAmount

SELECT * FROM dbo.FactInternetSales
WHERE DiscountAmount != 0

SELECT UnitPrice, (UnitPrice - (ProductStandardCost + TaxAmt + Freight)) AS CostAnalysis 
FROM dbo.FactInternetSales
--WHERE DiscountAmount != 0

--Roll Up Orders
SELECT SalesOrderNumber, COUNT(SalesOrderNumber) orderCount,
SUM(UnitPrice) AS orderUP, 
SUM(ProductStandardCost) AS orderPSC, 
SUM(TaxAmt) AS orderTax, 
SUM(Freight) AS orderFreight 
FROM dbo.FactInternetSales
GROUP BY SalesOrderNumber


SELECT * FROM dbo.FactInternetSales
WHERE SalesOrderNumber = 'SO67527'

--Two Sales Tables
SELECT SalesOrderNumber, COUNT(SalesOrderNumber) orderCount,
SUM(UnitPrice) AS orderUP, 
SUM(ProductStandardCost) AS orderPSC, 
SUM(TaxAmt) AS orderTax, 
SUM(Freight) AS orderFreight 
FROM dbo.FactResellerSales --AS inet
GROUP BY SalesOrderNumber

SELECT SalesOrderNumber, COUNT(SalesOrderNumber) orderCount,
SUM(UnitPrice) AS orderUP, 
SUM(ProductStandardCost) AS orderPSC, 
SUM(TaxAmt) AS orderTax, 
SUM(Freight) AS orderFreight 
FROM dbo.FactInternetSales --AS inet
GROUP BY SalesOrderNumber
UNION
SELECT SalesOrderNumber, COUNT(SalesOrderNumber) orderCount,
SUM(UnitPrice) AS orderUP, 
SUM(ProductStandardCost) AS orderPSC, 
SUM(TaxAmt) AS orderTax, 
SUM(Freight) AS orderFreight 
FROM dbo.FactResellerSales --AS inet
GROUP BY SalesOrderNumber

SELECT * FROM dbo.FactInternetSales
WHERE SalesOrderNumber = 'SO67527'

SELECT * FROM dbo.FactResellerSales
WHERE SalesOrderNumber = 'SO67527'

--No Crossover of SalesOrders
SELECT * FROM dbo.FactInternetSales
WHERE SalesOrderNumber IN (SELECT SalesOrderNumber FROM dbo.FactResellerSales)

--No understanding of price add ups
SELECT * FROM dbo.FactInternetSales
WHERE SalesOrderNumber = 'SO67527'