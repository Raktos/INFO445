CREATE PROCEDURE uspInsertGroupStudent
	@StudentFName VARCHAR(255),
	@StudentLName VARCHAR(255),
	@GroupName VARCHAR(255)
AS
BEGIN
	BEGIN TRAN T1
		DECLARE @StudentFind int;
		DECLARE @GroupFind int;

		SET @StudentFind = (SELECT StudentID FROM STUDENT WHERE StudentFName = @StudentFName AND StudentLName = @StudentLName)
		IF @StudentFind IS NULL
		BEGIN
			RETURN -1
		END

		SET @GroupFind = (SELECT GroupID FROM TRIPGROUP WHERE GroupName = @GroupName)
		IF @GroupFind IS NULL
		BEGIN
			RETURN -1
		END

		DECLARE @StudentID int;
		DECLARE @GroupID int;

		SET @StudentID = (SELECT TOP 1 StudentID from STUDENT where StudentID = newID())

		SET @GroupID = (SELECT TOP 1 GroupID from TRIPGROUP where GroupID = newID())

		INSERT INTO GROUP_STUDENT(StudentID, GroupID)
		VALUES(@StudentID, @GroupID)
	
	IF @@error <> 0
		ROLLBACK TRAN T1
	ELSE
		COMMIT TRAN T1
END
