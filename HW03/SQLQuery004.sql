MERGE INTO [Sales].[Customers] AS T
--	USING (VALUES ('Customer HW03 006')) AS S (NewCustomer) 
	USING (SELECT 'Customer HW03 006' AS NewCustomer) AS S
	ON T.CustomerName = S.NewCustomer
		WHEN MATCHED THEN
		UPDATE SET PhoneNumber = '(123) 456-7897'
		WHEN NOT MATCHED THEN
		INSERT ([CustomerID]
           ,[CustomerName]
           ,[BillToCustomerID]
           ,[CustomerCategoryID]
           ,[BuyingGroupID]
           ,[PrimaryContactPersonID]
           ,[AlternateContactPersonID]
           ,[DeliveryMethodID]
           ,[DeliveryCityID]
           ,[PostalCityID]
           ,[CreditLimit]
           ,[AccountOpenedDate]
           ,[StandardDiscountPercentage]
           ,[IsStatementSent]
           ,[IsOnCreditHold]
           ,[PaymentDays]
           ,[PhoneNumber]
           ,[FaxNumber]
           ,[DeliveryRun]
           ,[RunPosition]
           ,[WebsiteURL]
           ,[DeliveryAddressLine1]
           ,[DeliveryAddressLine2]
           ,[DeliveryPostalCode]
           ,[DeliveryLocation]
           ,[PostalAddressLine1]
           ,[PostalAddressLine2]
           ,[PostalPostalCode]
           ,[LastEditedBy])
		   VALUES
           ('1066',N'Customer HW03 006','1066','1',null,'3150','3150','1','1','1',null,N'2019-02-14','0','0','0','7',N'(123) 456-7895',N'(123) 456-7895',null,null,N'http://www.006.ru/',N'Moscow',null,N'123456',null,N'Moscow',null,N'123456',N'3150')
		
;		