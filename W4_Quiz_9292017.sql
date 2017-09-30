use AdventureWorks2012;

/*a.	Show First name and last name of employees whose job title is “Sales Representative”, ranking from oldest to youngest. You may use HumanResources.Employee table and Person.Person table. (14 rows)*/
SELECT FirstName, LastName, E.JobTitle, Person.Person.BusinessEntityID, E.BirthDate
FROM HumanResources.Employee AS E
Join Person.Person ON Person.Person.BusinessEntityID=E.BusinessEntityID
WHERE JobTitle='Sales Representative'
ORDER BY E.BirthDate ASC;

/*b.	Find out all the products which sold more than $5000 in total. Show product ID and name and total amount collected after selling the products. You may use LineTotal from Sales.SalesOrderDetail table and Production.Product table. (254 rows)*/
SELECT P.Name as 'Product Name', P.ProductID, SUM(S.LineTotal) as Collection
FROM Sales.SalesOrderDetail AS S
JOIN Production.Product AS P ON P.ProductID=S.ProductID
GROUP BY P.ProductID, P.Name
HAVING sum(S.LineTotal)>5000

/*c.	Show BusinessEntityID, territory name and SalesYTD of all sales persons whose SalesYTD is greater than $500,000, regardless of whether they are assigned a territory. You may use Sales.SalesPerson table and Sales.SalesTerritory table. (16 rows)*/
SELECT Sale.BusinessEntityID, T.Name AS 'Territory Name', T.SalesYTD
FROM Sales.SalesPerson as Sale
LEFT JOIN Sales.SalesTerritory as T on T.TerritoryID=Sale.TerritoryID
WHERE  Sale.SalesYTD>500000
ORDER BY Sale.SalesYTD ASC;

/*Alternate answer with same result*/
SELECT Sale.BusinessEntityID, T.Name AS 'Territory Name', Sale.SalesYTD
FROM Sales.SalesTerritory AS T
RIGHT JOIN Sales.SalesPerson as Sale on T.TerritoryID=Sale.TerritoryID
WHERE  Sale.SalesYTD>500000
ORDER BY Sale.SalesYTD ASC;

/*d.	Show the sales order ID of those orders in the year 2008 of which the total due is great-ER than the average total due of all the orders of the same year. (3200 rows)*/
SELECT SalesOrderID, OrderDate, AVG(TotalDue) AS 'Avg Total Due'
FROM Sales.SalesOrderHeader 
WHERE YEAR (OrderDate) = 2008 AND TotalDue>
	(SELECT AVG(TotalDue) AS 'Avg Total Due'
	FROM Sales.SalesOrderHeader
	WHERE YEAR (OrderDate) = 2008 )
GROUP BY SalesOrderID, OrderDate, TotalDue
ORDER BY TotalDue ASC;