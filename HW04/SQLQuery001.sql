SELECT [PersonID],FullName
	FROM [WideWorldImporters].[Application].[People]
	WHERE IsSalesperson = 1 
		AND [PersonID] NOT IN 
			(SELECT SalespersonPersonID
				FROM [WideWorldImporters].[Sales].[Orders]
			)