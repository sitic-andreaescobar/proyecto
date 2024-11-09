IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'MiEsquema')
BEGIN
    EXEC('CREATE SCHEMA MiEsquema');
END
