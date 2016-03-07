DECLARE @returnVal int
DECLARE @newCity varchar(50)

SET @newCity = 'Glacier'

SELECT * FROM CITY WHERE CityName = @newCity

EXEC @returnVal = dbo.uspInsertTripActivity 
    @TripName = 'Trip 4',
	@ActivityTypeName = 'Hike',
	@ActivityCategoryName = 'Physical',
	@CityName  = @newCity,
	@RegionName = 'Montana',
	@CountryName = 'United States',
	@ActivityName = 'Glacier National Park Hike',
	@ActivityDesc = 'Going into the national park for a day, hiking for 6 hours',
	@ActivityStreetAddress = ' 545 Going-To-The-Sun Rd',
	@ActivityStartDate = '2016-03-07',
	@ActivityEndDate = '2008-03-07',
	@ActivityCost = 15

SELECT @returnVal