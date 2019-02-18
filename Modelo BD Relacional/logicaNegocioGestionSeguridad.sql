
/*
* Procedimiento para registrar accidentes
* 
* Nombre			Fecha			Descripcion
* ----------------------------------------------
* Flores Sergio 	09/02/2019		Implementacion inicial
*/

create procedure REGISTRAR_ACCIDENTE(
	
	@TIPO	INT,
	@FECHA datetime,
	@DETALLE VARCHAR(500),
	@LUGAR VARCHAR(10),
	@DETALLE_EMPLEADO varchar(500),
	@EMPLEADO_ID INT,
	@ACCIDENTE_ID INT OUT
)
as
if (exists(select * from TIPO_ACCIDENTE ta where ta.ID_TIPO = @TIPO) and exists(select * from EMPLEADO e where e.ID_EMPLEADO = @EMPLEADO_ID))
	begin
		set @ACCIDENTE_ID = 0;
		
		INSERT INTO [dbo].[ACCIDENTE]
				   ([ID_TIPO],[FECHA],[DETALLE],[LUGAR],[DETALLE_EMPLEADO])
			 VALUES
				   (@TIPO, @FECHA, @DETALLE, @LUGAR, @DETALLE_EMPLEADO);
		SELECT @ACCIDENTE_ID = SCOPE_IDENTITY();


		INSERT INTO [dbo].[ACCIDENTES_EMPLEADO]
				   ([ID_ACCIDENTE],[ID_EMPLEADO])
			 VALUES
				   (@ACCIDENTE_ID, @EMPLEADO_ID);

		print @ACCIDENTE_ID;
	end
else
	begin
	raiserror('empleado o tipo de accidente no valido',1,1)
	return -1
	end
go


/*
* Procedimiento para registrar persona
* 
* Nombre			Fecha			Descripcion
* ----------------------------------------------
* Flores Sergio 	10/02/2019		Implementacion inicial
*/

create procedure REGISTRAR_PERSONA(
	@NOMBRES VARCHAR(50),
	@APELLIDOS	VARCHAR(50),
	@TELEFONO VARCHAR(25),
	@DIRECCION VARCHAR(200),
	@EMAIL VARCHAR(25),
	@SEXO CHAR(2),
	@NACIMIENTO DATETIME,
	@CI	VARCHAR(15),
	@NACIONALIDAD VARCHAR(25),
	@PERSONA_ID INT OUT
)
as
	begin
		set @PERSONA_ID = 0;
		
		INSERT INTO [dbo].[PERSONA]
				   ([NOMBRES],[APELLIDOS],[TELEFONO],[DIRECCION],[EMAIL],[SEXO],[NACIMIENTO],[CI],[NACIONALIDAD])
			 VALUES
				   (@NOMBRES, @APELLIDOS, @TELEFONO, @DIRECCION, @EMAIL, @SEXO, @NACIMIENTO, @CI, @NACIONALIDAD);
		
		SELECT @PERSONA_ID = SCOPE_IDENTITY();

		print @PERSONA_ID;
	end
go

/*
* Procedimiento para registrar empleado
* 
* Nombre			Fecha			Descripcion
* ----------------------------------------------
* Pamela arnez 	10/02/2019		Implementacion inicial
*/


create procedure REGISTRAR_EMPLEADO(
	@ID_PERSONA	INT,
	@ID_SECCION INT,
	@CARGO	VARCHAR(50),
	@TITULO VARCHAR(50),
	@FECHA_CONTRATACION DATETIME,
	@ESTADO CHAR(1),
	@NICK varchar(10),
	@PASSWORD varchar(100),
	@EMPLEADO_ID INT OUT
)
as
if (exists(select * from PERSONA p where p.ID_PERSONA = @ID_PERSONA) and exists(select * from SECCION s where s.ID_SECCION = @ID_SECCION))
	begin
		SET @EMPLEADO_ID = 0;
		DECLARE @KEYID INT;
		SET @KEYID = AsymKey_ID('ClaveISOCODE');

		INSERT INTO [dbo].[EMPLEADO]
				   ([ID_PERSONA],[ID_SECCION],[CARGO],[TITULO],[FECHA_CONTRATACION],[ESTADO])
			 VALUES
				   (@ID_PERSONA, @ID_SECCION, @CARGO, @TITULO, @FECHA_CONTRATACION, @ESTADO);
		
		SELECT @EMPLEADO_ID = SCOPE_IDENTITY();

		INSERT INTO [dbo].[LOGIN]
				   ([ID_EMPLEADO],[NICK],[CONTRASENA],[ESTADO])
			 VALUES
				   (@EMPLEADO_ID, @NICK,  EncryptByAsymKey (@KEYID, @PASSWORD), 'A');
		print @EMPLEADO_ID;
	end
else
	begin
	raiserror('la persona o seccion no son validas',1,1)
	return -1
	end
go

