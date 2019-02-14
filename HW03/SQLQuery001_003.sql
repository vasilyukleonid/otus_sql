INSERT INTO [Sales].[Customers]
           ([CustomerID]
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
           ('1062',N'Customer HW03 001','1062','1',null,'3150','3150','1','1','1',null,N'2019-02-14','0','0','0','7',N'(123) 456-7890',N'(123) 456-7890',null,null,N'http://www.001.ru/',N'Moscow',null,N'123456',null,N'Moscow',null,N'123456',N'3150')
           ,('1063',N'Customer HW03 002','1063','1',null,'3150','3150','1','1','1',null,N'2019-02-14','0','0','0','7',N'(123) 456-7891',N'(123) 456-7891',null,null,N'http://www.002.ru/',N'Moscow',null,N'123456',null,N'Moscow',null,N'123456',N'3150')
           ,('1064',N'Customer HW03 003','1064','1',null,'3150','3150','1','1','1',null,N'2019-02-14','0','0','0','7',N'(123) 456-7892',N'(123) 456-7892',null,null,N'http://www.003.ru/',N'Moscow',null,N'123456',null,N'Moscow',null,N'123456',N'3150')
           ,('1065',N'Customer HW03 004','1065','1',null,'3150','3150','1','1','1',null,N'2019-02-14','0','0','0','7',N'(123) 456-7893',N'(123) 456-7893',null,null,N'http://www.004.ru/',N'Moscow',null,N'123456',null,N'Moscow',null,N'123456',N'3150')
           ,('1066',N'Customer HW03 005','1066','1',null,'3150','3150','1','1','1',null,N'2019-02-14','0','0','0','7',N'(123) 456-7894',N'(123) 456-7894',null,null,N'http://www.005.ru/',N'Moscow',null,N'123456',null,N'Moscow',null,N'123456',N'3150')
GO

DELETE FROM [Sales].[Customers]
	WHERE [CustomerName] LIKE N'Customer HW03 005'
GO

UPDATE [Sales].[Customers]
	SET [PhoneNumber] = N'(123) 456-7895'
	WHERE [PhoneNumber] = N'(123) 456-7894'
GO