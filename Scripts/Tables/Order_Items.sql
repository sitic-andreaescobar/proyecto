IF NOT EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[Order_Items]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN
	/* Create Tables */
	--Almacen la información de los elmeentos del pedido
	CREATE TABLE [dbo].[Order_Items]
	(
		[Id] INT NOT NULL PRIMARY KEY IDENTITY(1,1), --Identificador único del elemento del pedido
		[Order_Id] INT NOT NULL, --Identificador relación al pedido (maestro)
		[Product_Id] INT NOT NULL, --Identificador relación al producto
		[Quantity] INT NOT NULL, --Cantidad del producto en el pedido
		[Price] DECIMAL(18,2) NOT NULL, --Precio del producto en el momento de añadirlo al pedido
		[Created_At] DATETIME NOT NULL DEFAULT GETDATE(), --Fecha de creación del producto añadido
		[Updated_At] DATETIME NOT NULL DEFAULT GETDATE(), --Fecha de última actualización del producto añadido
		FOREIGN KEY ([Order_Id]) REFERENCES [dbo].[Orders]([Id]),
		FOREIGN KEY ([Product_Id]) REFERENCES [dbo].[Products]([Id]),
	)
END


/* Create Table Comments */
IF EXISTS (SELECT * FROM ::fn_listextendedproperty ('MS_Description', 'SCHEMA', 'dbo', 'table', 'Order_Items', NULL, NULL))
BEGIN
  EXEC sys.sp_updateextendedproperty 'MS_Description', 'Almacen la información de los elementos del pedido', 'SCHEMA', 'dbo', 'table', 'Order_Items'
END 
ELSE
BEGIN
  EXEC sys.sp_addextendedproperty 'MS_Description', 'Almacen la información de los elementos del pedido', 'SCHEMA', 'dbo', 'table', 'Order_Items'
END
GO


/*  Comentarios para las columnas */
-- Descripción para la columna Id
IF NOT EXISTS (SELECT * 
               FROM ::fn_listextendedproperty ('MS_Description', 'SCHEMA', 'dbo', 'table', 'Order_Items', 'column', 'Id'))
    EXEC sp_addextendedproperty 'MS_Description', 'Identificador único del elemento del pedido', 'Schema', 'dbo', 'table', 'Order_Items', 'column', 'Id';

-- Descripción para la columna Order_Id
IF NOT EXISTS (SELECT * 
               FROM ::fn_listextendedproperty ('MS_Description', 'SCHEMA', 'dbo', 'table', 'Order_Items', 'column', 'Order_Id'))
    EXEC sp_addextendedproperty 'MS_Description', 'Identificador relación al pedido (maestro)', 'Schema', 'dbo', 'table', 'Order_Items', 'column', 'Order_Id';

-- Descripción para la columna Product_Id
IF NOT EXISTS (SELECT * 
               FROM ::fn_listextendedproperty ('MS_Description', 'SCHEMA', 'dbo', 'table', 'Order_Items', 'column', 'Product_Id'))
    EXEC sp_addextendedproperty 'MS_Description', 'Identificador relación al producto', 'Schema', 'dbo', 'table', 'Order_Items', 'column', 'Product_Id';

-- Descripción para la columna Quantity
IF NOT EXISTS (SELECT * 
               FROM ::fn_listextendedproperty ('MS_Description', 'SCHEMA', 'dbo', 'table', 'Order_Items', 'column', 'Quantity'))
    EXEC sp_addextendedproperty 'MS_Description', 'Cantidad del producto en el pedido', 'Schema', 'dbo', 'table', 'Order_Items', 'column', 'Quantity';

-- Descripción para la columna Price
IF NOT EXISTS (SELECT * 
               FROM ::fn_listextendedproperty ('MS_Description', 'SCHEMA', 'dbo', 'table', 'Order_Items', 'column', 'Price'))
    EXEC sp_addextendedproperty 'MS_Description', 'Precio del producto en el momento de añadirlo al pedido', 'Schema', 'dbo', 'table', 'Order_Items', 'column', 'Price';

-- Descripción para la columna Created_At
IF NOT EXISTS (SELECT * 
               FROM ::fn_listextendedproperty ('MS_Description', 'SCHEMA', 'dbo', 'table', 'Order_Items', 'column', 'Created_At'))
    EXEC sp_addextendedproperty 'MS_Description', 'Fecha de creación del producto añadido', 'Schema', 'dbo', 'table', 'Order_Items', 'column', 'Created_At';

-- Descripción para la columna Updated_At
IF NOT EXISTS (SELECT * 
               FROM ::fn_listextendedproperty ('MS_Description', 'SCHEMA', 'dbo', 'table', 'Order_Items', 'column', 'Updated_At'))
    EXEC sp_addextendedproperty 'MS_Description', 'Fecha de última actualización del producto añadido', 'Schema', 'dbo', 'table', 'Order_Items', 'column', 'Updated_At';
