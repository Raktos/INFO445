DECLARE @output int
DECLARE @depDate date
EXEC dbo.uspInsertFlight @Airline = 'Korean Air', @FlightDepartureCity = 'Seattle', @FlightDepartureRegion = 'Washington', @FlightDepartureCountry = 'United States', @FlightArrivalCity = 'New York', @FlightArrivalRegion = 'New York', @FlightArrivalCountry = 'United States', @FligthDepartureDate = '2005-12-15', @FlightArrivalDate = '2005-12-16', @FlightNumber = 343, @FlightID = @output OUTPUT
SELECT @output