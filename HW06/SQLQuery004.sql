SELECT *
FROM (
SELECT p.FullName
	, p.PersonID
	, c.CustomerName
	, c.CustomerID
	, tbl1.InvoiceSum
	, i.InvoiceDate
	, MAX(i.invoicedate) OVER (PARTITION BY p.FullName ORDER BY i.invoicedate DESC) AS [LastDate]
	FROM [Sales].[Invoices] AS i
		JOIN [WideWorldImporters].[Application].[People] AS p ON i.SalespersonPersonID = p.PersonID
		JOIN [Sales].[Customers] AS c ON i.CustomerID = c.CustomerID
		JOIN
		(
		SELECT [InvoiceID]
		, SUM([ExtendedPrice]) AS [InvoiceSum]
		FROM [WideWorldImporters].[Sales].[InvoiceLines]
		GROUP BY InvoiceID
		) AS tbl1 ON tbl1.InvoiceID = i.InvoiceID
) AS tbl2
WHERE tbl2.InvoiceDate = tbl2.LastDate