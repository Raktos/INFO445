CREATE FUNCTION fnCalcStudentsOnFlight (@FlightID INT)
RETURNS INT
AS
BEGIN
	DECLARE @RET INT =
		(SELECT COUNT(StudentID) FROM FLIGHT f JOIN FLIGHT_GROUP_STUDENT fgs ON f.FlightID = fgs.FlightID JOIN GROUP_STUDENT gs ON fgs.GroupStudentID = gs.GroupStudentID where f.FlightID = fgs.FlightID)
	RETURN @RET
END
GO

ALTER TABLE FLIGHT
ADD NumberOfStudents AS (dbo.fnCalcStudentsOnFlight(FlightID))
GO