 SELECT PO.[PurchaseOrderID]
      ,S.SupplierName
      ,[OrderDate]
      ,DM.DeliveryMethodName
      ,[ContactPersonID]
      ,S.PrimaryContactPersonID
	  ,P.FullName
 FROM [WideWorldImporters].[Purchasing].[PurchaseOrders] PO
	JOIN [WideWorldImporters].[Application].[DeliveryMethods] DM ON PO.DeliveryMethodID = DM.DeliveryMethodID
	JOIN [WideWorldImporters].[Purchasing].[Suppliers] S ON PO.SupplierID = S.SupplierID
	JOIN [WideWorldImporters].[Application].[People] P ON P.PersonID = PO.ContactPersonID
 WHERE PO.OrderDate BETWEEN '2014-01-01' AND '2014-12-31'
	AND (DM.DeliveryMethodName = 'Road Freight' OR DM.DeliveryMethodName = 'Post')