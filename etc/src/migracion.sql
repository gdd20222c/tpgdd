CREATE SCHEMA NN 
GO

USE [GD2C2022]
GO

/*
=================================================
================TABLES CREATION==================
=================================================
*/
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

CREATE TABLE [NN].[Cliente_Direccion] (
	cliente_direccion_id int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	cliente_direccion nvarchar(255) NOT NULL,
	localidad_id int NOT NULL FOREIGN KEY REFERENCES [NN].[Localidad](localidad_id),
	cod_postal_id int NOT NULL FOREIGN KEY REFERENCES [NN].[Codigo_Postal](cod_postal_id)
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
	cliente_direccion_id int NOT NULL FOREIGN KEY REFERENCES [NN].[Cliente_Direccion](cliente_direccion_id)
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
	localidad_id int NOT NULL FOREIGN KEY REFERENCES [NN].[Localidad](localidad_id),
	cod_postal_id int NOT NULL FOREIGN KEY REFERENCES [NN].[Codigo_Postal](cod_postal_id)
)
GO

CREATE TABLE [NN].[Material] (
    material_id int NOT NULL IDENTITY(1,1) PRIMAeRY KEY,
    material_descripcion nvarchar(50) NOT NULL
)
GO

CREATE TABLE [NN].[Marca] (
    marca_id int NOT NULL IDENTITY(1,1) PRIMARY KEY,
    marca_descripcion nvarchar(255) NOT NULL
)
GO

CREATE TABLE [NN].[Categoria] (
    categoria_id int NOT NULL IDENTITY(1,1) PRIMARY KEY,
    categoria_descripcion nvarchar(255) NOT NULL
)
GO

CREATE TABLE [NN].[Tipo_Variante] (
    tipo_variante_id int NOT NULL IDENTITY(1,1) PRIMARY KEY,
    tipo_variante_descripcion nvarchar(50) NOT NULL
)
GO

CREATE TABLE [NN].[Variante] (
    variante_id int NOT NULL IDENTITY(1,1) PRIMARY KEY,
    tipo_variante_id int NOT NULL FOREIGN KEY REFERENCES [NN].[Tipo_Variante](tipo_variante_id),
    variante_descripcion nvarchar(50) NOT NULL
)
GO

CREATE TABLE [NN].[Producto] (
    producto_id int NOT NULL IDENTITY(1,1) PRIMARY KEY,
    material_id int NOT NULL FOREIGN KEY REFERENCES [NN].[Material](material_id),
    marca_id int NOT NULL FOREIGN KEY REFERENCES [NN].[Marca](marca_id),
    categoria_id int NOT NULL FOREIGN KEY REFERENCES [NN].[Categoria](categoria_id),
    producto_codigo nvarchar(50) NOT NULL,
    producto_nombre nvarchar(50) NOT NULL,
    producto_descripcion nvarchar(50) NOT NULL
)
GO

CREATE TABLE [NN].[Producto_variante] (
    producto_variante_id int NOT NULL IDENTITY(1,1) PRIMARY KEY,
    producto_id int NOT NULL FOREIGN KEY REFERENCES [NN].[Producto](producto_id),
    variante_id int NOT NULL FOREIGN KEY REFERENCES [NN].[Variante](variante_id),
    producto_variante_codigo nvarchar(50) NOT NULL,
    producto_variante_precio decimal(18,2) NOT NULL,
    producto_variante_cantidad decimal(18,0) NOT NULL
)
GO

CREATE TABLE NN.Proveedor_direccion(
	proveedor_direccion_id int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	proveedor_direccion_domicilio NVARCHAR(50)	NOT NULL,
	localidad_id int NOT NULL FOREIGN KEY REFERENCES [NN].Localidad(localidad_id),
	codigo_postal_id int NOT NULL FOREIGN KEY REFERENCES [NN].Codigo_Postal(cod_postal_id),
)
GO

CREATE TABLE NN.Proveedor(
	proveedor_id int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	proveedor_cuit NVARCHAR(50)	NOT NULL,
	proveedor_razon_social NVARCHAR(50)	NOT NULL,
	proveedor_mail NVARCHAR(50)	NOT NULL,
	proveedor_direccion_id  int NOT NULL FOREIGN KEY REFERENCES [NN].Proveedor(proveedor_id),
)
GO

