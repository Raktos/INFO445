CREATE PROCEDURE uspInsertTripGroup
	@GroupName varchar(255),
	@GroupDesc varchar(255)
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRAN t1
		DECLARE @GroupID INT;
		DECLARE @TripID INT;
		DECLARE @GroupMainLeaderID INT;
		DECLARE @GroupCoLeaderID INT;

		BEGIN
			SELECT @GroupID = ISNULL(MAX(GroupID), 0) + 1
			FROM dbo.TRIP_GROUP

			SET @TripID = (SELECT TOP 1 TripID FROM TRIP ORDER BY NEWID());

			SET @GroupMainLeaderID = (SELECT TOP 1 LeaderID FROM LEADER WHERE LeaderID <> @GroupCoLeaderID ORDER BY NEWID());

			SET @GroupCoLeaderID = (SELECT TOP 1 LeaderID FROM LEADER WHERE LeaderID <> @GroupMainLeaderID ORDER BY NEWID());

			INSERT INTO TRIPGROUP(GroupID, TripID, GroupMainLeaderID, GroupCoLeaderID, GroupName, GroupDesc)
			VALUES(@GroupID, @TripID, @GroupMainLeaderID, @GroupCoLeaderID, @GroupName, @GroupDesc)

		END

	IF @@error <> 0 
		ROLLBACK TRAN t1
	ELSE
		commit tran t1
END