IF NOT EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[Cart_Items]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN
	/* Create Tables */
	CREATE TABLE [dbo].[Cart_Items]
	(
		[Id] INT NOT NULL PRIMARY KEY IDENTITY(1,1), --Identificador �nico del elemento del carrito
		[Cart_Id] INT NOT NULL, --Identificador relaci�n al carrito (maestro)
		[Product_Id] INT NOT NULL, --Identificador relaci�n al producto
		[Quantity] INT NOT NULL, --Cantidad del producto en el carrito
		[Price] DECIMAL(18,2) NOT NULL, --Precio del producto en el momento de a�adirlo al carrito
		[Created_At] DATETIME NOT NULL DEFAULT GETDATE(), --Fecha de creaci�n del producto a�adido
		[Updated_At] DATETIME NOT NULL DEFAULT GETDATE() --Fecha de �ltima actualizaci�n del producto a�adido
	)
END


/* Create Table Comments */
IF EXISTS (SELECT * FROM ::fn_listextendedproperty ('MS_Description', 'SCHEMA', 'dbo', 'table', 'Cart_Items', NULL, NULL))
BEGIN
  EXEC sys.sp_updateextendedproperty 'MS_Description', 'Almacen la informaci�n de los elementos del carrito', 'SCHEMA', 'dbo', 'table', 'Cart_Items'
END 
ELSE
BEGIN
  EXEC sys.sp_addextendedproperty 'MS_Description', 'Almacen la informaci�n de los elementos del carrito', 'SCHEMA', 'dbo', 'table', 'Cart_Items'
END
GO


/*  Comentarios para las columnas */
-- Descripci�n para la columna Id
IF NOT EXISTS (SELECT * 
               FROM ::fn_listextendedproperty ('MS_Description', 'SCHEMA', 'dbo', 'table', 'Cart_Items', 'column', 'Id'))
    EXEC sp_addextendedproperty 'MS_Description', 'Identificador �nico del elemento del carrito', 'Schema', 'dbo', 'table', 'Cart_Items', 'column', 'Id';

-- Descripci�n para la columna Cart_Id
IF NOT EXISTS (SELECT * 
               FROM ::fn_listextendedproperty ('MS_Description', 'SCHEMA', 'dbo', 'table', 'Cart_Items', 'column', 'Cart_Id'))
    EXEC sp_addextendedproperty 'MS_Description', 'Identificador relaci�n al carrito (maestro)', 'Schema', 'dbo', 'table', 'Cart_Items', 'column', 'Cart_Id';

-- Descripci�n para la columna Product_Id
IF NOT EXISTS (SELECT * 
               FROM ::fn_listextendedproperty ('MS_Description', 'SCHEMA', 'dbo', 'table', 'Cart_Items', 'column', 'Product_Id'))
    EXEC sp_addextendedproperty 'MS_Description', 'Identificador relaci�n al producto', 'Schema', 'dbo', 'table', 'Cart_Items', 'column', 'Product_Id';

-- Descripci�n para la columna Quantity
IF NOT EXISTS (SELECT * 
               FROM ::fn_listextendedproperty ('MS_Description', 'SCHEMA', 'dbo', 'table', 'Cart_Items', 'column', 'Quantity'))
    EXEC sp_addextendedproperty 'MS_Description', 'Cantidad del producto en el carrito', 'Schema', 'dbo', 'table', 'Cart_Items', 'column', 'Quantity';

-- Descripci�n para la columna Price
IF NOT EXISTS (SELECT * 
               FROM ::fn_listextendedproperty ('MS_Description', 'SCHEMA', 'dbo', 'table', 'Cart_Items', 'column', 'Price'))
    EXEC sp_addextendedproperty 'MS_Description', 'Precio del producto en el momento de a�adirlo al carrito', 'Schema', 'dbo', 'table', 'Cart_Items', 'column', 'Price';

-- Descripci�n para la columna Created_At
IF NOT EXISTS (SELECT * 
               FROM ::fn_listextendedproperty ('MS_Description', 'SCHEMA', 'dbo', 'table', 'Cart_Items', 'column', 'Created_At'))
    EXEC sp_addextendedproperty 'MS_Description', 'Fecha de creaci�n del producto a�adido', 'Schema', 'dbo', 'table', 'Cart_Items', 'column', 'Created_At';

-- Descripci�n para la columna Updated_At
IF NOT EXISTS (SELECT * 
               FROM ::fn_listextendedproperty ('MS_Description', 'SCHEMA', 'dbo', 'table', 'Cart_Items', 'column', 'Updated_At'))
    EXEC sp_addextendedproperty 'MS_Description', 'Fecha de �ltima actualizaci�n del producto a�adido', 'Schema', 'dbo', 'table', 'Cart_Items', 'column', 'Updated_At';
