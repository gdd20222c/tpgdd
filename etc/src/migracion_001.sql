
USE USE [GD2C2022]
GO

-- Table creation

CREATE TABLE [gd_esquema].[Material] (
    material_id int NOT NULL IDENTITY(1,1) PRIMARY KEY,
    material_descripcion nvarchar(50) NOT NULL
)
GO

CREATE TABLE [gd_esquema].[Marca] (
    marca_id int NOT NULL IDENTITY(1,1) PRIMARY KEY,
    marca_descripcion nvarchar(255) NOT NULL
)
GO

CREATE TABLE [gd_esquema].[Categoria] (
    categoria_id int NOT NULL IDENTITY(1,1) PRIMARY KEY,
    categoria_descripcion nvarchar(255) NOT NULL
)
GO
-- Tamaño, Color, Diseño
CREATE TABLE [gd_esquema].[Tipo_Variante] (
    tipo_variante_id int NOT NULL IDENTITY(1,1) PRIMARY KEY,
    tipo_variante_descripcion nvarchar(50) NOT NULL
)
GO
-- Tamaño, Large
CREATE TABLE [gd_esquema].[Variante] (
    variante_id int NOT NULL IDENTITY(1,1) PRIMARY KEY,
    tipo_variante_id int NOT NULL FOREIGN KEY REFERENCES [gd_esquema].[Tipo_Variante](tipo_variante_id),
    variante_descripcion nvarchar(50) NOT NULL
)
GO


CREATE TABLE [gd_esquema].[Producto] (
    producto_id int NOT NULL IDENTITY(1,1) PRIMARY KEY,
    material_id int NOT NULL FOREIGN KEY REFERENCES [gd_esquema].[Material](material_id),
    marca_id int NOT NULL FOREIGN KEY REFERENCES [gd_esquema].[Marca](marca_id),
    categoria_id int NOT NULL FOREIGN KEY REFERENCES [gd_esquema].[Categoria](categoria_id),
    producto_codigo nvarchar(50) NOT NULL,
    producto_nombre nvarchar(50) NOT NULL,
    producto_descripcion nvarchar(50) NOT NULL
)
GO

CREATE TABLE [gd_esquema].[Producto_variante] (
    producto_variante_id int NOT NULL IDENTITY(1,1) PRIMARY KEY,
    producto_id int NOT NULL FOREIGN KEY REFERENCES [gd_esquema].[Producto](producto_id),
    variante_id int NOT NULL FOREIGN KEY REFERENCES [gd_esquema].[Variante](variante_id),
    producto_variante_codigo nvarchar(50) NOT NULL,
    producto_variante_precio decimal(18,2) NOT NULL,
    producto_variante_cantidad decimal(18,0) NOT NULL
)
GO

CREATE TABLE [gd_esquema].[Venta_Producto] (
    venta_id int NOT NULL FOREIGN KEY REFERENCES [gd_esquema].[Venta](venta_id),
    producto_variante_id int NOT NULL FOREIGN KEY REFERENCES [gd_esquema].[Producto_variante](producto_variante_id),
    venta_producto_precio decimal(18,2) NOT NULL,
    venta_producto_cantidad decimal(18,0) NOT NULL
)
GO

CREATE TABLE [gd_esquema].[Compra_Producto] (
    compra_id int NOT NULL FOREIGN KEY REFERENCES [gd_esquema].[Compra](compra_id),
    producto_variante_id int NOT NULL FOREIGN KEY REFERENCES [gd_esquema].[Producto_Variante](producto_variante_id),
    compra_producto_precio decimal(18,2) NOT NULL,
    compra_producto_cantidad decimal(18,0) NOT NULL
)
GO

CREATE TABLE [gd_esquema].[Tipo_Descuento] (
    tipo_descuento_id int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	tipo_descuento_descripcion nvarchar(255) NOT NULL,
	tipo_descuento_concepto nvarchar(255) NOT NULL,
	venta_descuento_importe decimal(18,2) NOT NULL,
)
GO

CREATE TABLE [gd_esquema].[Venta_Descuento] (
    venta_descuento_id int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	venta_id int NOT NULL FOREIGN KEY REFERENCES [gd_esquema].[Venta](venta_id),
	tipo_descuento_id int NOT NULL FOREIGN KEY REFERENCES [gd_esquema].[Tipo_Descuento](tipo_descuento_id),
	venta_descuento_importe decimal(18,2) NOT NULL,
)
GO

CREATE TABLE [gd_esquema].[Venta](
	venta_id int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	cliente_id int NOT NULL FOREIGN KEY REFERENCES [gd_esquema].[Cliente](cliente_id),
	venta_codigo decimal(19,0) NOT NULL,
	venta_fecha date NOT NULL,
	venta_total decimal(18,2) NOT NULL,
	venta_canal_id int NOT NULL FOREIGN KEY REFERENCES [gd_esquema].[Venta_canal](venta_canal_id),
	venta_canal_costo decimal(18,2) NOT NULL,
	venta_medio_envio_id int NOT NULL FOREIGN KEY REFERENCES [gd_esquema].[Venta_medio_envio](venta_medio_envio_id),
	venta_envio_precio decimal(18,2) NOT NULL,
	venta_medio_pago_id int NOT NULL FOREIGN KEY REFERENCES [gd_esquema].[Venta_medio_pago](venta_medio_pago_id),
	venta_medio_pago_costo decimal(18,2) NOT NULL,
)
GO

