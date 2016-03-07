ALTER FUNCTION fnCalcTripTotalCost (@TripID INT)
RETURNS money
AS
BEGIN
	DECLARE @RET int;
	DECLARE @HotelTotalCost int;
	DECLARE @ActivityTotalCost int;
	DECLARE @TransitTotalCost int

	SET @HotelTotalCost = (SELECT Sum(HotelCost) FROM TRIP_HOTEL th WHERE th.TripID = @TripID);
  IF @HotelTotalCost is NULL
    BEGIN 
      SET @HotelTotalCost = 0
    END
	
	SET @ActivityTotalCost = (SELECT Sum(ActivityCost) FROM TRIP_ACTIVITY ta WHERE ta.TripID = @TripID);
  IF @ActivityTotalCost is NULL
    BEGIN 
      SET @ActivityTotalCost = 0
    END
	
	SET @TransitTotalCost = (SELECT Sum(TripTransitCost) FROM TRIP_TRANSIT tt WHERE tt.TripID = @TripID);
  IF @TransitTotalCost is NULL
    BEGIN 
      SET @TransitTotalCost = 0
    END

	SET @RET = (@HotelTotalCost + @ActivityTotalCost + @TransitTotalCost);
RETURN @RET
END
GO