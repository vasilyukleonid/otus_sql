SELECT O.OrderDate
	,O.OrderID
	,DATEPART(quarter, O.OrderDate) AS Quart
	,OL.UnitPrice
	,OL.Quantity
FROM [WideWorldImporters].[Sales].[Orders] O
	JOIN [WideWorldImporters].[Sales].[OrderLines] OL ON O.OrderID = OL.OrderID
WHERE (OL.UnitPrice > 100 OR OL.Quantity > 20)
	AND O.PickingCompletedWhen IS NOT NULL
ORDER BY Quart, O.OrderDate
	OFFSET 1000 ROWS FETCH NEXT 100 ROWS ONLY; -- Skip first 1000 rwas and shaw next 100