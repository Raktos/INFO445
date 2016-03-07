ALTER PROCEDURE uspPopulateTransit
  @NumInserts int
AS
WHILE @NumInserts > 0
BEGIN
  DECLARE @Type VARCHAR(255)
  DECLARE @Company VARCHAR(255)
  DECLARE @Desc VARCHAR(255)
  DECLARE @Out INT

  SET @Type = (SELECT TOP 1 TransitTypeName FROM TRANSIT_TYPE ORDER BY NEWID())
  SET @Company = (SELECT TOP 1 TransitCompanyName FROM TRANSIT_COMPANY ORDER BY NEWID())
  SET @Desc = 'This is a ' + @Type + ' service of ' + @Company + '.'

  EXEC dbo.uspInsertTransit
  	@TransitType = @Type,
    @TransitCompany = @Company,
    @TransitDesc = @Desc,
    @TransitID = @Out OUTPUT

  SET @NumInserts = @NumInserts - 1
END
GO