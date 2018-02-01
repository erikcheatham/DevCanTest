CREATE PROCEDURE [dbo].[getOrderSearchbyDatesOrCustName]
	@OrderDate DATE = null,
	@DueDate DATE = null,
	@ShipDate DATE = null,
	@CustID INT = null
AS
BEGIN
	SET ANSI_NULLS ON
	SET QUOTED_IDENTIFIER ON
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
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