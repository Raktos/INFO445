USE AtlasTravel_Final;

CREATE PROCEDURE uspPopulateSponsorContact
	@NumInserts int
AS
	DECLARE @People int;
	DECLARE @FName varchar(255);
	DECLARE @LName varchar(255);
	DECLARE @Phone varchar(255);
	DECLARE @Email varchar(255);
	WHILE @NumInserts > 0
	BEGIN
		BEGIN TRAN t1
			SET @PeopleID = SELECT TOP 1 FROM PEOPLE ORDER BY NEWID();
			SET @FName = (SELECT FirstName FROM @People);
			SET @LName = (SELECT LastName FROM @People);
			SET @Phone = ('(' + fnGetRandIntWithMax(999) + ') ' + fnGetRandIntWithMax(999) + '-' + fnGetRandIntWithMax(9999));
			SET @Email = @FName + CAST(fnGetRandIntWithMax(999) AS varchar) + '@email.com';
			SET @StudentType = fnGetRandIntWithMax(SELECT count(*) FROM STUDENT_TYPE);

			-- perform the insert
			INSERT INTO STUDENT(StudentTypeID, StudentFName, StudentLName, StudentDOB, StudentPhoneNumber, StudentEmail)
				VALUES(@StudentType, @FName, @LName, @DOB, @Phone, @Email)
		COMMIT TRAN t1
		@NumInserts = @NumInserts - 1;
	END
GO
