SELECT O.OrderDate
	,O.OrderID
	,DATEPART(quarter, O.OrderDate) AS Quart
	,DATENAME(month, O.OrderDate) AS Month
	,"Third" = CASE 
		WHEN DATEPART(month,O.OrderDate) >= 1 AND DATEPART(month,O.OrderDate) <= 4 THEN 'First'
		WHEN DATEPART(month,O.OrderDate) >= 5 AND DATEPART(month,O.OrderDate) <= 8 THEN 'Second'
		WHEN DATEPART(month,O.OrderDate) >= 9 AND DATEPART(month,O.OrderDate) <= 12 THEN 'Third'
		END
	,OL.UnitPrice
	,OL.Quantity
FROM [WideWorldImporters].[Sales].[Orders] O
	JOIN [WideWorldImporters].[Sales].[OrderLines] OL ON O.OrderID = OL.OrderID
WHERE (OL.UnitPrice > 100 OR OL.Quantity > 20)
	AND O.PickingCompletedWhen IS NOT NULL
ORDER BY Quart, O.OrderDate
--	OFFSET 1000 ROWS FETCH NEXT 100 ROWS ONLY; -- Skip first 1000 rwas and shaw next 100