USE [master];
GO
--TODO: Set SQLCMD variables


IF NOT EXISTS ( SELECT * FROM sys.server_principals WHERE name = 'Service' )
  CREATE LOGIN [Service] WITH PASSWORD = 'passwordService', CHECK_POLICY = OFF;

IF NOT EXISTS ( SELECT * FROM sys.server_principals WHERE name = 'Reporting' )
  CREATE LOGIN [Reporting] WITH PASSWORD = 'passwordReporting', CHECK_POLICY = OFF;