CREATE TABLE NN.Compra(
	compra_id int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	proveedor_id int NOT NULL FOREIGN KEY REFERENCES [NN].Proveedor(proveedor_id),
	compra_numero DECIMAL(19,0) NOT NULL,
	compra_fecha DATE NOT NULL,
	compra_medio_pago NVARCHAR(255) NOT NULL,
	compra_total DECIMAL(18,2) NOT NULL
)
GO

CREATE TABLE NN.Compra_descuento(
	compra_descuento_id int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	compra_id int NOT NULL FOREIGN KEY REFERENCES [NN].Proveedor(proveedor_id),
	compra_descuento_valor DECIMAL(18,2) NOT NULL
)
GO

CREATE TABLE [NN].[Compra_Producto] (
    compra_id int NOT NULL FOREIGN KEY REFERENCES [NN].[Compra](compra_id),
    producto_variante_id int NOT NULL FOREIGN KEY REFERENCES [NN].[Producto_Variante](producto_variante_id),
    compra_producto_precio decimal(18,2) NOT NULL,
    compra_producto_cantidad decimal(18,0) NOT NULL
)
GO

CREATE TABLE [NN].[Tipo_Descuento] (
    tipo_descuento_id int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	tipo_descuento_concepto nvarchar(255) NOT NULL,
	venta_descuento_importe decimal(18,2) NOT NULL,
)
GO
GO

CREATE TABLE [NN].[Cupon] (
    cupon_id int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	cupon_codigo nvarchar(255) NOT NULL,
    cupon_fecha_desde date NOT NULL,
    cupon_fecha_hasta date NOT NULL,
    cupon_importe decimal(18,2) NOT NULL,
    cupon_valor decimal(18,2) NOT NULL,
    cupon_tipo nvarchar(50) NOT NULL,
)
GO

CREATE TABLE [NN].[Venta](
	venta_id int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	cliente_id int NOT NULL FOREIGN KEY REFERENCES [NN].[Cliente](cliente_id),
	venta_codigo decimal(19,0) NOT NULL,
	venta_fecha date NOT NULL,
	venta_total decimal(18,2) NOT NULL,
	venta_canal_id int NOT NULL FOREIGN KEY REFERENCES [NN].[Venta_canal](venta_canal_id),
	venta_canal_costo decimal(18,2) NOT NULL,
	venta_medio_envio_id int NOT NULL FOREIGN KEY REFERENCES [NN].[Venta_medio_envio](venta_medio_envio_id),
	venta_envio_precio decimal(18,2) NOT NULL,
	venta_medio_pago_id int NOT NULL FOREIGN KEY REFERENCES [NN].[Venta_medio_pago](venta_medio_pago_id),
	venta_medio_pago_costo decimal(18,2) NOT NULL,
)
GO

CREATE TABLE [NN].[Venta_Producto] (
    venta_id int NOT NULL FOREIGN KEY REFERENCES [NN].[Venta](venta_id),
    producto_variante_id int NOT NULL FOREIGN KEY REFERENCES [NN].[Producto_variante](producto_variante_id),
    venta_producto_precio decimal(18,2) NOT NULL,
    venta_producto_cantidad decimal(18,0) NOT NULL
)
GO

CREATE TABLE [NN].[Venta_Descuento] (
    venta_descuento_id int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	venta_id int NOT NULL FOREIGN KEY REFERENCES [NN].[Venta](venta_id),
	tipo_descuento_id int NOT NULL FOREIGN KEY REFERENCES [NN].[Tipo_Descuento](tipo_descuento_id),
	venta_descuento_importe decimal(18,2) NOT NULL,
)
GO

CREATE TABLE [NN].[Venta_Cupon] (
	venta_id int NOT NULL FOREIGN KEY REFERENCES [NN].[Venta](venta_id),
    cupon_id int NOT NULL FOREIGN KEY REFERENCES [NN].[Cupon](cupon_id),
	venta_cupon_importe decimal(18,2) NOT NULL,
)
GO

/*
=================================================
================INDEXES CREATION=================
=================================================
*/



/*
=================================================
================STORE PROCEDURES=================
=================================================
*/

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

CREATE PROCEDURE [NN].[Insert_Cliente_Direccion] (
		@cliente_direccion nvarchar(255), 
		@localidad_id int,
		@cod_postal_id int
	)
