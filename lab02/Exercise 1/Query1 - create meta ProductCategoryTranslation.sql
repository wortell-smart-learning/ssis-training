USE AdventureWorks2016
GO

IF OBJECT_ID('meta.ProductCategoryTranslation', 'U') IS NOT NULL
	DROP TABLE meta.ProductCategoryTranslation;

GO
CREATE TABLE meta.ProductCategoryTranslation (
	[id] BIGINT IDENTITY(1,1)
	, [Name] NVARCHAR(50)
	, [FrenchTranslation] NVARCHAR(50)
	, [SpanishTranslation] NVARCHAR(50)
)
GO
INSERT INTO meta.ProductCategoryTranslation ([Name], [SpanishTranslation], [FrenchTranslation])
VALUES
('Bikes', 'Bicicleta', 'Vélo')
, ('Components', 'Componente', 'Composant')
, ('Clothing', 'Prenda', 'Vêtements')
, ('Accessories', 'Accesorio', 'Accessoire');
GO