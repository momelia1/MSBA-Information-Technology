/*In Class Activity F2F Activity 1*/
Use Adventureworks2012;
SELECT jobtitle, count(businessentityid) as number_of_employees
from HumanResources.employee
where currentflag = 1
group by JobTitle
order by count(businessentityid) 
desc;

/*Activity 2*/
Use Adventureworks2012;
SELECT jobtitle, count(businessentityid) as number_of_employees
from HumanResources.employee
where currentflag = 1
group by JobTitle
having count(businessentityid) > 1
order by count(businessentityid) 
desc;

/*Activity 3 as practice*/
/*For each product, show its ProductID and Name (from the ProductionProduct table) 
and the location of its inventory (from the Product.Location table) 
and amount of inventory held at that location (from the Production.ProductInventory table).*/
SELECT p.ProductID, 
		p.Name AS Product_Name, 
		l.Name as Location_name,
		i.Quantity 
FROM Production.Product AS p 
		JOIN Production.ProductInventory AS I 
			ON p.ProductID=i.productid
		Join Production.Location AS l 
			ON l.LocationID = i.LocationID;

/*Activity 4 as practice*/  
/*4. Find the product model IDs that have no product associated with them. 
	To do this, first do an outer join between the Production.Product table and the Production.ProductModel table in such a way that the ID from the ProductModel table always shows, even if there is no product associate with it.  
	Then, add a WHERE clause to specify that the ProductID IS NULL */
SELECT M.ProductModelID,
		M.Name as Model_name,
		P.ProductID,
		P.Name as Product_Name
FROM Production.Product as P
		full outer join Production.ProductModel as M
			on P.ProductModelID = M.ProductModelID
WHERE p.ProductID is null;