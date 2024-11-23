-- Author:		Andrea Escobar
-- Description:	GetProcedureParametersa Productos
-- Fecha:		31/08/2024
IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetProcedureParameters]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[GetProcedureParameters]
GO
CREATE PROCEDURE [dbo].[GetProcedureParameters]
	@Schema         VARCHAR(MAX),
    @Procedure      VARCHAR(MAX)
WITH  ENCRYPTION  
AS 
BEGIN	
	SELECT PARAMETER_NAME AS 'Parameter'
    FROM INFORMATION_SCHEMA.PARAMETERS
    WHERE SPECIFIC_SCHEMA = @Schema
    AND SPECIFIC_NAME = @Procedure
END
GO
EXEC sp_recompile N'[dbo].[GetProcedureParameters]';
GO