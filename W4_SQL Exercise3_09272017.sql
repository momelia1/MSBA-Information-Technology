use AdventureWorksDW2012;
/*1, Display number of orders and total sales amount(sum of SalesAmount) of Internet Sales in 1st quarter each year in each country. Note: your result set should produce a total of 18 rows.
Support/Tips:
1. In DimDate table, you can find CalendarYear and CalendarQuarter you may need to use in 'Group By' clause. You also need DateKey to connect the OrderDateKey in FactInternetSales table.
2. 'Where' clause should be always before the 'Group By' clause.
3. All the items in 'Select' clause that are not in any aggregate function should be in 'Group By' clause. */
SELECT COUNT(SalesOrderNumber) as 'Number of Total Orders', 
	SUM(SalesAmount)as TotalSales,  
	CalendarYear,
	SalesTerritoryCountry
FROM FactInternetSales  as s
	 join DimDate as d on s.OrderDateKey = d.DateKey
	 join 	DimSalesTerritory as t on s.SalesTerritoryKey = t.SalesTerritoryKey
WHERE d.CalendarQuarter = 1
GROUP BY CalendarYear, SalesTerritoryCountry;

/*2, Show total reseller sales amount (sum of SalesAmount), calendar quarter of order date, product category name and reseller’s business type by quarter by category and by business type in 2006. Note: your result set should produce a total of 44 rows. */
SELECT SUM (SalesAmount) AS 'Total Sales',
	C.EnglishProductCategoryName,
	R.BusinessType,
	D.CalendarQuarter
FROM FactResellerSales as S
	Join DimProduct AS P ON S.ProductKey=P.ProductKey
	JOIN DimProductSubcategory as Subc ON P.ProductSubcategoryKey=Subc.ProductSubcategoryKey
	JOIN DimProductCategory as C ON C.ProductCategoryKey=Subc.ProductCategoryKey
	JOIN DIMReseller as R ON S.ResellerKey=R.ResellerKey
	JOIN DimDate AS D ON D.DateKey=S.OrderDateKey
WHERE D.CalendarYear=2006
Group BY 
	C.EnglishProductCategoryName,
	R.BusinessType,
	D.CalendarQuarter;
/*3, Based on 2, perform an OLAP operation: slice. In comment, describe how you perform the slicing, i.e. what do you do to what dimension(s)? Why is it a operation of slicing?*/
SELECT SUM (SalesAmount) AS 'Total Sales',
	C.EnglishProductCategoryName,
	R.BusinessType,
	D.CalendarQuarter
FROM FactResellerSales as S
	Join DimProduct AS P ON S.ProductKey=P.ProductKey
	JOIN DimProductSubcategory as Subc ON P.ProductSubcategoryKey=Subc.ProductSubcategoryKey
	JOIN DimProductCategory as C ON C.ProductCategoryKey=Subc.ProductCategoryKey
	JOIN DIMReseller as R ON S.ResellerKey=R.ResellerKey
	JOIN DimDate AS D ON D.DateKey=S.OrderDateKey
WHERE D.CalendarYear=2006 AND D.CalendarQuarter=1
Group BY 
C.EnglishProductCategoryName,
	R.BusinessType,
	D.CalendarQuarter;
	/*The splice I preformed is by time, looking at only the sales in Quarter 1. This is an operational slice since it reduced the number of rows returned and I reduced the dimensions from its original form in question two.*/

/*4, Based on 2, perform an OLAP operation: drill-down. In comment, describe how you perform the drill-down, i.e. what do you do to what dimension(s)? Why is it a operation of drilling-down?*/
SELECT SUM (SalesAmount) AS 'Total Sales',
	P.EnglishProductName,
	R.BusinessType,
	D.CalendarQuarter
FROM FactResellerSales as S
	Join DimProduct AS P ON S.ProductKey=P.ProductKey
	JOIN DIMReseller as R ON S.ResellerKey=R.ResellerKey
	JOIN DimDate AS D ON D.DateKey=S.OrderDateKey
WHERE D.CalendarYear=2006
Group BY 
P.EnglishProductName,
	R.BusinessType,
	D.CalendarQuarter;
/*The drill down is looking at specific categories, I selected more detail in the product name, by removing several join functions. This operation is drilling down because I am looking at a more granular level of detail in the data. I have many more rows of data compared to question two.  */