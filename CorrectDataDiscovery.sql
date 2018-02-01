--ORder Deatil ([getOrderDetailbySalesID])
SELECT * FROM Sales.SalesOrderDetail

SELECT Sales.SalesOrderDetail.SalesOrderID,
OrderQty,
SUM(UnitPrice) AS orderPrice,
SUM(UnitPriceDiscount) AS orderDiscount,
LineTotal
FROM Sales.SalesOrderDetail
GROUP BY SalesOrderID,
OrderQty,
LineTotal

--Add Join
SELECT s.SalesOrderID,
p.Name AS [Name],
p.ProductID AS [Product Number],
OrderQty AS [Quantity],
SUM(UnitPrice) AS [Unit Price],
SUM(UnitPriceDiscount) AS [Discount],
LineTotal
FROM Sales.SalesOrderDetail AS s
JOIN Production.Product AS p
ON p.ProductID = s.ProductID
GROUP BY SalesOrderID,
OrderQty,
LineTotal

--Ugh
SELECT * FROM Production.Product
WHERE StandardCost != ListPrice

--Find Discount
SELECT * FROM Sales.SalesOrderDetail
WHERE UnitPriceDiscount != 0


SELECT MAX(s.SalesOrderID) AS [SalesOrderID],
p.ProductID,
p.Name AS [Name],
p.ProductNumber AS [Product Number],
OrderQty AS [Quantity],
SUM(UnitPrice) AS [Unit Price],
SUM(UnitPriceDiscount) AS [Discount],
SUM(LineTotal) AS [Line Total]
FROM Sales.SalesOrderDetail AS s
JOIN Production.Product AS p
ON p.ProductID = s.ProductID AND s.SalesOrderID = '50749'
--WHERE s.SalesOrderID = '50749'
GROUP BY --SalesOrderID,
p.ProductID,
p.Name,
p.ProductNumber,
OrderQty

--Made it too complicated
SELECT s.SalesOrderID,
p.Name,
p.ProductNumber,
OrderQty,
UnitPrice AS [Unit Price],
UnitPriceDiscount AS [Discount],
LineTotal AS [Line Total]
FROM Sales.SalesOrderDetail AS s
LEFT JOIN Production.Product AS p
ON p.ProductID = s.ProductID
WHERE s.SalesOrderID = '43659'
--GROUP BY SalesOrderID,
--OrderQty,
--LineTotal



--ORder Search ([getOrderSearchbyDatesAndCustName])
SELECT 
	p.FirstName,
	p.LastName,
	sc.CustomerID,
	sc.PersonID,
	soh.OrderDate,
	soh.DueDate,
	soh.ShipDate,
	sc.AccountNumber,
	psm.Name,
	soh.SubTotal,
	soh.TaxAmt,
	soh.Freight,
	soh.TotalDue
	FROM Sales.SalesOrderDetail AS sod
	JOIN Sales.SalesOrderHeader AS soh
	ON soh.SalesOrderID = sod.SalesOrderID
	JOIN Purchasing.ShipMethod AS psm
	ON psm.ShipMethodID = soh.ShipMethodID
	JOIN Sales.Customer AS sc
	ON soh.CustomerID = sc.CustomerID
	JOIN Person.BusinessEntityContact AS bec
	ON bec.PersonID = sc.PersonID
	JOIN Person.Person AS p
	ON p.BusinessEntityID = bec.PersonID
	ORDER BY sc.PersonID
	
--All Records Now
	SELECT 
	p.FirstName,
	p.LastName,
	a.AddressLine1,
	a.AddressLine2,
	a.City,
	sp.StateProvinceCode,
	a.PostalCode,
	sc.CustomerID,
	sc.PersonID,
	soh.OrderDate,
	soh.DueDate,
	soh.ShipDate,
	sc.AccountNumber,
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

	USE AdventureWorks2016
--Concatenation
SELECT
CASE 
WHEN p.MiddleName IS NULL THEN (p.FirstName + ' ' + p.LastName)
WHEN p.MiddleName IS NOT NULL THEN (p.FirstName + ' ' + p.MiddleName + ' ' + p.LastName) 
END,
--LTRIM(RTRIM(CONCAT(COALESCE(p.FirstName,''),' ',COALESCE(p.MiddleName,''),' ',COALESCE(p.LastName,'')))),
	soh.AccountNumber,
CASE
WHEN a.AddressLine2 IS NULL THEN (a.AddressLine1 + ' ' + a.City + ' ' + sp.StateProvinceCode + ' ' + a.PostalCode)
ELSE (a.AddressLine1 + ' ' + a.AddressLine2 + ' ' + a.City + ' ' + sp.StateProvinceCode + ' ' + a.PostalCode)
END,
	sc.CustomerID,
	sc.PersonID,
	soh.OrderDate,
	soh.DueDate,
	soh.ShipDate,
	sc.AccountNumber,
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
	WHERE soh.CustomerID = '29825' 
	OR soh.OrderDate = null
	OR soh.DueDate = null
	OR soh.ShipDate = null
