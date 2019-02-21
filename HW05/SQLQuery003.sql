SELECT [Description]
      ,SUM(Quantity) AS Quantity
	  ,DATEPART(mm,PickingCompletedWhen) AS MonOrd
	  ,DATEPART(yy,PickingCompletedWhen) AS YOrd
	  ,MIN(PickingCompletedWhen) AS FirstDate
  FROM [WideWorldImporters].[Sales].[OrderLines]
  WHERE [PickingCompletedWhen] IS NOT NULL
  GROUP BY [Description],DATEPART(mm,PickingCompletedWhen),DATEPART(yy,PickingCompletedWhen)
  HAVING SUM(Quantity) > 50
  ORDER BY YOrd,MonOrd,[Description]

/**
SELECT *
	FROM [WideWorldImporters].[Sales].[OrderLines]
**/