AS 
BEGIN
	INSERT INTO [NN].[Cliente_Direccion] (
		cliente_direccion, 
		localidad_id,
		cod_postal_id
	)
	VALUES (
		@cliente_direccion, 
		@localidad_id,
		@cod_postal_id
	)
END
GO

CREATE PROCEDURE [NN].[Insert_Cliente] (
		@cliente_nombre nvarchar(255), 
		@cliente_apellido nvarchar(255), 
		@cliente_telefono decimal(18,0), 
		@cliente_dni decimal(18,0), 
		@cliente_mail nvarchar(255), 
		@cliente_fecha_nac date,
		@cliente_direccion_id int
	)
AS 
BEGIN
	INSERT INTO [NN].[Cliente] (
		cliente_nombre,
		cliente_apellido,
		cliente_telefono,
		cliente_dni,
		cliente_mail,
		cliente_fecha_nac,
		cliente_direccion_id)
	VALUES (
		@cliente_nombre,
		@cliente_apellido,
		@cliente_telefono,
		@cliente_dni,
		@cliente_mail,
		@cliente_fecha_nac,
		@cliente_direccion_id
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
		@localidad_id int, 
		@cod_postal_id int
	)
AS 
BEGIN
	INSERT INTO [NN].[Venta_Medio_Envio] (
		venta_medio_envio_descripcion, 
		venta_medio_envio_precio, 
		localidad_id, 
		cod_postal_id
	)
	VALUES (
		@venta_medio_envio_descripcion, 
		@venta_medio_envio_precio, 
		@localidad_id, 
		@cod_postal_id
	)
END
GO

CREATE PROCEDURE NN.Insert_Categoria(
  @categoria_descripcion nvarchar(255)
) AS BEGIN
	INSERT INTO [NN].[Categoria] (categoria_descripcion)
	VALUES (@categoria_descripcion)
END
GO

CREATE PROCEDURE NN.Insert_Marca(
  @marca_descripcion nvarchar(255)
) AS BEGIN
	INSERT INTO [NN].[Marca] (marca_descripcion)
	VALUES (@marca_descripcion)
END
GO

CREATE PROCEDURE NN.Insert_Material(
  @material_descripcion nvarchar(255)
) AS BEGIN
	INSERT INTO [NN].[Material] (material_descripcion)
	VALUES (@material_descripcion)
END
GO

CREATE PROCEDURE NN.Insert_Tipo_variante(
  @tipo_variante_descripcion nvarchar(255)
) AS BEGIN
	INSERT INTO [NN].[Tipo_Variante] (tipo_variante_descripcion)
	VALUES (@tipo_variante_descripcion)
END
GO

CREATE PROCEDURE NN.Insert_Variante(
  @tipo_variante_id int,
  @variante_descripcion varchar(50)
) AS BEGIN
	INSERT INTO [NN].[Variante] (tipo_variante_id, variante_descripcion)
	VALUES (@tipo_variante_id, @variante_descripcion)
END
GO

CREATE PROCEDURE NN.Insert_Producto(
  @material_id int,
  @marca_id int, 
  @categoria_id int,
  @producto_codigo nvarchar(50),
  @producto_nombre nvarchar(50),
  @producto_descripcion nvarchar(50)
) AS BEGIN
	INSERT INTO [NN].[Producto] (material_id, marca_id, categoria_id, producto_codigo, producto_nombre, producto_descripcion)
	VALUES (@material_id, @marca_id, @categoria_id, @producto_codigo, @producto_nombre, @producto_descripcion)
END
GO

CREATE PROCEDURE NN.Insert_Producto_Variante(
  	@producto_id int,
    @variante_id int,
    @producto_variante_codigo nvarchar(50),
    @producto_variante_precio decimal(18,2),
    @producto_variante_cantidad decimal(18,0)
) AS BEGIN
	INSERT INTO [NN].[Producto_Variante] (producto_id, variante_id, producto_variante_codigo, producto_variante_precio, producto_variante_cantidad)
	VALUES (@producto_id, @variante_id, @producto_variante_codigo, @producto_variante_precio, @producto_variante_cantidad)
END
GO

