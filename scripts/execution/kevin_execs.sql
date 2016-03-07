DECLARE @returnVal int
DECLARE @newCity varchar(50)

SET @newCity = 'Glacier'

SELECT * FROM CITY WHERE CityName = @newCity

EXEC @returnVal = dbo.uspInsertTripActivity 
    @TripName = 'Trip 85',
	@ActivityTypeName = 'Hike',
	@ActivityCategoryName = 'Physical',
	@CityName  = @newCity,
	@RegionName = 'Montana',
	@CountryName = 'United States',
	@ActivityName = 'National Park Hike',
	@ActivityDesc = 'Hiking through Glacier National Park',
	@ActivityStreetAddress = ' 545 Going-To-The-Sun Rd',
	@ActivityStartDate = '2016-03-07',
	@ActivityEndDate = '2008-03-07',
	@ActivityCost = 15

SELECT @returnVal

SELECT TOP 1 * FROM TRIP_ACTIVITY ORDER BY TripActivityID DESC

EXEC dbo.uspInsertGroupStudent = 
	@StudentFName = 'Kevin',
	@StudentLName = 'Horwitz',
	@GroupName = 'INFO 445' 

SELECT * FROM TRIPGROUP WHERE GroupID = 1