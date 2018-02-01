CREATE PROCEDURE [dbo].[getOrderSearchbyDatesAndCustName]
	@OrderDate DATE,
	@DueDate DATE,
	@ShipDate DATE,
	@CustID INT,
	@CustName NVARCHAR(MAX) OUT,
	@AccountNumber NVARCHAR(MAX) OUT,
	@ShipToAddress NVARCHAR(MAX) OUT,
	@ShipMethod NVARCHAR(MAX) OUT,
	@SubTotal MONEY OUT,
	@Tax MONEY OUT,
	@Freight MONEY OUT,
	@Total MONEY OUT
AS
BEGIN
	SELECT 
	@CustName = CASE 
WHEN p.MiddleName IS NULL THEN (p.FirstName + ' ' + p.LastName)
WHEN p.MiddleName IS NOT NULL THEN (p.FirstName + ' ' + p.MiddleName + ' ' + p.LastName) 
END,
	@AccountNumber = soh.AccountNumber,
	--sc.CustomerID,
	--sc.PersonID,
	--soh.OrderDate,
	--soh.DueDate,
	--soh.ShipDate,
	@ShipToAddress = CASE
WHEN a.AddressLine2 IS NULL THEN (a.AddressLine1 + ' ' + a.City + ' ' + sp.StateProvinceCode + ' ' + a.PostalCode)
ELSE (a.AddressLine1 + ' ' + a.AddressLine2 + ' ' + a.City + ' ' + sp.StateProvinceCode + ' ' + a.PostalCode)
END,
	@ShipMethod = psm.Name,
	@SubTotal = soh.SubTotal,
	@Tax = soh.TaxAmt,
	@Freight = soh.Freight,
	@Total = soh.TotalDue
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