CREATE PROCEDURE NN.Insert_Venta_Producto(
  	@venta_id int,
    @producto_variante_id int,
    @venta_producto_precio decimal(18,2),
    @venta_producto_cantidad decimal(18,0)
) AS BEGIN
	INSERT INTO [NN].[Producto_Variante] (venta_id, producto_variante_id, venta_producto_precio, venta_producto_cantidad)
	VALUES (@venta_id, @producto_variante_id, @venta_producto_precio, @venta_producto_cantidad)
END
GO

CREATE PROCEDURE NN.Insert_Compra_Producto(
  	@compra_id int,
    @producto_variante_id int,
    @compra_producto_precio decimal(18,2),
    @compra_producto_cantidad decimal(18,0)
) AS BEGIN
	INSERT INTO [NN].[Producto_Variante] (compra_id, producto_variante_id, compra_producto_precio, compra_producto_cantidad)
	VALUES (@compra_id, @producto_variante_id, @compra_producto_precio, @compra_producto_cantidad)
END
GO


CREATE PROCEDURE NN.Insert_Proveedor_direccion(
	@proveedor_direccion_domicilio NVARCHAR(50),
	@localidad_id INT,
	@codigo_postal_id INT 
) AS BEGIN
	INSERT INTO Proveedor_direccion (proveedor_direccion_domicilio, localidad_id, codigo_postal_id)
	VALUES (@proveedor_direccion_domicilio, @localidad_id, @codigo_postal_id)
END
GO

CREATE PROCEDURE NN.Insert_Proveedor(
	@proveedor_cuit NVARCHAR(50),
	@proveedor_razon_social NVARCHAR(50),
	@proveedor_mail NVARCHAR(50),
	@proveedor_direccion_id  INT 
) AS BEGIN
	INSERT INTO Proveedor(proveedor_cuit, proveedor_razon_social, proveedor_mail, proveedor_direccion_id)
	VALUES (@proveedor_cuit, @proveedor_razon_social, @proveedor_mail, @proveedor_direccion_id)
END
GO

CREATE PROCEDURE NN.Insert_Compra(
	@proveedor_id INT,
	@compra_numero DECIMAL(19,0),
	@compra_fecha DATE,
	@compra_medio_pago NVARCHAR(255),
	@compra_total DECIMAL(18,2) 
) AS BEGIN
	INSERT INTO Compra(proveedor_id, compra_numero, compra_fecha, compra_medio_pago, compra_total)
	VALUES (@proveedor_id, @compra_numero, @compra_fecha, @compra_medio_pago, @compra_total)

END
GO

CREATE PROCEDURE NN.Insert_Compra_descuento(
	@compra_id INT,
	@compra_descuento_valor DECIMAL(18,2) 
) AS BEGIN
	INSERT INTO Compra_descuento(compra_id ,compra_descuento_valor)
	VALUES(@compra_id, @compra_descuento_valor)
END
GO

/*
=================================================
================INSERTION LOGIC==================
=================================================
*/

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

/****************** CLIENTE DIRECCION ******************/
	DECLARE 
		@cliente_direccion nvarchar(255), 
		@localidad_id int, 
		@cod_postal_id int

	DECLARE cliente_direccion_migracion CURSOR FOR
		SELECT DISTINCT
			m.CLIENTE_DIRECCION,
			l.localidad_id,
			cp.cod_postal_id
		FROM [gd_esquema].[Maestra] m
		JOIN [NN].[Localidad] l ON l.localidad_nombre = m.CLIENTE_LOCALIDAD
		JOIN [NN].[Provincia] p ON p.provincia_nombre = m.CLIENTE_PROVINCIA
		JOIN [NN].[Codigo_Postal] cp ON cp.cod_postal_codigo = m.CLIENTE_CODIGO_POSTAL
		WHERE m.CLIENTE_DIRECCION IS NOT NULL




	OPEN cliente_direccion_migracion
	FETCH NEXT FROM cliente_direccion_migracion INTO 
			@cliente_direccion, 
			@localidad_id, 
			@cod_postal_id
	WHILE @@FETCH_STATUS = 0 
	BEGIN
		EXEC [NN].[Insert_Cliente_Direccion]			
			@cliente_direccion, 
			@localidad_id, 
			@cod_postal_id
		FETCH NEXT FROM cliente_direccion_migracion INTO
			@cliente_direccion, 
			@localidad_id, 
			@cod_postal_id
	END

	CLOSE cliente_direccion_migracion
	DEALLOCATE cliente_direccion_migracion
