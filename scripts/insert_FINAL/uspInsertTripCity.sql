ALTER PROCEDURE [dbo].[uspInsertTripCity]
	@TripName VARCHAR(255),
	@CityName VARCHAR(255),
	@RegionName VARCHAR(255),
	@CountryName VARCHAR(255),
	@TripCityArrivalDate DATE,
	@TripCityDepartureDate DATE
AS
BEGIN
	BEGIN TRAN T1
		DECLARE @TripFind VARCHAR(255);
		DECLARE @CityFind VARCHAR(255);

		SET @TripFind = (SELECT TripID FROM TRIP WHERE TripName = @TripName)
		IF @TripFind IS NULL
		BEGIN
			RETURN -1
		END

		SET @CityFind = (SELECT CityID FROM CITY c JOIN REGION r on r.RegionID = c.RegionID JOIN COUNTRY cu ON cu.CountryID = r.CountryID WHERE c.CityName = @CityName AND r.RegionName = @RegionName AND cu.CountryName = @CountryName)
		IF @CityFind IS NULL
		BEGIN
			EXEC dbo.uspInsertCity @City = @CityName, @Region = @RegionName, @Country = @CountryName, @CityID = @CityFind OUTPUT
		END
	
		INSERT INTO dbo.TRIP_CITY (TripID, CityID, TripCityArrivalDate, TripCityDepartureDate)
		VALUES (@TripFind, @CityFind, @TripCityArrivalDate, @TripCityDepartureDate)
	COMMIT TRAN t1
END
GO