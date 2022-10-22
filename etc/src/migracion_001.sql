CREATE SCHEMA NN 
GO

USE [GD2C2022]
GO

/*
=================================================
================TABLES CREATION==================
=================================================
*/

CREATE TABLE [NN].[Material] (
    material_id int NOT NULL IDENTITY(1,1) PRIMARY KEY,
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

/*
=================================================
================INSERTION LOGIC==================
=================================================
*/

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
	    FETCH NEXT FROM cuponesMigracion INTO @categoria_descripcion
	END
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
GO

/*

First insertion approach

*/

INSERT INTO [NN].[Variante] (tipo_variante_id, variante_descripcion)
SELECT tp.tipo_variante_id,
       m.[PRODUCTO_VARIANTE] as variante_descripcion
FROM [gd_esquema].[Maestra] as m
INNER JOIN [NN].[Tipo_Variante] AS tp
    ON m.[PRODUCTO_TIPO_VARIANTE] = tp.[tipo_variante_descripcion]
WHERE m.[PRODUCTO_TIPO_VARIANTE] IS NOT NULL
group by m.[PRODUCTO_VARIANTE],
       tp.tipo_variante_id
order by tp.tipo_variante_id, m.[PRODUCTO_VARIANTE]
GO

INSERT INTO [NN].[Producto] (material_id, marca_id, categoria_id, producto_codigo, producto_nombre, producto_descripcion)
SELECT material.material_id,
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
GO

INSERT INTO [NN].[Producto_variante] (producto_id, variante_id, producto_variante_codigo, producto_variante_precio, producto_variante_cantidad)
select 1
GO

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

-- Full insertion example

/*
CREATE PROCEDURE NN.InsertCupon (
  @cupon_codigo nvarchar(255),
  @cupon_fecha_desde date,
  @cupon_fecha_hasta date,
  @cupon_importe decimal(18,2),
  @cupon_valor decimal(18,2),
  @cupon_tipo nvarchar(50)
) AS BEGIN
	INSERT INTO [NN].[Cupon] (cupon_codigo, cupon_fecha_desde, cupon_fecha_hasta, cupon_importe, cupon_valor, cupon_tipo)
	VALUES (@cupon_codigo, @cupon_fecha_desde, @cupon_fecha_hasta, @cupon_importe, @cupon_valor, @cupon_tipo)
END

DECLARE @cupon_codigo nvarchar(255),
  @cupon_fecha_desde date,
  @cupon_fecha_hasta date,
  @cupon_importe decimal(18,2),
  @cupon_valor decimal(18,2),
  @cupon_tipo nvarchar(50)
DECLARE cuponesMigracion CURSOR FOR
SELECT DISTINCT m.VENTA_CUPON_CODIGO, m.VENTA_CUPON_FECHA_DESDE, m.VENTA_CUPON_FECHA_HASTA, m.VENTA_CUPON_IMPORTE, m.VENTA_CUPON_VALOR, m.VENTA_CUPON_TIPO
FROM gd_esquema.Maestra m
WHERE VENTA_CUPON_CODIGO IS NOT NULL

OPEN cuponesMigracion
FETCH NEXT FROM cuponesMigracion   
INTO @cupon_codigo,
@cupon_fecha_desde,
@cupon_fecha_hasta,
@cupon_importe,
@cupon_valor,
@cupon_tipo
WHILE @@FETCH_STATUS = 0 BEGIN
  EXEC NN.InsertCupon @cupon_codigo, @cupon_fecha_desde, @cupon_fecha_hasta, @cupon_importe, @cupon_valor, @cupon_tipo

  FETCH NEXT FROM cuponesMigracion   
  INTO @cupon_codigo,
  @cupon_fecha_desde,
  @cupon_fecha_hasta,
  @cupon_importe,
  @cupon_valor,
  @cupon_tipo
END
*/