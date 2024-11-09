--Alter table para añadir llave foránea del maestro en la tabla: Cart_Items
IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = 'FK_Cart_Items_Cart_Id')
BEGIN
	ALTER TABLE [dbo].[Cart_Items]
	ADD CONSTRAINT FK_Cart_Items_Cart_Id
	FOREIGN KEY ([Cart_Id]) REFERENCES [dbo].[Carts]([Id])
END
GO

--Alter table para añadir llave foránea del producto en la tabla: Cart_Items
IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = 'FK_Cart_Items_Product_Id')
BEGIN
	ALTER TABLE [dbo].[Cart_Items]
	ADD CONSTRAINT FK_Cart_Items_Product_Id
	FOREIGN KEY ([Product_Id]) REFERENCES [dbo].[Products]([Id])
END
