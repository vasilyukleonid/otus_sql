SELECT CityID
	,CityName
	,PickedByPersonID
	,FullName
	FROM 
		(
		SELECT O.[OrderID]
			,O.[CustomerID]
			,O.[PickedByPersonID]
			,P.FullName
		FROM [WideWorldImporters].[Sales].[Orders] AS O
			LEFT JOIN [Application].[People] AS P -- use LEFT JOIN because some PickedByPerson is null
		ON O.PickedByPersonID = P.PersonID
		) AS t001
		JOIN
		(
		SELECT Ci.CityID AS CityID
			,Ci.CityName AS CityName
			,Cus.DeliveryCityID AS DeliveryCityID
			,Cus.CustomerID AS CustomerID
			,Cus.CustomerName
		FROM [WideWorldImporters].[Sales].[Customers] AS Cus
			JOIN [Application].[Cities] AS Ci
		ON Cus.DeliveryCityID = Ci.CityID
		) AS t002
		ON t001.CustomerID = t002.CustomerID
WHERE t001.OrderID IN
		(
		SELECT [OrderID]
		FROM [WideWorldImporters].[Sales].[OrderLines]
		WHERE StockItemID IN
				(
				SELECT TOP (3) [StockItemID]
				FROM [WideWorldImporters].[Warehouse].[StockItems]
				ORDER BY UnitPrice DESC
				-- results 73,75,215 возвращает значения
				)
				-- returns results, where StockItemID is 74,75,215. why? возвращает строки, у которых StockItemID равен 74,75,215. Почему? Видимо где-то ошибка
		)