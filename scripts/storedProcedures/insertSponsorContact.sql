alter Procedure insertSponsorContact
	@SponsorContactFName varchar(255),
	@SponsorContactLName varchar(255),
	@SponsorContactPhoneNumber varchar(255),
	@SponsorContactEmail varchar(255)
As
Begin
	Set Nocount on;
	Begin Tran t1
		declare @SponsorContactID int;
		declare @SponsorID int;

		begin
			select @SponsorContactID = ISNULL(MAX(SponsorContactID), 0) + 1
			from dbo.SPONSOR_CONTACT

			set @SponsorID = (Select top 1 SponsorID from SPONSOR_CONTACT ORDER BY NEWID());

			insert into SPONSOR_CONTACT(SponsorContactID, SponsorID, SponsorContactFName, SponsorContactLName, SponsorContactPhoneNumber, SponsorContactEmail)
			Values(@SponsorContactID, @SponsorID, @SponsorContactFName, @SponsorContactLName, @SponsorContactPhoneNumber, @SponsorContactEmail)

		end

	if @@error <> 0 
		rollback tran t1
	else
		commit tran t1
end