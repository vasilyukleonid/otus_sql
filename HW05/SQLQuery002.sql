-- Sum Orders (Price*Quantity) by Every Month
SELECT t001.YOrd
	  ,t001.MonOrd
      ,SUM(t001.UnitPrice*t001.Quantity) AS SumOrder
  FROM 
	(
	SELECT DATEPART(MM, PickingCompletedWhen) AS MonOrd
		,DATEPART(YYYY, PickingCompletedWhen) AS YOrd
		,UnitPrice
		,Quantity
	FROM [WideWorldImporters].[Sales].[OrderLines]
	WHERE PickingCompletedWhen IS NOT NULL	-- Delete Orders with null-date
	) AS t001
  GROUP BY YOrd,MonOrd
  HAVING SUM(t001.UnitPrice*t001.Quantity) > 10000
  ORDER BY YOrd,MonOrd