-- Sum Orders (Price*Quantity) by Every Month
SELECT t001.Year
	  ,t001.Month
      ,SUM(t001.UnitPrice*t001.Quantity) AS SumOrder
  FROM 
	(
	SELECT DATEPART(MM, PickingCompletedWhen) AS Month
		,DATEPART(YYYY, PickingCompletedWhen) AS Year
		,UnitPrice
		,Quantity
	FROM [WideWorldImporters].[Sales].[OrderLines]
	WHERE PickingCompletedWhen IS NOT NULL	-- Delete Orders with null-date
	) AS t001
  GROUP BY Year,Month
  HAVING SUM(t001.UnitPrice*t001.Quantity) > 10000
  ORDER BY Year,Month

-- ver 2
SELECT DATEPART(YYYY, PickingCompletedWhen) AS Year
	  ,DATEPART(MM, PickingCompletedWhen) AS Month
      ,SUM(UnitPrice*Quantity) AS SumOrder
  FROM [WideWorldImporters].[Sales].[OrderLines]
	WHERE PickingCompletedWhen IS NOT NULL	-- Delete Orders with null-date
  GROUP BY DATEPART(YYYY, PickingCompletedWhen),DATEPART(MM, PickingCompletedWhen)
  HAVING SUM(UnitPrice*Quantity) > 10000
  ORDER BY Year,Month