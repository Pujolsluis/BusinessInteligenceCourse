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
	OrderDate AS DATEKEY
	,CustomerID
	,EmployeeID
	,ShipVia
	,
FROM Orders

