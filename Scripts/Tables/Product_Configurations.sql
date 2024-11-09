IF NOT EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[Product_Configurations]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN
	/* Create Tables */
	--Define las configuraciones específicas para los productos, 
	--como diferentes colores y tamaños
	CREATE TABLE [dbo].[Product_Configurations]
	(
		[Id]					INT NOT NULL PRIMARY KEY IDENTITY(1,1), --Identificador único de la configuración
		[Product_Id]			INT NOT NULL, --Identificador de la llave foránea de Products 
		[Configuration_Name]	VARCHAR(255) NOT NULL, --Nombre de la configuración como puede ser: Color, Tamaño, etc.
		[Value]					VARCHAR(255) NOT NULL, --El valor asigndo dependiendo la configuración
		[Created_At]			DATETIME NOT NULL DEFAULT GETDATE(), --Fecha de creación de la configuración
		[Updated_At]			DATETIME NOT NULL DEFAULT GETDATE(), --Fecha de última actualización de la configuración
		FOREIGN KEY ([Product_Id]) REFERENCES [dbo].[Products]([Id])
	)
END


/* Create Table Comments */
IF EXISTS (SELECT * FROM ::fn_listextendedproperty ('MS_Description', 'SCHEMA', 'dbo', 'table', 'Product_Configurations', NULL, NULL))
BEGIN
  EXEC sys.sp_updateextendedproperty 'MS_Description', 'Define las configuraciones específicas para los productos, como diferentes colores y tamaños', 'SCHEMA', 'dbo', 'table', 'Product_Configurations'
END 
ELSE
BEGIN
  EXEC sys.sp_addextendedproperty 'MS_Description', 'Define las configuraciones específicas para los productos, como diferentes colores y tamaños', 'SCHEMA', 'dbo', 'table', 'Product_Configurations'
END
GO


/*  Comentarios para las columnas */
-- Descripción para la columna Id
IF NOT EXISTS (SELECT * 
               FROM ::fn_listextendedproperty ('MS_Description', 'SCHEMA', 'dbo', 'table', 'Product_Configurations', 'column', 'Id'))
    EXEC sp_addextendedproperty 'MS_Description', 'Identificador único de la configuración', 'Schema', 'dbo', 'table', 'Product_Configurations', 'column', 'Id';

-- Descripción para la columna Product_Id
IF NOT EXISTS (SELECT * 
               FROM ::fn_listextendedproperty ('MS_Description', 'SCHEMA', 'dbo', 'table', 'Product_Configurations', 'column', 'Product_Id'))
    EXEC sp_addextendedproperty 'MS_Description', 'Identificador de la llave foránea de Products', 'Schema', 'dbo', 'table', 'Product_Configurations', 'column', 'Product_Id';

-- Descripción para la columna Configuration_Name
IF NOT EXISTS (SELECT * 
               FROM ::fn_listextendedproperty ('MS_Description', 'SCHEMA', 'dbo', 'table', 'Product_Configurations', 'column', 'Configuration_Name'))
    EXEC sp_addextendedproperty 'MS_Description', 'Nombre de la configuración como puede ser: Color, Tamaño, etc.', 'Schema', 'dbo', 'table', 'Product_Configurations', 'column', 'Configuration_Name';

-- Descripción para la columna Value
IF NOT EXISTS (SELECT * 
               FROM ::fn_listextendedproperty ('MS_Description', 'SCHEMA', 'dbo', 'table', 'Product_Configurations', 'column', 'Value'))
    EXEC sp_addextendedproperty 'MS_Description', 'El valor asignado dependiendo la configuración', 'Schema', 'dbo', 'table', 'Product_Configurations', 'column', 'Value';

-- Descripción para la columna Created_At
IF NOT EXISTS (SELECT * 
               FROM ::fn_listextendedproperty ('MS_Description', 'SCHEMA', 'dbo', 'table', 'Product_Configurations', 'column', 'Created_At'))
    EXEC sp_addextendedproperty 'MS_Description', 'Fecha de creación de la configuración', 'Schema', 'dbo', 'table', 'Product_Configurations', 'column', 'Created_At';

-- Descripción para la columna Updated_At
IF NOT EXISTS (SELECT * 
               FROM ::fn_listextendedproperty ('MS_Description', 'SCHEMA', 'dbo', 'table', 'Product_Configurations', 'column', 'Updated_At'))
    EXEC sp_addextendedproperty 'MS_Description', 'Fecha de última actualización de la configuración', 'Schema', 'dbo', 'table', 'Product_Configurations', 'column', 'Updated_At';
