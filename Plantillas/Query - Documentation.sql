DECLARE @NombreTabla VARCHAR(255)= 'Orders' 

SELECT 
    objname AS [NombreObjeto],
    name AS [Propiedad],
    value AS [Descripción]
FROM 
    fn_listextendedproperty ('MS_Description', 'SCHEMA', 'dbo', 'TABLE', @NombreTabla, NULL, NULL);

 SELECT
    col.name AS 'Columna',
    prop.name AS 'Nombre de la Propiedad Extendida',
    prop.value AS 'Valor de la Propiedad Extendida'
FROM sys.columns col
	JOIN sys.extended_properties prop ON col.object_id = prop.major_id AND col.column_id = prop.minor_id
WHERE
    col.object_id = OBJECT_ID(@NombreTabla); -- Nombre de la tabla
