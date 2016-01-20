--students, leaders, hotels, flights--

use AtlasTravel
GO

SET ANSI_NULLS ON
GO

-- Store Procedure for inserting data into AtlastTravel.dbo.STUDENT_TYPE
CREATE PROCEDURE insertStudentType(
	@StudentTypeID int,
	@StudentTypeName varchar(255),
	@StudentTypeDesc varchar(255)
)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT @StudentTypeID = ISNULL(MAX(StudentTypeID), 0) + 1
	FROM dbo.STUDENT_TYPE
	BEGIN
		INSERT INTO AtlasTravel.dbo.STUDENT_TYPE (StudentTypeID, StudentTypeName, StudentTypeDesc)
		VALUES (@StudentTypeID, @StudentTypeName, @StudentTypeDesc)
	END
END

EXEC insertStudentType @StudentTypeID = 0, @StudentTypeName = 'Sophomore', @StudentTypeDesc = 'Second year of college'
EXEC insertStudentType @StudentTypeID = 0, @StudentTypeName = 'Freshman', @StudentTypeDesc = 'First year of college'
EXEC insertStudentType @StudentTypeID = 0, @StudentTypeName = 'Senior', @StudentTypeDesc = 'Fourth year of college'
EXEC insertStudentType @StudentTypeID = 0, @StudentTypeName = 'Junior', @StudentTypeDesc = 'Third year of college'
EXEC insertStudentType @StudentTypeID = 0, @StudentTypeName = 'Sophomore', @StudentTypeDesc = 'Second year of college'





-- Store Procedure for inserting data into AtlastTravel.dbo.SPONSOR_TYPE
CREATE PROCEDURE insertSPONSOR_TYPE(
	@SponsorTypeID int OUTPUT,
	@SponsorTypeName varchar(255),
	@SponsorTypeDesc varchar(255)
)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT @SponsorTypeID = ISNULL(MAX(SponsorTypeID), 0) + 1
	FROM dbo.SPONSOR_TYPE
	BEGIN
		INSERT INTO AtlasTravel.dbo.SPONSOR_TYPE(SponsorTypeID, SponsorTypeName, SponsorTypeDesc)
		VALUES (@SponsorTypeID, @SponsorTypeName, @SponsorTypeDesc)
	END
END

EXEC insertSPONSOR_TYPE @SponsorTypeID = 0, @SponsorTypeName = 'University of Washington', @SponsorTypeDesc = 'University sponsorship'
EXEC insertSPONSOR_TYPE @SponsorTypeID = 0, @SponsorTypeName = 'University of Georgia', @SponsorTypeDesc = 'University sponsorship'
EXEC insertSPONSOR_TYPE @SponsorTypeID = 0, @SponsorTypeName = 'Stanford University', @SponsorTypeDesc = 'University sponsorship'
EXEC insertSPONSOR_TYPE @SponsorTypeID = 0, @SponsorTypeName = 'University of Oregon', @SponsorTypeDesc = 'University sponsorship'
EXEC insertSPONSOR_TYPE @SponsorTypeID = 0, @SponsorTypeName = 'San Diego State University', @SponsorTypeDesc = 'University sponsorship'





-- Store Procedure for inserting data into AtlastTravel.dbo.TRANSIT_TYPE
CREATE PROCEDURE insertTRANSIT_TYPE(
	@TransitTypeID int,
	@TransitTypeName varchar(255),
	@TransitTypeDesc varchar(255)
)
AS

BEGIN
	SET NOCOUNT ON
	SELECT @TransitTypeID = ISNULL(MAX(TransitTypeID), 0) + 1
	FROM dbo.TRANSIT_TYPE
	BEGIN 
		SET IDENTITY_INSERT AtlasTravel.dbo.TRANSIT_TYPE ON
		INSERT INTO AtlasTravel.dbo.TRANSIT_TYPE(TransitTypeID, TransitTypeName, TransitTypeDesc)
		VALUES (@TransitTypeID, @TransitTypeName, @TransitTypeDesc)
	END
END

