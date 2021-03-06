/******************************************************************************
**  Name: Schema DW
**  Desc: Create Dw Schema
**  Called By SQL Job ETL
**
**  Author: Yamil Medina
			Sergio Flores 
			Pamela Arnex
**
**  Created: 17/02/2018
*******************************************************************************
**                            Change History
*******************************************************************************
**  Date:       Author:          Description:
**  --------    --------------   ---------------------------------------------------
** 17/02/2018                  Initial Version
******************************************************************************/
USE [DWgestion_seguridad];
GO

CREATE SCHEMA [ETL];
GO

CREATE TABLE [dbo].[DimEmpleado](
	[id_empleado] [int] NOT NULL,
	[nombres] [varchar](100) NOT NULL,
	[cargo] [varchar](100) NOT NULL,
	[fecha_contratacion] [datetime] NOT NULL,
	[telefono] [varchar](100) NOT NULL,
 CONSTRAINT [PK_DimEmpleado] PRIMARY KEY CLUSTERED 
(
	[id_empleado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[DimArtefacto](
	[id_detalle_artefacto] [int] NOT NULL,
	[nombre] [varchar](50) NOT NULL,
	[tipo] [varchar](50) NOT NULL,
	[estado] [char](1) NOT NULL,
	[antiguedad] [varchar](100) NOT NULL,
	[ultimo_mantenimiento] [datetime] NOT NULL,
 CONSTRAINT [PK_DimArtefacto] PRIMARY KEY CLUSTERED 
(
	[id_detalle_artefacto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[DimLugar](
	[id_seccion] [int] NOT NULL,
	[lugar] [varchar](150) NOT NULL,
	[seccion] [varchar](50) NOT NULL,
	[obra] [varchar](50) NOT NULL,
 CONSTRAINT [PK_DimLugar] PRIMARY KEY CLUSTERED 
(
	[id_seccion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[FactAccidente](
	[id_empleado] [int] NOT NULL,
	[id_seccion] [int] NOT NULL,
	[id_detalle_artefacto] [int] NOT NULL,
	[detalle] [varchar](500) NOT NULL,
	[fecha] [datetime] NOT NULL,
	[tipo_accidente] [varchar](50) NOT NULL,
 CONSTRAINT [PK_FactAccidente] PRIMARY KEY CLUSTERED 
(
	[id_empleado] ASC,
	[id_seccion] ASC,
	[id_detalle_artefacto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [ETL].[Empleado](
	[id_empleado] [int] NOT NULL,
	[nombres] [varchar](100) NOT NULL,
	[cargo] [varchar](100) NOT NULL,
	[fecha_contratacion] [datetime] NULL,
	[telefono] [varchar](100) NULL
) ON [PRIMARY]
GO

CREATE TABLE [ETL].[Artefacto](
	[id_detalle_artefacto] [int] NOT NULL,
	[nombre] [varchar](50) NOT NULL,
	[tipo] [varchar](50) NULL,
	[estado] [char](1) NOT NULL,
	[antiguedad] [varchar](100) NULL,
	[ultimo_mantenimiento] [datetime] NULL
) ON [PRIMARY]
GO

CREATE TABLE [ETL].[Lugar](
	[id_seccion] [int] NOT NULL,
	[lugar] [varchar](150) NOT NULL,
	[seccion] [varchar](50) NOT NULL,
	[obra] [varchar](50) NOT NULL
) ON [PRIMARY]
GO

CREATE TABLE [ETL].[Accidente](
	[id_empleado] [int] NOT NULL,
	[id_seccion] [int] NOT NULL,
	[id_detalle_artefacto] [int] NOT NULL,
	[detalle] [varchar](500) NOT NULL,
	[fecha] [datetime] NOT NULL,
	[tipo_accidente] [varchar](50) NULL
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[FactAccidente]  WITH CHECK ADD  CONSTRAINT [FK_DimEmpleado] FOREIGN KEY([id_empleado])
REFERENCES [dbo].[DimEmpleado] ([id_empleado])
GO
ALTER TABLE [dbo].[FactAccidente] CHECK CONSTRAINT [FK_DimEmpleado]
GO
ALTER TABLE [dbo].[FactAccidente]  WITH CHECK ADD  CONSTRAINT [FK_DimArtefacto] FOREIGN KEY([id_detalle_artefacto])
REFERENCES [dbo].[DimArtefacto] ([id_detalle_artefacto])
GO
ALTER TABLE [dbo].[FactAccidente] CHECK CONSTRAINT [FK_DimArtefacto]
GO
ALTER TABLE [dbo].[FactAccidente]  WITH CHECK ADD  CONSTRAINT [FK_DimLugar] FOREIGN KEY([id_seccion])
REFERENCES [dbo].[DimLugar] ([id_seccion])
GO
ALTER TABLE [dbo].[FactAccidente] CHECK CONSTRAINT [FK_DimLugar]
GO

/******************************************************************************
**  Name: ETL.DW_MergeDepartments
**  Desc: Merges Source ETL.Departments changes into Destination dbo.DimDepartments table. 
**  Called By SQL Job ETL
**
**  Author: Sergio Flores
**
**  Created: 17/02/2018
*******************************************************************************
**                            Change History
*******************************************************************************
**  Date:       Author:          Description:
**  --------    --------------   ---------------------------------------------------
** 17/02/2018  Sergio Flores   Initial Version
******************************************************************************/
CREATE PROCEDURE [ETL].[DW_MergeEmpleado]
AS
SET NOCOUNT ON;
SET XACT_ABORT ON;
BEGIN
	MERGE [dbo].[DimEmpleado] AS target
	USING [ETL].[Empleado] AS source
	ON
	(
	  target.[id_empleado] = source.[id_empleado]
	)
	WHEN MATCHED
	THEN UPDATE 
		 SET [nombres]   = source.[nombres]
			,[cargo] = source.[cargo]
			,[fecha_contratacion] = source.[fecha_contratacion]
			,[telefono]      = source.[telefono]
	WHEN NOT MATCHED
	THEN 
	  INSERT
	  (
		 [id_empleado]
		,[nombres]
		,[cargo]
		,[fecha_contratacion]
		,[telefono]
	  )
	  VALUES
	  (
		source.[id_empleado]
		,source.[nombres]
		,source.[cargo]
		,source.[fecha_contratacion]
		,source.[telefono]
	  );
END
GO

/******************************************************************************
**  Name: ETL.DW_MergeDepartments
**  Desc: Merges Source ETL.Departments changes into Destination dbo.DimDepartments table. 
**  Called By SQL Job ETL
**
**  Author: Yamil Medina
**
**  Created: 18/05/2018
*******************************************************************************
**                            Change History
*******************************************************************************
**  Date:       Author:          Description:
**  --------    --------------   ---------------------------------------------------
** 18/05/2018   Yamil Medina  Initial Version
******************************************************************************/
CREATE PROCEDURE [ETL].[DW_MergeArtefacto]
AS
SET NOCOUNT ON;
SET XACT_ABORT ON;
BEGIN
	MERGE [dbo].[DimArtefacto] AS target
	USING [ETL].[Artefacto] AS source
	ON
	(
	  target.[id_detalle_artefacto] = source.[id_detalle_artefacto]
	)
	WHEN MATCHED
	THEN UPDATE 
		 SET [nombre] = source.[nombre]
			,[tipo] = source.[tipo]
			,[estado] = source.[estado]
			,[antiguedad] = source.[antiguedad]
			,[ultimo_mantenimiento] = source.[ultimo_mantenimiento]
	WHEN NOT MATCHED
	THEN 
	  INSERT
	  (
		[id_detalle_artefacto]
		,[nombre]
		,[tipo]
		,[estado]
		,[antiguedad]
		,[ultimo_mantenimiento]
	  )
	  VALUES
	  (
		source.[id_detalle_artefacto]
		,source.[nombre]
		,source.[tipo]
		,source.[estado]
		,source.[antiguedad]
		,source.[ultimo_mantenimiento]
	  );
END
GO

/******************************************************************************
**  Name: ETL.DW_MergeGrade
**  Desc: Merges Source ETL.FactGrades changes into Destination dbo.FactGrades table. 
**  Called By SQL Job ETL
**
**  Author: Pamela Arnez
**
**  Created: 17/02/2019
*******************************************************************************
**                            Change History
*******************************************************************************
**  Date:       Author:          Description:
**  --------    --------------   ---------------------------------------------------
**  17/02/2019   Pamela Arnez   Initial Version
******************************************************************************/
CREATE PROCEDURE [ETL].[DW_MergeAccidente]
AS
SET NOCOUNT ON;
SET XACT_ABORT ON;
BEGIN
	MERGE [dbo].[FactAccidente] AS target
	USING [ETL].[Accidente] AS source
	ON
	(
	  target.[id_empleado]     = source.[id_empleado]
	  AND target.[id_seccion]     = source.[id_seccion]
	  AND target.[id_detalle_artefacto] = source.[id_detalle_artefacto]
	)
	WHEN MATCHED
	THEN UPDATE 
		 SET [detalle]    = source.[detalle],
		     [fecha] = source.[fecha],
			 [tipo_accidente] = source.[tipo_accidente]
	WHEN NOT MATCHED
	THEN 
	  INSERT
	  (
		[id_empleado]
		,[id_seccion]
		,[id_detalle_artefacto]
		,[detalle]
		,[fecha]
		,[tipo_accidente]
	  )
	  VALUES
	  (
		source.[id_empleado]
		,source.[id_seccion]
		,source.[id_detalle_artefacto]
		,source.[detalle]
		,source.[fecha]
		,source.[tipo_accidente]
	  );
END
GO

/******************************************************************************
**  Name: ETL.DW_MergeInstructor
**  Desc: Merges Source ETL.DeInstructor changes into Destination dbo.DimInstructor table. 
**  Called By SQL Job ETL
**
**  Author: Sergio Flores
**
**  Created:  17/02/2019
*******************************************************************************
**                            Change History
*******************************************************************************
**  Date:       Author:          Description:
**  --------    --------------   ---------------------------------------------------
**  17/02/2019   Sergio Flores   Initial Version
******************************************************************************/
CREATE PROCEDURE [ETL].[DW_MergeLugar]
AS
SET NOCOUNT ON;
SET XACT_ABORT ON;
BEGIN
	MERGE [dbo].[DimLugar] AS target
	USING [ETL].[Lugar] AS source
	ON
	(
	  target.[id_seccion] = source.[id_seccion]
	)
	WHEN MATCHED
	THEN UPDATE 
		 SET [lugar] = source.[lugar]
			,[seccion] = source.[seccion]
			,[obra]  = source.[obra]
	WHEN NOT MATCHED
	THEN 
	  INSERT
	  (
		[id_seccion]
		,[lugar]
		,[seccion]
		,[obra]
	  )
	  VALUES
	  (
		source.[id_seccion]
		,source.[lugar]
		,source.[seccion]
		,source.[obra]
	  );
END
GO
