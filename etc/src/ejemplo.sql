-- Full insertion example


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