GO

/****************** CLIENTE ******************/

	DECLARE @cliente_nombre nvarchar(255), 
			@cliente_apellido nvarchar(255), 
			@cliente_telefono decimal(18,0), 
			@cliente_dni decimal(18,0), 
			@cliente_mail nvarchar(255), 
			@cliente_fecha_nac date,
			@cliente_direccion_id int

	DECLARE cliente_migracion CURSOR FOR
		SELECT DISTINCT
			m1.CLIENTE_NOMBRE, 
			m1.CLIENTE_APELLIDO, 
			m1.CLIENTE_TELEFONO, 
			m1.CLIENTE_DNI, 
			m1.CLIENTE_MAIL, 
			m1.CLIENTE_FECHA_NAC,
			cd.cliente_direccion_id
		FROM [gd_esquema].[Maestra] m1
		JOIN [NN].[Cliente_Direccion] cd
		ON m1.CLIENTE_DIRECCION = cd.cliente_direccion 
		JOIN [NN].[Localidad] l
		ON m1.CLIENTE_LOCALIDAD = l.localidad_nombre
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
			@cliente_fecha_nac,
			@cliente_direccion_id
	WHILE @@FETCH_STATUS = 0 
	BEGIN
		EXEC [NN].[Insert_Cliente]			
			@cliente_nombre, 
			@cliente_apellido, 
			@cliente_telefono, 
			@cliente_dni, 
			@cliente_mail, 
			@cliente_fecha_nac,
			@cliente_direccion_id
		FETCH NEXT FROM cliente_migracion INTO
			@cliente_nombre, 
			@cliente_apellido, 
			@cliente_telefono, 
			@cliente_dni, 
			@cliente_mail, 
			@cliente_fecha_nac,
			@cliente_direccion_id
	END

	CLOSE cliente_migracion
	DEALLOCATE cliente_migracion
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
	DECLARE @venta_medio_envio_descripcion nvarchar(255), 
			@venta_medio_envio_precio decimal(18,2), 
			@localidad_id int, 
			@cod_postal_id int

	DECLARE venta_medio_envio_migracion CURSOR FOR
		SELECT DISTINCT
			m1.VENTA_MEDIO_ENVIO, 
			m1.VENTA_ENVIO_PRECIO,
			l.localidad_id,
			cp.cod_postal_id 
		FROM [gd_esquema].[Maestra] m1
		JOIN [NN].[Localidad] l ON m1.CLIENTE_LOCALIDAD = l.localidad_nombre
		JOIN [NN].[Codigo_Postal] cp ON m1.CLIENTE_CODIGO_POSTAL = cp.cod_postal_codigo 
		WHERE m1.VENTA_MEDIO_ENVIO IS NOT NULL
			

	OPEN venta_medio_envio_migracion
	FETCH NEXT FROM venta_medio_envio_migracion INTO
			@venta_medio_envio_descripcion, 
			@venta_medio_envio_precio, 
			@localidad_id, 
			@cod_postal_id
	WHILE @@FETCH_STATUS = 0 
	BEGIN
		EXEC [NN].[Insert_Venta_Medio_Envio] 
			@venta_medio_envio_descripcion, 
			@venta_medio_envio_precio, 
			@localidad_id, 
			@cod_postal_id
		FETCH NEXT FROM venta_medio_envio_migracion INTO 
			@venta_medio_envio_descripcion, 
			@venta_medio_envio_precio, 
			@localidad_id, 
			@cod_postal_id
	END

	CLOSE venta_medio_envio_migracion
	DEALLOCATE venta_medio_envio_migracion
GO

/********************CATEGORIA**********************/
	DECLARE @categoria_descripcion varchar(255)

	DECLARE categoriaMigration CURSOR FOR
        SELECT DISTINCT m.[PRODUCTO_CATEGORIA]
        FROM [gd_esquema].[Maestra] m
        WHERE m.[PRODUCTO_CATEGORIA] IS NOT NULL
        ORDER BY m.[PRODUCTO_CATEGORIA] ASC

	OPEN categoriaMigration
	FETCH NEXT FROM categoriaMigration INTO @categoria_descripcion
	WHILE @@FETCH_STATUS = 0 BEGIN
	    EXEC NN.Insert_Categoria @categoria_descripcion
	    FETCH NEXT FROM categoriaMigration INTO @categoria_descripcion
	END

	CLOSE categoriaMigration
	DEALLOCATE categoriaMigration
