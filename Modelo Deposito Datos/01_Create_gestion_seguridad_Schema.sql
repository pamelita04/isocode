/******************************************************************************
**  Name: Create Schema ETL
**  Called By ETL SQL Job.
**
**  Author: Sergio Flores
			Yamil Medina
			Paela Arnez
**
**  Created: 17/02/2018
*******************************************************************************
**                            Change History
*******************************************************************************
**  Date:       Author:				Description:
**  --------    --------     --------------------------------------------------
**  17/02/2018    Initial Version
******************************************************************************/
USE [gestion_seguridad];
GO

CREATE SCHEMA [ETL];
GO


create table ACCIDENTE (
   ID_ACCIDENTE         int                  not null identity,
   ID_TIPO              int                  null,
   FECHA                datetime             null,
   DETALLE              varchar(500)         null,
   LUGAR                varchar(150)         null,
   DETALLE_EMPLEADO     varchar(500)         null,
   Rowversion			timestamp			 not null,
   constraint PK_ACCIDENTE primary key nonclustered (ID_ACCIDENTE)
)
go

create table ACCIDENTES_EMPLEADO (
   ID_ACCIDENTE         int                  not null,
   ID_EMPLEADO          int                  not null,
   Rowversion			timestamp			 not null,
   constraint PK_ACCIDENTES_EMPLEADO primary key nonclustered (ID_ACCIDENTE, ID_EMPLEADO)
)
go

create table ARTEFACTO (
   ID_ARTEFACTO         int                  not null identity,
   ID_TIPO              int                  null,
   NOMBRE               varchar(50)          null,
   MODELO               varchar(50)          null,
   INGRESO              datetime             null,
   ESTADO               varchar(15)          null,
   CANTIDAD             int                  null,
   Rowversion			timestamp			 not null,
   constraint PK_ARTEFACTO primary key nonclustered (ID_ARTEFACTO)
)
go

create table ARTEFACTO_EMPLEADO (
   ID_EMPLEADO          int                  not null identity,
   ID_ESTADO_FISICO     int                  null,
   ID_DETALLE_ARTEFACTO int                  null,
   Rowversion			timestamp			 not null,
   constraint PK_ARTEFACTO_EMPLEADO primary key nonclustered (ID_EMPLEADO)
)
go

create table CAPACITACION (
   ID_CAPACITACION      int                  not null identity,
   ID_MEDIDA_SEGURIDAD  int                  null,
   TUTOR                varchar(50)          null,
   FECHA_INICIO         datetime             null,
   FECHA_FIN            datetime             null,
   TITULO               varchar(50)          null,
   DECRIPCION           varchar(250)         null,
   Rowversion			timestamp			 not null,
   constraint PK_CAPACITACION primary key nonclustered (ID_CAPACITACION)
)
go

create table CAPACITACION_EMPLEADO (
   ID_CAPACITACION      int                  not null,
   ID_EMPLEADO          int                  not null,
   Rowversion			timestamp			 not null,
   constraint PK_CAPACITACION_EMPLEADO primary key nonclustered (ID_CAPACITACION, ID_EMPLEADO)
)
go

create table COSTO (
   ID_COSTO             int                  not null identity,
   ID_ACCIDENTE         int                  null,
   TIPO                 varchar(25)          null,
   IMPORTE              money                null,
   NOTA                 varchar(150)         null,
   Rowversion			timestamp			 not null,
   constraint PK_COSTO primary key nonclustered (ID_COSTO)
)
go

create table DETALLE_ARTEFACTO (
   ID_DETALLE_ARTEFACTO int                  not null identity,
   ID_ARTEFACTO         int                  null,
   SERIAL               varchar(50)          null,
   INGRESO              datetime             null,
   ESTADO               char(1)              null,
   Rowversion			timestamp			 not null,
   constraint PK_DETALLE_ARTEFACTO primary key nonclustered (ID_DETALLE_ARTEFACTO)
)
go

