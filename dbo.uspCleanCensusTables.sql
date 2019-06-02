IF EXISTS(SELECT 1 FROM sysobjects WHERE id = object_id(N'[dbo].[uspCleanCensusTables]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1 )
BEGIN
    DROP PROCEDURE [dbo].[uspCleanCensusTables]
END

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*======================================================================================
** File			:	[dbo].[uspCleanCensusTables]    
** Execution	:
					EXEC [dbo].[uspCleanCensusTables]
					@AsOfDate = '2019-06-02'
** ------------------------------------------------------------------------------------
** Change History
** ------------------------------------------------------------------------------------
** Date			Author		Description 
** ----------	----------	-----------------------------------------------------------
** 02/06/2019   Avi			Clean census tables based on as of date.
======================================================================================*/

CREATE PROCEDURE [dbo].[uspCleanCensusTables]
(
    @AsOfDate	DATETIME
)
AS
BEGIN
    SET NOCOUNT ON;

	IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'Continent')
	BEGIN
		CREATE TABLE [dbo].[Continent] (
			[Id] bigint,
			[Name] varchar(13),
			[AsOfDate] datetime,
			[RunId] int
		)
	END

	IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'Country')
	BEGIN
		CREATE TABLE [dbo].[Country] (
			[Id] bigint,
			[Name] varchar(13),
			[ContinentId] bigint,
			[AsOfDate] datetime,
			[RunId] int
		)
	END

	IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'State')
	BEGIN
		CREATE TABLE [dbo].[State] (
			[Id] bigint,
			[Name] varchar(13),
			[ContinentId] bigint,
			[CountryId] bigint,
			[AsOfDate] datetime,
			[RunId] int
		)
	END

	DELETE FROM [dbo].[Continent]
	WHERE AsOfDate = @AsOfDate

	DELETE FROM [dbo].[Country]
	WHERE AsOfDate = @AsOfDate

	DELETE FROM [dbo].[State]
	WHERE AsOfDate = @AsOfDate
END;
GO