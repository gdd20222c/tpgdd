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
	(@cod_postal_codigo decimal(18,0))
AS 
BEGIN
	INSERT INTO [NN].[Codigo_Postal] 
		(cod_postal_codigo)
	VALUES 
		(@cod_postal_codigo)
END
GO

CREATE PROCEDURE [NN].[Insert_Provincia] 
	(@provincia_nombre nvarchar(255))
AS 
BEGIN
	INSERT INTO [NN].[Provincia] 
		(provincia_nombre)
	VALUES 
		(@provincia_nombre)
END
GO

CREATE PROCEDURE [NN].[Insert_Localidad] 
	(@localidad_nombre nvarchar(255), @provincia_id int)
AS 
BEGIN
	INSERT INTO [NN].[Localidad] 
		(localidad_nombre, provincia_id)
	VALUES 
		(@localidad_nombre, @provincia_id)
END
GO

CREATE PROCEDURE [NN].[Insert_Cliente] (
		@cliente_nombre nvarchar(255), 
		@cliente_apellido nvarchar(255), 
		@cliente_telefono decimal(18,0), 
		@cliente_dni decimal(18,0), 
		@cliente_mail nvarchar(255), 
		@cliente_fecha_nac date
	)
AS 
BEGIN
	INSERT INTO [NN].[Cliente] (
		cliente_nombre,
		cliente_apellido,
		cliente_telefono,
		cliente_dni,
		cliente_mail,
		cliente_fecha_nac)
	VALUES (
		@cliente_nombre,
		@cliente_apellido,
		@cliente_telefono,
		@cliente_dni,
		@cliente_mail,
		@cliente_fecha_nac
	)
END
GO

CREATE PROCEDURE [NN].[Insert_Cliente_Direccion] (
		@cliente_direccion nvarchar(255), 
		@cliente_id int, 
		@localidad_id int,
		@cod_postal_id int
	)
AS 
BEGIN
	INSERT INTO [NN].[Cliente_Direccion] (
		cliente_direccion, 
		cliente_id, 
		localidad_id,
		cod_postal_id
	)
	VALUES (
		@cliente_direccion, 
		@cliente_id, 
		@localidad_id,
		@cod_postal_id
	)
END
GO

CREATE PROCEDURE [NN].[Insert_Venta_Canal] 
	(@venta_canal_descripcion nvarchar(255), @venta_canal_costo decimal(18,2))
AS 
BEGIN
	INSERT INTO [NN].[Venta_Canal]
		(venta_canal_descripcion, venta_canal_costo)
	VALUES 
		(@venta_canal_descripcion, @venta_canal_costo)
END
GO

CREATE PROCEDURE [NN].[Insert_Venta_Medio_Pago] 
	(@venta_medio_pago_descripcion nvarchar(255), @venta_medio_pago_costo decimal(18,2))
AS 
BEGIN
	INSERT INTO [NN].[Venta_Medio_Pago]
		(venta_medio_pago_descripcion, venta_medio_pago_costo)
	VALUES 
		(@venta_medio_pago_descripcion, @venta_medio_pago_costo)
END
GO

CREATE PROCEDURE [NN].[Insert_Venta_Medio_Envio] (
		@venta_medio_envio_descripcion nvarchar(255), 
		@venta_medio_envio_precio decimal(18,2), 
		@provincia_id int, 
		@cod_postal_id int
	)
AS 
BEGIN
	INSERT INTO [NN].[Venta_Medio_Envio] (
		venta_medio_envio_descripcion, 
		venta_medio_envio_precio, 
		provincia_id, 
		cod_postal_id
	)
	VALUES (
		@venta_medio_envio_descripcion, 
		@venta_medio_envio_precio, 
		@provincia_id, 
		@cod_postal_id
	)
END
GO

/****************** CODIGO POSTAL ******************/

	DECLARE @cod_postal_codigo decimal(18,0)

	DECLARE cod_postal_migracion CURSOR FOR
		SELECT 
			m1.CLIENTE_CODIGO_POSTAL
		FROM [gd_esquema].[Maestra] m1
		WHERE m1.CLIENTE_CODIGO_POSTAL IS NOT NULL
		UNION
		SELECT 
			m2.PROVEEDOR_CODIGO_POSTAL
		FROM [gd_esquema].[Maestra] m2
		WHERE m2.PROVEEDOR_CODIGO_POSTAL IS NOT NULL

	OPEN cod_postal_migracion
	FETCH NEXT FROM cod_postal_migracion INTO @cod_postal_codigo
	WHILE @@FETCH_STATUS = 0 
	BEGIN
		EXEC [NN].[Insert_Codigo_Postal] @cod_postal_codigo
		FETCH NEXT FROM cod_postal_migracion INTO @cod_postal_codigo
	END

	CLOSE cod_postal_migracion
	DEALLOCATE cod_postal_migracion
