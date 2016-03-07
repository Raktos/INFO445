ALTER PROCEDURE uspInsertGroupStudent
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

		BEGIN
			INSERT INTO GROUP_STUDENT(StudentID, GroupID)
			VALUES(@StudentFind, @GroupFind)
		END

	COMMIT TRAN T1
END
GO