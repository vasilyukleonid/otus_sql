-- Average Price
SELECT [Description]
      ,AVG(UnitPrice) AS AveragePrice
  FROM [WideWorldImporters].[Sales].[OrderLines]
  GROUP BY Description

-- Sum Orders (Price*Quantity) by Month
SELECT t001.MonOrd
      ,SUM(t001.UnitPrice*t001.Quantity) AS SumOrder
  FROM 
	(
	SELECT DATEPART(MM, PickingCompletedWhen) AS MonOrd
		,UnitPrice
		,Quantity
	FROM [WideWorldImporters].[Sales].[OrderLines]
	WHERE PickingCompletedWhen IS NOT NULL	-- Delete Orders with null-date
	) AS t001
  GROUP BY MonOrd
  ORDER BY MonOrd