USE AtlasTravel_FINAL;
GO

CREATE PROCEDURE uspinsertFlight
	@Airline varchar(255),
	@FlightDepartureCity varchar(255),
	@FlightDepartureRegion varchar(255),
	@FlightDepartureCountry varchar(255),
	@FlightArrivalCity varchar(255),
	@FlightArrivalRegion varchar(255),
	@FlightArrivalCountry varchar(255),
	@FlightDepartureDate DATE,
	@FlightArrivalDate DATE,
	@FlightNumber varchar(255),
	@FlightID int OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @AirlineFind INT;
	DECLARE @FlightDepartureCityFind INT;
	DECLARE @FlightArrivalCityFind INT;

	SET @AirlineFind = (SELECT AirlineID 
						FROM AIRLINE
						WHERE AirlineName = @Airline);
	IF @AirlineFind IS NULL
	BEGIN
		EXEC dbo.uspInsertAirline @AirlineName = @Airline, @AirlineID = @AirlineFind OUTPUT;
	END

	SET @FlightDepartureCityFind = (SELECT CityID 
						FROM CITY c
						JOIN REGION r
							ON r.RegionID = c.RegionID
						JOIN COUNTRY cu
							ON cu.CountryID = r.CountryID
						WHERE c.CityName = @FlightDepartureCity
						AND r.RegionName = @FlightDepartureRegion
						AND cu.CountryName = @FlightDepartureCountry);
	IF @FlightDepartureCityFind IS NULL
	BEGIN
		EXEC dbo.uspInsertCity @City = @FlightDepartureCity, @Region = @FlightDepartureRegion, @Country = @FlightDepartureCountry, @CityID = @FlightDepartureCityFind OUTPUT
	END

	SET @FlightArrivalCityFind = (SELECT CityID 
						FROM CITY c
						JOIN REGION r
							ON r.RegionID = c.RegionID
						JOIN COUNTRY cu
							ON cu.CountryID = r.CountryID
						WHERE c.CityName = @FlightArrivalCity
						AND r.RegionName = @FlightArrivalRegion
						AND cu.CountryName = @FlightArrivalCountry);
	IF @FlightArrivalCityFind IS NULL
	BEGIN
		EXEC dbo.uspInsertCity @City = @FlightArrivalCity, @Region = @FlightArrivalRegion, @Country = @FlightArrivalCountry, @CityID = @FlightArrivalCityFind OUTPUT
	END

	BEGIN TRAN T2
		INSERT INTO FLIGHT
		VALUES(@AirlineFind, @FlightDepartureCityFind,
		 @FlightArrivalCityFind, @FlightDepartureDate, 
		 @FlightArrivalDate, @FlightNumber);
		SET @FlightID = SCOPE_IDENTITY()
    COMMIT TRAN T2
END
GO


