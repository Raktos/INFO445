USE AtlasTravel_FINAL;
GO

CREATE PROCEDURE [dbo].[insertFlight]
	@Airline varchar(255),
	@FlightDepartureCity varchar(255),
	@FlightDepartureRegion varchar(255),
	@FlightDepartureCountry varchar(255),
	@FlightArrivalCity varchar(255),
	@FlightArrivalRegion varchar(255),
	@FlightArrivalCountry varchar(255),
	@FligthDepartureDate DATE,
	@FlightArrivalDate DATE,
	@FlightNumber varchar(255)
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
		EXEC dbo.uspInsertAirline @AirlineName = @AirlineFind;
	END

	SET @FlightDepartureCityFind = (SELECT CityID 
						FROM CITY c
						JOIN REGION r
							ON r.RegionID = c.CityID
						JOIN COUNTRY cu
							ON cu.CountryID - r.RegionID
						WHERE c.CityName = @FlightDepartureCity
						AND r.RegionName = @FlightDepartureRegion
						AND cu.CountryID = @FlightDepartureCountry);
	IF @FlightDepartureCityFind IS NULL
	BEGIN
		EXEC dbo.uspInsertCity @City = @FlightDepartureCity, @Region = @FlightDepartureRegion, @Country = @FlightDepartureCountry;
	END

	SET @FlightArrivalCityFind = (SELECT CityID 
						FROM CITY c
						JOIN REGION r
							ON r.RegionID = c.CityID
						JOIN COUNTRY cu
							ON cu.CountryID - r.RegionID
						WHERE c.CityName = @FlightArrivalCity
						AND r.RegionName = @FlightArrivalRegion
						AND cu.CountryID = @FlightArivalCountry);
	IF @FlightArrivalCityFind IS NULL
	BEGIN
		EXEC dbo.uspInsertCity @City = @FlightArrivalCity, @Region = @FlightArrivalRegion, @Country = @FlightArrivalCountry;
	END

	BEGIN TRAN T2
		INSERT INTO FLIGHT
		VALUES(@AirlineFind, @FlightDepartureCityFind,
		 @FlightArrivalCityFind, @FligthDepartureDate, 
		 @FlightArrivalDate, @FlightNumber);
    COMMIT TRAN T2
END
GO


