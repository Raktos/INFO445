CREATE PROCEDURE uspInsertTripGroup
	@TripName varchar(255),
	@MainLeaderFName varchar(255),
	@MainLeaderLName varchar(255),
	@CoLeaderFName varchar(255),
	@CoLeaderLName varchar(255),
	@GroupName varchar(255),
	@GroupDesc varchar(255)
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRAN t1
		DECLARE @TripFind INT;
		DECLARE @MainLeaderFind INT;
		DECLARE @CoLeaderFind INT;

		DECLARE @GroupID INT;
		DECLARE @TripID INT;
		DECLARE @GroupMainLeaderID INT;
		DECLARE @GroupCoLeaderID INT;

		BEGIN
			SET @TripFind = (SELECT TripID FROM TRIP WHERE TripName = @TripName)
			IF @TripFind IS NULL
			BEGIN
				RETURN -1
			END

			SET @MainLeaderFind = (SELECT LeaderID FROM LEADER WHERE LeaderFName = @MainLeaderFName AND LeaderLName = @MainLeaderLName)
			IF @MainLeaderFind IS NULL
			BEGIN
				RETURN -1
			END

			SET @CoLeaderFind = (SELECT LeaderID FROM LEADER WHERE LeaderFName = @CoLeaderFName AND LeaderLName = @CoLeaderLName)
			IF @CoLeaderFind IS NULL
			BEGIN
				RETURN -1
			END

			SET @TripID = (SELECT TOP 1 TripID FROM TRIP ORDER BY NEWID());

			SET @GroupMainLeaderID = (SELECT TOP 1 LeaderID FROM LEADER WHERE LeaderID <> @GroupCoLeaderID ORDER BY NEWID());

			SET @GroupCoLeaderID = (SELECT TOP 1 LeaderID FROM LEADER WHERE LeaderID <> @GroupMainLeaderID ORDER BY NEWID());

			INSERT INTO TRIPGROUP(TripID, GroupMainLeaderID, GroupCoLeaderID, GroupName, GroupDesc)
			VALUES(@TripID, @GroupMainLeaderID, @GroupCoLeaderID, @GroupName, @GroupDesc)

		END

	IF @@error <> 0 
		ROLLBACK TRAN t1
	ELSE
		commit tran t1
END