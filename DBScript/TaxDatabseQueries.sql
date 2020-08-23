--Create Database TaxDatabase
IF NOT EXISTS(SELECT * FROM sys.databases WHERE name = 'TaxDatabase')
BEGIN
	CREATE DATABASE [TaxDatabase]
END
GO

USE [TaxDatabase]
GO
IF  NOT EXISTS (SELECT * FROM sys.objects 
WHERE object_id = OBJECT_ID(N'[dbo].[MunicipalityTax]') AND type in (N'U'))
BEGIN
Create Table MunicipalityDetails
(
	MunicipalityId Int Identity(1,1) Primary Key,
	MunicipalityName Varchar(100) Not Null
)
END
GO
--You need to check if the table exists
IF  NOT EXISTS (SELECT * FROM sys.objects 
WHERE object_id = OBJECT_ID(N'[dbo].[MunicipalityTax]') AND type in (N'U'))
BEGIN
CREATE TABLE dbo.MunicipalityTax  (
	ScheduledTaxId Int Identity(1,1) Primary Key,
	MunicipalityId Int,
	MunicipalityName Varchar(50),
	TaxType Varchar(50),
	TaxStartDate DateTime,
	TaxEndDate DateTime,
	TaxAmount float
)
END

---------------------------------------------------------------------------------------
------------------------------Create DB Entries in DB----------------------------------

Insert Into dbo.MunicipalityTax
Values ( 1, 'Copenhegan', 'Yearly', '2016.01.01', '2016.12.31', 0.2),
( 1, 'Copenhegan', 'Monthly', '2016.05.01', '2016.05.31', 0.4),
( 1, 'Copenhegan', 'Weekly', null, null, 0.0),
( 1, 'Copenhegan', 'Daily', '2016.01.01', null, 0.1),
( 1, 'Copenhegan', 'Daily', '2016.12.25', null, 0.1),
( 2, 'Ballerup', 'Weekly', '2016.03.01', '2016.03.31', 0.6),
( 2, 'Ballerup', 'Daily', '2016.04.01', null, 0.6),
( 2, 'Ballerup', 'Daily', '2016.05.01', null, 0.7),
( 2, 'Ballerup', 'Weekly', '2016.07.01', '2016.07.31', 0.65),
( 3, 'Dennis', 'Yearly', '2016.01.01', '2016.12.31', 0.65)

Select * from dbo.MunicipalityTax

---------------------------------------------------------------------------------------
-----------------------Query to Get Data based on Name and Input Date----------------------------------

Declare @InputDate DATETIME = '2016-05-01';
SELECT * from dbo.MunicipalityTax where  MunicipalityName = 'Copenhegan'
and @InputDate BETWEEN TaxStartDate AND TaxEndDate

---------------------------------------------------------------------------------------
-----------------------Stored PROC to get Municipality Date based on InputDate & Name-----------


IF EXISTS ( SELECT * FROM   sysobjects WHERE  id = object_id(N'[dbo].[GetMunicipalityTax]') 
            and OBJECTPROPERTY(id, N'IsProcedure') = 1 )
BEGIN
    DROP PROCEDURE [dbo].[GetMunicipalityTax]
END
GO

CREATE PROCEDURE dbo.GetMunicipalityTax 
	@MunicipalityName nvarchar(30),
	@InputDate DateTime
AS
BEGIN
	SELECT ScheduledTaxId, MunicipalityId, 
	MunicipalityName, TaxType, TaxAmount 
	from dbo.MunicipalityTax where  MunicipalityName = @MunicipalityName
	and @InputDate BETWEEN TaxStartDate AND TaxEndDate
END
GO

Exec dbo.GetMunicipalityTax 'Copenhegan', '2016-05-01'


