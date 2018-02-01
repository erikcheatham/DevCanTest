USE [AdventureWorks2016]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[getOrderSearchAutoComplete]
	@text DATE
AS
BEGIN
	SELECT TOP 10
	sc.CustomerID AS CustID,
CASE 
WHEN p.MiddleName IS NULL THEN (p.LastName + ', ' + p.LastName)
WHEN p.MiddleName IS NOT NULL THEN (p.LastName + ', ' + p.FirstName + ' ' + p.MiddleName) 
END AS CustomerName
	FROM Sales.Customer AS sc
	JOIN Person.Person AS p
	ON p.BusinessEntityID = sc.PersonID	
	WHERE p.LastName like @text 
	OR p.FirstName like @text
	OR p.MiddleName like @text

END
GO

USE [AdventureWorks2016]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getOrderSearchbyDatesOrCustName]
	@OrderDate DATE = null,
	@DueDate DATE = null,
	@ShipDate DATE = null,
	@CustID INT = null
AS
BEGIN
	SELECT 
CASE 
WHEN p.MiddleName IS NULL THEN (p.FirstName + ' ' + p.LastName)
WHEN p.MiddleName IS NOT NULL THEN (p.FirstName + ' ' + p.MiddleName + ' ' + p.LastName) 
END AS CustomerName,
	soh.AccountNumber,
	--sc.CustomerID,
	--sc.PersonID,
	--soh.OrderDate,
	--soh.DueDate,
	--soh.ShipDate,
	CASE
WHEN a.AddressLine2 IS NULL THEN (a.AddressLine1 + ' ' + a.City + ' ' + sp.StateProvinceCode + ' ' + a.PostalCode)
ELSE (a.AddressLine1 + ' ' + a.AddressLine2 + ' ' + a.City + ' ' + sp.StateProvinceCode + ' ' + a.PostalCode)
END AS ShipToAddress,
	psm.Name,
	soh.SubTotal,
	soh.TaxAmt,
	soh.Freight,
	soh.TotalDue
	FROM Sales.SalesOrderDetail AS sod
	JOIN Sales.SalesOrderHeader AS soh
	ON soh.SalesOrderID = sod.SalesOrderID
	JOIN Sales.Customer AS sc
	ON soh.CustomerID = sc.CustomerID
	JOIN Person.Person AS p
	ON p.BusinessEntityID = sc.PersonID
	JOIN Person.Address AS a
	ON a.AddressID = soh.ShipToAddressID
	JOIN Person.StateProvince AS sp
	ON sp.StateProvinceID = a.StateProvinceID
	LEFT JOIN Purchasing.ShipMethod AS psm
	ON psm.ShipMethodID = soh.ShipMethodID
	WHERE sc.CustomerID = @CustID 
	OR soh.OrderDate = @OrderDate
	OR soh.DueDate = @DueDate
	OR soh.ShipDate = @ShipDate
END
GO

USE [AdventureWorks2016]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getOrderDetailbySalesID]
	@SalesID INT,
	@ProductName NVARCHAR(MAX) OUT,
	@ProductNumber NVARCHAR(MAX) OUT,
	@OrderQuantity INT OUT,
	@UnitPrice MONEY OUT,
	@UnitPriceDiscount MONEY OUT,
	@LineTotal MONEY OUT
AS
BEGIN
	SELECT 
	--s.SalesOrderID,
	@ProductName = p.Name,
	@ProductNumber = p.ProductNumber,
	@OrderQuantity = OrderQty,
	@UnitPrice = UnitPrice,
	@UnitPriceDiscount = UnitPriceDiscount,
	@LineTotal = LineTotal
	FROM Sales.SalesOrderDetail AS s
	LEFT JOIN Production.Product AS p
	ON p.ProductID = s.ProductID
	WHERE s.SalesOrderID = @SalesID
END
GO
