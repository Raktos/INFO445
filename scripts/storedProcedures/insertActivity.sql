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
	IF @@error <> 0
		ROLLBACK TRAN t1
	ELSE
		COMMIT TRAN t1
GO
