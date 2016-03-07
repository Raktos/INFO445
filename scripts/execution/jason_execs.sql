DECLARE @output int
DECLARE @depDate date
EXEC dbo.uspInsertFlight @Airline = 'Korean Air', @FlightDepartureCity = 'Seattle', @FlightDepartureRegion = 'Washington', @FlightDepartureCountry = 'United States', @FlightArrivalCity = 'New York', @FlightArrivalRegion = 'New York', @FlightArrivalCountry = 'United States', @FligthDepartureDate = '2005-12-15', @FlightArrivalDate = '2005-12-16', @FlightNumber = 343, @FlightID = @output OUTPUT
SELECT @output

EXEC dbo.uspInsertTripTransit @TripName = 'Trip 445',
	@TransitType = 'Bus',
	@TransitCompany = 'transit company asdf',
	@PickupCity  = 'Seattle',
	@PickupRegion = 'Washington',
	@PickupCountry = 'United States',
	@TripTransitPickupDate = '2008-01-15',
	@DropoffCity = 'New York',
	@DropoffRegion = 'New York',
	@DropoffCountry = 'United States',
	@TripTransitDropoffDate = '2008-01-17',
	@TripTransitPickupStreetAddress = 'asdgfdhtfdghfdghty',
	@TripTransitDropoffStreetAddress = 'f3654ehtrdhtrdhtr',
	@TripTransitCost = 50.00