GO

/**********************MARCA**********************/
	DECLARE @marca_descripcion varchar(255)

	DECLARE marcaMigration CURSOR FOR
        SELECT DISTINCT m.[PRODUCTO_MARCA]
        FROM [gd_esquema].[Maestra] m
        WHERE m.[PRODUCTO_MARCA] IS NOT NULL
        ORDER BY m.[PRODUCTO_MARCA] ASC

	OPEN marcaMigration
	FETCH NEXT FROM marcaMigration INTO @marca_descripcion
	WHILE @@FETCH_STATUS = 0 BEGIN
	    EXEC NN.Insert_Marca @marca_descripcion
	    FETCH NEXT FROM marcaMigration INTO @marca_descripcion
	END

	CLOSE marcaMigration
	DEALLOCATE marcaMigration
GO

/*********************MATERIAL********************/
	DECLARE @material_descripcion varchar(255)

	DECLARE materialMigration CURSOR FOR
        SELECT DISTINCT m.[PRODUCTO_MATERIAL]
        FROM [gd_esquema].[Maestra] m
        WHERE m.[PRODUCTO_MATERIAL] IS NOT NULL
        ORDER BY m.[PRODUCTO_MATERIAL] ASC

	OPEN materialMigration
	FETCH NEXT FROM materialMigration INTO @material_descripcion
	WHILE @@FETCH_STATUS = 0 BEGIN
	    EXEC NN.Insert_Material @material_descripcion
	    FETCH NEXT FROM materialMigration INTO @material_descripcion
	END

	CLOSE materialMigration
	DEALLOCATE materialMigration
GO

/******************TIPO VARIANTE******************/
    DECLARE @tipo_variante_descripcion varchar(255)

	DECLARE tipoVarianteMigration CURSOR FOR
        SELECT DISTINCT m.[PRODUCTO_TIPO_VARIANTE]
        FROM [gd_esquema].[Maestra] m
        WHERE m.[PRODUCTO_TIPO_VARIANTE] IS NOT NULL
        ORDER BY m.[PRODUCTO_TIPO_VARIANTE] asc
    
    OPEN tipoVarianteMigration
	FETCH NEXT FROM tipoVarianteMigration INTO @tipo_variante_descripcion
	WHILE @@FETCH_STATUS = 0 BEGIN
	    EXEC NN.Insert_Tipo_variante @tipo_variante_descripcion
	    FETCH NEXT FROM tipoVarianteMigration INTO @tipo_variante_descripcion
	END

	CLOSE tipoVarianteMigration
	DEALLOCATE tipoVarianteMigration
GO

/*********************VARIANTE*********************/
    DECLARE @variante_descripcion varchar(50)
	DECLARE @tipo_variante_id int

	DECLARE varianteMigration CURSOR FOR
        SELECT tp.tipo_variante_id,
			   m.[PRODUCTO_VARIANTE] as variante_descripcion
		FROM [gd_esquema].[Maestra] as m
		INNER JOIN [NN].[Tipo_Variante] AS tp
			ON m.[PRODUCTO_TIPO_VARIANTE] = tp.[tipo_variante_descripcion]
		WHERE m.[PRODUCTO_TIPO_VARIANTE] IS NOT NULL
		GROUP BY m.[PRODUCTO_VARIANTE],
			   tp.tipo_variante_id
		ORDER BY tp.tipo_variante_id, m.[PRODUCTO_VARIANTE]
    
    OPEN varianteMigration 
	FETCH NEXT FROM varianteMigration INTO @tipo_variante_id, @variante_descripcion
	WHILE @@FETCH_STATUS = 0 BEGIN
	    EXEC NN.Insert_Variante @tipo_variante_id, @variante_descripcion 
	    FETCH NEXT FROM varianteMigration INTO @tipo_variante_id, @variante_descripcion
	END

	CLOSE varianteMigration
	DEALLOCATE varianteMigration
