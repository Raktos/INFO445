-- Jaoson Ho
-- Lab2
-- 25 January 2016

-- Gets a random integer from 1 - max inclusive
-- 0 is not allowed
CREATE FUNCTION fnGetRandIntWithMax (@Max int)
RETURNS int
AS BEGIN
	DECLARE @Rand int;
	SET @Rand = 0;
	WHILE @Rand = 0
	BEGIN
		SET @Rand = CAST(ROUND(RAND() * @Max, 0) AS int);
	END
	RETURN @Rand
END
GO

-- Inserts a fake student.
CREATE PROCEDURE uspPopulateStudent
	@NumInserts int
AS
	DECLARE @FName varchar(255);
	DECLARE @LName varchar(255);
	DELCARE @DOB date;
	DECLARE @Phone varchar(255);
	DECLARE @Email varchar(255);
	DECLARE @StudentType int;

	WHILE @NumInserts > 0
	BEGIN
		BEGIN TRAN t1
			-- get a first name from the first name lookup table
			SET @FName = (SELECT FirstName FROM tblFIRST_NAME WHERE FirstNameID = fnGetRandIntWithMax(SELECT count(*) FROM tblFIRST_NAME));

			-- get a last name from the last name lookup table
			SET @LName = (SELECT LastName FROM tblLAST_NAME WHERE LastNameID = fnGetRandIntWithMax(SELECT count(*) FROM tblLAST_NAME));

			-- create a birthdate between age 18 and 30
			SET @DOB = (SELECT DATEADD(day, -10950 + fnGetRandIntWithMax(4380), GETDATE()));

			-- generate a phone number string with 3 random numbers
			SET @PHONE = ('(' + fnGetRandIntWithMax(999) + ') ' + fnGetRandIntWithMax(999) + '-' + fnGetRandIntWithMax(9999));

			-- use FName and random numbers to generate email
			SET @Email = @FName + CAST(fnGetRandIntWithMax(999) AS varchar) + '@email.com';

			-- find a student type
			SET @StudentType = fnGetRandIntWithMax(SELECT count(*) FROM STUDENT_TYPE);

			-- perform the insert
			INSERT INTO STUDENT(StudentTypeID, StudentFName, StudentLName, StudentDOB, StudentPhoneNumber, StudentEmail)
				VALUES(@StudentType, @FName, @LName, @DOB, @Phone, @Email)
		COMMIT TRAN t1
		@NumInserts = @NumInserts - 1;
	END
GO
