ALTER PROCEDURE uspInsertStudentType
	@StudentTypeName varchar(255),
	@StudentTypeDesc varchar(255)
AS
BEGIN
	BEGIN TRAN T1
		INSERT INTO STUDENT_TYPE(StudentTypeName, StudentTypeDesc)
		VALUES(@StudentTypeName, @StudentTypeDesc)
	COMMIT TRAN T1
END
GO