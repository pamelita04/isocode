
/*
* Procedimiento para registrar accidentes
* 
* Nombre			Fecha			Descripcion
* ----------------------------------------------
* Flores Sergio 	09/02/2019		Implementacion inicial
* Pamela Arnez      10/02/2019      Seguridad
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

grant execute on object::[dbo].[REGISTRAR_ACCIDENTE] TO [MyService] AS [dbo];
go

print 'Procedure [dbo].[REGISTRAR_ACCIDENTE] creado';
go


/*
* Procedimiento para registrar persona
* 
* Nombre			Fecha			Descripcion
* ----------------------------------------------
* Flores Sergio 	10/02/2019		Implementacion inicial
* Pamela Arnez      10/02/2019      Seguridad
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

grant execute on object::[dbo].[REGISTRAR_PERSONA] TO [MyService] AS [dbo];
go

print 'Procedure [dbo].[REGISTRAR_PERSONA] creado';
go

/*
* Procedimiento para registrar empleado
* 
* Nombre			Fecha			Descripcion
* ----------------------------------------------
* Pamela arnez 	10/02/2019		Implementacion inicial
* Pamela Arnez      10/02/2019      Seguridad
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

grant execute on object::[dbo].[REGISTRAR_EMPLEADO] TO [MyService] AS [dbo];
go

print 'Procedure [dbo].[REGISTRAR_EMPLEADO] creado';
go


CREATE ASYMMETRIC KEY ClaveISOCODE
WITH ALGORITHM = RSA_2048
ENCRYPTION BY PASSWORD = 'KEYISOCODE'
GO

DECLARE @KEYID INT
SET @KEYID = AsymKey_ID('ClaveISOCODE');
