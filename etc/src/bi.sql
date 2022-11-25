USE [GD2C2022]
GO

/*
=================================================
===============BI TABLES CREATION================
=================================================
*/

CREATE TABLE NN.BI_Provincia (
	provincia_id int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	provincia_nombre nvarchar(255) NOT NULL
)
GO

CREATE TABLE NN.BI_Localidad (
	localidad_id int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	localidad_nombre nvarchar(255) NOT NULL,
	provincia_id int NOT NULL FOREIGN KEY REFERENCES NN.BI_Provincia(provincia_id)
	
)
GO

CREATE TABLE NN.BI_Edad (
	edad_id int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	edad nvarchar(10) NOT NULL
)
GO

CREATE TABLE NN.BI_Codigo_Postal (
	cod_postal_id int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	cod_postal_codigo decimal(18,0) NOT NULL
)
GO

CREATE TABLE NN.BI_Tiempo (
	tiempo_id int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	anio int NOT NULL,
    mes int NOT NULL,
);

CREATE TABLE NN.BI_Venta_Canal(
	venta_canal_id int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	venta_canal_descripcion nvarchar(255) NOT NULL,
	venta_canal_costo decimal(18,2) NOT NULL
)
GO

CREATE TABLE NN.BI_Venta_Medio_Pago(
	venta_medio_pago_id int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	venta_medio_pago_descripcion nvarchar(255) NOT NULL,
	venta_medio_pago_costo decimal(18,2) NOT NULL,
)
GO

CREATE TABLE NN.BI_Venta_Medio_Envio(
	venta_medio_envio_id int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	venta_medio_envio_descripcion nvarchar(255) NOT NULL,
	venta_medio_envio_precio decimal(18,2) NOT NULL
)
GO

CREATE TABLE NN.BI_Categoria (
    categoria_id int NOT NULL IDENTITY(1,1) PRIMARY KEY,
    categoria_descripcion nvarchar(255) NOT NULL
)
GO

CREATE TABLE NN.BI_Producto (
    producto_id int NOT NULL IDENTITY(1,1) PRIMARY KEY,
    categoria_id int NOT NULL FOREIGN KEY REFERENCES NN.BI_Categoria(categoria_id),
    producto_codigo nvarchar(50) NOT NULL,
    producto_nombre nvarchar(50) NOT NULL,
    producto_descripcion nvarchar(50) NOT NULL
)
GO

CREATE TABLE NN.BI_Tipo_Descuento (
    tipo_descuento_id int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	tipo_descuento_concepto nvarchar(255) NOT NULL
)
GO

CREATE TABLE NN.BI_Venta_Descuento (
    venta_descuento_id int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	tipo_descuento_id int NOT NULL FOREIGN KEY REFERENCES NN.BI_Tipo_Descuento(tipo_descuento_id),
	venta_descuento_importe decimal(18,2) NOT NULL,
)
GO

CREATE TABLE NN.BI_Compra(
	compra_id int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	proveedor_id int NOT NULL,
	compra_numero DECIMAL(19,0) NOT NULL,
	compra_medio_pago NVARCHAR(255) NOT NULL,
	compra_total DECIMAL(18,2) NOT NULL
)
GO

/*
=================================================
================INSERTION LOGIC==================
=================================================
*/

CREATE PROCEDURE NN.BI_Insert_Provincia
AS BEGIN
	INSERT INTO NN.BI_Provincia (provincia_nombre)
	SELECT provincia_nombre FROM NN.Provincia
END
GO
































