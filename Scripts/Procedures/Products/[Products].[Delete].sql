-- Author:		Andrea Escobar
-- Description:	Elimina Productos
-- Fecha:		09/11/2024
IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[Products].[Delete]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [Products].[Delete]
GO
CREATE PROCEDURE [Products].[Delete]
	@Id				INT
WITH  ENCRYPTION  
AS 
BEGIN	
	DELETE Products 
	WHERE Id = @Id
END
GO
EXEC sp_recompile N'[Products].[Delete]';
GO