create table EMPLEADO (
   ID_EMPLEADO          int                  not null identity,
   ID_PERSONA           int                  not null,
   ID_SECCION           int                  null,
   CARGO                varchar(50)          null,
   TITULO               varchar(50)          null,
   FECHA_CONTRATACION   datetime             null,
   ESTADO               char(1)              null,
   Rowversion			timestamp			 not null,
   constraint PK_EMPLEADO primary key nonclustered (ID_EMPLEADO)
)
go

create table EMPRESA (
   ID_EMPRESA           int                  not null identity,
   NOMBRE               varchar(25)          null,
   NIT                  varchar(30)          null,
   PROPIETARIO          varchar(50)          null,
   RUT                  int                  null,
   Rowversion			timestamp			 not null,
   constraint PK_EMPRESA primary key nonclustered (ID_EMPRESA)
)
go

create table ESTADO_FISICO_ARTEFACTO (
   ID_ESTADO_FISICO     int                  not null identity,
   CODIGO_ESTADO        varchar(25)          null,
   DESCRIPCION_ESTADO   varchar(100)         null,
   Rowversion			timestamp			 not null,
   constraint PK_ESTADO_FISICO_ARTEFACTO primary key nonclustered (ID_ESTADO_FISICO)
)
go

create table ESTRUCTURA_PERSONAL (
   EMPLEADOR_ID_EMP     int                  not null,
   ID_EMPLEADO          int                  not null,
   Rowversion			timestamp			 not null,
   constraint PK_ESTRUCTURA_PERSONAL primary key nonclustered (EMPLEADOR_ID_EMP, ID_EMPLEADO)
)
go

create table HISTORICO_ACCIDENTADO (
   ID_HISTORICO_AC      int                  not null identity,
   ID_EMPLEADO          int                  null,
   FECHA_INGRESO        datetime             null,
   FECHA_EGRESO         datetime             null,
   DETALLE              varchar(250)         null,
   Rowversion			timestamp			 not null,
   constraint PK_HISTORICO_ACCIDENTADO primary key nonclustered (ID_HISTORICO_AC)
)
go

create table HISTORICO_ACCIDENTE (
   ID_HISTORICO_ACCIDENTE int                  not null identity,
   ID_ACCIDENTE         int                  null,
   ID_TIPO              int                  null,
   FECHA                datetime             null,
   DETALLE              varchar(500)         null,
   LUGAR                varchar(150)         null,
   DETALLE_EMPLEADO     varchar(500)         null,
   FECHA_MODIFICACION   datetime             null,
   USUARIO_MODIFICACION varchar(50)          null,
   Rowversion			timestamp			 not null,
   constraint PK_HISTORICO_ACCIDENTE primary key nonclustered (ID_HISTORICO_ACCIDENTE)
)
go

create table HISTORICO_ARTEFACTO (
   ID_ARTEFACTO         int                  not null,
   ID_MEDIDA_SEGURIDAD  int                  not null,
   Rowversion			timestamp			 not null,
   constraint PK_HISTORICO_ARTEFACTO primary key nonclustered (ID_ARTEFACTO, ID_MEDIDA_SEGURIDAD)
)
go


create table LOGIN (
   ID_LOGIN             int                  not null identity,
   ID_EMPLEADO          int                  null,
   NICK                 varchar(10)          null,
   CONTRASENA           varchar(100)         null,
   ESTADO               char(1)              null,
   Rowversion			timestamp			 not null,
   constraint PK_LOGIN primary key nonclustered (ID_LOGIN)
)
go

create table MANTENIMIENTO (
   ID_MANTENIMIENTO     int                  not null identity,
   ID_DETALLE_ARTEFACTO int                  null,
   FECHA_INICIO         datetime             null,
   FECHA_FIN            datetime             null,
   DETALLE              varchar(250)         null,
   Rowversion			timestamp			 not null,
   constraint PK_MANTENIMIENTO primary key nonclustered (ID_MANTENIMIENTO)
)
go

