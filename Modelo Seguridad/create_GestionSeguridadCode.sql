USE GestionSeguridadCode;

PRINT 'Creating Users....';

IF NOT EXISTS ( SELECT 1 FROM sys.database_principals WHERE name = 'Service')
	CREATE USER [Service] FOR LOGIN [Service] WITH DEFAULT_SCHEMA = [dbo];

IF NOT EXISTS ( SELECT 1 FROM sys.database_principals WHERE name = 'Reporting')
	CREATE USER [Reporting] FOR LOGIN [Reporting] WITH DEFAULT_SCHEMA = [dbo];

PRINT 'Creating Roles.......';

IF NOT EXISTS ( SELECT 1 FROM sys.database_principals WHERE name = 'MyService' and Type = 'R')
	CREATE ROLE MyService AUTHORIZATION [dbo];

IF NOT EXISTS ( SELECT 1 FROM sys.database_principals WHERE name = 'MyReporting' and Type = 'R')
	CREATE ROLE MyReporting AUTHORIZATION [dbo];

PRINT 'Adding Users to Roles.......';
ALTER ROLE MyService ADD MEMBER [Service];
ALTER ROLE MyReporting ADD MEMBER [Reporting];

PRINT 'Creating Synonyms....';

IF NOT EXISTS ( SELECT 1 FROM sys.synonyms WHERE name = 'PERSONA')
	CREATE SYNONYM [dbo].[PERSONA] FOR [GestionSeguridadData].[dbo].[PERSONA];

IF NOT EXISTS ( SELECT 1 FROM sys.synonyms WHERE name = 'EMPRESA')
	CREATE SYNONYM [dbo].[EMPRESA] FOR [GestionSeguridadData].[dbo].[EMPRESA];

IF NOT EXISTS ( SELECT 1 FROM sys.synonyms WHERE name = 'OBRA')
	CREATE SYNONYM [dbo].[OBRA] FOR [GestionSeguridadData].[dbo].[OBRA];

IF NOT EXISTS ( SELECT 1 FROM sys.synonyms WHERE name = 'SECCION')
	CREATE SYNONYM [dbo].[SECCION] FOR [GestionSeguridadData].[dbo].[SECCION];

IF NOT EXISTS ( SELECT 1 FROM sys.synonyms WHERE name = 'ESTRUCTURA_PERSONAL')
	CREATE SYNONYM [dbo].[ESTRUCTURA_PERSONAL] FOR [GestionSeguridadData].[dbo].[ESTRUCTURA_PERSONAL];

IF NOT EXISTS ( SELECT 1 FROM sys.synonyms WHERE name = 'EMPLEADO')
	CREATE SYNONYM [dbo].[EMPLEADO] FOR [GestionSeguridadData].[dbo].[EMPLEADO];

IF NOT EXISTS ( SELECT 1 FROM sys.synonyms WHERE name = 'ACCIDENTES_EMPLEADO')
	CREATE SYNONYM [dbo].[ACCIDENTES_EMPLEADO] FOR [GestionSeguridadData].[dbo].[ACCIDENTES_EMPLEADO];

IF NOT EXISTS ( SELECT 1 FROM sys.synonyms WHERE name = 'HISTORICO_ACCIDENTE')
	CREATE SYNONYM [dbo].[HISTORICO_ACCIDENTE] FOR [GestionSeguridadData].[dbo].[HISTORICO_ACCIDENTE];

IF NOT EXISTS ( SELECT 1 FROM sys.synonyms WHERE name = 'CAPACITACION_EMPLEADO')
	CREATE SYNONYM [dbo].[CAPACITACION_EMPLEADO] FOR [GestionSeguridadData].[dbo].[CAPACITACION_EMPLEADO];

IF NOT EXISTS ( SELECT 1 FROM sys.synonyms WHERE name = 'HISTORICO_BAJAS')
	CREATE SYNONYM [dbo].[HISTORICO_BAJAS] FOR [GestionSeguridadData].[dbo].[HISTORICO_BAJAS];

IF NOT EXISTS ( SELECT 1 FROM sys.synonyms WHERE name = 'ARTEFACTO')
	CREATE SYNONYM [dbo].[ARTEFACTO] FOR [GestionSeguridadData].[dbo].[ARTEFACTO];

IF NOT EXISTS ( SELECT 1 FROM sys.synonyms WHERE name = 'TIPO_ARTEFACTO')
	CREATE SYNONYM [dbo].[TIPO_ARTEFACTO] FOR [GestionSeguridadData].[dbo].[TIPO_ARTEFACTO];

IF NOT EXISTS ( SELECT 1 FROM sys.synonyms WHERE name = 'CAPACITACION')
	CREATE SYNONYM [dbo].[CAPACITACION] FOR [GestionSeguridadData].[dbo].[CAPACITACION];

IF NOT EXISTS ( SELECT 1 FROM sys.synonyms WHERE name = 'MANTENIMIENTO')
	CREATE SYNONYM [dbo].[MANTENIMIENTO] FOR [GestionSeguridadData].[dbo].[MANTENIMIENTO];