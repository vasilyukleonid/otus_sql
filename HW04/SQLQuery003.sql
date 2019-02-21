-- 1
SELECT C.CustomerName
	,CT.TransactionAmount
	FROM [Sales].[Customers] AS C
		JOIN [Sales].[CustomerTransactions] AS CT
		ON C.[CustomerID] = CT.[CustomerID]
	WHERE CT.TransactionAmount IN
			(
			SELECT TOP (3) TransactionAmount
				FROM [WideWorldImporters].[Sales].[CustomerTransactions]
				WHERE TransactionTypeID = 1
				ORDER BY TransactionAmount DESC
			)

-- 2
