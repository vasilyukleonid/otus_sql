SELECT SI.StockItemName
      ,SUM(OL.Quantity*OL.UnitPrice) AS OrderSum
	  ,SUM(OL.Quantity) AS QuantityByMonth
	  ,DATEPART(mm,O.OrderDate) AS Month
	  ,DATEPART(yy,O.OrderDate) AS Year
	  ,MIN(O.OrderDate) AS FirstDate
  FROM 
	[WideWorldImporters].[Sales].[OrderLines] OL
	JOIN [Warehouse].[StockItems] SI
	ON OL.StockItemID = SI.StockItemID
		JOIN [Sales].[Orders] O
		ON OL.[OrderID] = O.[OrderID]
--  WHERE O.OrderDate IS NOT NULL
  GROUP BY SI.StockItemName,DATEPART(yy,O.OrderDate),DATEPART(mm,O.OrderDate)
  HAVING SUM(OL.Quantity) < 50
  ORDER BY Year,Month,SI.StockItemName