create table MEDIDA_DE_SEGURIDAD (
   ID_MEDIDA_SEGURIDAD  int                  not null identity,
   TITULO               varchar(25)          null,
   DESCRIPCION          varchar(250)         null,
   FECHA_CREACION       datetime             null,
   ENCARGADO            varchar(50)          null,
   TIPO                 varchar(50)          null,
   PATH_DOCUMENTO       varchar(150)         null,
   Rowversion			timestamp			 not null,
   constraint PK_MEDIDA_DE_SEGURIDAD primary key nonclustered (ID_MEDIDA_SEGURIDAD)
)
go

create table OBRA (
   ID_OBRA              int                  not null identity,
   ID_SECCION           int                  null,
   NOMBRE               varchar(50)          null,
   TELEFONO             varchar(10)          null,
   DIRECCION            varchar(50)          null,
   Rowversion			timestamp			 not null,
   constraint PK_OBRA primary key nonclustered (ID_OBRA)
)
go

create table PERSONA (
   ID_PERSONA           int                  not null identity,
   NOMBRES              varchar(50)          null,
   APELLIDOS            varchar(100)         null,
   TELEFONO             varchar(25)          null,
   DIRECCION            varchar(200)         null,
   EMAIL                varchar(50)          null,
   SEXO                 char(2)              null,
   NACIMIENTO           datetime             null,
   CI                   varchar(15)          null,
   NACIONALIDAD         varchar(25)          null,
   Rowversion			timestamp			 not null,
   constraint PK_PERSONA primary key nonclustered (ID_PERSONA)
)
go

create table REPORTE (
   ID_REPORTE           int                  not null identity,
   ID_TIPO              int                  null,
   ID_MEDIDA_SEGURIDAD  int                  null,
   DETALLE              varchar(250)         null,
   FECHA                datetime             null,
   DIRECTORIO           varchar(50)          null,
   Rowversion			timestamp			 not null,
   constraint PK_REPORTE primary key nonclustered (ID_REPORTE)
)
go

create table SECCION (
   ID_SECCION           int                  not null identity,
   ID_EMPRESA           int                  null,
   NOMBRE               varchar(50)          null,
   UBICACION            varchar(100)         null,
   Rowversion			timestamp			 not null,
   constraint PK_SECCION primary key nonclustered (ID_SECCION)
)
go

create table TELEFONO (
   ID_TELEFONO          int                  not null identity,
   ID_EMPRESA           int                  null,
   NUMERO               varchar(10)          null,
   DETALLE              varchar(50)          null,
   Rowversion			timestamp			 not null,
   constraint PK_TELEFONO primary key nonclustered (ID_TELEFONO)
)
go

create table TIPO_ACCIDENTE (
   ID_TIPO              int                  not null identity,
   CODIGO               varchar(50)          null,
   DESCRIPCION          varchar(250)         null,
   Rowversion			timestamp			 not null,
   constraint PK_TIPO_ACCIDENTE primary key nonclustered (ID_TIPO)
)
go

create table TIPO_ARTEFACTO (
   ID_TIPO              int                  not null identity,
   NOMBRE               varchar(50)          null,
   DESCRIPCION          varchar(150)         null,
   Rowversion			timestamp			 not null,
   constraint PK_TIPO_ARTEFACTO primary key nonclustered (ID_TIPO)
)
go

create table TIPO_REPORTE (
   ID_TIPO              int                  not null identity,
   CODIGO               varchar(25)          null,
   DESCRIPCION          varchar(50)          null,
   Rowversion			timestamp			 not null,
   constraint PK_TIPO_REPORTE primary key nonclustered (ID_TIPO)
)
go

