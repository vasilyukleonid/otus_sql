SELECT [PersonID],FullName
	FROM [WideWorldImporters].[Application].[People]
	WHERE IsEmployee = 1 AND IsSalesperson = 1 
		AND [PersonID] NOT IN 
			(SELECT SalespersonPersonID
				FROM [WideWorldImporters].[Sales].[Orders]
			)