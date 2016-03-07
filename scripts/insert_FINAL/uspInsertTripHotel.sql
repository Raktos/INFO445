ALTER PROCEDURE uspInsertTripHotel
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

	SET @TripFind = (SELECT TOP 1 TripID 
						FROM TRIP
						WHERE TripName = @TripName);
	IF @TripFind IS NULL
	BEGIN
		raiserror('could not find trip', 18, 1)
		return -1
	END

	SET @CityFind = (SELECT TOP 1 CityID 
						FROM CITY c
						JOIN REGION r
							ON r.RegionID = c.RegionID
						JOIN COUNTRY cu
							ON cu.CountryID = r.CountryID
						WHERE c.CityName = @City
						AND r.RegionName = @Region
						AND cu.CountryName = @Country);
	
	IF @CityFind IS NULL
	BEGIN
		raiserror('could not find city', 18, 1)
		return -1
	END

	SET @HotelFind = (SELECT TOP 1 HotelID 
						FROM HOTEL
						WHERE HotelName = @HotelName
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