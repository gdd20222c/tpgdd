CREATE SCHEMA NN 
GO

USE [GD2C2022]
GO


--Tables


CREATE TABLE [NN].[Codigo_Postal] (
	cod_postal_id int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	cod_postal_codigo decimal(18,0) NOT NULL
)
GO

CREATE TABLE [NN].[Provincia] (
	provincia_id int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	provincia_nombre nvarchar(255) NOT NULL
)
GO

CREATE TABLE [NN].[Localidad] (
	localidad_id int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	localidad_nombre nvarchar(255) NOT NULL,
	provincia_id int NOT NULL FOREIGN KEY REFERENCES [NN].[Provincia](provincia_id)
	
)
GO

CREATE TABLE [NN].[Cliente] (
    cliente_id int NOT NULL IDENTITY(1,1) PRIMARY KEY,
    cliente_nombre nvarchar(255) NOT NULL,
	cliente_apellido nvarchar(255) NOT NULL,
	cliente_telefono decimal(18,0) NOT NULL,
	cliente_dni decimal(18,0) NOT NULL,
	cliente_mail nvarchar(255) NOT NULL,
	cliente_fecha_nac date NOT NULL,
)
GO

CREATE TABLE [NN].[Cliente_Direccion] (
	cliente_direccion_id int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	cliente_direccion nvarchar(255) NOT NULL,
	cliente_id int NOT NULL FOREIGN KEY REFERENCES [NN].[Cliente](cliente_id),
	localidad_id int NOT NULL FOREIGN KEY REFERENCES [NN].[Localidad](localidad_id),
	cod_postal_id int NOT NULL FOREIGN KEY REFERENCES [NN].[Codigo_Postal](cod_postal_id)
)
GO

CREATE TABLE [NN].[Venta_Canal](
	venta_canal_id int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	venta_canal_descripcion nvarchar(255) NOT NULL,
	venta_canal_costo decimal(18,2) NOT NULL
)
GO

CREATE TABLE [NN].[Venta_Medio_Pago](
	venta_medio_pago_id int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	venta_medio_pago_descripcion nvarchar(255) NOT NULL,
	venta_medio_pago_costo decimal(18,2) NOT NULL,
)
GO

CREATE TABLE [NN].[Venta_Medio_Envio](
	venta_medio_envio_id int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	venta_medio_envio_descripcion nvarchar(255) NOT NULL,
	venta_medio_envio_precio decimal(18,2) NOT NULL,
	provincia_id int NOT NULL FOREIGN KEY REFERENCES [NN].[Provincia](provincia_id),
	cod_postal_id int NOT NULL FOREIGN KEY REFERENCES [NN].[Codigo_Postal](cod_postal_id)
)
GO


--Inserts

CREATE PROCEDURE [NN].[Insert_Codigo_Postal] 
AS
BEGIN
	INSERT INTO [NN].[Codigo_Postal] 
	(cod_postal_codigo)
		SELECT 
			m1.CLIENTE_CODIGO_POSTAL 
		FROM [gd_esquema].[Maestra] m1
		WHERE m1.CLIENTE_CODIGO_POSTAL IS NOT NULL
		UNION
		SELECT 
			m2.PROVEEDOR_CODIGO_POSTAL
		FROM [gd_esquema].[Maestra] m2
		WHERE m2.PROVEEDOR_CODIGO_POSTAL IS NOT NULL
END
GO

CREATE PROCEDURE [NN].[Insert_Provincia] 
AS
BEGIN
	INSERT INTO [NN].[Provincia] 
	(provincia_nombre)
		SELECT 
			m1.CLIENTE_PROVINCIA
		FROM [gd_esquema].[Maestra] m1
		WHERE m1.CLIENTE_PROVINCIA IS NOT NULL
		UNION
		SELECT 
			m2.PROVEEDOR_PROVINCIA
		FROM [gd_esquema].[Maestra] m2
		WHERE m2.PROVEEDOR_PROVINCIA IS NOT NULL
END
GO

