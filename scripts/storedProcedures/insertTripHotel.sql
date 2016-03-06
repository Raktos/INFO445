USE AtlasTravel_FINAL;
GO

CREATE PROCEDURE uspInsertTipHotel
	@HotelName varchar(255),
	@City varchar(255),
	@Region varchar(255),
	@Country varchar(255),
	@TripName varchar(255),
	@RoomsReserved int,
	@CheckIn date,
	@CheckOut date,
	@Cost money
AS
BEGIN
	DECLARE @CityFind int;
	DECLARE @HotelFind int;
	DECLARE @TripFind int;

	SET @TripFind = (SELECT TripID 
						FROM TRIP
						WHERE TripName = @TripName);
	IF @TripFind IS NULL
	BEGIN
		raiserror('could not find trip', 18, 1)
		return -1
	END

	SET @CityFind = (SELECT CityID 
						FROM CITY c
						JOIN REGION r
							ON r.RegionID = c.CityID
						JOIN COUNTRY cu
							ON cu.CountryID - r.RegionID
						WHERE c.CityName = @FlightDepartureCity
						AND r.RegionName = @FlightDepartureRegion
						AND cu.CountryID = @FlightDepartureCountry);
	
	IF @FlightDepartureCityFind IS NULL
	BEGIN
		raiserror('could not find city', 18, 1)
		return -1
	END

	SET @HotelFind = (SELECT HotelID 
						FROM HOTEL
						WHERE HotelName = @FHotelName
						AND CityID = @CityFind);
	IF @HotelFind IS NULL
	BEGIN
		raiserror('could not find hotel', 18, 1)
		return -1
	END

	BEGIN TRAN T1
		INSERT INTO TRIP_HOTEL (TripID, HotelID, HotelRoomsReserved, HotelCheckInDate, HotelCheckOutDate, HotelCost)
		VALUES(@TripFind, @HotelFind, @RoomsReserved, @CheckIn, @CheckOut, @Cost);
    COMMIT TRAN T1
END
GO
