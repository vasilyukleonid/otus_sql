-- ver 1
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
			JOIN [Application].[People] AS P 
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
;

-- ver 2
;WITH top3stock (stockitemsID)
	AS 
	(
	SELECT TOP (3) [StockItemID]
		FROM [WideWorldImporters].[Warehouse].[StockItems]
		ORDER BY UnitPrice DESC
	)

SELECT Ci.CityID
	,Ci.CityName
	,O.PickedByPersonID
	,P.FullName
FROM [Sales].[Orders] AS O
		JOIN [Application].[People] AS P ON O.PickedByPersonID = P.PersonID 
		JOIN [Sales].[Customers] AS Cus ON O.CustomerID = Cus.CustomerID
		JOIN [Application].[Cities] AS Ci ON Cus.DeliveryCityID = Ci.CityID 
WHERE O.OrderID IN
		(
		SELECT [OrderID]
		FROM [Sales].[OrderLines]
		WHERE StockItemID IN (SELECT * FROM top3stock)
		)
;

-- ver 3 В таблице StockItems 3 максимальных цены 285,345,1899, которым соответствуют 4 товара - 73,74,75,215
;WITH top3stock (stockitemsID)
	AS 
	(
	SELECT StockItemID
	FROM [Warehouse].[StockItems]
	WHERE [Warehouse].[StockItems].UnitPrice IN
		(
		SELECT TOP (3) UnitPrice
			FROM [Warehouse].[StockItems]
			ORDER BY UnitPrice DESC
		)
	)

SELECT Ci.CityID
	,Ci.CityName
	,O.PickedByPersonID
	,P.FullName
FROM [Sales].[Orders] AS O
		JOIN [Application].[People] AS P ON O.PickedByPersonID = P.PersonID 
		JOIN [Sales].[Customers] AS Cus ON O.CustomerID = Cus.CustomerID
		JOIN [Application].[Cities] AS Ci ON Cus.DeliveryCityID = Ci.CityID 
WHERE O.OrderID IN
		(
		SELECT [OrderID]
		FROM [Sales].[OrderLines]
		WHERE StockItemID IN (SELECT * FROM top3stock)
;

-- ver 4 Оптимизированная версия
;WITH top3stock (stockitemsID)
AS 
(
SELECT StockItemID
FROM [Warehouse].[StockItems]
WHERE [Warehouse].[StockItems].UnitPrice IN
(
SELECT TOP (3) UnitPrice
FROM [Warehouse].[StockItems]
ORDER BY UnitPrice DESC
)
)
SELECT Ci.CityID
,Ci.CityName
,O.PickedByPersonID
,P.FullName
FROM [Sales].[Orders] AS O
JOIN [Application].[People] AS P ON O.PickedByPersonID = P.PersonID 
JOIN [Sales].[Customers] AS Cus ON O.CustomerID = Cus.CustomerID
JOIN [Application].[Cities] AS Ci ON Cus.DeliveryCityID = Ci.CityID 
JOIN Sales.OrderLines ol ON ol.OrderID = o.OrderID
JOIN top3stock ON OL.StockItemID = top3stock.stockitemsID
ORDER BY CityID;
	