CREATE PROCEDURE [NN].[Insert_Localidad] 
AS
BEGIN
	INSERT INTO [NN].[Localidad] 
	(localidad_nombre,provincia_id)
		SELECT 
			m1.CLIENTE_LOCALIDAD, 
			p.provincia_id  
		FROM [gd_esquema].[Maestra] m1
		JOIN [NN].[Provincia] p ON m1.CLIENTE_PROVINCIA = p.provincia_nombre --a testear - quiza necesite index
		WHERE CLIENTE_LOCALIDAD IS NOT NULL
		UNION
		SELECT 
			m1.PROVEEDOR_LOCALIDAD, 
			m1.PROVEEDOR_PROVINCIA 
		FROM [gd_esquema].[Maestra] m1
		WHERE PROVEEDOR_LOCALIDAD IS NOT NULL
END
GO

CREATE PROCEDURE [NN].[Insert_Cliente] 
AS
BEGIN
	INSERT INTO [NN].[Cliente] 
	(cliente_nombre, cliente_apellido, cliente_telefono, cliente_dni, cliente_mail, cliente_fecha_nac)
		SELECT DISTINCT
			m1.CLIENTE_NOMBRE, 
			m1.CLIENTE_APELLIDO, 
			m1.CLIENTE_TELEFONO, 
			m1.CLIENTE_DNI, 
			m1.CLIENTE_MAIL, 
			m1.CLIENTE_FECHA_NAC
		FROM [gd_esquema].[Maestra] m1
		WHERE
			m1.CLIENTE_NOMBRE IS NOT NULL AND
			m1.CLIENTE_APELLIDO IS NOT NULL AND
			m1.CLIENTE_TELEFONO IS NOT NULL AND
			m1.CLIENTE_DNI IS NOT NULL AND
			m1.CLIENTE_MAIL IS NOT NULL AND
			m1.CLIENTE_FECHA_NAC IS NOT NULL 
END
GO

--Resolver insert de domicilio

CREATE PROCEDURE [NN].[Insert_Venta_Canal] 
AS
BEGIN
	INSERT INTO [NN].[Venta_Canal] 
	(venta_canal_descripcion, venta_canal_costo)
		SELECT DISTINCT
			m1.VENTA_CANAL, 
			m1.VENTA_CANAL_COSTO
		FROM [gd_esquema].[Maestra] m1
		WHERE
			m1.VENTA_CANAL IS NOT NULL
END
GO

CREATE PROCEDURE [NN].[Insert_Venta_Medio_Pago] 
AS
BEGIN
	INSERT INTO [NN].[Venta_Medio_Pago] 
	(venta_medio_pago_descripcion, venta_medio_pago_costo)
		SELECT DISTINCT
			m1.VENTA_MEDIO_PAGO, 
			m1.VENTA_MEDIO_PAGO_COSTO
		FROM [gd_esquema].[Maestra] m1
		WHERE
			m1.VENTA_MEDIO_PAGO IS NOT NULL
END
GO

CREATE PROCEDURE [NN].[Insert_Venta_Medio_Envio] 
AS
BEGIN
	INSERT INTO [NN].[Venta_Medio_Envio] 
	(venta_medio_envio_descripcion, venta_medio_envio_precio, provincia_id, cod_postal_id)
		SELECT DISTINCT
			m1.VENTA_MEDIO_ENVIO, 
			m1.VENTA_ENVIO_PRECIO,
			p.provincia_id,
			cp.cod_postal_id 
		FROM [gd_esquema].[Maestra] m1
		JOIN [NN].[Provincia] p ON m1.CLIENTE_PROVINCIA = p.provincia_nombre --a testear - quiza necesite index
		JOIN [NN].[Codigo_Postal] cp ON m1.CLIENTE_CODIGO_POSTAL = cp.cod_postal_codigo --a testear - quiza necesite index
		WHERE
			m1.VENTA_MEDIO_ENVIO IS NOT NULL
END
GO


EXEC [NN].[Insert_Codigo_Postal]
EXEC [NN].[Insert_Provincia]
EXEC [NN].[Insert_Localidad]
EXEC [NN].[Insert_Cliente]
--EXEC [NN].[Insert_Cliente_Direccion]
EXEC [NN].[Insert_Venta_Canal]
EXEC [NN].[Insert_Venta_Medio_Pago]
EXEC [NN].[Insert_Venta_Medio_Envio]
GO

