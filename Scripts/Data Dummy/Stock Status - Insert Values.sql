--SELECT * FROM stock_status
--SELECT * FROM vwStock_Status

--INSERTAMOS VALORES FIJOS EN NUESTRA TABLA INTERNA:
IF NOT EXISTS (SELECT 1 FROM Stock_Status WHERE [Key] = 'IN_STOCK')
	INSERT INTO Stock_Status(Status_Name, [Key])
	VALUES ('In Stock', 'IN_STOCK')
ELSE
	PRINT('Ya existe IN_STOCK')

IF NOT EXISTS (SELECT 1 FROM Stock_Status WHERE [Key] = 'OUT_OF_STOCK')
	INSERT INTO Stock_Status(Status_Name, [Key])
	VALUES ('Out of Stock', 'OUT_OF_STOCK')
ELSE
	PRINT('Ya existe OUT_OF_STOCK')

IF NOT EXISTS (SELECT 1 FROM Stock_Status WHERE [Key] = 'LOW_STOCK')
	INSERT INTO Stock_Status(Status_Name, [Key])
	VALUES ('Low Stock', 'LOW_STOCK')
ELSE
	PRINT('Ya existe LOW_STOCK')

--INSERT INTO Stock_Status(Status_Name, [Key])
--VALUES ('In Stock', 'IN_STOCK'),
--('Out of Stock', 'OUT_OF_STOCK'),
--('Low Stock', 'LOW_STOCK')