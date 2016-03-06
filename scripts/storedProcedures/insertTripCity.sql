CREATE PROCEDURE uspInsertTripCity
	@counter INT
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRAN T1

		DECLARE @TripCityID INT;
		DECLARE @TripID INT;
		DECLARE @CityID INT;
		DECLARE @TripCityArrivalDate DATE;
		DECLARE @TripCityDepartureDate DATE;
		DECLARE @Dig1 VARCHAR(20);
		DECLARE @rand NUMERIC (16, 16);

		WHILE @counter > 0
		BEGIN
			
			SELECT @TripCityID = ISNULL(MAX(TripCityID), 0) + 1
			FROM dbo.TRIP_CITY

			SELECT @TripID = (SELECT TOP 1 TripID FROM TRIP ORDER BY newid());

			SELECT @CityID = (SELECT TOP 1 CityID from CITY ORDER BY newid());

			SELECT @rand = RAND();
			SET @Dig1 = @rand;
			SET @TripCityArrivalDate = (SELECT DATEADD(DAY, ABS(CHECKSUM(NEWID()) % 45), '2008-01-01'));

			SELECT @rand = RAND();
			SET @Dig1 = @rand;
			SET @TripCityDepartureDate = (SELECT DATEADD(DAY, ABS(CHECKSUM(NEWID()) % 85), '2008-05-01'));

			INSERT INTO dbo.TRIP_CITY (TripCityID, TripID, CityID, TripCityArrivalDate, TripCityDepartureDate)
			VALUES (@TripCityID, @TripID, @CityID, @TripCityArrivalDate, @TripCityDepartureDate)

			SET @counter = @counter - 1;
		END

		IF @@error <> 0
			ROLLBACK TRAN t1
		ELSE 
			COMMIT TRAN t1
END