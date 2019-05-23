-- ver 1 для проверки
SELECT si.StockItemName
    ,SUM(il.Quantity) AS [AllQuantity]
    ,DATEPART(mm,i.InvoiceDate) AS InvM
FROM [Sales].[InvoiceLines] il
            JOIN [Sales].[Invoices] i ON il.InvoiceID = i.InvoiceID AND DATEPART(yyyy,i.InvoiceDate) = 2016
            JOIN Warehouse.StockItems si ON il.StockItemID = si.StockItemID
GROUP BY si.StockItemName,DATEPART(mm,i.InvoiceDate)
ORDER BY InvM, AllQuantity DESC

-- ver 2
SELECT *
FROM (
SELECT tbl.StockItemName
    , tbl.AllQuantity
    , tbl.InvM
    , ROW_NUMBER() OVER (PARTITION BY tbl.InvM ORDER BY tbl.AllQuantity DESC) AS Score
    FROM (
SELECT si.StockItemName
    , SUM(il.Quantity) AS [AllQuantity]
    , datepart(mm,i.InvoiceDate) AS InvM
        FROM [Sales].[InvoiceLines] il
            JOIN [Sales].[Invoices] i ON il.InvoiceID = i.InvoiceID AND DATEPART(yyyy,i.InvoiceDate) = 2016
            JOIN Warehouse.StockItems si ON il.StockItemID = si.StockItemID
        GROUP BY si.StockItemName,datepart(mm,i.InvoiceDate)
) AS tbl
) AS tbl2
WHERE tbl2.Score <= 2
ORDER BY tbl2.InvM, tbl2.AllQuantity DESC