USE AtlasTravel_FINAL;
GO

CREATE PROCEDURE uspInsertActivityCategory
	@ActivityCategoryName varchar(255),
	@ActivityCategoryDesc varchar(255),
AS
	BEGIN TRAN t1
	
		DECLARE @ActCateFind int;

		SET @ActCateFind = (SELECT ActivityCategoryID FROM ACTIVITY_CATEGORY 
							WHERE ActivityCategoryName = @ActivityCategoryName
							AND ActivityCategoryDesc = @ActivityCategoryDesc);

		IF @ActCateFind IS NULL
		BEGIN
			INSERT INTO ACTIVITY_CATEGORY(ActivityCategoryName, ActivityCategoryDesc)
			VALUES(@ActivityCategoryName, @ActivityCategoryDesc);
		END

	COMMIT TRAN t1
GO