GO

/*********************PRODUCTO*********************/
	DECLARE @material_id int
	DECLARE @marca_id int 
	DECLARE @categoria_id int
	DECLARE @producto_codigo nvarchar(50)
	DECLARE @producto_nombre nvarchar(50)
	DECLARE @producto_descripcion nvarchar(50)

	DECLARE productoMigration CURSOR FOR
        SELECT DISTINCT	material.material_id,
				marca.marca_id,
				categoria.categoria_id,
				m.PRODUCTO_CODIGO as producto_codigo,
				m.PRODUCTO_NOMBRE as producto_nombre,
				m.PRODUCTO_DESCRIPCION as producto_descripcion
		FROM [gd_esquema].[Maestra] as m
		inner join [NN].[Material] as material
			on material.material_descripcion = m.PRODUCTO_MATERIAL
		inner join [NN].[Marca] as marca
			on marca.marca_descripcion = m.PRODUCTO_MARCA
		inner join [NN].[Categoria] as categoria
			on categoria.categoria_descripcion = m.PRODUCTO_CATEGORIA
		order by 4	
    OPEN productoMigration 
	FETCH NEXT FROM productoMigration INTO @material_id, @marca_id, @categoria_id, @producto_codigo, @producto_nombre, @producto_descripcion
	WHILE @@FETCH_STATUS = 0 BEGIN
	    EXEC NN.Insert_Producto @material_id, @marca_id, @categoria_id, @producto_codigo, @producto_nombre, @producto_descripcion 
	    FETCH NEXT FROM productoMigration INTO @material_id, @marca_id, @categoria_id, @producto_codigo, @producto_nombre, @producto_descripcion
	END

	CLOSE productoMigration
	DEALLOCATE productoMigration
GO

/*********************PRODUCTO_VARIANTE*********************/
/*
    DECLARE @producto_id int
    DECLARE @variante_id int
    DECLARE @producto_variante_codigo nvarchar(50)
    DECLARE @producto_variante_precio decimal(18,2)
    DECLARE @producto_variante_cantidad decimal(18,0)

	DECLARE productoVarianteMigration 
	CURSOR FOR @producto_id, @variante_id, @producto_variante_codigo, @producto_variante_precio, @producto_variante_cantidad
	-- .SELECT
	OPEN productoVarianteMigration
	FETCH NEXT FROM productoVarianteMigration INTO @producto_id, @variante_id, @producto_variante_codigo, @producto_variante_precio, @producto_variante_cantidad
	WHILE @@FETCH_STATUS = 0 BEGIN
	    EXEC NN.Insert_Producto_Variante @producto_id, @variante_id, @producto_variante_codigo, @producto_variante_precio, @producto_variante_cantidad
	    FETCH NEXT FROM productoVarianteMigration INTO @producto_id, @variante_id, @producto_variante_codigo, @producto_variante_precio, @producto_variante_cantidad
	END

	CLOSE productoVarianteMigration
	DEALLOCATE productoVarianteMigration
GO	
*/
/*********************VENTA_PRODUCTO*********************/
/*
    DECLARE @venta_id int
    DECLARE @producto_variante_id int
    DECLARE @venta_producto_precio decimal(18,2)
    DECLARE @venta_producto_cantidad decimal(18,0)

	DECLARE ventaProductoMigration 
	CURSOR FOR @venta_id, @producto_variante_id, @venta_producto_precio, @venta_producto_cantidad
	-- .SELECT
	OPEN ventaProductoMigration
	FETCH NEXT FROM ventaProductoMigration INTO @venta_id, @producto_variante_id, @venta_producto_precio, @venta_producto_cantidad
	WHILE @@FETCH_STATUS = 0 BEGIN
	    EXEC NN.Insert_Venta_Producto @venta_id, @producto_variante_id, @venta_producto_precio, @venta_producto_cantidad
	    FETCH NEXT FROM ventaProductoMigration INTO @venta_id, @producto_variante_id, @venta_producto_precio, @venta_producto_cantidad
	END

	CLOSE ventaProductoMigration
	DEALLOCATE ventaProductoMigration
GO	
*/
/*********************COMPRA_PRODUCTO*********************/
/*
    DECLARE @compra_id int
    DECLARE @producto_variante_id int
    DECLARE @compra_producto_precio decimal(18,2)
    DECLARE @compra_producto_cantidad decimal(18,0)

	DECLARE compraProductoMigration 
	CURSOR FOR @compra_id, @producto_variante_id, @compra_producto_precio, @compra_producto_cantidad
	-- .SELECT
	OPEN compraProductoMigration
	FETCH NEXT FROM compraProductoMigration INTO @compra_id, @producto_variante_id, @compra_producto_precio, @compra_producto_cantidad
	WHILE @@FETCH_STATUS = 0 BEGIN
	    EXEC NN.Insert_Compra_Producto @compra_id, @producto_variante_id, @compra_producto_precio, @compra_producto_cantidad
	    FETCH NEXT FROM compraProductoMigration INTO @compra_id, @producto_variante_id, @compra_producto_precio, @compra_producto_cantidad
	END

	CLOSE compraProductoMigration
	DEALLOCATE compraProductoMigration
GO	
*/
/*

First insertion approach

*/

