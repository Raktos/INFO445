ALTER PROCEDURE uspPopulateTripHotel
  @NumInserts int
AS
WHILE @NumInserts > 0
BEGIN
  DECLARE @Hotel VARCHAR(255)
  DECLARE @HotelID INT
  DECLARE @Trip VARCHAR(255)
  DECLARE @CityID INT
  DECLARE @CityName VARCHAR(255)
  DECLARE @RegionID INT
  DECLARE @RegionName VARCHAR(255)
  DECLARE @CountryID INT
  DECLARE @CountryName VARCHAR(255)
  DECLARE @Rooms INT
  DECLARE @CheckIn DATE
  DECLARE @CheckOut DATE
  DECLARE @Cost MONEY
  
  SET @HotelID = (SELECT TOP 1 HotelID FROM HOTEL ORDER BY NEWID())
  SET @Hotel = (SELECT TOP 1 HotelName FROM HOTEL WHERE HotelID = @HotelID)
  SET @Trip = (SELECT TOP 1 TripName FROM TRIP ORDER BY NEWID())
  SET @CityID = (SELECT TOP 1 CityID FROM HOTEL WHERE HOTELID = @HotelID)
  SET @CityName = (SELECT TOP 1 CityName FROM CITY WHERE CityID = @CityID)
  SET @RegionID = (SELECT TOP 1 RegionID FROM CITY WHERE CityID = @CityID)
  SET @RegionName = (SELECT TOP 1 RegionName FROM REGION WHERE RegionID = @RegionID)
  SET @CountryID = (SELECT TOP 1 CountryID FROM REGION WHERE RegionID = @RegionID)
  SET @CountryName = (SELECT TOP 1 CountryName FROM COUNTRY WHERE CountryID = @CountryID)
  SET @Rooms = CAST(ROUND((RAND() * 19) + 1, 0) AS INT)
  SET @CheckIn = DATEADD(DAY, ABS(CHECKSUM(NEWID()) % 365), '2015-01-01')
  SET @CheckOut = DATEADD(DAY, ABS(CHECKSUM(NEWID()) % 5), @CheckIn)
  SET @Cost = CONVERT(MONEY, (RAND() * 8999) + 1000, 2)
  
  EXEC dbo.uspInsertTripHotel 
    @HotelName = @Hotel,
    @City = @CityName,
    @Region = @RegionName,
    @Country = @CountryName,
    @TripName = @Trip,
    @RoomsReserved = @Rooms,
    @CheckIn = @CheckIn,
    @CheckOut = @CheckOut,
    @Cost = @Cost;
  
  SET @NumInserts = @NumInserts - 1
END
GO