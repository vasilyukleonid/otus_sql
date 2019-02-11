SELECT DISTINCT C.[CustomerID]
      ,C.[CustomerName]
      ,C.[PhoneNumber]
FROM [WideWorldImporters].[Sales].[Customers] C 
	JOIN [WideWorldImporters].[Sales].[Orders] O ON C.CustomerID = O.CustomerID
	JOIN [WideWorldImporters].[Sales].[OrderLines] OL ON OL.OrderID = O.OrderID
WHERE OL.Description = 'Chocolate frogs 250g'
ORDER BY C.CustomerName	