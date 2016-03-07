ALTER PROCEDURE uspPopulateFlight
  @NumInserts int
AS
WHILE @NumInserts > 0
BEGIN
  DECLARE @Airline VARCHAR(255)
  DECLARE @DepCityID INT
  DECLARE @DepCityName VARCHAR(255)
  DECLARE @DepRegionID INT
  DECLARE @DepRegionName VARCHAR(255)
  DECLARE @DepCountryID INT
  DECLARE @DepCountryName VARCHAR(255)
  DECLARE @ArrCityID INT
  DECLARE @ArrCityName VARCHAR(255)
  DECLARE @ArrRegionID INT
  DECLARE @ArrRegionName VARCHAR(255)
  DECLARE @ArrCountryID INT
  DECLARE @ArrCountryName VARCHAR(255)
  DECLARE @Number VARCHAR(255)
  DECLARE @DepDate DATE
  DECLARE @ArrDate DATE
  DECLARE @Out INT
  
  SET @Airline = (SELECT TOP 1 AirlineName FROM AIRLINE ORDER BY NEWID())
  SET @DepCityID = (SELECT TOP 1 CityID FROM CITY ORDER BY NEWID())
  SET @DepCityName = (SELECT TOP 1 CityName FROM CITY WHERE CityID = @DepCityID)
  SET @DepRegionID = (SELECT TOP 1 RegionID FROM CITY WHERE CityID = @DepCityID)
  SET @DepRegionName = (SELECT TOP 1 RegionName FROM REGION WHERE RegionID = @DepRegionID)
  SET @DepCountryID = (SELECT TOP 1 CountryID FROM REGION WHERE RegionID = @DepRegionID)
  SET @DepCountryName = (SELECT TOP 1 CountryName FROM COUNTRY WHERE CountryID = @DepCountryID)
  SET @ArrCityID = (SELECT TOP 1 CityID FROM CITY ORDER BY NEWID())
  SET @ArrCityName = (SELECT TOP 1 CityName FROM CITY WHERE CityID = @ArrCityID)
  SET @ArrRegionID = (SELECT TOP 1 RegionID FROM CITY WHERE CityID = @ArrCityID)
  SET @ArrRegionName = (SELECT TOP 1 RegionName FROM REGION WHERE RegionID = @ArrRegionID)
  SET @ArrCountryID = (SELECT TOP 1 CountryID FROM REGION WHERE RegionID = @ArrRegionID)
  SET @ArrCountryName = (SELECT TOP 1 CountryName FROM COUNTRY WHERE CountryID = @ArrCountryID)
  SET @Number = CAST(CAST(ROUND((RAND() * 8999) + 1000, 0) AS INT) AS VARCHAR)
  SET @DepDate = DATEADD(DAY, ABS(CHECKSUM(NEWID()) % 365), '2015-01-01')
  SET @ArrDate = DATEADD(DAY, ABS(CHECKSUM(NEWID()) % 1), @DepDate)

  
  EXEC dbo.uspInsertFlight
    @Airline = @Airline,
    @FlightDepartureCity = @DepCityName,
    @FlightDepartureRegion = @DepRegionName,
    @FlightDepartureCountry = @DepCountryName,
    @FlightArrivalCity = @ArrCityName,
    @FlightArrivalRegion = @ArrRegionName,
    @FlightArrivalCountry = @ArrCountryName,
    @FlightDepartureDate = @DepDate,
    @FlightArrivalDate = @ArrDate,
    @FlightNumber = @Number,
    @FlightID = @Out OUTPUT
  
  SET @NumInserts = @NumInserts - 1
END
GO