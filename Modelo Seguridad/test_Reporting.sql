
USE GestionSeguridadData
GO

DECLARE @ID int
DECLARE @NAME varchar(50)

EXECUTE @NAME = [dbo].[GetSeccionName] 
   @ID = 231
GO


DECLARE @ID int
DECLARE @NAME varchar(50)

EXECUTE @NAME = [dbo].[GetEmployeName] 
   @ID = 12
GO
