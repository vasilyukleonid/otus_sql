SELECT *
FROM (
SELECT il.[InvoiceID]
      , il.[StockItemID]
	  , si.StockItemName
      , il.[UnitPrice]
	  , c.CustomerID
	  , c.CustomerName
	  , i.InvoiceDate
	  , MAX(il.UnitPrice) OVER (PARTITION BY c.CustomerName) AS [MaxUnitPrice]
    FROM [WideWorldImporters].[Sales].[InvoiceLines] AS il
        JOIN [Warehouse].[StockItems] AS si ON il.StockItemID = si.StockItemID
        JOIN [Sales].[Invoices] AS i ON il.InvoiceID = i.InvoiceID
        JOIN [Sales].[Customers] AS c ON i.CustomerID = c.CustomerID
--ORDER BY il.InvoiceID
) AS tbl
WHERE tbl.UnitPrice = tbl.MaxUnitPrice