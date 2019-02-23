SELECT [Description]
      ,SUM(Quantity*UnitPrice) AS OrderSum
	  ,DATEPART(mm,PickingCompletedWhen) AS Month
	  ,DATEPART(yy,PickingCompletedWhen) AS Year
	  ,MIN(PickingCompletedWhen) AS FirstDate
  FROM [WideWorldImporters].[Sales].[OrderLines]
  WHERE [PickingCompletedWhen] IS NOT NULL
  GROUP BY [Description],DATEPART(yy,PickingCompletedWhen),DATEPART(mm,PickingCompletedWhen)
  HAVING SUM(Quantity) < 50
  ORDER BY Year,Month,[Description]

/**
SELECT *
	FROM [WideWorldImporters].[Sales].[OrderLines]
**/