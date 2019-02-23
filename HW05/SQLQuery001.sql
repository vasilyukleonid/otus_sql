-- Average Price
SELECT [Description]
      ,AVG(UnitPrice) AS AveragePrice
  FROM [WideWorldImporters].[Sales].[OrderLines]
  GROUP BY Description

-- Sum Orders (Price*Quantity) by Month
SELECT t001.Year
      ,t001.Month
	  ,SUM(t001.UnitPrice*t001.Quantity) AS SumOrder
  FROM 
	(
	SELECT DATEPART(MM, O.OrderDate) AS Month
		,DATEPART(YY, O.OrderDate) AS Year
		,UnitPrice
		,Quantity
	FROM [WideWorldImporters].[Sales].[OrderLines] AS OL
		JOIN [Sales].[Orders] AS O
		ON OL.OrderID = O.OrderID
	WHERE O.OrderDate IS NOT NULL	-- Delete Orders with null-date
	) AS t001
  GROUP BY t001.Year,t001.Month
  ORDER BY t001.Year,t001.Month