CREATE TABLE [gd_esquema].[Venta_Cupon] (
	venta_id int NOT NULL FOREIGN KEY REFERENCES [gd_esquema].[Venta](venta_id),
    cupon_id int NOT NULL FOREIGN KEY REFERENCES [gd_esquema].[Cupon](cupon_id),
	venta_cupon_importe decimal(18,2) NOT NULL,
)
GO

CREATE TABLE [gd_esquema].[Cupon] (
    cupon_id int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	cupon_codigo nvarchar(255) NOT NULL,
    cupon_fecha_desde date NOT NULL,
    cupon_fecha_hasta date NOT NULL,
    cupon_importe decimal(18,2) NOT NULL,
    cupon_valor decimal(18,2) NOT NULL,
    cupon_tipo nvarchar(50) NOT NULL,
)
GO

-- Index creation
-- TODO: Por ahora no hay indices extra a los pk

-- STORE PROCEDURES 

-- CREATE PROCEDURE InsertProducto (
--     @material nvarchar(50),
--     @marca nvarchar(255),
--     @categoria nvarchar(255),
--     @codigo nvarchar(50),
--     @nombre nvarchar(50),
--     @descripcion nvarchar(50)
-- )
-- AS
-- BEGIN
--     insert into [gd_esquema].[Material]
-- END
-- GO

-- Inserts

INSERT INTO [gd_esquema].[Categoria] (categoria_descripcion)
SELECT DISTINCT [gd_esquema].[Maestra].[PRODUCTO_CATEGORIA] as categoria_descripcion
FROM [gd_esquema].[Maestra]
WHERE [gd_esquema].[Maestra].[PRODUCTO_CATEGORIA] is not null
ORDER BY categoria_descripcion asc
GO

INSERT INTO [gd_esquema].[Marca] (marca_descripcion)
SELECT DISTINCT [gd_esquema].[Maestra].[PRODUCTO_MARCA] as marca_descripcion
FROM [gd_esquema].[Maestra]
WHERE [gd_esquema].[Maestra].[PRODUCTO_MARCA] is not null
ORDER BY marca_descripcion asc
GO

INSERT INTO [gd_esquema].[Material] (material_descripcion)
SELECT DISTINCT [gd_esquema].[Maestra].[PRODUCTO_MATERIAL] as material_descripcion
FROM [gd_esquema].[Maestra]
WHERE [gd_esquema].[Maestra].[PRODUCTO_MATERIAL] is not null
ORDER BY material_descripcion asc
GO

INSERT INTO [gd_esquema].[Tipo_Variante] (tipo_variante_descripcion)
SELECT DISTINCT [gd_esquema].[Maestra].[PRODUCTO_TIPO_VARIANTE] as tipo_variante_descripcion
FROM [gd_esquema].[Maestra]
WHERE [gd_esquema].[Maestra].[PRODUCTO_TIPO_VARIANTE] IS NOT NULL
ORDER BY tipo_variante_descripcion asc
GO

INSERT INTO [gd_esquema].[Variante] (tipo_variante_id, variante_descripcion)
SELECT tp.tipo_variante_id,
       m.[PRODUCTO_VARIANTE] as variante_descripcion
FROM [gd_esquema].[Maestra] as m
INNER JOIN [gd_esquema].[Tipo_Variante] AS tp
    ON m.[PRODUCTO_TIPO_VARIANTE] = tp.[tipo_variante_descripcion]
WHERE m.[PRODUCTO_TIPO_VARIANTE] IS NOT NULL
group by m.[PRODUCTO_VARIANTE],
       tp.tipo_variante_id
order by tp.tipo_variante_id, m.[PRODUCTO_VARIANTE]
GO

INSERT INTO [gd_esquema].[Producto] (material_id, marca_id, categoria_id, producto_codigo, producto_nombre, producto_descripcion)
SELECT material.material_id,
       marca.marca_id,
       categoria.categoria_id,
       m.PRODUCTO_CODIGO as producto_codigo,
       m.PRODUCTO_NOMBRE as producto_nombre,
       m.PRODUCTO_DESCRIPCION as producto_descripcion
FROM [gd_esquema].[Maestra] as m
inner join [gd_esquema].[Material] as material
    on material.material_descripcion = m.PRODUCTO_MATERIAL
inner join [gd_esquema].[Marca] as marca
    on marca.marca_descripcion = m.PRODUCTO_MARCA
inner join [gd_esquema].[Categoria] as categoria
    on categoria.categoria_descripcion = m.PRODUCTO_CATEGORIA
GO

INSERT INTO [gd_esquema].[Producto_variante] (producto_id, variante_id, producto_variante_codigo, producto_variante_precio, producto_variante_cantidad)

GO