USE AtlasTravel;
GO

CREATE PROCEDURE [dbo].[insertFlights]
	@Airline varchar(255),
	@FlightDepartureCity varchar(255),
	@FlightArrivalCity varchar(255),
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
		EXEC dbo.insertAirline @AirlineName = @AirlineFind;
	END

	SET @FlightDepartureCityFind = (SELECT CityID 
						FROM CITY
						WHERE CityName = @FlightDepartureCity);
	IF @FlightDepartureCityFind IS NULL
	BEGIN
		EXEC dbo.uspInsertCity @City = @FlightDepartureCity, @Region = '', @Country ='';
	END

	SET @FlightArrivalCityFind = (SELECT CityID 
						FROM CITY
						WHERE CityName = @FlightArrivalCity);
	IF @FlightArrivalCityFind IS NULL
	BEGIN
		EXEC dbo.uspInsertCity @City = @FlightArrivalCity, @Region = '', @Country ='';
	END

	BEGIN TRAN T2
		INSERT INTO FLIGHT
		VALUES(@AirlineFind, @FlightDepartureCityFind,
		 @FlightArrivalCityFind, @FligthDepartureDate, 
		 @FlightArrivalDate, @FlightNumber);
    COMMIT TRAN T2
END
GO