GO

/****************** PROVINCIA ******************/

	DECLARE @provincia_nombre nvarchar(255)

	DECLARE provincia_migracion CURSOR FOR
		SELECT 
			m1.CLIENTE_PROVINCIA
		FROM [gd_esquema].[Maestra] m1
		WHERE m1.CLIENTE_PROVINCIA IS NOT NULL
		UNION
		SELECT 
			m2.PROVEEDOR_PROVINCIA
		FROM [gd_esquema].[Maestra] m2
		WHERE m2.PROVEEDOR_PROVINCIA IS NOT NULL

	OPEN provincia_migracion
	FETCH NEXT FROM provincia_migracion INTO @provincia_nombre
	WHILE @@FETCH_STATUS = 0 
	BEGIN
		EXEC [NN].[Insert_Provincia] @provincia_nombre
		FETCH NEXT FROM provincia_migracion INTO @provincia_nombre
	END

	CLOSE provincia_migracion
	DEALLOCATE provincia_migracion
GO

/****************** LOCALIDAD ******************/

	DECLARE @localidad_nombre nvarchar(255), 
			@provincia_id int

	DECLARE localidad_migracion CURSOR FOR
		SELECT 
			m1.CLIENTE_LOCALIDAD, 
			p.provincia_id  
		FROM [gd_esquema].[Maestra] m1
		JOIN [NN].[Provincia] p ON m1.CLIENTE_PROVINCIA = p.provincia_nombre
		WHERE CLIENTE_LOCALIDAD IS NOT NULL
		UNION
		SELECT 
			m2.PROVEEDOR_LOCALIDAD, 
			p.provincia_id 
		FROM [gd_esquema].[Maestra] m2
		JOIN [NN].Provincia p ON m2.PROVEEDOR_PROVINCIA = p.provincia_nombre
		WHERE PROVEEDOR_LOCALIDAD IS NOT NULL

	OPEN localidad_migracion
	FETCH NEXT FROM localidad_migracion INTO @localidad_nombre, @provincia_id
	WHILE @@FETCH_STATUS = 0 
	BEGIN
		EXEC [NN].[Insert_Localidad] @localidad_nombre, @provincia_id
		FETCH NEXT FROM localidad_migracion INTO @localidad_nombre, @provincia_id
	END

	CLOSE localidad_migracion
	DEALLOCATE localidad_migracion
GO

/****************** CLIENTE ******************/

	DECLARE @cliente_nombre nvarchar(255), 
			@cliente_apellido nvarchar(255), 
			@cliente_telefono decimal(18,0), 
			@cliente_dni decimal(18,0), 
			@cliente_mail nvarchar(255), 
			@cliente_fecha_nac date

	DECLARE cliente_migracion CURSOR FOR
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

	OPEN cliente_migracion
	FETCH NEXT FROM cliente_migracion INTO 
			@cliente_nombre, 
			@cliente_apellido, 
			@cliente_telefono, 
			@cliente_dni, 
			@cliente_mail, 
			@cliente_fecha_nac
	WHILE @@FETCH_STATUS = 0 
	BEGIN
		EXEC [NN].[Insert_Cliente]			
			@cliente_nombre, 
			@cliente_apellido, 
			@cliente_telefono, 
			@cliente_dni, 
			@cliente_mail, 
			@cliente_fecha_nac
		FETCH NEXT FROM cliente_migracion INTO
			@cliente_nombre, 
			@cliente_apellido, 
			@cliente_telefono, 
			@cliente_dni, 
			@cliente_mail, 
			@cliente_fecha_nac
	END

	CLOSE cliente_migracion
	DEALLOCATE cliente_migracion
GO

/****************** CLIENTE DIRECCION ******************/
/** arreglar**/
	DECLARE 
		@cliente_direccion nvarchar(255), 
		@cliente_id int, 
		@localidad_id int, 
		@cod_postal_id int

	DECLARE cliente_direccion_migracion CURSOR FOR
		SELECT DISTINCT
			m.CLIENTE_DIRECCION,
			c.cliente_id,
			l.localidad_id,
			cp.cod_postal_id
		FROM [gd_esquema].[Maestra] m
		JOIN [NN].[Cliente] c ON c.cliente_dni = m.CLIENTE_DNI and c.cliente_apellido != m.CLIENTE_APELLIDO
		JOIN [NN].[Localidad] l ON l.localidad_nombre = m.CLIENTE_LOCALIDAD
		JOIN [NN].[Codigo_Postal] cp ON cp.cod_postal_codigo = m.CLIENTE_CODIGO_POSTAL
		WHERE m.CLIENTE_DIRECCION IS NOT NULL

	OPEN cliente_direccion_migracion
	FETCH NEXT FROM cliente_direccion_migracion INTO 
			@cliente_direccion, 
			@cliente_id, 
			@localidad_id, 
			@cod_postal_id
	WHILE @@FETCH_STATUS = 0 
	BEGIN
		EXEC [NN].[Insert_Cliente_Direccion]			
			@cliente_direccion, 
			@cliente_id, 
			@localidad_id, 
			@cod_postal_id
		FETCH NEXT FROM cliente_direccion_migracion INTO
			@cliente_direccion, 
			@cliente_id, 
			@localidad_id, 
			@cod_postal_id
	END

	CLOSE cliente_direccion_migracion
	DEALLOCATE cliente_direccion_migracion
