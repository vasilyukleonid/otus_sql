-- нарастающий итог по году
SET STATISTICS TIME ON;
GO
SELECT il.[InvoiceID]
	  , i.InvoiceDate
	  , DATEPART(mm,i.InvoiceDate) AS [Month]
	  , c.CustomerName
	  , (il.Quantity*il.UnitPrice) AS [SummaOfOrder]
	  , SUM(il.Quantity*il.UnitPrice) OVER(PARTITION BY DATEPART(mm,i.InvoiceDate)) AS [SummaInMonth]
--	  , SUM(il.Quantity*il.UnitPrice) OVER(PARTITION BY DATEPART(mm,i.InvoiceDate) ORDER BY i.InvoiceDate) AS [SummaIn?]
--	  , SUM(il.Quantity*il.UnitPrice) OVER(PARTITION BY DATEPART(yyyy,i.InvoiceDate)) AS [SummaIn?]
FROM [WideWorldImporters].[Sales].[InvoiceLines] AS il
	JOIN [WideWorldImporters].[Sales].[Invoices] AS i ON il.InvoiceID = i.InvoiceID
	JOIN [Sales].[Customers] AS C ON i.CustomerID = c.CustomerID
WHERE i.InvoiceDate BETWEEN '2015-01-01' AND '2015-12-31'
SET STATISTICS TIME OFF;
GO
-- SQL Server parse and compile time:	CPU time = 31 ms, elapsed time = 363 ms.
-- SQL Server Execution Times:			CPU time = 204 ms,  elapsed time = 5261 ms.

-- версия 2
SET STATISTICS TIME ON;
GO
SELECT il.[InvoiceID]
	  , i.InvoiceDate
	  , DATEPART(mm,i.InvoiceDate) AS [Month]
	  , c.CustomerName
	  , (il.Quantity*il.UnitPrice) AS [SummaOfOrder]
	  , t01.SummaOfMonth
FROM [WideWorldImporters].[Sales].[InvoiceLines] AS il
	JOIN [WideWorldImporters].[Sales].[Invoices] AS i ON il.InvoiceID = i.InvoiceID
	JOIN [Sales].[Customers] AS C ON i.CustomerID = c.CustomerID
	JOIN (SELECT datepart(mm,i.InvoiceDate) as [Month]
		  , sum(il.Quantity*il.UnitPrice) as [SummaOfMonth]
	FROM [WideWorldImporters].[Sales].[InvoiceLines] AS il
		JOIN [WideWorldImporters].[Sales].[Invoices] AS i on il.InvoiceID = i.InvoiceID AND i.InvoiceDate BETWEEN '2015-01-01' AND '2015-12-31'
	GROUP BY datepart(mm,i.InvoiceDate)) AS t01 ON DATEPART(mm,i.InvoiceDate) = t01.Month
WHERE i.InvoiceDate BETWEEN '2015-01-01' AND '2015-12-31'
ORDER BY Month, InvoiceDate
SET STATISTICS TIME OFF;
GO
-- SQL Server parse and compile time:	CPU time = 63 ms, elapsed time = 293 ms.
-- SQL Server Execution Times:			CPU time = 281 ms,  elapsed time = 7054 ms.