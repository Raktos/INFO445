ALTER PROCEDURE [dbo].[uspPopulateTripGroup]
	@NumInserts int
AS
	DECLARE @TripID int;
	DECLARE @MainLeaderID int;
	DECLARE @CoLeaderID int;
	DECLARE @GroupName varchar(50);
	DECLARE @GroupDesc varchar(255);
	DECLARE @GroupPre varchar(50);
	SET @GroupPre = 'Group ';
	WHILE @NumInserts > 0
	BEGIN
		BEGIN TRAN t1
			SET @TripID = (SELECT TOP 1 TripID FROM TRIP ORDER BY NEWID());
			SET @MainLeaderID = (SELECT TOP 1 LeaderID FROM LEADER ORDER BY NEWID());
			SET @CoLeaderID = @MainLeaderID;
			WHILE @CoLeaderID = @MainLeaderID
			BEGIN
				SET @CoLeaderID = (SELECT TOP 1 LeaderID FROM LEADER ORDER BY NEWID());
			END

			-- perform the insert

			INSERT INTO TRIPGROUP(TripID, GroupMainLeaderID, GroupCoLeaderID, GroupName, GroupDesc)
				VALUES(@TripID, @MainLeaderID, @CoLeaderID, @GroupPre + CAST(@NumInserts AS varchar(8)), 'Some group description')
		COMMIT TRAN t1
		SET @NumInserts = @NumInserts - 1;
	END
GO