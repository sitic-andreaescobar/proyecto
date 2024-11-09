-- Author:		Andrea Escobar
-- Description:	Desautoriza un DoctoXCobrar
-- Fecha:		31/08/2024
IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[]') AND type in (N'P', N'PC'))
	DROP PROCEDURE []
GO
CREATE PROCEDURE []
WITH  ENCRYPTION  
AS 
BEGIN	
END
GO
EXEC sp_recompile N'[]';
GO