  SELECT TOP (10) O.[OrderDate]
      ,C.[CustomerName] AS Customer
      ,P.FullName AS WhoSale
  FROM [WideWorldImporters].[Sales].[Orders] O
	JOIN [WideWorldImporters].[Sales].[Customers] C ON O.CustomerID = C.CustomerID
	JOIN [WideWorldImporters].[Application].[People] P ON O.SalespersonPersonID = P.PersonID
  ORDER BY O.[OrderDate] DESC