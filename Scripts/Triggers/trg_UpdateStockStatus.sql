--VERIFICA SI EXISTE EL TRIGGER
IF OBJECT_ID('trg_UpdateStockStatus', 'TR') IS NOT NULL
BEGIN
--Y DESPUÉS LO ELIMINA
	DROP TRIGGER trg_UpdateStockStatus;
END
GO

--SE CREA
CREATE TRIGGER trg_UpdateStockStatus
ON [dbo].[Products]
AFTER INSERT, UPDATE
AS
BEGIN
	--SI SE MODIFICÓ LA COLUMNA Current_Stock O SI FUE INSERTADA
	IF UPDATE(Current_Stock) OR EXISTS (SELECT 1 FROM inserted)
	BEGIN
		--SE DECLARA VARIABLE QUE VA A SER LA ENCARGADA DE CONSEGUIR EL IDENTIFICADOR
		--PRINCIPAL DEL ESTATUS QUE SE VA A CALCULAR DENTRO DEL BLOQUE DE CÓDIGO DEL CURSOR
		DECLARE @OutOfStockId	INT,
				@LowStockId		INT,
				@InStockId		INT,
				@StockStatusId	INT

		SELECT @OutOfStockId = Id
		FROM Stock_Status
		WHERE [Key] = 'OUT_OF_STOCK'
		
		SELECT @LowStockId = Id
		FROM Stock_Status
		WHERE [Key] = 'LOW_STOCK'

		SELECT @InStockId = Id
		FROM Stock_Status
		WHERE [Key] = 'IN_STOCK'

		--VERIFICAMOS QUE NO EXISTE PREVIAMENTE EL CURSOR PARA PODERLO CERRAR
		IF CURSOR_STATUS('GLOBAL', 'cursor_products') >= -1
		BEGIN
			--SE CIERRA & LIBERA MEMORIA
			CLOSE cursor_products --SE CIERRA
			DEALLOCATE cursor_products --SE LIBERA MEMORIA
		END

		--VARIABLES QUE VA A USAR EL CURSOR
		DECLARE @ProductId		INT,--0 - Id
				@CurrentStock	INT,--1 - Current_Stock
				@MinStock		INT --2 - MinStock

		--SE DECLARA CURSOR:
		DECLARE cursor_products CURSOR FAST_FORWARD FOR
		--TABLA QUE VA A AFECTAR + SUS COLUMNAS ESPECÍFICAS QUE NECESITAMOS PARA OPERACIONES

		SELECT	Id, --0 - @ProductId
				Current_Stock, --1 - @CurrentStock
				Min_Stock --2 - @MinStock
		FROM Products

		--SE ABRE CURSOR
		OPEN cursor_products
		
		--SE ABRE RENGLÓN Y SE METEN LOS VALORES (EN ORDEN A LAS COLUMNAS ESPECIFICADAS)		
		FETCH NEXT FROM cursor_products INTO @ProductId, --0 - Id
											 @CurrentStock, --1 - Current_Stock
											 @MinStock; --2 - MinStock
			
		--SE ABRE BLOQUE DE EJECUCIÓN (CICLO)
		WHILE @@FETCH_STATUS = 0 --ESTA PARTE DEL FETCH EVITA BUCLES INFINITOS 
		BEGIN
			--BLOQUE DE CÓDIGO QUE SE VA A ESTAR EJECUTANDO CADA VEZ QUE VAYA RECOGIENDO

			--SE UBICA IDENTIFICADOR EN BASE A [KEY] O CLAVE DEL NIVEL O ESTATUS DE INVENTARIO
			IF(ISNULL(@CurrentStock, 0) = 0)			
				SET @StockStatusId = @OutOfStockId --Status nulo
			ELSE IF (@CurrentStock <= @MinStock)
				SET @StockStatusId = @LowStockId --Status bajo
			ELSE
				SET @StockStatusId = @InStockId --Status bien/alto

			--SE ACTUALIZA LA INFORMACIÓN EN BASE AL CÁLCULO PREVIO
			UPDATE Products
			SET Stock_Status_Id = @StockStatusId
			WHERE Id = @ProductId

			--PASAMOS AL SIG. RENGLÓN
			FETCH NEXT FROM cursor_products INTO @ProductId, @CurrentStock, @MinStock
		END
		--SE CIERRA BLOQUE DE EJECUCIÓN (CICLO)

		CLOSE cursor_products
		DEALLOCATE cursor_products

	END
END