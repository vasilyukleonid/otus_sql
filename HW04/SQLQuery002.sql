SELECT *
  FROM [WideWorldImporters].[Warehouse].[StockItems]
  WHERE UnitPrice = (SELECT MIN (UnitPrice) FROM [WideWorldImporters].[Warehouse].[StockItems])