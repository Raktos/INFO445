ALTER PROCEDURE [dbo].[uspPopulateGroupStudent] 
	-- Add the parameters for the stored procedure here
	@numRows int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
SET NOCOUNT ON;


	DECLARE @randGroupID int;
	DECLARE @randStudentID int;

	WHILE @numRows > 0
	BEGIN
		SET @randGroupID = (SELECT TOP 1 GroupID FROM TRIPGROUP ORDER BY NEWID());
		SET @randStudentID = (SELECT TOP 1 StudentID FROM STUDENT ORDER BY NEWID());

		BEGIN TRAN t1
			INSERT INTO GROUP_STUDENT (StudentID, GroupID)
			VALUES (@randStudentID, @randGroupID);
		COMMIT TRAN t1

		SET @numRows = @numRows - 1;
	END	
END
GO