ALTER PROCEDURE [dbo].[uspPopulateActivityType]
	@NumInserts int
AS
WHILE @NumInserts > 0
BEGIN
  DECLARE @Category VARCHAR(255)
  DECLARE @Name VARCHAR(255)
  DECLARE @Desc VARCHAR(255)
  
  SET @Category = (SELECT TOP 1 ActivityCategoryName FROM ACTIVITY_CATEGORY ORDER BY NEWID())
  SET @Name = (SELECT TOP 1 verb FROM VERB ORDER BY NEWID())
  SET @Desc = @Name + ' is a really fun activity that you should try some time.'
  
  EXEC dbo.uspInsertActivityType
		@ActivityCategory = @Category,
    @ActivityTypeName = @Name,
    @ActivityTypeDesc = @Desc
  
  SET @NumInserts = @NumInserts - 1
END
GO