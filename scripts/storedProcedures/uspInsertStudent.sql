CREATE PROCEDURE uspInsertStudent
	@StudentTypeName varchar(255),
	@StudentFName varchar(255),
	@StudentLName varchar(255),
	@StudentDOB DATE,
	@StudentPhoneNumber varchar(10),
	@StudentEmail varchar(255)
AS
BEGIN
	BEGIN TRAN T1	
		DECLARE @StudentTypeID int;
		DECLARE @StudentFind int;

		SET @StudentTypeID = (SELECT StudentTypeID FROM STUDENT_TYPE WHERE StudentTypeName = @StudentTypeName)
		
		IF @StudentTypeID IS NULL
			BEGIN
				RETURN -1
			END	

		INSERT INTO STUDENT(StudentTypeID, StudentFName, StudentLName, StudentDOB, StudentPhoneNumber, StudentEmail)
		VALUES(@StudentTypeID, @StudentFName, @StudentLName, @StudentDOB, @StudentPhoneNumber, @StudentEmail)

		IF @@error <> 0
			ROLLBACK TRAN T1
		ELSE
			COMMIT TRAN T1
END