CREATE TABLE [ETL].[TableMigration](
	[IDMigration] [int] IDENTITY(1,1) NOT NULL,
	[TableName] [varchar](50) NOT NULL,
	[LatestChange] [bigint] NOT NULL CONSTRAINT [DF_Migration]  DEFAULT ((0)),
 CONSTRAINT [PK_Migration] PRIMARY KEY CLUSTERED 
(
	[IDMigration] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

alter table ACCIDENTE
   add constraint FK_ACCIDENT_RELATIONS_TIPO_ACC foreign key (ID_TIPO)
      references TIPO_ACCIDENTE (ID_TIPO)
go

alter table ACCIDENTES_EMPLEADO
   add constraint FK_ACCIDENT_RELATIONS_EMPLEADO foreign key (ID_EMPLEADO)
      references EMPLEADO (ID_EMPLEADO)
go

alter table ACCIDENTES_EMPLEADO
   add constraint FK_ACCIDENT_RELATIONS_ACCIDENT foreign key (ID_ACCIDENTE)
      references ACCIDENTE (ID_ACCIDENTE)
go

alter table ARTEFACTO
   add constraint FK_ARTEFACT_RELATIONS_TIPO_ART foreign key (ID_TIPO)
      references TIPO_ARTEFACTO (ID_TIPO)
go

alter table ARTEFACTO_EMPLEADO
   add constraint FK_ARTEFACT_RELATIONS_ESTADO_F foreign key (ID_ESTADO_FISICO)
      references ESTADO_FISICO_ARTEFACTO (ID_ESTADO_FISICO)
go

alter table ARTEFACTO_EMPLEADO
   add constraint FK_ARTEFACT_RELATIONS_DETALLE_ foreign key (ID_DETALLE_ARTEFACTO)
      references DETALLE_ARTEFACTO (ID_DETALLE_ARTEFACTO)
go

alter table ARTEFACTO_EMPLEADO
   add constraint FK_ARTEFACT_RELATIONS_EMPLEADO foreign key (ID_EMPLEADO)
      references EMPLEADO (ID_EMPLEADO)
go

alter table CAPACITACION
   add constraint FK_CAPACITA_RELATIONS_MEDIDA_D foreign key (ID_MEDIDA_SEGURIDAD)
      references MEDIDA_DE_SEGURIDAD (ID_MEDIDA_SEGURIDAD)
go

alter table CAPACITACION_EMPLEADO
   add constraint FK_CAPACITA_RELATIONS_EMPLEADO foreign key (ID_EMPLEADO)
      references EMPLEADO (ID_EMPLEADO)
go

alter table CAPACITACION_EMPLEADO
   add constraint FK_CAPACITA_RELATIONS_CAPACITA foreign key (ID_CAPACITACION)
      references CAPACITACION (ID_CAPACITACION)
go

alter table COSTO
   add constraint FK_COSTO_RELATIONS_ACCIDENT foreign key (ID_ACCIDENTE)
      references ACCIDENTE (ID_ACCIDENTE)
go

alter table DETALLE_ARTEFACTO
   add constraint FK_DETALLE__RELATIONS_ARTEFACT foreign key (ID_ARTEFACTO)
      references ARTEFACTO (ID_ARTEFACTO)
go

alter table EMPLEADO
   add constraint FK_EMPLEADO_RELATIONS_SECCION foreign key (ID_SECCION)
      references SECCION (ID_SECCION)
go

alter table EMPLEADO
   add constraint FK_EMPLEADO_RELATIONS_PERSONA foreign key (ID_PERSONA)
      references PERSONA (ID_PERSONA)
go

alter table ESTRUCTURA_PERSONAL
   add constraint FK_ESTRUCTU_RELATIONS_EMPLEADO foreign key (ID_EMPLEADO)
      references EMPLEADO (ID_EMPLEADO)
go

alter table ESTRUCTURA_PERSONAL
   add constraint FK_ESTRUCTU_RELATION_EMPLEADOR foreign key (EMPLEADOR_ID_EMP)
      references EMPLEADO (ID_EMPLEADO)
go

alter table HISTORICO_ACCIDENTADO
   add constraint FK_HISTORIC_RELATIONS_EMPLEADO foreign key (ID_EMPLEADO)
      references EMPLEADO (ID_EMPLEADO)
go

alter table HISTORICO_ACCIDENTE
   add constraint FK_HISTORIC_RELATIONS_ACCIDENT foreign key (ID_ACCIDENTE)
      references ACCIDENTE (ID_ACCIDENTE)
go

alter table HISTORICO_ARTEFACTO
   add constraint FK_HISTORIC_RELATIONS_MEDIDA_D foreign key (ID_MEDIDA_SEGURIDAD)
      references MEDIDA_DE_SEGURIDAD (ID_MEDIDA_SEGURIDAD)
go

alter table HISTORICO_ARTEFACTO
   add constraint FK_HISTORIC_RELATIONS_ARTEFACT foreign key (ID_ARTEFACTO)
      references ARTEFACTO (ID_ARTEFACTO)
go

alter table LOGIN
   add constraint FK_LOGIN_RELATIONS_EMPLEADO foreign key (ID_EMPLEADO)
      references EMPLEADO (ID_EMPLEADO)
go

alter table MANTENIMIENTO
   add constraint FK_MANTENIM_RELATIONS_DETALLE_ foreign key (ID_DETALLE_ARTEFACTO)
      references DETALLE_ARTEFACTO (ID_DETALLE_ARTEFACTO)
go

alter table OBRA
   add constraint FK_OBRA_RELATIONS_SECCION foreign key (ID_SECCION)
      references SECCION (ID_SECCION)
go

alter table REPORTE
   add constraint FK_REPORTE_RELATIONS_TIPO_REP foreign key (ID_TIPO)
      references TIPO_REPORTE (ID_TIPO)
go

alter table REPORTE
   add constraint FK_REPORTE_RELATIONS_MEDIDA_D foreign key (ID_MEDIDA_SEGURIDAD)
      references MEDIDA_DE_SEGURIDAD (ID_MEDIDA_SEGURIDAD)
go

alter table SECCION
   add constraint FK_SECCION_RELATIONS_EMPRESA foreign key (ID_EMPRESA)
      references EMPRESA (ID_EMPRESA)
go

alter table TELEFONO
   add constraint FK_TELEFONO_RELATIONS_EMPRESA foreign key (ID_EMPRESA)
      references EMPRESA (ID_EMPRESA)
go

/******************************************************************************
**  Name: GetDatabaseRowVersion
**  Desc: Used by DW ETL Process
**
**  Called by: SQL Job
**  Author: 
**
**  Created: 17/02/2018
*******************************************************************************
**                            Change History
*******************************************************************************
**  Date:       Author:         Description:
**  --------    --------        -----------------------------------------------
**  17/02/2018    Initial Version
******************************************************************************/
CREATE FUNCTION [ETL].[GetDatabaseRowVersion] ()
RETURNS BIGINT
AS
BEGIN
  RETURN CONVERT(BIGINT, MIN_ACTIVE_ROWVERSION()) - 1;
END
GO

/******************************************************************************
**  Name: GetTableMigrationLatestRowVersion
**  Desc: Gets Latest Rowversion used into the corresponding the table
**
**  Called by: SQL Job
**  Author: Pamela Arnez
**
**  Created: 18/05/2018
*******************************************************************************
**                            Change History
*******************************************************************************
**  Date:       Author:         Description:
**  --------    --------        -----------------------------------------------
**  18/05/2018  Pamela Arnez  Initial Version
******************************************************************************/
CREATE FUNCTION [ETL].[GetTableMigrationLatestRowVersion] 
(
	@table VARCHAR(50)
)
RETURNS BIGINT
AS
BEGIN
	DECLARE @last BIGINT;

	SELECT @last = LatestChange
	FROM [ETL].[TableMigration]
	WHERE TableName = @table;

  RETURN @last;
END
GO

/******************************************************************************
**  Name: GetCourseChangesByRowVersion
**  Desc: Pulls Changes and Inserts from the dbo.Course table 
**  Called By ETL SQL Job.
**
**  Author: Sergio Flores
*
**  Created: 18/05/2018
*******************************************************************************
**                            Change History
*******************************************************************************
**  Date:       Author:				Description:
**  --------    --------		--------------------------------------------------
**  18/05/2018  Sergio Flores Initial Version
******************************************************************************/
CREATE PROCEDURE [ETL].[GetEmpleadoChangesByRowVersion]
(
  @LastRowVersionID BIGINT,
  @CurrentDBTS      BIGINT
)
AS
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	SELECT e.id_empleado, 
		   nombres = p.nombres + ' ' + p.apellidos, 
		   e.cargo, 
		   e.fecha_contratacion, 
		   p.telefono 
	FROM   empleado e 
		   INNER JOIN persona p ON e.id_persona = p.id_persona 
	WHERE  e.[rowversion] > CONVERT(ROWVERSION, @LastRowVersionID) 
		   AND e.[rowversion] <= CONVERT(ROWVERSION, @CurrentDBTS) 
	UNION 
	SELECT e.id_empleado, 
		   nombres = p.nombres + ' ' + p.apellidos, 
		   e.cargo, 
		   e.fecha_contratacion, 
		   p.telefono 
	FROM   empleado e 
		   INNER JOIN persona p ON e.id_persona = p.id_persona 
	WHERE  p.[rowversion] > CONVERT(ROWVERSION, @LastRowVersionID) 
		   AND p.[rowversion] <= CONVERT(ROWVERSION, @CurrentDBTS); 
GO
/******************************************************************************
**  Name: GetDepartmentChangesByRowVersion
**  Desc: Pulls Changes and Inserts from the dbo.Department table 
**  Called By ETL SQL Job.
**
**  Author: Yamil Medina
**
**  Created: 17/02/2018
*******************************************************************************
**                            Change History
*******************************************************************************
**  Date:       Author:      Description:
**  --------    --------     --------------------------------------------------
** 17/02/2018  Yamil Medina Initial Version
******************************************************************************/
CREATE PROCEDURE [ETL].[GetArtefactoChangesByRowVersion]
(
  @LastRowVersionID BIGINT,
  @CurrentDBTS      BIGINT
)
AS
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	SELECT da.id_detalle_artefacto, 
		   a.nombre, 
		   tipo = ta.nombre, 
		   da.estado, 
		   antiguedad = CONVERT(VARCHAR, Datediff(month, da.ingreso, Getdate())) + ' meses', 
		   ultimo_mantenimiento = m.fecha_fin 
	FROM   artefacto a 
		   INNER JOIN detalle_artefacto da ON a.id_artefacto = da.id_artefacto 
		   INNER JOIN tipo_artefacto ta ON a.id_tipo = ta.id_tipo 
		   LEFT JOIN mantenimiento m ON da.id_detalle_artefacto = m.id_detalle_artefacto 
	WHERE  a.[rowversion] > CONVERT(ROWVERSION, @LastRowVersionID) 
		   AND a.[rowversion] <= CONVERT(ROWVERSION, @CurrentDBTS) 
	UNION 
	SELECT da.id_detalle_artefacto, 
		   a.nombre, 
		   ta.nombre, 
		   da.estado, 
		   antiguedad = CONVERT(VARCHAR, Datediff(month, da.ingreso, Getdate())) + ' meses', 
		   m.fecha_fin 
	FROM   artefacto a 
		   INNER JOIN detalle_artefacto da ON a.id_artefacto = da.id_artefacto 
		   INNER JOIN tipo_artefacto ta ON a.id_tipo = ta.id_tipo 
		   LEFT JOIN mantenimiento m ON da.id_detalle_artefacto = m.id_detalle_artefacto 
	WHERE  da.[rowversion] > CONVERT(ROWVERSION, @LastRowVersionID) 
		   AND da.[rowversion] <= CONVERT(ROWVERSION, @CurrentDBTS) 
	UNION 
	SELECT da.id_detalle_artefacto, 
		   a.nombre, 
		   ta.nombre, 
		   da.estado, 
		   antiguedad = CONVERT(VARCHAR, Datediff(month, da.ingreso, Getdate())) + ' meses', 
		   m.fecha_fin 
	FROM   artefacto a 
		   INNER JOIN detalle_artefacto da ON a.id_artefacto = da.id_artefacto 
		   INNER JOIN tipo_artefacto ta ON a.id_tipo = ta.id_tipo 
		   LEFT JOIN mantenimiento m ON da.id_detalle_artefacto = m.id_detalle_artefacto 
	WHERE  ta.[rowversion] > CONVERT(ROWVERSION, @LastRowVersionID) 
		   AND ta.[rowversion] <= CONVERT(ROWVERSION, @CurrentDBTS) 
GO

/******************************************************************************
**  Name: GetGradeChangesByRowVersion
**  Desc: Pulls Changes and Inserts from the dbo.StudentGrade table 
**  Called By ETL SQL Job.
**
**  Author: Pamela Arnez
**
**  Created: 17/02/2018
*******************************************************************************
**                            Change History
*******************************************************************************
**  Date:       Author:      Description:
**  --------    --------     --------------------------------------------------
**  17/02/2018  Pamela Arnez Initial Version
******************************************************************************/
CREATE PROCEDURE [ETL].[GetLugarChangesByRowVersion]
(
  @LastRowVersionID BIGINT,
  @CurrentDBTS      BIGINT
)
AS
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	SELECT s.id_seccion, 
		   a.lugar, 
		   seccion = s.nombre, 
		   obra = o.nombre 
	FROM   accidente a 
		   INNER JOIN accidentes_empleado ae ON a.id_accidente = ae.id_accidente 
		   INNER JOIN empleado e ON ae.id_empleado = e.id_empleado 
		   INNER JOIN seccion s ON e.id_seccion = s.id_seccion 
		   INNER JOIN obra o ON s.id_seccion = o.id_seccion 
	WHERE  ae.[rowversion] > CONVERT(ROWVERSION, @LastRowVersionID) 
		   AND ae.[rowversion] <= CONVERT(ROWVERSION, @CurrentDBTS) 
	UNION 
	SELECT s.id_seccion, 
		   a.lugar, 
		   seccion = s.nombre, 
		   obra = o.nombre 
	FROM   accidente a 
		   INNER JOIN accidentes_empleado ae ON a.id_accidente = ae.id_accidente 
		   INNER JOIN empleado e ON ae.id_empleado = e.id_empleado 
		   INNER JOIN seccion s ON e.id_seccion = s.id_seccion 
		   INNER JOIN obra o ON s.id_seccion = o.id_seccion 
	WHERE  e.[rowversion] > CONVERT(ROWVERSION, @LastRowVersionID) 
		   AND e.[rowversion] <= CONVERT(ROWVERSION, @CurrentDBTS) 
	UNION 
	SELECT s.id_seccion, 
		   a.lugar, 
		   seccion = s.nombre, 
		   obra = o.nombre 
	FROM   accidente a 
		   INNER JOIN accidentes_empleado ae ON a.id_accidente = ae.id_accidente 
		   INNER JOIN empleado e ON ae.id_empleado = e.id_empleado 
		   INNER JOIN seccion s ON e.id_seccion = s.id_seccion 
		   INNER JOIN obra o ON s.id_seccion = o.id_seccion 
	WHERE  s.[rowversion] > CONVERT(ROWVERSION, @LastRowVersionID) 
		   AND s.[rowversion] <= CONVERT(ROWVERSION, @CurrentDBTS); 

GO

/******************************************************************************
**  Name: GetGradeChangesByRowVersion
**  Desc: Pulls Changes and Inserts from the dbo.StudentGrade table 
**  Called By ETL SQL Job.
**
**  Author: Sergio Flores
**
**  Created: 17/02/2018
*******************************************************************************
**                            Change History
*******************************************************************************
**  Date:       Author:				Description:
**  --------    --------     --------------------------------------------------
**  17/02/2018  Sergio Flores  Initial Version
******************************************************************************/
CREATE PROCEDURE [ETL].[GetAccidenteChangesByRowVersion]
(
  @LastRowVersionID BIGINT,
  @CurrentDBTS      BIGINT
)
AS
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	SELECT ae.id_empleado, 
		   s.id_seccion, 
		   are.id_detalle_artefacto, 
		   a.detalle, 
		   a.fecha, 
		   tipo_accidente = ta.codigo 
	FROM   accidente a 
		   INNER JOIN accidentes_empleado ae ON a.id_accidente = ae.id_accidente 
		   INNER JOIN empleado e ON ae.id_empleado = e.id_empleado 
		   INNER JOIN seccion s ON e.id_seccion = s.id_seccion 
		   INNER JOIN artefacto_empleado are ON e.id_empleado = are.id_empleado 
		   INNER JOIN tipo_accidente ta ON a.id_tipo = ta.id_tipo 
	WHERE  a.[rowversion] > CONVERT(ROWVERSION, @LastRowVersionID) 
		   AND a.[rowversion] <= CONVERT(ROWVERSION, @CurrentDBTS); 
	
GO



/******************************************************************************
**  Name: UpdateTableMigration
**  Desc: Updates Table Migration with latest Rowversion used 
**  Called By ETL SQL Job.
**
**  Author: 
**
**  Created: 17/02/2018
*******************************************************************************
**                            Change History
*******************************************************************************
**  Date:       Author:      Description:
**  --------    --------     --------------------------------------------------
**  17/02/2018   Initial Version
******************************************************************************/
CREATE PROCEDURE [ETL].[UpdateTableMigration]
(
  @tableName VARCHAR(50),
  @current     BIGINT
)
AS
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	UPDATE [ETL].[TableMigration]
	SET LatestChange = @current
	WHERE TableName = @tableName;
GO

/******************************************************************************
**  Name: PullTableDataToDW
**  Desc: Pulls Changes and Inserts from the School to DWSchool Database
**  Called By ETL SQL Job.
**
**  Author: Yamil Medina
**
**  Created: 17/02/2018
*******************************************************************************
**                            Change History
*******************************************************************************
**  Date:       Author:      Description:
**  --------    --------     --------------------------------------------------
**  17/02/2018  Yamil Medina Initial Version
******************************************************************************/
CREATE PROCEDURE [ETL].[PullDataToDatawarehouse]
(
  @table VARCHAR(50)
)
AS
	SET NOCOUNT ON;
	SET XACT_ABORT ON;
BEGIN
	DECLARE @SQLString      NVARCHAR(MAX);  
	DECLARE @ParmDefinition NVARCHAR(MAX); 
	DECLARE @currentDBTS    BIGINT = [ETL].[GetDatabaseRowVersion]();
	DECLARE @lastDBTS       BIGINT = [ETL].[GetTableMigrationLatestRowVersion](@table); 

	SET @ParmDefinition = N'@last BIGINT, @current BIGINT'; 
	SET @SQLString = N'INSERT INTO [DWgestion_seguridad].[ETL].[' + @table + ']
					   EXECUTE [ETL].[Get' + @table + 'ChangesByRowVersion] @LastRowVersionID = @last
																		   ,@CurrentDBTS      = @current;';  
	EXECUTE SP_EXECUTESQL @SQLString
						 ,@ParmDefinition
						 ,@last    = @lastDBTS
						 ,@current = @currentDBTS;  

	EXECUTE [ETL].[UpdateTableMigration] @tableName = @table
										,@current   = @currentDBTS;
END
GO
