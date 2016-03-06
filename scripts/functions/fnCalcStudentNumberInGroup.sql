USE AtlasTravel_FINAL
GO

CREATE FUNCTION fnCalcStudentNumberInGroup (@GroupID INT)
RETURNS int
AS
BEGIN
DECLARE @RET INT =
	(SELECT COUNT(GroupStudentID) FROM GROUP_STUDENT gs WHERE gs.GroupID = @GroupID)
RETURN @RET
END
GO


ALTER TABLE TRIPGROUP
ADD TotalNumStudents AS (dbo.fnCalcStudentNumberInGroup (@GroupID))
GO
