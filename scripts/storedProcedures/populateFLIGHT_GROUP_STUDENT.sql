USE [AtlasTravel]
GO

/****** Object:  StoredProcedure [dbo].[uspKevinLab2_insertFLIGHT_GROUP_STUDENT]    Script Date: 3/5/2016 10:58:17 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[uspKevinLab2_insertFLIGHT_GROUP_STUDENT] 
	-- Add the parameters for the stored procedure here
	@numRows int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	BEGIN TRAN t1

		DECLARE @randFlightID int;
		DECLARE @randGroupStudentID int;
		DECLARE @index int;

		SET @index = 0;

		WHILE @index < @numRows
		BEGIN
			SET @randFlightID = (SELECT TOP 1 FlightID FROM FLIGHT ORDER BY RAND());
			SET @randGroupStudentID = (SELECT TOP 1 GroupStudentID FROM GROUP_STUDENT ORDER BY RAND());
			
			INSERT INTO FLIGHT_GROUP_STUDENT (FlightID, GroupStudentID)
			VALUES (@randFlightID, @randGroupStudentID);

			SET @index = @index + 1;
		END

	COMMIT TRAN t1
END

GO


