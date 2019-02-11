
/******************************************************************************
**  Name: auditoria accidente
*******************************************************************************/
/*
* trigger auditoria accidente
* 
* Nombre			Fecha			Descripcion
* ----------------------------------------------
* Pamela Arnez 	09/02/2019		Implementacion inicial
*/
CREATE TRIGGER [dbo].[TG_accidente_InsertUpdate]
ON ACCIDENTE
AFTER INSERT, UPDATE
AS
BEGIN
  
  DECLARE @CurrDate DATETIME = GETUTCDATE();
 
  IF (UPDATE(FECHA) OR UPDATE(DETALLE) OR UPDATE(LUGAR) OR UPDATE(DETALLE_EMPLEADO))
  BEGIN

	INSERT INTO [dbo].[HISTORICO_ACCIDENTE]
			   ([ID_ACCIDENTE]
			   ,[ID_TIPO]
			   ,[FECHA]
			   ,[DETALLE]
			   ,[LUGAR]
			   ,[DETALLE_EMPLEADO]
			   ,[FECHA_MODIFICACION]
			   ,[USUARIO_MODIFICACION])
	SELECT ID_ACCIDENTE = d.ID_ACCIDENTE,
		   ID_TIPO = d.ID_TIPO,
		   FECHA = d.FECHA,
		   DETALLE = d.DETALLE,
		   LUGAR = d.LUGAR,
		   DETALLE_EMPLEADO = d.DETALLE,
		   FECHA_MODIFICACION = @CurrDate,
		   USUARIO_MODIFICACION = CURRENT_USER
	  FROM deleted d
	  FULL OUTER JOIN inserted i ON (d.ID_ACCIDENTE = i.ID_ACCIDENTE)
    WHERE ISNULL(convert(varchar,d.ID_ACCIDENTE), '') != ISNULL(convert(varchar,i.ID_ACCIDENTE), '')
	   OR ISNULL(convert(varchar,d.ID_TIPO), '') != ISNULL(convert(varchar,i.ID_TIPO), '')
	   OR ISNULL(convert(varchar,d.FECHA), '') != ISNULL(convert(varchar,i.FECHA), '')
	   OR ISNULL(d.DETALLE, '') != ISNULL(i.DETALLE, '')
	   OR ISNULL(d.LUGAR, '') != ISNULL(i.LUGAR, '')
	   OR ISNULL(d.DETALLE_EMPLEADO, '') != ISNULL(i.DETALLE_EMPLEADO, '');

  END

END;