EXEC insertTRANSIT_TYPE @TransitTypeID = 0, @TransitTypeName = 'Bus', @TransitTypeDesc = 'An inexpensive mode of transporation on the road'
EXEC insertTRANSIT_TYPE @TransitTypeID = 0, @TransitTypeName = 'Airplane', @TransitTypeDesc = 'An expensive mode of transporation in the air'
EXEC insertTRANSIT_TYPE @TransitTypeID = 0, @TransitTypeName = 'Train', @TransitTypeDesc = 'A cost effective mode of transporation for long distances'
EXEC insertTRANSIT_TYPE @TransitTypeID = 0, @TransitTypeName = 'Walk', @TransitTypeDesc = 'The least expensive mode of transporation for short distances'
EXEC insertTRANSIT_TYPE @TransitTypeID = 0, @TransitTypeName = 'Bike', @TransitTypeDesc = 'An inexpensive mode of transporation for moderate distances'





-- Store Procedure for inserting data into AtlastTravel.dbo.TRANSIT_COMPANY
ALTER PROCEDURE insertTRANSIT_COMPANY(
	@TransitCompanyID int,
	@TransitCompanyName varchar(255),
	@TransitCompanyDesc varchar(255)
)
AS

BEGIN
	SET NOCOUNT ON
	SELECT @TransitCompanyID = ISNULL(MAX(TransitCompanyID), 0) + 1
	FROM dbo.TRANSIT_COMPANY
	BEGIN 
		SET IDENTITY_INSERT AtlasTravel.dbo.TRANSIT_COMPANY ON
		INSERT INTO AtlasTravel.dbo.TRANSIT_COMPANY(TransitCompanyID, TransitCompanyName, TransitCompanyDesc)
		VALUES (@TransitCompanyID, @TransitCompanyName, @TransitCompanyDesc)
	END
END

EXEC insertTRANSIT_COMPANY @TransitCompanyID = 0, @TransitCompanyName = 'LeMetro', @TransitCompanyDesc = 'French Bus Metro System'
EXEC insertTRANSIT_COMPANY @TransitCompanyID = 0, @TransitCompanyName = 'Das Rail', @TransitCompanyDesc = 'German Rail System'
EXEC insertTRANSIT_COMPANY @TransitCompanyID = 0, @TransitCompanyName = 'Air France', @TransitCompanyDesc = 'French Airline'
EXEC insertTRANSIT_COMPANY @TransitCompanyID = 0, @TransitCompanyName = 'Bikes 4 All', @TransitCompanyDesc = 'British Bike Sharing Service'
EXEC insertTRANSIT_COMPANY @TransitCompanyID = 0, @TransitCompanyName = 'Cyclos', @TransitCompanyDesc = 'A European Union Bike Rental Program'





-- Store Procedure for inserting data into AtlastTravel.dbo.TRANSIT
ALTER PROCEDURE insertTRANSIT(
	@TransitID int,
	@TransitTypeID int,
	@TransitCompanyID int,
	@TransitDesc varchar(255)
)
AS

BEGIN
	SET NOCOUNT ON

	SELECT @TransitID = ISNULL(MAX(TransitID), 0) + 1
	FROM dbo.TRANSIT

	BEGIN 
		SET IDENTITY_INSERT AtlasTravel.dbo.TRANSIT ON
		INSERT INTO AtlasTravel.dbo.TRANSIT(TransitID, TransitTypeID, TransitCompanyID, TransitDesc)
		VALUES (@TransitID, @TransitTypeID, @TransitCompanyID, @TransitDesc)
	END
END

EXEC insertTRANSIT @TransitID = 0, @TransitTypeID = 3, @TransitCompanyID = 3, @TransitDesc = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed'
EXEC insertTRANSIT @TransitID = 0, @TransitTypeID = 1, @TransitCompanyID = 1, @TransitDesc = 'Sed ut perspiciatis unde omnis iste'
EXEC insertTRANSIT @TransitID = 0, @TransitTypeID = 2, @TransitCompanyID = 2, @TransitDesc = 'Ut labore et dolore magnam aliquam quaerat voluptatem'
EXEC insertTRANSIT @TransitID = 0, @TransitTypeID = 5, @TransitCompanyID = 5, @TransitDesc = 'Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus'
EXEC insertTRANSIT @TransitID = 0, @TransitTypeID = 4, @TransitCompanyID = 4, @TransitDesc = 'Itaque earum rerum hic tenetur a sapiente delectus, ut aut reiciendis voluptatibus maiores'


--flightgroupstudent, group_student, hotel, leader, sponsor, sponsor_contact, trip, trip_activity, trip_city, trip_hotel, trip_transit, tripgroup
