SELECT * FROM TRIP WHERE TripName = 'Trip 445'

EXEC dbo.uspInsertTripTransit @TripName = 'Trip 445',
	@TransitType = 'Bus',
	@TransitCompany = 'transit company asdf',
	@PickupCity  = 'Tacoma',
	@PickupRegion = 'Washington',
	@PickupCountry = 'United States',
	@TripTransitPickupDate = '20016-01-15',
	@DropoffCity = 'New York',
	@DropoffRegion = 'New York',
	@DropoffCountry = 'United States',
	@TripTransitDropoffDate = '20016-01-16',
	@TripTransitPickupStreetAddress = '445 Elm Street',
	@TripTransitDropoffStreetAddress = '8857 Main Street'

