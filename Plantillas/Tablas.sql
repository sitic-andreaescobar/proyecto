IF NOT EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[NombreTabla]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN
	/* Create Tables */
	CREATE TABLE [dbo].[NombreTabla]
	(
		[Id] INT NOT NULL PRIMARY KEY IDENTITY(1,1) -- Comentario de qué es
		
	)
END


/* Create Table Comments */
IF EXISTS (SELECT * FROM ::fn_listextendedproperty ('MS_Description', 'SCHEMA', 'dbo', 'table', 'NombreTabla', NULL, NULL))
BEGIN
  EXEC sys.sp_updateextendedproperty 'MS_Description', 'AgregaDescripción', 'SCHEMA', 'dbo', 'table', 'NombreTabla'
END 
ELSE
BEGIN
  EXEC sys.sp_addextendedproperty 'MS_Description', 'AgregaDescripción', 'SCHEMA', 'dbo', 'table', 'NombreTabla'
END
GO


/*  Comentarios para las columnas */
IF NOT EXISTS(SELECT * FROM ::fn_listextendedproperty ('MS_Description', 'SCHEMA', 'dbo', 'table', 'NombreTabla', 'column', 'NombreColumna'))
	EXEC sp_addextendedproperty 'MS_Description', 'AgregaDescripción', 'Schema', [dbo], 'table', [NombreTabla], 'column', [NombreColumna]
