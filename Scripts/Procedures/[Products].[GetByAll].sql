-- Author:		Andrea Escobar
-- Description:	Obtiene una lista de Productos
-- Fecha:		09/11/2024
IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[Products].[GetByAll]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [Products].[GetByAll]
GO
CREATE PROCEDURE [Products].[GetByAll]
WITH  ENCRYPTION  
AS 
BEGIN	
	SELECT	Id				AS 'Id', 
			Name			AS 'Name',  
			Description		AS 'Description',  
			Price			AS 'Price', 
			Current_Stock	AS 'CurrentStock',  
			Max_Stock		AS 'MaxStock', 
			Min_Stock		AS 'MinStock', 
			Stock_Status_Id AS 'StockStatusId', 
			Image_Path		AS 'ImagePath', 
			Created_At		AS 'CreatedAt', 
			Updated_At		AS 'UpdatedAt' 
	FROM Products
END
GO
EXEC sp_recompile N'[Products].[GetByAll]';
GO