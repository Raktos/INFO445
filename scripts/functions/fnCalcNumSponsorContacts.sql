CREATE FUNCTION fnCalcNumSponsorContacts (@SponsorID INT)
RETURNS INT
AS
BEGIN
	DECLARE @RET INT =
		(SELECT COUNT(SponsorContactID) FROM SPONSOR_CONTACT sc JOIN SPONSOR s ON sc.SponsorID = s.SponsorID)
	RETURN @RET
END
GO

ALTER TABLE SPONSOR
ADD NumberOfSponsorContacts AS (dbo.fnCalcNumSponsorContacts(SponsorID))
GO