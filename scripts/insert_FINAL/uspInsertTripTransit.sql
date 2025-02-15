ALTER PROCEDURE [dbo].[uspInsertTripTransit]
	@TripName varchar(255),
	@TransitType varchar(255),
	@TransitCompany varchar(255),
	@PickupCity varchar(255),
	@PickupRegion varchar(255),
	@PickupCountry varchar(255),
	@TripTransitPickupDate date,
	@DropoffCity varchar(255),
	@DropoffRegion varchar(255),
	@DropoffCountry varchar(255),
	@TripTransitDropoffDate date,
	@TripTransitPickupStreetAddress varchar(255),
	@TripTransitDropoffStreetAddress varchar(255),
	@TripTransitCost money
AS
BEGIN
	DECLARE @PickupCityFind int
	DECLARE @DropoffCityFind int
	DECLARE @TripFind int
	DECLARE @TransitFind int
	DECLARE @TransitCompanyFind int
	DECLARE @TransitTypeFind int

	SET @TripFind = (SELECT TripID 
						FROM TRIP
						WHERE TripName = @TripName);
	IF @TripFind IS NULL
	BEGIN
		raiserror('could not find trip', 18, 1)
		return -1
	END

	SET @TransitCompanyFind = (SELECT TransitCompanyID
								FROM TRANSIT_COMPANY
								WHERE TransitCompanyName = @TransitCompany);
	IF @TransitCompanyFind IS NULL
	BEGIN
		raiserror('could not find transit company', 18, 1)
		return -1
	END

	SET @TransitTypeFind = (SELECT TransitTypeID
								FROM TRANSIT_TYPE
								WHERE TransitTypeName = @TransitType);
	IF @TransitTypeFind IS NULL
	BEGIN
		raiserror('could not find transit type', 18, 1)
		return -1
	END

	SET @TransitFind = (SELECT TransitID
						FROM TRANSIT
						WHERE TransitTypeID = @TransitTypeFind
						AND TransitCompanyID = @TransitcompanyFind);
	IF @TransitFind IS NULL
	BEGIN
		raiserror('could not find transit', 18, 1)
		return -1
	END

	SET @PickupCityFind = (SELECT CityID 
						FROM CITY c
						JOIN REGION r
							ON r.RegionID = c.RegionID
						JOIN COUNTRY cu
							ON cu.CountryID = r.CountryID
						WHERE c.CityName = @PickupCity
						AND r.RegionName = @PickupRegion
						AND cu.CountryName = @PickupCountry);
	IF @PickupCityFind IS NULL
	BEGIN
		EXEC dbo.uspInsertCity @City = @PickupCity, @Region = @PickupRegion, @Country = @PickupCountry, @CityID = @PickupCityFind OUTPUT;
	END
	
	SET @DropoffCityFind = (SELECT CityID 
						FROM CITY c
						JOIN REGION r
							ON r.RegionID = c.RegionID
						JOIN COUNTRY cu
							ON cu.CountryID = r.CountryID
						WHERE c.CityName = @DropoffCity
						AND r.RegionName = @DropoffRegion
						AND cu.CountryName = @DropoffCountry);
	IF @DropoffCityFind IS NULL
	BEGIN
		EXEC dbo.uspInsertCity @City = @DropoffCity, @Region = @DropoffRegion, @Country = @DropoffCountry, @CityID = @DropoffCityFind OUTPUT;
	END
	BEGIN TRAN T1
		INSERT INTO TRIP_TRANSIT (TripID, TransitID, TripTransitPickupCityID, TripTransitDropoffCityID,
									TripTransitPickupDate, TripTransitDropoffDate, TripTransitPickupStreetAddress,
									TripTransitDropoffStreetAddress, TripTransitCost)
		VALUES(
			@TripFind,
			@TransitFind,
			@PickupCityFind,
			@DropoffCityFind,
			@TripTransitPickupDate,
			@TripTransitDropoffDate,
			@TripTransitPickupStreetAddress,
			@TripTransitDropoffStreetAddress,
			@TripTransitCost
		);
    COMMIT TRAN T1
END
GO