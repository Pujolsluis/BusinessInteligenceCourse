SELECT [ProductID]
		,[ProductName]
		,sup.[SupplierID]
		,sup.CompanyName AS SupplierCompanyName
		,sup.Country AS SupplierCountry
		,sup.Region AS SupplierRegion
		,cat.[CategoryID]
		,cat.[CategoryName]
		,cat.[Description] AS CategoryDescription
		,[QuantityPerUnit]
		,[UnitPrice]
		,[UnitsInStock]
		,[UnitsOnOrder]
		,[ReorderLevel]
		,CASE WHEN [Discontinued] = 0 THEN 'No' ELSE 'Yes' END AS Discontinued
		INTO [NorthwindDWH].dbo.DimProducts
FROM Products prod INNER JOIN [dbo].[Categories] cat
	ON prod.CategoryID = cat.CategoryID
	INNER JOIN [dbo].[Suppliers] sup
	ON prod.SupplierID = sup.SupplierID

------------------------------------------------------------------------


SELECT [CustomerID]
	   ,[CompanyName]
	   ,[City]
	   ,[Region]
	   ,[PostalCode]
	   ,[Country]
	   INTO [NorthwindDWH].dbo.DimCustomers
	   FROM Customers

------------------------------------------------------------------------

SELECT emp.EmployeeID
	   ,emp.LastName
	   ,emp.FirstName
	   ,emp.LastName + ' ' + emp.FirstName AS CompleteName
	   ,emp.BirthDate
	   ,emp.HireDate
	   ,emp.City
	   ,emp.Region
	   ,emp.Country
	   ,CAST(emp.ReportsTo AS VARCHAR(10)) AS ReportsTo
	   ,ISNULL(E.LastName + ' ' + E.FirstName, 'None') AS ReportsToCompleteName
	   INTO [NorthwindDWH].dbo.DimEmployees
FROM Employees emp LEFT JOIN Employees AS E
	 ON emp.ReportsTo = E.EmployeeID

------------------------------------------------------------------------

SELECT ShipperID, CompanyName 
INTO [NorthwindDWH].dbo.DimShippers
FROM Shippers

------------------------------------------------------------------------

SELECT 
	ord.OrderDate AS DATEKEY
	,ord.CustomerID
	,ord.EmployeeID
	,ord.ShipVia AS ShipperID
	,ordDetails.ProductID
	,ord.OrderID
	,(ordDetails.UnitPrice * ordDetails.Quantity * (1 - ordDetails.Discount)) SubTotal
	, ordDetails.Quantity
	INTO [NorthwindDWH].dbo.FactOrders
FROM Orders ord INNER JOIN [Order Details] ordDetails
	ON ord.OrderID = ordDetails.OrderID

------------------------------------------------------------------------

SELECT DISTINCT OrderDate
	,YEAR(OrderDate) AS 'YEAR'
	,MONTH(OrderDate) AS 'Month'
	,DATENAME(month, orderDate) AS 'MonthName'
	,DATEPART(dw, OrderDate) AS 'DayOfWeek'
	,DATENAME(dw, OrderDate) AS 'DayOfWeekName'
	,DATEPART(Q, OrderDate) AS 'Quarter'
	,CASE WHEN MONTH(OrderDate) < 7 THEN 'H1' ELSE 'H2' END AS 'Semester'
	INTO [NorthwindDWH].dbo.DimDate
FROM Orders

------------------------------------------------------------------------