/*
* Procedimiento para retornar informacion empleado
* 
* Nombre			Fecha			Descripcion
* ----------------------------------------------
* Pamela arnez 	10/02/2019		Implementacion inicial
*/
CREATE PROCEDURE GET_EMPLEADO
(
	@ID_EMPLEADO INT
)
AS
if (exists(select * from EMPLEADO e where e.ID_EMPLEADO = @ID_EMPLEADO))
	begin
		SELECT emp.ID_PERSONA
			  ,emp.ID_SECCION
			  ,emp.CARGO
			  ,emp.TITULO
			  ,emp.FECHA_CONTRATACION
			  ,emp.ESTADO
		  FROM [dbo].[EMPLEADO] emp
		 WHERE  emp.ID_EMPLEADO = @ID_EMPLEADO
		   AND emp.ESTADO = 'A';
	end
else
	begin
	raiserror('el id empleado no existe',1,1)
	return -1
	end
go

/*
* Procedimiento para actualizar informacion empleado
* 
* Nombre			Fecha			Descripcion
* ----------------------------------------------
* Medina Yamil 	10/02/2019		Implementacion inicial
*/
create procedure ACTUALIZAR_EMPLEADO(
	@ID_EMPLEADO INT,
	@ID_PERSONA	INT,
	@ID_SECCION INT,
	@CARGO	VARCHAR(50),
	@TITULO VARCHAR(50),
	@FECHA_CONTRATACION DATETIME,
	@ESTADO CHAR(1),
	@NICK varchar(10),
	@PASSWORD varchar(100),
	@RESPUESTA INT OUT
)
as
if (exists(select * from EMPLEADO e where e.ID_EMPLEADO = @ID_EMPLEADO) and 
	exists(select * from PERSONA p where p.ID_PERSONA = @ID_PERSONA) and 
	exists(select * from SECCION s where s.ID_SECCION = @ID_SECCION))
	begin
		SET @RESPUESTA = 0;

		SELECT @ID_PERSONA = ISNULL(@ID_PERSONA, emp.ID_PERSONA)
			  ,@ID_SECCION = ISNULL(@ID_SECCION, emp.ID_SECCION)
			  ,@CARGO = ISNULL(@CARGO, emp.CARGO)
			  ,@TITULO = ISNULL(@TITULO, emp.TITULO)
			  ,@FECHA_CONTRATACION = ISNULL(@FECHA_CONTRATACION, emp.FECHA_CONTRATACION)
			  ,@ESTADO =  ISNULL(@ESTADO, emp.ESTADO)
		  FROM [dbo].[EMPLEADO] emp
		 WHERE  emp.ID_EMPLEADO = @ID_EMPLEADO;

		UPDATE [dbo].[EMPLEADO]
		   SET [ID_PERSONA] = @ID_PERSONA
			  ,[ID_SECCION] = @ID_SECCION
			  ,[CARGO] = @CARGO
			  ,[TITULO] = @TITULO
			  ,[FECHA_CONTRATACION] = @FECHA_CONTRATACION
			  ,[ESTADO] = @ESTADO
		 WHERE ID_EMPLEADO = @ID_EMPLEADO;
		 
		 SET @RESPUESTA = 1;
		 PRINT @RESPUESTA;
	end
else
	begin
	raiserror('el empleado, la persona o seccion no son validas',1,1)
	return -1
	end
go

/*
* Procedimiento para registrar empleado
* 
* Nombre			Fecha			Descripcion
* ----------------------------------------------
* Medina Yamil 	10/02/2019		Implementacion inicial
*/
CREATE PROCEDURE ELIMINAR_EMPLEADO
(
	@ID_EMPLEADO INT
)
AS
BEGIN
	DELETE FROM EMPLEADO 
	WHERE ID_EMPLEADO = @ID_EMPLEADO;
END
GO


/*
* Procedimiento para retornar informacion sobre los artefactos
* 
* Nombre			Fecha			Descripcion
* ----------------------------------------------
* Flores Sergio 	10/02/2019		Implementacion inicial
*/
CREATE PROCEDURE GET_ARTEFACTO
(
	@ID_ARTEFACTO INT
)
AS
if (exists(select * from ARTEFACTO ar where ar.ID_ARTEFACTO = @ID_ARTEFACTO))
	begin
		SELECT [ID_ARTEFACTO]
			  , tar.NOMBRE
			  ,ar.[NOMBRE]
			  ,[MODELO]
			  ,[INGRESO]
			  ,[ESTADO]
			  ,[CANTIDAD]
		  FROM [dbo].[ARTEFACTO] ar inner join TIPO_ARTEFACTO tar on ar.ID_TIPO = tar.ID_TIPO
		 WHERE AR.ID_ARTEFACTO = @ID_ARTEFACTO;
	end
else
	begin
	raiserror('el id artefacto no existe',1,1)
	return -1
	end
go

CREATE ASYMMETRIC KEY ClaveISOCODE
WITH ALGORITHM = RSA_2048
ENCRYPTION BY PASSWORD = 'KEYISOCODE'
GO

DECLARE @KEYID INT
SET @KEYID = AsymKey_ID('ClaveISOCODE');
