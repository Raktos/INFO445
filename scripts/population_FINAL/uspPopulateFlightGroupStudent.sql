ALTER PROCEDURE [dbo].[uspPopulateFlightGroupStudent] 
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
			SET @randFlightID = (SELECT TOP 1 FlightID FROM FLIGHT ORDER BY NEWID());
			SET @randGroupStudentID = (SELECT TOP 1 GroupStudentID FROM GROUP_STUDENT ORDER BY NEWID());
			
			INSERT INTO FLIGHT_GROUP_STUDENT (FlightID, GroupStudentID)
			VALUES (@randFlightID, @randGroupStudentID);

			SET @index = @index + 1;
		END

	COMMIT TRAN t1
END
GO