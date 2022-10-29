USE [GD2C2022]
GO
/****** Object:  StoredProcedure [NN].[Insert_Venta_Medio_Pago]    Script Date: 29/10/2022 18:01:20 ******/
DROP PROCEDURE [NN].[Insert_Venta_Medio_Pago]
GO
/****** Object:  StoredProcedure [NN].[Insert_Venta_Medio_Envio]    Script Date: 29/10/2022 18:01:20 ******/
DROP PROCEDURE [NN].[Insert_Venta_Medio_Envio]
GO
/****** Object:  StoredProcedure [NN].[Insert_Venta_Canal]    Script Date: 29/10/2022 18:01:20 ******/
DROP PROCEDURE [NN].[Insert_Venta_Canal]
GO
/****** Object:  StoredProcedure [NN].[Insert_Variante]    Script Date: 29/10/2022 18:01:20 ******/
DROP PROCEDURE [NN].[Insert_Variante]
GO
/****** Object:  StoredProcedure [NN].[Insert_Tipo_variante]    Script Date: 29/10/2022 18:01:20 ******/
DROP PROCEDURE [NN].[Insert_Tipo_variante]
GO
/****** Object:  StoredProcedure [NN].[Insert_Provincia]    Script Date: 29/10/2022 18:01:20 ******/
DROP PROCEDURE [NN].[Insert_Provincia]
GO
/****** Object:  StoredProcedure [NN].[Insert_Producto]    Script Date: 29/10/2022 18:01:20 ******/
DROP PROCEDURE [NN].[Insert_Producto]
GO
/****** Object:  StoredProcedure [NN].[Insert_Material]    Script Date: 29/10/2022 18:01:20 ******/
DROP PROCEDURE [NN].[Insert_Material]
GO
/****** Object:  StoredProcedure [NN].[Insert_Marca]    Script Date: 29/10/2022 18:01:20 ******/
DROP PROCEDURE [NN].[Insert_Marca]
GO
/****** Object:  StoredProcedure [NN].[Insert_Localidad]    Script Date: 29/10/2022 18:01:20 ******/
DROP PROCEDURE [NN].[Insert_Localidad]
GO
/****** Object:  StoredProcedure [NN].[Insert_Codigo_Postal]    Script Date: 29/10/2022 18:01:20 ******/
DROP PROCEDURE [NN].[Insert_Codigo_Postal]
GO
/****** Object:  StoredProcedure [NN].[Insert_Cliente_Direccion]    Script Date: 29/10/2022 18:01:20 ******/
DROP PROCEDURE [NN].[Insert_Cliente_Direccion]
GO
/****** Object:  StoredProcedure [NN].[Insert_Cliente]    Script Date: 29/10/2022 18:01:20 ******/
DROP PROCEDURE [NN].[Insert_Cliente]
GO
/****** Object:  StoredProcedure [NN].[Insert_Categoria]    Script Date: 29/10/2022 18:01:20 ******/
DROP PROCEDURE [NN].[Insert_Categoria]
GO
ALTER TABLE [NN].[Venta_Producto] DROP CONSTRAINT [FK__Venta_Pro__venta__60FC61CA]
GO
ALTER TABLE [NN].[Venta_Producto] DROP CONSTRAINT [FK__Venta_Pro__venta__22FF2F51]
GO
ALTER TABLE [NN].[Venta_Producto] DROP CONSTRAINT [FK__Venta_Pro__produ__60083D91]
GO
ALTER TABLE [NN].[Venta_Producto] DROP CONSTRAINT [FK__Venta_Pro__produ__23F3538A]
GO
ALTER TABLE [NN].[Venta_Medio_Envio] DROP CONSTRAINT [FK__Venta_Med__local__5F141958]
GO
ALTER TABLE [NN].[Venta_Medio_Envio] DROP CONSTRAINT [FK__Venta_Med__local__019E3B86]
GO
ALTER TABLE [NN].[Venta_Medio_Envio] DROP CONSTRAINT [FK__Venta_Med__cod_p__5E1FF51F]
GO
ALTER TABLE [NN].[Venta_Medio_Envio] DROP CONSTRAINT [FK__Venta_Med__cod_p__02925FBF]
GO
ALTER TABLE [NN].[Venta_Descuento] DROP CONSTRAINT [FK__Venta_Des__venta__5D2BD0E6]
GO
ALTER TABLE [NN].[Venta_Descuento] DROP CONSTRAINT [FK__Venta_Des__venta__26CFC035]
GO
ALTER TABLE [NN].[Venta_Descuento] DROP CONSTRAINT [FK__Venta_Des__tipo___5C37ACAD]
GO
ALTER TABLE [NN].[Venta_Descuento] DROP CONSTRAINT [FK__Venta_Des__tipo___27C3E46E]
GO
ALTER TABLE [NN].[Venta_Cupon] DROP CONSTRAINT [FK__Venta_Cup__venta__5B438874]
GO
ALTER TABLE [NN].[Venta_Cupon] DROP CONSTRAINT [FK__Venta_Cup__venta__29AC2CE0]
GO
ALTER TABLE [NN].[Venta_Cupon] DROP CONSTRAINT [FK__Venta_Cup__cupon__5A4F643B]
GO
ALTER TABLE [NN].[Venta_Cupon] DROP CONSTRAINT [FK__Venta_Cup__cupon__2AA05119]
GO
ALTER TABLE [NN].[Venta] DROP CONSTRAINT [FK__Venta__venta_med__595B4002]
GO
ALTER TABLE [NN].[Venta] DROP CONSTRAINT [FK__Venta__venta_med__58671BC9]
GO
ALTER TABLE [NN].[Venta] DROP CONSTRAINT [FK__Venta__venta_med__2116E6DF]
GO
ALTER TABLE [NN].[Venta] DROP CONSTRAINT [FK__Venta__venta_med__2022C2A6]
GO
ALTER TABLE [NN].[Venta] DROP CONSTRAINT [FK__Venta__venta_can__5772F790]
GO
ALTER TABLE [NN].[Venta] DROP CONSTRAINT [FK__Venta__venta_can__1F2E9E6D]
GO
ALTER TABLE [NN].[Venta] DROP CONSTRAINT [FK__Venta__cliente_i__567ED357]
GO
ALTER TABLE [NN].[Venta] DROP CONSTRAINT [FK__Venta__cliente_i__1E3A7A34]
GO
ALTER TABLE [NN].[Variante] DROP CONSTRAINT [FK__Variante__tipo_v__558AAF1E]
GO
ALTER TABLE [NN].[Variante] DROP CONSTRAINT [FK__Variante__tipo_v__0D0FEE32]
GO
ALTER TABLE [NN].[Producto_variante] DROP CONSTRAINT [FK__Producto___varia__54968AE5]
GO
ALTER TABLE [NN].[Producto_variante] DROP CONSTRAINT [FK__Producto___varia__15A53433]
GO
ALTER TABLE [NN].[Producto_variante] DROP CONSTRAINT [FK__Producto___produ__53A266AC]
GO
ALTER TABLE [NN].[Producto_variante] DROP CONSTRAINT [FK__Producto___produ__14B10FFA]
GO
ALTER TABLE [NN].[Producto] DROP CONSTRAINT [FK__Producto__materi__52AE4273]
GO
ALTER TABLE [NN].[Producto] DROP CONSTRAINT [FK__Producto__materi__0FEC5ADD]
GO
ALTER TABLE [NN].[Producto] DROP CONSTRAINT [FK__Producto__marca___51BA1E3A]
GO
ALTER TABLE [NN].[Producto] DROP CONSTRAINT [FK__Producto__marca___10E07F16]
GO
ALTER TABLE [NN].[Producto] DROP CONSTRAINT [FK__Producto__catego__50C5FA01]
GO
ALTER TABLE [NN].[Producto] DROP CONSTRAINT [FK__Producto__catego__11D4A34F]
GO
ALTER TABLE [NN].[Localidad] DROP CONSTRAINT [FK__Localidad__provi__74444068]
GO
ALTER TABLE [NN].[Localidad] DROP CONSTRAINT [FK__Localidad__provi__4FD1D5C8]
GO
ALTER TABLE [NN].[Cliente_Direccion] DROP CONSTRAINT [FK__Cliente_D__local__7720AD13]
GO
ALTER TABLE [NN].[Cliente_Direccion] DROP CONSTRAINT [FK__Cliente_D__local__4EDDB18F]
GO
ALTER TABLE [NN].[Cliente_Direccion] DROP CONSTRAINT [FK__Cliente_D__cod_p__7814D14C]
GO
ALTER TABLE [NN].[Cliente_Direccion] DROP CONSTRAINT [FK__Cliente_D__cod_p__4DE98D56]
GO
ALTER TABLE [NN].[Cliente] DROP CONSTRAINT [FK__Cliente__cliente__7AF13DF7]
GO
ALTER TABLE [NN].[Cliente] DROP CONSTRAINT [FK__Cliente__cliente__4CF5691D]
GO
/****** Object:  Table [NN].[Venta_Producto]    Script Date: 29/10/2022 18:01:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[NN].[Venta_Producto]') AND type in (N'U'))
DROP TABLE [NN].[Venta_Producto]
GO
/****** Object:  Table [NN].[Venta_Medio_Pago]    Script Date: 29/10/2022 18:01:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[NN].[Venta_Medio_Pago]') AND type in (N'U'))
DROP TABLE [NN].[Venta_Medio_Pago]
GO
/****** Object:  Table [NN].[Venta_Medio_Envio]    Script Date: 29/10/2022 18:01:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[NN].[Venta_Medio_Envio]') AND type in (N'U'))
DROP TABLE [NN].[Venta_Medio_Envio]
GO
/****** Object:  Table [NN].[Venta_Descuento]    Script Date: 29/10/2022 18:01:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[NN].[Venta_Descuento]') AND type in (N'U'))
DROP TABLE [NN].[Venta_Descuento]
GO
/****** Object:  Table [NN].[Venta_Cupon]    Script Date: 29/10/2022 18:01:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[NN].[Venta_Cupon]') AND type in (N'U'))
DROP TABLE [NN].[Venta_Cupon]
GO
/****** Object:  Table [NN].[Venta_Canal]    Script Date: 29/10/2022 18:01:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[NN].[Venta_Canal]') AND type in (N'U'))
DROP TABLE [NN].[Venta_Canal]
GO
/****** Object:  Table [NN].[Venta]    Script Date: 29/10/2022 18:01:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[NN].[Venta]') AND type in (N'U'))
DROP TABLE [NN].[Venta]
GO
/****** Object:  Table [NN].[Variante]    Script Date: 29/10/2022 18:01:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[NN].[Variante]') AND type in (N'U'))
DROP TABLE [NN].[Variante]
GO
/****** Object:  Table [NN].[Tipo_Variante]    Script Date: 29/10/2022 18:01:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[NN].[Tipo_Variante]') AND type in (N'U'))
DROP TABLE [NN].[Tipo_Variante]
GO
/****** Object:  Table [NN].[Tipo_Descuento]    Script Date: 29/10/2022 18:01:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[NN].[Tipo_Descuento]') AND type in (N'U'))
DROP TABLE [NN].[Tipo_Descuento]
GO
/****** Object:  Table [NN].[Provincia]    Script Date: 29/10/2022 18:01:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[NN].[Provincia]') AND type in (N'U'))
DROP TABLE [NN].[Provincia]
GO
/****** Object:  Table [NN].[Producto_variante]    Script Date: 29/10/2022 18:01:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[NN].[Producto_variante]') AND type in (N'U'))
DROP TABLE [NN].[Producto_variante]
GO
/****** Object:  Table [NN].[Producto]    Script Date: 29/10/2022 18:01:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[NN].[Producto]') AND type in (N'U'))
DROP TABLE [NN].[Producto]
GO
/****** Object:  Table [NN].[Material]    Script Date: 29/10/2022 18:01:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[NN].[Material]') AND type in (N'U'))
DROP TABLE [NN].[Material]
GO
/****** Object:  Table [NN].[Marca]    Script Date: 29/10/2022 18:01:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[NN].[Marca]') AND type in (N'U'))
DROP TABLE [NN].[Marca]
GO
/****** Object:  Table [NN].[Localidad]    Script Date: 29/10/2022 18:01:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[NN].[Localidad]') AND type in (N'U'))
DROP TABLE [NN].[Localidad]
GO
/****** Object:  Table [NN].[Cupon]    Script Date: 29/10/2022 18:01:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[NN].[Cupon]') AND type in (N'U'))
DROP TABLE [NN].[Cupon]
GO
/****** Object:  Table [NN].[Codigo_Postal]    Script Date: 29/10/2022 18:01:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[NN].[Codigo_Postal]') AND type in (N'U'))
DROP TABLE [NN].[Codigo_Postal]
GO
/****** Object:  Table [NN].[Cliente_Direccion]    Script Date: 29/10/2022 18:01:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[NN].[Cliente_Direccion]') AND type in (N'U'))
DROP TABLE [NN].[Cliente_Direccion]
GO
/****** Object:  Table [NN].[Cliente]    Script Date: 29/10/2022 18:01:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[NN].[Cliente]') AND type in (N'U'))
DROP TABLE [NN].[Cliente]
GO
/****** Object:  Table [NN].[Categoria]    Script Date: 29/10/2022 18:01:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[NN].[Categoria]') AND type in (N'U'))
DROP TABLE [NN].[Categoria]
GO
/****** Object:  Schema [NN]    Script Date: 29/10/2022 18:01:20 ******/
DROP SCHEMA [NN]
GO
