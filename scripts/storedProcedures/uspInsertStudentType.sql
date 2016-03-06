CREATE PROCEDURE uspInsertStudentType
	@StudentTypeName varchar(255),
	@StudentTypeDesc varchar(255)
AS
BEGIN
	BEGIN TRAN T1
		INSERT INTO STUDENT_TYPE(StudentTypeName, StudentTypeDesc)
		VALUES(@StudentTypeName, @StudentTypeDesc)
	
	IF @@error <> 0
		ROLLBACK TRAN T1
	ELSE
		COMMIT TRAN T1
END
