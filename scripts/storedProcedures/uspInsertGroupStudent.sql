CREATE PROCEDURE uspInsertGroupStudent
AS
BEGIN
	BEGIN TRAN T1
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
