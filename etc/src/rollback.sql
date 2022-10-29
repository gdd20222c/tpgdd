USE [GD2C2022]
GO
/****** Object:  Schema [NN]    Script Date: 29/10/2022 17:53:26 ******/
CREATE SCHEMA [NN]
GO
/****** Object:  Table [NN].[Categoria]    Script Date: 29/10/2022 17:53:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [NN].[Categoria](
	[categoria_id] [int] IDENTITY(1,1) NOT NULL,
	[categoria_descripcion] [nvarchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[categoria_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [NN].[Cliente]    Script Date: 29/10/2022 17:53:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [NN].[Cliente](
	[cliente_id] [int] IDENTITY(1,1) NOT NULL,
	[cliente_nombre] [nvarchar](255) NOT NULL,
	[cliente_apellido] [nvarchar](255) NOT NULL,
	[cliente_telefono] [decimal](18, 0) NOT NULL,
	[cliente_dni] [decimal](18, 0) NOT NULL,
	[cliente_mail] [nvarchar](255) NOT NULL,
	[cliente_fecha_nac] [date] NOT NULL,
	[cliente_direccion_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[cliente_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [NN].[Cliente_Direccion]    Script Date: 29/10/2022 17:53:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [NN].[Cliente_Direccion](
	[cliente_direccion_id] [int] IDENTITY(1,1) NOT NULL,
	[cliente_direccion] [nvarchar](255) NOT NULL,
	[localidad_id] [int] NOT NULL,
	[cod_postal_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[cliente_direccion_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [NN].[Codigo_Postal]    Script Date: 29/10/2022 17:53:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [NN].[Codigo_Postal](
	[cod_postal_id] [int] IDENTITY(1,1) NOT NULL,
	[cod_postal_codigo] [decimal](18, 0) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[cod_postal_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [NN].[Cupon]    Script Date: 29/10/2022 17:53:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [NN].[Cupon](
	[cupon_id] [int] IDENTITY(1,1) NOT NULL,
	[cupon_codigo] [nvarchar](255) NOT NULL,
	[cupon_fecha_desde] [date] NOT NULL,
	[cupon_fecha_hasta] [date] NOT NULL,
	[cupon_importe] [decimal](18, 2) NOT NULL,
	[cupon_valor] [decimal](18, 2) NOT NULL,
	[cupon_tipo] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[cupon_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [NN].[Localidad]    Script Date: 29/10/2022 17:53:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [NN].[Localidad](
	[localidad_id] [int] IDENTITY(1,1) NOT NULL,
	[localidad_nombre] [nvarchar](255) NOT NULL,
	[provincia_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[localidad_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [NN].[Marca]    Script Date: 29/10/2022 17:53:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [NN].[Marca](
	[marca_id] [int] IDENTITY(1,1) NOT NULL,
	[marca_descripcion] [nvarchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[marca_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [NN].[Material]    Script Date: 29/10/2022 17:53:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [NN].[Material](
	[material_id] [int] IDENTITY(1,1) NOT NULL,
	[material_descripcion] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[material_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [NN].[Producto]    Script Date: 29/10/2022 17:53:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [NN].[Producto](
	[producto_id] [int] IDENTITY(1,1) NOT NULL,
	[material_id] [int] NOT NULL,
	[marca_id] [int] NOT NULL,
	[categoria_id] [int] NOT NULL,
	[producto_codigo] [nvarchar](50) NOT NULL,
	[producto_nombre] [nvarchar](50) NOT NULL,
	[producto_descripcion] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[producto_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [NN].[Producto_variante]    Script Date: 29/10/2022 17:53:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [NN].[Producto_variante](
	[producto_variante_id] [int] IDENTITY(1,1) NOT NULL,
	[producto_id] [int] NOT NULL,
	[variante_id] [int] NOT NULL,
	[producto_variante_codigo] [nvarchar](50) NOT NULL,
	[producto_variante_precio] [decimal](18, 2) NOT NULL,
	[producto_variante_cantidad] [decimal](18, 0) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[producto_variante_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [NN].[Provincia]    Script Date: 29/10/2022 17:53:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [NN].[Provincia](
	[provincia_id] [int] IDENTITY(1,1) NOT NULL,
	[provincia_nombre] [nvarchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[provincia_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [NN].[Tipo_Descuento]    Script Date: 29/10/2022 17:53:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [NN].[Tipo_Descuento](
	[tipo_descuento_id] [int] IDENTITY(1,1) NOT NULL,
	[tipo_descuento_concepto] [nvarchar](255) NOT NULL,
	[venta_descuento_importe] [decimal](18, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[tipo_descuento_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [NN].[Tipo_Variante]    Script Date: 29/10/2022 17:53:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [NN].[Tipo_Variante](
	[tipo_variante_id] [int] IDENTITY(1,1) NOT NULL,
	[tipo_variante_descripcion] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[tipo_variante_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [NN].[Variante]    Script Date: 29/10/2022 17:53:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [NN].[Variante](
	[variante_id] [int] IDENTITY(1,1) NOT NULL,
	[tipo_variante_id] [int] NOT NULL,
	[variante_descripcion] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[variante_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [NN].[Venta]    Script Date: 29/10/2022 17:53:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [NN].[Venta](
	[venta_id] [int] IDENTITY(1,1) NOT NULL,
	[cliente_id] [int] NOT NULL,
	[venta_codigo] [decimal](19, 0) NOT NULL,
	[venta_fecha] [date] NOT NULL,
	[venta_total] [decimal](18, 2) NOT NULL,
	[venta_canal_id] [int] NOT NULL,
	[venta_canal_costo] [decimal](18, 2) NOT NULL,
	[venta_medio_envio_id] [int] NOT NULL,
	[venta_envio_precio] [decimal](18, 2) NOT NULL,
	[venta_medio_pago_id] [int] NOT NULL,
	[venta_medio_pago_costo] [decimal](18, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[venta_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [NN].[Venta_Canal]    Script Date: 29/10/2022 17:53:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [NN].[Venta_Canal](
	[venta_canal_id] [int] IDENTITY(1,1) NOT NULL,
	[venta_canal_descripcion] [nvarchar](255) NOT NULL,
	[venta_canal_costo] [decimal](18, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[venta_canal_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [NN].[Venta_Cupon]    Script Date: 29/10/2022 17:53:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [NN].[Venta_Cupon](
	[venta_id] [int] NOT NULL,
	[cupon_id] [int] NOT NULL,
	[venta_cupon_importe] [decimal](18, 2) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [NN].[Venta_Descuento]    Script Date: 29/10/2022 17:53:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [NN].[Venta_Descuento](
	[venta_descuento_id] [int] IDENTITY(1,1) NOT NULL,
	[venta_id] [int] NOT NULL,
	[tipo_descuento_id] [int] NOT NULL,
	[venta_descuento_importe] [decimal](18, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[venta_descuento_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [NN].[Venta_Medio_Envio]    Script Date: 29/10/2022 17:53:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [NN].[Venta_Medio_Envio](
	[venta_medio_envio_id] [int] IDENTITY(1,1) NOT NULL,
	[venta_medio_envio_descripcion] [nvarchar](255) NOT NULL,
	[venta_medio_envio_precio] [decimal](18, 2) NOT NULL,
	[localidad_id] [int] NOT NULL,
	[cod_postal_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[venta_medio_envio_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [NN].[Venta_Medio_Pago]    Script Date: 29/10/2022 17:53:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [NN].[Venta_Medio_Pago](
	[venta_medio_pago_id] [int] IDENTITY(1,1) NOT NULL,
	[venta_medio_pago_descripcion] [nvarchar](255) NOT NULL,
	[venta_medio_pago_costo] [decimal](18, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[venta_medio_pago_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [NN].[Venta_Producto]    Script Date: 29/10/2022 17:53:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [NN].[Venta_Producto](
	[venta_id] [int] NOT NULL,
	[producto_variante_id] [int] NOT NULL,
	[venta_producto_precio] [decimal](18, 2) NOT NULL,
	[venta_producto_cantidad] [decimal](18, 0) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [NN].[Cliente]  WITH CHECK ADD FOREIGN KEY([cliente_direccion_id])
REFERENCES [NN].[Cliente_Direccion] ([cliente_direccion_id])
GO
ALTER TABLE [NN].[Cliente_Direccion]  WITH CHECK ADD FOREIGN KEY([cod_postal_id])
REFERENCES [NN].[Codigo_Postal] ([cod_postal_id])
GO
ALTER TABLE [NN].[Cliente_Direccion]  WITH CHECK ADD FOREIGN KEY([localidad_id])
REFERENCES [NN].[Localidad] ([localidad_id])
GO
ALTER TABLE [NN].[Localidad]  WITH CHECK ADD FOREIGN KEY([provincia_id])
REFERENCES [NN].[Provincia] ([provincia_id])
GO
ALTER TABLE [NN].[Producto]  WITH CHECK ADD FOREIGN KEY([categoria_id])
REFERENCES [NN].[Categoria] ([categoria_id])
GO
ALTER TABLE [NN].[Producto]  WITH CHECK ADD FOREIGN KEY([marca_id])
REFERENCES [NN].[Marca] ([marca_id])
GO
ALTER TABLE [NN].[Producto]  WITH CHECK ADD FOREIGN KEY([material_id])
REFERENCES [NN].[Material] ([material_id])
GO
ALTER TABLE [NN].[Producto_variante]  WITH CHECK ADD FOREIGN KEY([producto_id])
REFERENCES [NN].[Producto] ([producto_id])
GO
ALTER TABLE [NN].[Producto_variante]  WITH CHECK ADD FOREIGN KEY([variante_id])
REFERENCES [NN].[Variante] ([variante_id])
GO
ALTER TABLE [NN].[Variante]  WITH CHECK ADD FOREIGN KEY([tipo_variante_id])
REFERENCES [NN].[Tipo_Variante] ([tipo_variante_id])
GO
ALTER TABLE [NN].[Venta]  WITH CHECK ADD FOREIGN KEY([cliente_id])
REFERENCES [NN].[Cliente] ([cliente_id])
GO
ALTER TABLE [NN].[Venta]  WITH CHECK ADD FOREIGN KEY([venta_canal_id])
REFERENCES [NN].[Venta_Canal] ([venta_canal_id])
GO
ALTER TABLE [NN].[Venta]  WITH CHECK ADD FOREIGN KEY([venta_medio_envio_id])
REFERENCES [NN].[Venta_Medio_Envio] ([venta_medio_envio_id])
GO
ALTER TABLE [NN].[Venta]  WITH CHECK ADD FOREIGN KEY([venta_medio_pago_id])
REFERENCES [NN].[Venta_Medio_Pago] ([venta_medio_pago_id])
GO
ALTER TABLE [NN].[Venta_Cupon]  WITH CHECK ADD FOREIGN KEY([cupon_id])
REFERENCES [NN].[Cupon] ([cupon_id])
GO
ALTER TABLE [NN].[Venta_Cupon]  WITH CHECK ADD FOREIGN KEY([venta_id])
REFERENCES [NN].[Venta] ([venta_id])
GO
ALTER TABLE [NN].[Venta_Descuento]  WITH CHECK ADD FOREIGN KEY([tipo_descuento_id])
REFERENCES [NN].[Tipo_Descuento] ([tipo_descuento_id])
GO
ALTER TABLE [NN].[Venta_Descuento]  WITH CHECK ADD FOREIGN KEY([venta_id])
REFERENCES [NN].[Venta] ([venta_id])
GO
ALTER TABLE [NN].[Venta_Medio_Envio]  WITH CHECK ADD FOREIGN KEY([cod_postal_id])
REFERENCES [NN].[Codigo_Postal] ([cod_postal_id])
GO
ALTER TABLE [NN].[Venta_Medio_Envio]  WITH CHECK ADD FOREIGN KEY([localidad_id])
REFERENCES [NN].[Localidad] ([localidad_id])
GO
ALTER TABLE [NN].[Venta_Producto]  WITH CHECK ADD FOREIGN KEY([producto_variante_id])
REFERENCES [NN].[Producto_variante] ([producto_variante_id])
GO
ALTER TABLE [NN].[Venta_Producto]  WITH CHECK ADD FOREIGN KEY([venta_id])
REFERENCES [NN].[Venta] ([venta_id])
GO
/****** Object:  StoredProcedure [NN].[Insert_Categoria]    Script Date: 29/10/2022 17:53:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [NN].[Insert_Categoria](
  @categoria_descripcion nvarchar(255)
) AS BEGIN
	INSERT INTO [NN].[Categoria] (categoria_descripcion)
	VALUES (@categoria_descripcion)
END
GO
/****** Object:  StoredProcedure [NN].[Insert_Cliente]    Script Date: 29/10/2022 17:53:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [NN].[Insert_Cliente_Direccion]    Script Date: 29/10/2022 17:53:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [NN].[Insert_Codigo_Postal]    Script Date: 29/10/2022 17:53:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [NN].[Insert_Localidad]    Script Date: 29/10/2022 17:53:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [NN].[Insert_Marca]    Script Date: 29/10/2022 17:53:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [NN].[Insert_Marca](
  @marca_descripcion nvarchar(255)
) AS BEGIN
	INSERT INTO [NN].[Marca] (marca_descripcion)
	VALUES (@marca_descripcion)
END
GO
/****** Object:  StoredProcedure [NN].[Insert_Material]    Script Date: 29/10/2022 17:53:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [NN].[Insert_Material](
  @material_descripcion nvarchar(255)
) AS BEGIN
	INSERT INTO [NN].[Material] (material_descripcion)
	VALUES (@material_descripcion)
END
GO
/****** Object:  StoredProcedure [NN].[Insert_Producto]    Script Date: 29/10/2022 17:53:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [NN].[Insert_Producto](
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
/****** Object:  StoredProcedure [NN].[Insert_Provincia]    Script Date: 29/10/2022 17:53:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [NN].[Insert_Tipo_variante]    Script Date: 29/10/2022 17:53:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [NN].[Insert_Tipo_variante](
  @tipo_variante_descripcion nvarchar(255)
) AS BEGIN
	INSERT INTO [NN].[Tipo_Variante] (tipo_variante_descripcion)
	VALUES (@tipo_variante_descripcion)
END
GO
/****** Object:  StoredProcedure [NN].[Insert_Variante]    Script Date: 29/10/2022 17:53:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [NN].[Insert_Variante](
  @tipo_variante_id int,
  @variante_descripcion varchar(50)
) AS BEGIN
	INSERT INTO [NN].[Variante] (tipo_variante_id, variante_descripcion)
	VALUES (@tipo_variante_id, @variante_descripcion)
END
GO
/****** Object:  StoredProcedure [NN].[Insert_Venta_Canal]    Script Date: 29/10/2022 17:53:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [NN].[Insert_Venta_Medio_Envio]    Script Date: 29/10/2022 17:53:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [NN].[Insert_Venta_Medio_Pago]    Script Date: 29/10/2022 17:53:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
