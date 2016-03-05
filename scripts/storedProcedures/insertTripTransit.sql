USE AtlasTravel;
GO


CREATE PROCEDURE [dbo].[insertTRIP_TRANSIT]
	@TripTransitID int,
	@TripID int,
	@TransitID int,
	@TripTransitPickupCityID int,
	@TripTransitDropoffCityID int,
	@TripTransitPickupDate date,
	@TripTransitDropoffDate date,
	@TripTransitPickupStreetAddress varchar(255),
	@TripTransitDropoffStreetAddress varchar(255),
	@TripTransitCost money
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRAN T1
		INSERT INTO TRIP_TRANSIT (
			TripTransitID, TripID, TransitID, TripTransitPickupCityID, TripTransitDropoffCityID, TripTransitPickupDate,
			TripTransitDropoffDate, TripTransitPickupStreetAddress, TripTransitDropoffStreetAddress, TripTransitCost
		)

		VALUES(
			@TripTransitID,
			@TripID,
			@TransitID,
			@TripTransitPickupCityID,
			@TripTransitDropoffCityID,
			@TripTransitPickupDate,
			@TripTransitDropoffDate,
			@TripTransitPickupStreetAddress,
			@TripTransitDropoffStreetAddress,
			@TripTransitCost
		);
    COMMIT TRAN T1
END
GO


