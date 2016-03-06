USE AtlasTravel_FINAL
GO

CREATE FUNCTION fnCalcTripTotalCost (@TripID INT)
RETURNS money
AS
BEGIN
	DECLARE @RET money;
	DECLARE @HotelTotalCost money;
	DECLARE @ActivityTotalCost money;
	DECLARE @TransitTotalCost money

	SET @HotelTotalCost = (SELECT Sum(HotelCost) FROM TRIP_HOTEL th WHERE th.TripID = @TripID);
	
	SET @ActivityTotalCost = (SELECT Sum(ActivityCost) FROM TRIP_ACTIVITY ta WHERE ta.TripID = @TripID);
	
	SET @TransitTotalCost = (SELECT Sum(TripTransitCost) FROM TRIP_TRANSIT tt WHERE tt.TripID = @TripID);

	SET @RET = (SELECT (@HotelTotalCost + @ActivityTotalCost + @TransitTotalCost));
RETURN @RET
END
GO

ALTER TABLE TRIP
ADD TotalCost AS (dbo.fnCalcTripTotalCost(@TripID))
GO
