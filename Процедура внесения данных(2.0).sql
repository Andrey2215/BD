use VS
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE NS
@num_ls int,
@OGV decimal(16,6),
@OHV decimal(16,6),
@ludi int
as
/*Ћокальные переменные*/
begin
SET XACT_ABORT, NOCOUNT ON

BEGIN try
	BEGIN TRANSACTION t_main
	declare @ls decimal(16,6)
	declare @TXT varchar(100)

	select @ls=kvar.num_ls from kvar
	where @num_ls=kvar.num_ls

	If @num_ls=@ls begin

	insert into VST (num_lsv,OGV,OHV,TGV,THV,NGV,NHV,Ludi,KT) 
	values (@num_ls,@OGV,@OHV,85.28,17.61,4.745,6.935,@ludi,23.95)

	set @TXT = 'ќжидание расчЄта'
	insert into LG(num_ls,Stat,d) 
	values (@num_ls,@TXT,GETDATE ( ))

	end

	select * from VST
	select * from LG

	COMMIT TRANSACTION t_main
END try
BEGIN CATCH
    if( (XACT_STATE()) = 1 )
    COMMIT TRANSACTION t_main
    else
    if( (XACT_STATE()) = -1 )
    ROLLBACK TRANSACTION t_main
END CATCH
END
--drop proc NS