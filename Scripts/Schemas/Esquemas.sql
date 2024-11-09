-- Verificar y crear el esquema 'Products'
IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'Products')
BEGIN
    EXEC('CREATE SCHEMA Products');
END

-- Verificar y crear el esquema 'Product_Configurations'
IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'Product_Configurations')
BEGIN
    EXEC('CREATE SCHEMA Product_Configurations');
END

-- Verificar y crear el esquema 'Carts'
IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'Carts')
BEGIN
    EXEC('CREATE SCHEMA Carts');
END

-- Verificar y crear el esquema 'Cart_Items'
IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'Cart_Items')
BEGIN
    EXEC('CREATE SCHEMA Cart_Items');
END

-- Verificar y crear el esquema 'Orders'
IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'Orders')
BEGIN
    EXEC('CREATE SCHEMA Orders');
END

-- Verificar y crear el esquema 'Order_Items'
IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'Order_Items')
BEGIN
    EXEC('CREATE SCHEMA Order_Items');
END
