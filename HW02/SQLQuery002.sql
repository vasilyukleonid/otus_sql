SELECT SupplierName, SupplierID
FROM [Purchasing].[Suppliers]
EXCEPT
SELECT S.SupplierName, S.SupplierID
FROM [Purchasing].[Suppliers] as S RIGHT JOIN [Purchasing].[SupplierTransactions] as ST
ON S.SupplierID = ST.SupplierID