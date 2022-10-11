CREATE DATABASE gdd
go

USE gdd
go

-- Table creation

CREATE TABLE Material (
    material_id int NOT NULL IDENTITY(1,1) PRIMARY KEY,
    material_descripcion nvarchar(50) NOT NULL
)
go

CREATE TABLE Marca (
    marca_id int NOT NULL IDENTITY(1,1) PRIMARY KEY,
    marca_descripcion nvarchar(255) NOT NULL
)
go

CREATE TABLE Categoria (
    categoria_id int NOT NULL IDENTITY(1,1) PRIMARY KEY,
    categoria_descripcion nvarchar(255) NOT NULL
)
go

CREATE TABLE Tipo_Variante (
    tipo_variante_id int NOT NULL IDENTITY(1,1) PRIMARY KEY,
    tipo_variante_descripcion nvarchar(50) NOT NULL
)
go

CREATE TABLE Variante (
    variante_id int NOT NULL IDENTITY(1,1) PRIMARY KEY,
    tipo_variante_id int NOT NULL FOREIGN KEY REFERENCES Tipo_Variante(tipo_variante_id),
    variante_descripcion nvarchar(50) NOT NULL
)
go


CREATE TABLE Producto (
    producto_id int NOT NULL IDENTITY(1,1) PRIMARY KEY,
    material_id int NOT NULL FOREIGN KEY REFERENCES Material(material_id),
    marca_id int NOT NULL FOREIGN KEY REFERENCES Marca(marca_id),
    categoria_id int NOT NULL FOREIGN KEY REFERENCES Categoria(categoria_id),
    producto_codigo nvarchar(50) NOT NULL,
    producto_nombre nvarchar(50) NOT NULL,
    producto_descripcion nvarchar(50) NOT NULL
)
go

CREATE TABLE Producto_variante (
    producto_variante_id int NOT NULL IDENTITY(1,1) PRIMARY KEY,
    producto_id int NOT NULL FOREIGN KEY REFERENCES Producto(producto_id),
    variante_id int NOT NULL FOREIGN KEY REFERENCES Variante(variante_id),
    producto_variante_codigo nvarchar(50) NOT NULL,
    producto_variante_precio decimal(18,2) NOT NULL,
    producto_variante_cantidad decimal(18,0) NOT NULL
)
go

CREATE TABLE Venta_Producto (
    venta_id int NOT NULL FOREIGN KEY REFERENCES Venta(venta_id),
    producto_variante_id int NOT NULL FOREIGN KEY REFERENCES Producto_variante(producto_variante_id),
    venta_producto_precio decimal(18,2) NOT NULL,
    venta_producto_cantidad decimal(18,0) NOT NULL
)
go

CREATE TABLE Compra_Producto (
    compra_id int NOT NULL FOREIGN KEY REFERENCES Compra(compra_id),
    producto_variante_id int NOT NULL FOREIGN KEY REFERENCES Producto_Variante(producto_variante_id),
    compra_producto_precio decimal(18,2) NOT NULL,
    compra_producto_cantidad decimal(18,0) NOT NULL
)
go

-- Index creation
-- TODO: Por ahora no hay indices extra a los pk


-- Data migration: Aca colocar el nombre de base de datos que usaste

USE dbo_gestion;

-- TODO: Agregar la migracion de data.