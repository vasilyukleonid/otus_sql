-- 1
SELECT C.CustomerName
	,CT.TransactionAmount
	FROM [Sales].[Customers] AS C
		JOIN [Sales].[CustomerTransactions] AS CT
		ON C.[CustomerID] = CT.[CustomerID]
	WHERE CT.TransactionAmount IN
			(
			SELECT TOP (5) TransactionAmount
				FROM [WideWorldImporters].[Sales].[CustomerTransactions]
				WHERE TransactionTypeID = 1
				ORDER BY TransactionAmount DESC
			)

-- 2
SELECT 
	(SELECT CustomerName FROM [Sales].[Customers] WHERE CustomerID = CT.[CustomerID])
	,CT.TransactionAmount
	FROM [Sales].[CustomerTransactions] AS CT
	WHERE CT.TransactionAmount IN
			(
			SELECT TOP (5) TransactionAmount
				FROM [WideWorldImporters].[Sales].[CustomerTransactions]
				WHERE TransactionTypeID = 1
				ORDER BY TransactionAmount DESC
			)

-- 3 CTE
;WITH top5transaction (TA)
	AS
		(
		SELECT TOP (5) TransactionAmount
				FROM [WideWorldImporters].[Sales].[CustomerTransactions]
				WHERE TransactionTypeID = 1
				ORDER BY TransactionAmount DESC
		)
SELECT 
	(SELECT CustomerName FROM [Sales].[Customers] WHERE CustomerID = CT.[CustomerID]) AS Customer
	,TransactionAmount
	FROM [Sales].[CustomerTransactions] AS CT
	WHERE CT.TransactionAmount IN (SELECT * FROM top5transaction);