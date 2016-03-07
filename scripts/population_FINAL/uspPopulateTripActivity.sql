ALTER PROCEDURE uspPopulateTripActivity
  @NumInserts INT
AS
DECLARE @ThisTripName VARCHAR(255)
DECLARE @TypeName VARCHAR(255)
DECLARE @CategoryName VARCHAR(255)
DECLARE @CityID INT
DECLARE @CityName VARCHAR(255)
DECLARE @RegionID INT
DECLARE @RegionName VARCHAR(255)
DECLARE @CountryID INT
DECLARE @CountryName VARCHAR(255)
DECLARE @Adverb VARCHAR(255)
DECLARE @Noun VARCHAR(255)
DECLARE @Name VARCHAR(255)
DECLARE @Desc VARCHAR(255)
DECLARE @StreetAddress VARCHAR(255)
DECLARE @StartDate DATE
DECLARE @EndDate DATE
DECLARE @Cost MONEY

WHILE @NumInserts > 0
BEGIN 
  SET @ThisTripName = (SELECT TOP 1 TripName FROM TRIP ORDER BY NEWID())
  SET @TypeName = (SELECT TOP 1 ActivityTypeName FROM ACTIVITY_TYPE ORDER BY NEWID())
  SET @CategoryName = (SELECT TOP 1 ActivityCategoryName FROM ACTIVITY_CATEGORY ORDER BY NEWID())
  SET @CityID = (SELECT TOP 1 CityID FROM CITY ORDER BY NEWID())
  SET @CityName = (SELECT TOP 1 CityName FROM CITY WHERE CityID = @CityID)
  SET @RegionID = (SELECT TOP 1 RegionID FROM CITY WHERE CityID = @CityID)
  SET @RegionName = (SELECT TOP 1 RegionName FROM REGION WHERE RegionID = @RegionID)
  SET @CountryID = (SELECT TOP 1 CountryID FROM REGION WHERE RegionID = @RegionID)
  SET @CountryName = (SELECT TOP 1 CountryName FROM COUNTRY WHERE CountryID = @CountryID)
  SET @Adverb = (SELECT TOP 1 adverb FROM ADVERB ORDER BY NEWID())
  SET @Noun = (SELECT TOP 1 noun FROM NOUN ORDER BY NEWID())
  SET @Name = @Adverb + ' ' + @Noun
  SET @Desc =  @Name + ' is a fun activity on ' + @ThisTripName + '.'
  SET @StreetAddress = CAST(CAST(ROUND((RAND() * 89999) + 10000, 0) AS INT) AS VARCHAR) + @Noun + ' street'
  SET @StartDate = DATEADD(DAY, ABS(CHECKSUM(NEWID()) % 365), '2015-01-01')
  SET @EndDate = DATEADD(DAY, ABS(CHECKSUM(NEWID()) % 2), @StartDate)
  SET @Cost = CONVERT(MONEY, (RAND() * 8999) + 1000, 2)
  
  EXEC dbo.uspInsertTripActivity
    @TripName = @ThisTripName,
    @ActivityTypeName = @TypeName,
    @ActivityCategoryName = @CategoryName,
    @CityName = @CityName,
    @RegionName = @RegionName,
    @CountryName = @CountryName,
    @ActivityName = @Name,
    @ActivityDesc = @Desc,
    @ActivityStreetAddress = @StreetAddress,
    @ActivityStartDate = @StartDate,
    @ActivityEndDate = @EndDate,
    @ActivityCost = @Cost
  
  SET @NumInserts = @NumInserts - 1
END
GO