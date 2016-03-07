ALTER FUNCTION fnCalcNumFlightsPerAirline (@AirlineID INT)
RETURNS INT
AS
BEGIN
	DECLARE @RET INT =
		(SELECT COUNT(FlightID) from FLIGHT f JOIN AIRLINE a ON f.AirlineID = a.AirlineID where a.AirlineID = @AirlineID)
	RETURN @RET
END
GO