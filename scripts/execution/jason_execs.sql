SELECT * FROM TRIP WHERE TripName = 'Trip 445'

EXEC dbo.uspInsertTripTransit @TripName = 'Trip 445',
	@TransitType = 'Bus',
	@TransitCompany = 'transit company asdf',
	@PickupCity  = 'Bothell',
	@PickupRegion = 'Washington',
	@PickupCountry = 'United States',
	@TripTransitPickupDate = '2016-01-15',
	@DropoffCity = 'San Francisco',
	@DropoffRegion = 'California',
	@DropoffCountry = 'United States',
	@TripTransitDropoffDate = '2016-01-16',
	@TripTransitPickupStreetAddress = '445 Elm Street',
	@TripTransitDropoffStreetAddress = '8857 Main Street',
    @TripTransitCost = 5000.00
