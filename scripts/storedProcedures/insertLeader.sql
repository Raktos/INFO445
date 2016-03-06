USE AtlasTravel;
GO

CREATE PROCEDURE uspInsertLeader (
	@LeaderID int,
	@LeaderFName varchar(50),
	@LeaderLName varchar(50),
	@LeaderDOB date,
	@LeaderPhoneNumber varchar(50),
	@LeaderEmail varchar(100)
)
AS

BEGIN TRAN T1
	SET NOCOUNT ON

	SELECT @LeaderID = ISNULL(MAX(TransitID), 0) + 1
	FROM dbo.LEADER

	BEGIN 
		SET IDENTITY_INSERT AtlasTravel.dbo.TRANSIT ON
		INSERT INTO AtlasTravel.dbo.LEADER(LeaderID, LeaderFName, LeaderLName, LeaderDOB, LeaderPhoneNumber, LeaderEmail)
		VALUES (@LeaderID, @LeaderFName, @LeaderLName, @LeaderDOB, @LeaderPhoneNumber, @LeaderEmail)
	END
COMMIT TRAN T1
GO


