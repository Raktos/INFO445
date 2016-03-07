USE AtlasTravel_FINAL
GO

CREATE PROCEDURE [dbo].[uspinsertRandTRIP_CITY] 
	-- Add the parameters for the stored procedure here
	@numRows int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	BEGIN TRAN t1

		DECLARE @randTripID int;
		DECLARE @randCityID int;
		DECLARE @arrivalDate date;
		DECLARE @departureDate date;
		DECLARE @dateAdd int;
		DECLARE @RAND numeric(16, 16);
		DECLARE @digit varchar(20)

		WHILE @numRows > 0
		BEGIN
			SET @Rand = RAND();
			SET @digit = @Rand
			SET @randTripID = (SELECT  CASE
							WHEN SUBSTRING(@digit, 3, 3) = 000 
								THEN 9
							ELSE CAST(SUBSTRING(@digit, 3, 3) AS INT)
							END);
			SET @randCityID = (SELECT  CASE
							WHEN SUBSTRING(@digit, 6, 2) = 00 
								THEN 100
							ELSE CAST(SUBSTRING(@digit, 6, 2) AS INT)
							END);
			SET @arrivalDate = (SELECT DATEADD(DAY, ABS(CHECKSUM(NEWID()) % 45), '2008-01-01'));
			SET @dateAdd = (SELECT CASE
							WHEN SUBSTRING(@digit, 8, 1) = 0 
								THEN 10
							ELSE CAST(SUBSTRING(@digit, 8, 1) AS INT)
							END);
			SET @departureDate = (SELECT DATEADD(DAY, @dateAdd, @arrivalDate);
			
			INSERT INTO TRIP_CITY(TripID, CityID, TripCityArrivalDate, TripCityDepartureDate)
			VALUES (@randTripID, @randCityID, @arrivalDate, @departureDate);

			SET @numRows = @numRows - 1;
		END

	COMMIT TRAN t1
END

GO