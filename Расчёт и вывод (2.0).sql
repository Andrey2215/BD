use VS
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE RS
@num_ls int
as
/*��������� ����������*/
begin
SET XACT_ABORT, NOCOUNT ON

BEGIN TRY 
	BEGIN TRANSACTION t_main
	declare @OGV decimal(16,6)
	declare @OHV decimal(16,6)
	declare @TGV decimal(16,6)
	declare @THV decimal(16,6)
	declare @TK decimal(16,6)
	declare @NGV decimal(16,6)
	declare @NHV decimal(16,6)
	declare @ludi decimal(16,6)
	declare @txt varchar (100)

	select @TGV=VST.TGV,
	@OGV=VST.OGV,
	@OHV=VST.OHV,
	@THV=VST.THV,
	@TK=VST.KT,
	@NGV=VST.NGV,
	@NHV=VST.NHV,
	@ludi=VST.Ludi
	from VST
	where @num_ls=VST.num_lsv

	if (@OGV is not null) and (@OHV is not null) begin

	select (@num_ls) as '������� ����',
	((@OGV*@TGV)+(@OHV*@THV)) as '���������� �� ��������',
	((@OGV+@OHV)*@TK) as'���������� �� �����������' 
	from VST
	where VST.num_lsv=@num_ls

	set @txt = '���������'
	insert into LG(num_ls,Nach,Stat,d) 
	values (@num_ls,((@OGV*@TGV)+(@OHV*@THV))+((@OGV+@OHV)*@TK),@TXT,GETDATE ( ))

	end
	else

	if (@OGV is not null) and (@OHV is null) 
	begin
	select (@num_ls) as '������� ����',
	(@OGV*@TGV) as '���������� �� ��������',
	(@NHV*@THV)*@ludi as '���������� �� ���������',
	((@OGV+@NHV)*@TK) as'���������� �� �����������' 
	from VST
	where VST.num_lsv=@num_ls

	set @txt = '���������'
	insert into LG(num_ls,Nach,Stat,d) 
	values (@num_ls,(@OGV*@TGV)+((@NHV*@THV)*@ludi)+((@OGV+@NHV)*@TK),@TXT,GETDATE ( ))

	end
	else

	if (@OGV is null) and (@OHV is not null) 
	begin
	select (@num_ls) as '������� ����',
	(@OHV*@THV) as '���������� �� ��������',
	(@NGV*@TGV)*@ludi as '���������� �� ���������' ,
	((@NGV+@OHV)*@TK) as'���������� �� �����������' 
	from VST
	where VST.num_lsv=@num_ls

	set @txt = '���������'
	insert into LG(num_ls,Nach,Stat,d) 
	values (@num_ls,(@OHV*@THV)+((@NGV*@TGV)*@ludi)+((@NGV+@OHV)*@TK),@TXT,GETDATE ( ))

	end
	else

	if (@OGV is null) and (@OHV is null)
	begin
	select (@num_ls) as '������� ����',
	((@NGV*@TGV)+(@NHV*@THV)) as '���������� �� ���������' ,
	(((@NGV+@NHV)*@TK)*@ludi) as'���������� �� �����������' 
	from VST
	where VST.num_lsv=@num_ls

	set @txt = '���������'
	insert into LG(num_ls,Nach,Stat,d) 
	values (@num_ls,((@NGV*@TGV)+(@NHV*@THV))+(((@NGV+@NHV)*@TK)*@ludi),@TXT,GETDATE ( ))

	end

	COMMIT TRANSACTION t_main
END TRY 
BEGIN CATCH

    if( (XACT_STATE()) = 1 )
    COMMIT TRANSACTION t_main
    else
    if( (XACT_STATE()) = -1 )
    ROLLBACK TRANSACTION t_main

END CATCH
END
--drop proc RS