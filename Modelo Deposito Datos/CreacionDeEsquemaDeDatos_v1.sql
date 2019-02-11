/*
use [MyDataBase]
go
*/

CREATE SCHEMA [ETL];
GO

create table TIPO_ACCIDENTE (
   ID_TIPO              int                  not null identity,
   CODIGO               varchar(25)          null,
   DESCRIPCION          varchar(50)          null,
   [Rowversion]			[timestamp]			 NOT NULL,
   constraint PK_TIPO_ACCIDENTE primary key nonclustered
(
	[ID_TIPO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

create table ACCIDENTE (
   ID_ACCIDENTE         int                  not null identity,
   ID_TIPO              int                  null,
   FECHA                datetime             null,
   DETALLE              varchar(500)         null,
   LUGAR                varchar(150)         null,
   DETALLE_EMPLEADO     varchar(500)         null,
   [Rowversion]			[timestamp]			 NOT NULL,
   constraint PK_ACCIDENTE primary key nonclustered
(
	ID_ACCIDENTE ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

create table PERSONA (
   ID_PERSONA           int                  not null identity,
   NOMBRES              varchar(50)          null,
   APELLIDOS            varchar(100)         null,
   TELEFONO             varchar(25)          null,
   DIRECCION            varchar(200)         null,
   EMAIL                varchar(25)          null,
   SEXO                 char(2)              null,
   NACIMIENTO           datetime             null,
   CI                   varchar(15)          null,
   NACIONALIDAD         varchar(25)          null,
   [Rowversion]			[timestamp]			 NOT NULL,
   constraint PK_PERSONA primary key nonclustered
(
	ID_PERSONA ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

create table EMPRESA (
   ID_EMPRESA           int                  not null identity,
   NOMBRE               varchar(25)          null,
   NIT                  varchar(30)          null,
   PROPIETARIO          varchar(50)          null,
   RUT                  int                  null,
   TELEFONO             varchar(15)          null,
   [Rowversion]			[timestamp]			 NOT NULL,
   constraint PK_EMPRESA primary key nonclustered 
(
	ID_EMPRESA ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


create table OBRA (
   ID_OBRA              int                  not null identity,
   ID_EMPRESA           int                  null,
   NOMBRE               varchar(50)          null,
   TELEFONO             varchar(10)          null,
   DIRECCION            varchar(50)          null,
   [Rowversion]			[timestamp]			 NOT NULL,
   constraint PK_OBRA primary key nonclustered
(
	ID_OBRA ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

create table SECCION (
   ID_SECCION           int                  not null identity,
   ID_OBRA              int                  null,
   NOMBRE               varchar(25)          null,
   UBICACION            varchar(50)          null,
   [Rowversion]			[timestamp]			 NOT NULL,
   constraint PK_SECCION primary key nonclustered
(
	ID_SECCION ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

create table EMPLEADO (
   ID_EMPLEADO          int                  not null identity,
   ID_PERSONA           int                  not null,
   ID_SECCION           int                  null,
   CARGO                varchar(25)          null,
   TITULO               varchar(25)          null,
   FECHA_CONTRATACION   datetime             null,
   ESTADO               char(1)              null,
   [Rowversion]			[timestamp]			 NOT NULL,
   constraint PK_EMPLEADO primary key nonclustered	  
(
	ID_EMPLEADO ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

create table ACCIDENTES_EMPLEADO (
   ID_ACCIDENTE         int                  not null,
   ID_EMPLEADO          int                  not null,
   [Rowversion]			[timestamp]			 NOT NULL,
   constraint PK_ACCIDENTES_EMPLEADO primary key nonclustered  
(
	ID_ACCIDENTE ASC,
    ID_EMPLEADO ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

create table TIPO_ARTEFACTO (
   ID_TIPO              int                  not null identity,
   NOMBRE               varchar(25)          null,
   DESCRIPCION          varchar(50)          null,
   [Rowversion]			[timestamp]			 NOT NULL,
   constraint PK_TIPO_ARTEFACTO primary key nonclustered
(
	ID_TIPO ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

create table ARTEFACTO (
   ID_ARTEFACTO         int                  not null identity,
   ID_TIPO              int                  null,
   NOMBRE               varchar(50)          null,
   MODELO               varchar(50)          null,
   INGRESO              datetime             null,
   ESTADO               varchar(15)          null,
   CANTIDAD             int                  null,
   [Rowversion]			[timestamp]			 NOT NULL,
   constraint PK_ARTEFACTO primary key nonclustered
(
	ID_ARTEFACTO ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

create table ESTADO_FISICO_EQUIPO (
   ID_ESTADO_FISICO     int                  not null identity,
   CODIGO_ESTADO        varchar(25)          null,
   DESCRIPCION_ESTADO   varchar(100)         null,
   [Rowversion]			[timestamp]			 NOT NULL,
   constraint PK_ESTADO_FISICO_EQUIPO primary key nonclustered 
(
	ID_ESTADO_FISICO ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

create table ARTEFACTO_EMPLEADO (
   ID_EMPLEADO          int                  not null,
   ID_ARTEFACTO         int                  not null,
   ID_ESTADO_FISICO     int                  null,
   ID_DETALLE_ARTEFACTO int                  null,
   [Rowversion]			[timestamp]			 NOT NULL,
   constraint PK_ARTEFACTO_EMPLEADO primary key nonclustered 
(
	ID_EMPLEADO ASC,
    ID_ARTEFACTO ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

create table MEDIDA_DE_SEGURIDAD (
   ID_MEDIDA_SEGURIDAD  int                  not null identity,
   TITULO               varchar(25)          null,
   DESCRIPCION          varchar(250)         null,
   FECHA_CREACION       datetime             null,
   ENCARGADO            varchar(50)          null,
   TIPO                 varchar(50)          null,
   PATH_DOCUMENTO       varchar(150)         null,
   [Rowversion]			[timestamp]			 NOT NULL,
   constraint PK_MEDIDA_DE_SEGURIDAD primary key nonclustered
(
	ID_MEDIDA_SEGURIDAD ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

create table CAPACITACION (
   ID_CAPACITACION      int                  not null identity,
   ID_MEDIDA_SEGURIDAD  int                  null,
   TUTOR                varchar(50)          null,
   FECHA_INICIO         datetime             null,
   FECHA_FIN            datetime             null,
   TITULO               varchar(50)          null,
   DECRIPCION           varchar(250)         null,
   [Rowversion]			[timestamp]			 NOT NULL,
   constraint PK_CAPACITACION primary key nonclustered 
(
	ID_CAPACITACION ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

create table CAPACITACION_EMPLEADO (
   ID_CAPACITACION      int                  not null,
   ID_EMPLEADO          int                  not null,
   [Rowversion]			[timestamp]			 NOT NULL,
   constraint PK_CAPACITACION_EMPLEADO primary key nonclustered
(
	ID_CAPACITACION ASC,
    ID_EMPLEADO ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

create table COSTO (
   ID_COSTO             int                  not null identity,
   ID_ACCIDENTE         int                  null,
   TIPO                 varchar(25)          null,
   IMPORTE              money                null,
   NOTA                 varchar(150)         null,
   [Rowversion]			[timestamp]			 NOT NULL,
   constraint PK_COSTO primary key nonclustered 
(
	ID_COSTO ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

create table DETALLE_ARTEFACTO (
   ID_DETALLE_ARTEFACTO int                  not null identity,
   ID_ARTEFACTO         int                  null,
   SERIAL               varchar(50)          null,
   INGRESO              datetime             null,
   ESTADO               char(1)              null,
   [Rowversion]			[timestamp]			 NOT NULL,
   constraint PK_DETALLE_ARTEFACTO primary key nonclustered
(
	ID_DETALLE_ARTEFACTO ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO



create table ESTRUCTURA_PERSONAL (
   EMP_ID_EMPLEADO      int                  not null,
   ID_EMPLEADO          int                  not null,
   [Rowversion]			[timestamp]			 NOT NULL,
   constraint PK_ESTRUCTURA_PERSONAL primary key nonclustered 
(
	EMP_ID_EMPLEADO ASC,
   ID_EMPLEADO ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

create table HISTORICO_ACCIDENTE (
   ID_HISTORICO_ACCIDENTE int                  not null identity,
   ID_ACCIDENTE         int                  null,
   ID_TIPO              int                  null,
   FECHA                datetime             null,
   DETALLE              varchar(500)         null,
   LUGAR                varchar(150)         null,
   DETALLE_EMPLEADO     varchar(500)         null,
   FECHA_MODIFICACION   datetime             null,
   USUARIO_MODIFICACION int                  null,
   [Rowversion]			[timestamp]			 NOT NULL,
   constraint PK_HISTORICO_ACCIDENTE primary key nonclustered 
(
	ID_HISTORICO_ACCIDENTE ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

create table HISTORICO_ARTEFACTO (
   ID_ARTEFACTO         int                  not null,
   ID_MEDIDA_SEGURIDAD  int                  not null,
   [Rowversion]			[timestamp]			 NOT NULL,
   constraint PK_HISTORICO_ARTEFACTO primary key nonclustered 
(
	ID_ARTEFACTO ASC,
   ID_MEDIDA_SEGURIDAD ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

create table HISTORICO_BAJAS (
   ID_HISTORICO_AC      int                  not null identity,
   ID_EMPLEADO          int                  null,
   FECHA_INGRESO        datetime             null,
   FECHA_EGRESO         datetime             null,
   DETALLE              varchar(250)         null,
   [Rowversion]			[timestamp]			 NOT NULL,
   constraint PK_HISTORICO_BAJAS primary key nonclustered
(
	ID_HISTORICO_AC ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

create table LOGIN (
   ID_LOGIN             int                  not null identity,
   ID_EMPLEADO          int                  null,
   NICK                 varchar(10)          null,
   CONTRASENA           varchar(100)         null,
   ESTADO               char(1)              null,
   [Rowversion]			[timestamp]			 NOT NULL,
   constraint PK_LOGIN primary key nonclustered 
(
	ID_LOGIN ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

create table MANTENIMIENTO (
   ID_MANTENIMIENTO     int                  not null identity,
   ID_ARTEFACTO         int                  null,
   FECHA_INICIO         datetime             null,
   FECHA_FIN            datetime             null,
   DETALLE              varchar(250)         null,
   [Rowversion]			[timestamp]			 NOT NULL,
   constraint PK_MANTENIMIENTO primary key nonclustered 
(
	ID_MANTENIMIENTO ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


/*
Table migration
*/

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


ALTER TABLE [dbo].ACCIDENTE  WITH CHECK ADD  CONSTRAINT FK_ACCIDENT_RELATIONS_TIPO_ACC FOREIGN KEY(ID_TIPO)
REFERENCES [dbo].TIPO_ACCIDENTE (ID_TIPO)
GO
ALTER TABLE [dbo].OBRA  WITH CHECK ADD  CONSTRAINT FK_OBRA_RELATIONS_EMPRESA FOREIGN KEY(ID_EMPRESA)
REFERENCES [dbo].EMPRESA (ID_EMPRESA)
GO
ALTER TABLE [dbo].SECCION WITH CHECK ADD  CONSTRAINT FK_SECCION_RELATIONS_OBRA FOREIGN KEY(ID_OBRA)
REFERENCES [dbo].OBRA (ID_OBRA)
GO

ALTER TABLE [dbo].EMPLEADO  WITH CHECK ADD  CONSTRAINT FK_EMPLEADO_RELATIONS_PERSONA FOREIGN KEY(ID_PERSONA)
REFERENCES [dbo].PERSONA (ID_PERSONA)
GO
ALTER TABLE [dbo].EMPLEADO  WITH CHECK ADD  CONSTRAINT FK_EMPLEADO_RELATIONS_SECCION FOREIGN KEY(ID_SECCION)
REFERENCES [dbo].SECCION (ID_SECCION)
GO

ALTER TABLE [dbo].ACCIDENTES_EMPLEADO  WITH CHECK ADD  CONSTRAINT FK_ACCIDENT_RELATIONS_EMPLEADO FOREIGN KEY(ID_EMPLEADO)
REFERENCES [dbo].EMPLEADO (ID_EMPLEADO)
GO
ALTER TABLE [dbo].ACCIDENTES_EMPLEADO  WITH CHECK ADD  CONSTRAINT FK_ACCIDENT_RELATIONS_ACCIDENT FOREIGN KEY(ID_ACCIDENTE)
REFERENCES [dbo].ACCIDENTE (ID_ACCIDENTE)
GO

ALTER TABLE [dbo].ARTEFACTO  WITH CHECK ADD  CONSTRAINT FK_ARTEFACT_RELATIONS_TIPO_ART FOREIGN KEY(ID_TIPO)
REFERENCES [dbo].TIPO_ARTEFACTO (ID_TIPO)
GO

ALTER TABLE [dbo].ARTEFACTO_EMPLEADO  WITH CHECK ADD  CONSTRAINT FK_ARTEFACT_RELATIONS_DETALLE_ FOREIGN KEY(ID_DETALLE_ARTEFACTO)
REFERENCES [dbo].DETALLE_ARTEFACTO (ID_DETALLE_ARTEFACTO)
GO
ALTER TABLE [dbo].ARTEFACTO_EMPLEADO  WITH CHECK ADD  CONSTRAINT FK_ARTEFACT_RELATIONS_ESTADO_F FOREIGN KEY(ID_ESTADO_FISICO)
REFERENCES [dbo].ESTADO_FISICO_EQUIPO (ID_ESTADO_FISICO)
GO
ALTER TABLE [dbo].ARTEFACTO_EMPLEADO  WITH CHECK ADD  CONSTRAINT FK_ARTEFACT_RELATIONS_ARTEFACT FOREIGN KEY(ID_ARTEFACTO)
REFERENCES [dbo].ARTEFACTO (ID_ARTEFACTO)
GO
ALTER TABLE [dbo].ARTEFACTO_EMPLEADO  WITH CHECK ADD  CONSTRAINT FK_ARTEFACT_RELATIONS_EMPLEADO FOREIGN KEY(ID_EMPLEADO)
REFERENCES [dbo].EMPLEADO (ID_EMPLEADO)
GO

ALTER TABLE [dbo].CAPACITACION  WITH CHECK ADD  CONSTRAINT FK_CAPACITA_RELATIONS_MEDIDA_D FOREIGN KEY(ID_MEDIDA_SEGURIDAD)
REFERENCES [dbo].MEDIDA_DE_SEGURIDAD (ID_MEDIDA_SEGURIDAD)
GO

ALTER TABLE [dbo].CAPACITACION_EMPLEADO  WITH CHECK ADD  CONSTRAINT FK_CAPACITA_RELATIONS_EMPLEADO FOREIGN KEY(ID_EMPLEADO)
REFERENCES [dbo].EMPLEADO (ID_EMPLEADO)
GO
ALTER TABLE [dbo].CAPACITACION_EMPLEADO  WITH CHECK ADD  CONSTRAINT FK_CAPACITA_RELATIONS_CAPACITA FOREIGN KEY(ID_CAPACITACION)
REFERENCES [dbo].CAPACITACION (ID_CAPACITACION)
GO

ALTER TABLE [dbo].COSTO  WITH CHECK ADD  CONSTRAINT FK_COSTO_RELATIONS_ACCIDENT FOREIGN KEY(ID_ACCIDENTE)
REFERENCES [dbo].ACCIDENTE (ID_ACCIDENTE)
GO

ALTER TABLE [dbo].DETALLE_ARTEFACTO  WITH CHECK ADD  CONSTRAINT FK_DETALLE__RELATIONS_ARTEFACT FOREIGN KEY(ID_ARTEFACTO)
REFERENCES [dbo].ARTEFACTO (ID_ARTEFACTO)
GO

ALTER TABLE [dbo].ESTRUCTURA_PERSONAL  WITH CHECK ADD  CONSTRAINT FK_ESTRUCTU_RELATIONS_EMPLEAD1 FOREIGN KEY(ID_EMPLEADO)
REFERENCES [dbo].EMPLEADO (ID_EMPLEADO)
GO
ALTER TABLE [dbo].ESTRUCTURA_PERSONAL  WITH CHECK ADD  CONSTRAINT FK_ESTRUCTU_RELATIONS_EMPLEAD2 FOREIGN KEY(EMP_ID_EMPLEADO)
REFERENCES [dbo].EMPLEADO (ID_EMPLEADO)
GO

ALTER TABLE [dbo].HISTORICO_ACCIDENTE  WITH CHECK ADD  CONSTRAINT FK_HISTORIC_RELATIONS_ACCIDENT FOREIGN KEY(ID_ACCIDENTE)
REFERENCES [dbo].ACCIDENTE (ID_ACCIDENTE)
GO

ALTER TABLE [dbo].HISTORICO_ARTEFACTO  WITH CHECK ADD  CONSTRAINT FK_HISTORIC_RELATIONS_MEDIDA_D FOREIGN KEY(ID_MEDIDA_SEGURIDAD)
REFERENCES [dbo].MEDIDA_DE_SEGURIDAD (ID_MEDIDA_SEGURIDAD)
GO
ALTER TABLE [dbo].HISTORICO_ARTEFACTO  WITH CHECK ADD  CONSTRAINT FK_HISTORIC_RELATIONS_ARTEFACT FOREIGN KEY(ID_ARTEFACTO)
REFERENCES [dbo].ARTEFACTO (ID_ARTEFACTO)
GO

ALTER TABLE [dbo].HISTORICO_BAJAS  WITH CHECK ADD  CONSTRAINT FK_HISTORIC_RELATIONS_EMPLEADO FOREIGN KEY(ID_EMPLEADO)
REFERENCES [dbo].EMPLEADO (ID_EMPLEADO)
GO

ALTER TABLE [dbo].LOGIN  WITH CHECK ADD  CONSTRAINT FK_LOGIN_RELATIONS_EMPLEADO FOREIGN KEY(ID_EMPLEADO)
REFERENCES [dbo].EMPLEADO (ID_EMPLEADO)
GO

ALTER TABLE [dbo].MANTENIMIENTO  WITH CHECK ADD  CONSTRAINT FK_MANTENIM_RELATIONS_ARTEFACT FOREIGN KEY(ID_ARTEFACTO)
REFERENCES [dbo].ARTEFACTO (ID_ARTEFACTO)
GO




/******************************************************************************
**  Name: GetDatabaseRowVersion
**  Desc: Used by DW ETL Process
**
**  Called by: SQL Job
**  Author: Sergio Danny Flores Montero
**
**  Created: 18/05/2018
*******************************************************************************
**                            Change History
*******************************************************************************
**  Date:       Author:         Description:
**  --------    --------        -----------------------------------------------
**  10/02/2019  Sergio Flores  Initial Version
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
**  Author: Sergio Danny Flores Montero	
**
**  Created: 10/02/2019
*******************************************************************************
**                            Change History
*******************************************************************************
**  Date:       Author:         Description:
**  --------    --------        -----------------------------------------------
**  10/02/2019 Sergio Flores  Initial Version
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
**  Name: GetEmpleadoChangesByRowVersion
**  
**
**  Author: Sergio Danny Flores Montero
**
**  Created: 10/002/2019
*******************************************************************************
**                            Change History
*******************************************************************************
**  Date:       Author:         Description:
**  --------    --------        --------------------------------------------------
**  10/002/2019  sergio Danny    Initial Version
******************************************************************************/
CREATE PROCEDURE [ETL].[GetEmpleadoChangesByRowVersion]
(
  @LastRowVersionID BIGINT,
  @CurrentDBTS      BIGINT
)
AS
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	SELECT [ID_EMPLEADO]
		   ,[CARGO]
		  ,[TITULO]
		  ,[ESTADO]
	FROM [dbo].[EMPLEADO]
	WHERE [Rowversion] > CONVERT(ROWVERSION, @LastRowVersionID)
	AND [Rowversion] <= CONVERT(ROWVERSION, @CurrentDBTS);
GO




