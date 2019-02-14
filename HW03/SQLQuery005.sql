-- Export via BCP Utility
EXEC xp_cmdshell 'bcp [WideWorldImporters].[Sales].[CustomerTransactions] out D:\disk.yandex\OTUS\ve2-pc621\otus_sql\HW03\Sales.CustomerTransaction.bcp -c -S ve2-pc621\sql2017 -T'

-- Import via BCP Utility
SELECT * INTO
	[Sales].[CustomerTransactionsHW]
	FROM [Sales].[CustomerTransactions]
	WHERE 1 = 2
EXEC xp_cmdshell 'bcp [WideWorldImporters].[Sales].[CustomerTransactionsHW] in D:\disk.yandex\OTUS\ve2-pc621\otus_sql\HW03\Sales.CustomerTransaction.bcp -c -S ve2-pc621\sql2017 -T'
GO