ALTER PROCEDURE uspPopulateTransitCompany
  @NumInserts int
AS
WHILE @NumInserts > 0
BEGIN
  DECLARE @Noun VARCHAR(255)
  DECLARE @Verb VARCHAR(255)
  DECLARE @Name VARCHAR(255)
  DECLARE @Desc VARCHAR(255)

  SET @Noun = (SELECT TOP 1 noun FROM NOUN ORDER BY NEWID())
  SET @Verb = (SELECT TOP 1 verb FROM VERB ORDER BY NEWID())
  SET @Name = @Noun + ' ' + @Verb + ' Transit Co.'
  SET @Desc = @Name + ' is a pretty great transit company.'

  EXEC dbo.uspInsertTransitCompany
  	@TransitCompanyName = @Name,
	  @TransitCompanyDesc = @Desc

  SET @NumInserts = @NumInserts - 1
END
GO