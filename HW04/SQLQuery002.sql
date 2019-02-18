-- 1
SELECT *
  FROM [WideWorldImporters].[Warehouse].[StockItems]
  WHERE UnitPrice = (SELECT MIN (UnitPrice) FROM [WideWorldImporters].[Warehouse].[StockItems])

-- 2?
SELECT *
  FROM [WideWorldImporters].[Warehouse].[StockItems]
  WHERE UnitPrice = (SELECT TOP(1) UnitPrice FROM [WideWorldImporters].[Warehouse].[StockItems] ORDER BY UnitPrice ASC)