INSERT INTO [NN].[Tipo_Descuento] (tipo_descuento_concepto, venta_descuento_importe)
SELECT DISTINCT VENTA_DESCUENTO_CONCEPTO, 0
FROM gd_esquema.Maestra
WHERE VENTA_DESCUENTO_CONCEPTO IS NOT NULL
GO

INSERT INTO [NN].[Venta_Descuento] (venta_id, tipo_descuento_id, venta_descuento_importe)
SELECT v.venta_id, td.tipo_descuento_id, m.VENTA_DESCUENTO_IMPORTE
FROM gd_esquema.Maestra m
JOIN NN.Venta v ON m.VENTA_CODIGO = v.venta_codigo
JOIN NN.Tipo_Descuento td ON m.VENTA_DESCUENTO_CONCEPTO = td.tipo_descuento_concepto
WHERE m.VENTA_DESCUENTO_IMPORTE IS NOT NULL
GO

INSERT INTO [NN].[Venta](cliente_id, venta_codigo, venta_fecha, venta_total, venta_canal_id, venta_canal_costo, venta_medio_envio_id, venta_envio_precio, venta_medio_pago_id, venta_medio_pago_costo)
SELECT c.cliente_id, m.VENTA_CODIGO, m.VENTA_FECHA, m.VENTA_TOTAL, vc.venta_canal_id, m.VENTA_CANAL_COSTO, vme.venta_medio_envio_id, m.VENTA_ENVIO_PRECIO, vmp.venta_medio_pago_id, m.VENTA_MEDIO_PAGO_COSTO
FROM gd_esquema.Maestra m
JOIN NN.Cliente c ON m.CLIENTE_DNI = c.cliente_dni
JOIN NN.Venta_canal vc ON m.VENTA_CANAL = vc.venta_canal_descripcion
JOIN NN.Venta_medio_envio vme ON m.VENTA_MEDIO_ENVIO = vme.venta_medio_envio_descripcion
JOIN NN.Venta_medio_pago vmp ON m.VENTA_MEDIO_PAGO = vmp.venta_medio_pago_descripcion
WHERE m.VENTA_CODIGO IS NOT NULL
GO

INSERT INTO [NN].[Venta_Cupon] (venta_id, cupon_id, venta_cupon_importe)
SELECT v.venta_id, c.cupon_id, m.VENTA_CUPON_IMPORTE
FROM gd_esquema.Maestra m
JOIN NN.Venta v ON m.VENTA_CODIGO = v.venta_codigo
JOIN NN.Cupon c ON m.VENTA_CUPON_CODIGO = c.cupon_codigo
WHERE m.VENTA_CUPON_CODIGO IS NOT NULL
GO

INSERT INTO [NN].[Cupon] (cupon_codigo, cupon_fecha_desde, cupon_fecha_hasta, cupon_importe, cupon_valor, cupon_tipo)
SELECT DISTINCT m.VENTA_CUPON_CODIGO, m.VENTA_CUPON_FECHA_DESDE, m.VENTA_CUPON_FECHA_HASTA, m.VENTA_CUPON_IMPORTE, m.VENTA_CUPON_VALOR, m.VENTA_CUPON_TIPO
FROM gd_esquema.Maestra m
WHERE VENTA_CUPON_CODIGO IS NOT NULL
GO