GO

/****************** VENTA CANAL ******************/

	DECLARE @venta_canal_descripcion nvarchar(255), 
			@venta_canal_costo decimal(18,2)

	DECLARE venta_canal_migracion CURSOR FOR
		SELECT DISTINCT
			m1.VENTA_CANAL, 
			m1.VENTA_CANAL_COSTO
		FROM [gd_esquema].[Maestra] m1
		WHERE m1.VENTA_CANAL IS NOT NULL

	OPEN venta_canal_migracion
	FETCH NEXT FROM venta_canal_migracion INTO @venta_canal_descripcion, @venta_canal_costo
	WHILE @@FETCH_STATUS = 0 
	BEGIN
		EXEC [NN].[Insert_Venta_Canal] @venta_canal_descripcion, @venta_canal_costo
		FETCH NEXT FROM venta_canal_migracion INTO @venta_canal_descripcion, @venta_canal_costo
	END

	CLOSE venta_canal_migracion
	DEALLOCATE venta_canal_migracion
GO

/****************** VENTA MEDIO PAGO ******************/

	DECLARE @venta_medio_pago_descripcion nvarchar(255), 
			@venta_medio_pago_costo decimal(18,2)

	DECLARE venta_medio_pago_migracion CURSOR FOR
		SELECT DISTINCT
			m1.VENTA_MEDIO_PAGO, 
			m1.VENTA_MEDIO_PAGO_COSTO
		FROM [gd_esquema].[Maestra] m1
		WHERE m1.VENTA_MEDIO_PAGO IS NOT NULL

	OPEN venta_medio_pago_migracion
	FETCH NEXT FROM venta_medio_pago_migracion INTO @venta_medio_pago_descripcion, @venta_medio_pago_costo
	WHILE @@FETCH_STATUS = 0 
	BEGIN
		EXEC [NN].[Insert_Venta_Medio_Pago] @venta_medio_pago_descripcion, @venta_medio_pago_costo
		FETCH NEXT FROM venta_medio_pago_migracion INTO @venta_medio_pago_descripcion, @venta_medio_pago_costo
	END

	CLOSE venta_medio_pago_migracion
	DEALLOCATE venta_medio_pago_migracion
GO

/****************** VENTA MEDIO ENVIO ******************/
/** arreglar**/
	DECLARE @venta_medio_envio_descripcion nvarchar(255), 
			@venta_medio_envio_precio decimal(18,2), 
			@provincia_id int, 
			@cod_postal_id int

	DECLARE venta_medio_envio_migracion CURSOR FOR
		SELECT
			m1.VENTA_MEDIO_ENVIO, 
			m1.VENTA_ENVIO_PRECIO,
			p.provincia_id,
			cp.cod_postal_id 
		FROM [gd_esquema].[Maestra] m1
		JOIN [NN].[Provincia] p ON m1.CLIENTE_PROVINCIA = p.provincia_nombre 
		JOIN [NN].[Codigo_Postal] cp ON m1.CLIENTE_CODIGO_POSTAL = cp.cod_postal_codigo 
		WHERE m1.VENTA_MEDIO_ENVIO IS NOT NULL
			

	OPEN venta_medio_envio_migracion
	FETCH NEXT FROM venta_medio_envio_migracion INTO
			@venta_medio_envio_descripcion, 
			@venta_medio_envio_precio, 
			@provincia_id, 
			@cod_postal_id
	WHILE @@FETCH_STATUS = 0 
	BEGIN
		EXEC [NN].[Insert_Venta_Medio_Envio] 
			@venta_medio_envio_descripcion, 
			@venta_medio_envio_precio, 
			@provincia_id, 
			@cod_postal_id
		FETCH NEXT FROM venta_medio_envio_migracion INTO 
			@venta_medio_envio_descripcion, 
			@venta_medio_envio_precio, 
			@provincia_id, 
			@cod_postal_id
	END

	CLOSE venta_medio_envio_migracion
	DEALLOCATE venta_medio_envio_migracion
GO


