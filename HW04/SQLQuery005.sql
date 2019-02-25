﻿SELECT Invoices.InvoiceID
	,Invoices.InvoiceDate
	,(SELECT People.FullName 
		FROM Application.People 
		WHERE People.PersonID = Invoices.SalespersonPersonID) AS SalesPersonName
	,SalesTotals.TotalSumm AS TotalSummByInvoice
	,(SELECT SUM(OrderLines.PickedQuantity*OrderLines.UnitPrice) 
		FROM Sales.OrderLines 
		WHERE OrderLines.OrderId = 
			(SELECT Orders.OrderId 
				FROM Sales.Orders
				WHERE Orders.PickingCompletedWhen IS NOT NULL	
					AND Orders.OrderId = Invoices.OrderId)	
	) AS TotalSummForPickedItems
FROM Sales.Invoices 
	JOIN
	(SELECT InvoiceId, SUM(Quantity*UnitPrice) AS TotalSumm
		FROM Sales.InvoiceLines
		GROUP BY InvoiceId
		HAVING SUM(Quantity*UnitPrice) > 27000
	) AS SalesTotals
	ON Invoices.InvoiceID = SalesTotals.InvoiceID
ORDER BY TotalSumm DESC

-- выводит ИД счета заказов, дату заказа, продавца, общая сумма которых больше 27000

SELECT Invoices.InvoiceID
	,Invoices.InvoiceDate
	,(SELECT People.FullName 
		FROM Application.People 
		WHERE People.PersonID = Invoices.SalespersonPersonID) AS SalesPersonName
	,SalesTotals.TotalSumm AS TotalSummByInvoice
	,(SELECT SUM(OrderLines.PickedQuantity*OrderLines.UnitPrice) 
		FROM Sales.OrderLines 
		WHERE OrderLines.OrderId = 
			(SELECT Orders.OrderId 
				FROM Sales.Orders
				WHERE Orders.PickingCompletedWhen IS NOT NULL	
					AND Orders.OrderId = Invoices.OrderId)	
	) AS TotalSummForPickedItems
FROM Sales.Invoices 
	JOIN
	(SELECT InvoiceId, SUM(Quantity*UnitPrice) AS TotalSumm
		FROM Sales.InvoiceLines
		GROUP BY InvoiceId
		HAVING SUM(Quantity*UnitPrice) > 27000
	) AS SalesTotals
	ON Invoices.InvoiceID = SalesTotals.InvoiceID
ORDER BY TotalSumm DESC