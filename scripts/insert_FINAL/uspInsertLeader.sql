ALTER PROCEDURE uspInsertLeader
	@LeaderFName varchar(255),
	@LeaderLName varchar(255),
	@LeaderDOB DATE,
	@LeaderPhoneNumber varchar(10),
	@LeaderEmail varchar(255)
AS
BEGIN
	BEGIN TRAN T1	
		INSERT INTO LEADER(LeaderFName, LeaderLName, LeaderDOB, LeaderPhoneNumber, LeaderEmail)
		VALUES(@LeaderFName, @LeaderLName, @LeaderDOB, @LeaderPhoneNumber, @LeaderEmail)
	COMMIT TRAN T1
END
GO