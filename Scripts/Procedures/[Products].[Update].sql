-- Author:		Andrea Escobar
-- Description:	Actualiza Productos
-- Fecha:		09/11/2024
IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[Products].[Update]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [Products].[Update]
GO
CREATE PROCEDURE [Products].[Update]
	@Id				INT,
	@Name			VARCHAR(255),
	@Description	TEXT,
	@Price			DECIMAL(18,2), 
	@Current_Stock	INT,
	@Max_Stock		INT, 
	@Min_Stock		INT, 
	@Image_Path		VARCHAR(255)
WITH  ENCRYPTION  
AS 
BEGIN	
	UPDATE Products 
	SET Name = @Name, 
		Description = @Description,
		Price = @Price,
		Current_Stock = @Current_Stock,
		Max_Stock = @Max_Stock,
		Min_Stock = @Min_Stock,
		Image_Path = @Image_Path
	WHERE Id = @Id
END
GO
EXEC sp_recompile N'[Products].[Update]';
GO