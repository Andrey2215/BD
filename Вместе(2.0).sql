--create database VS
use VS
Create Table s_land(
nzp_land int IDENTITY(1, 1), --���������� ��� ������
land varchar(30), --������������
land_t char(30), --������������ �� ���. �����
soato char(15), --��� �����
CONSTRAINT PK_nzp_land Primary Key (nzp_land)
);

	insert into s_land (land) values ('������')

Create Table s_stat(
nzp_stat int IDENTITY (1, 1), --���������� ��� �������
nzp_land int, --��� ������
rajon varchar(30), --������������ �������
rajon_t char(30), --������������ ������� �� ���. �����
soato char(30), --��� �����
CONSTRAINT PK_nzp_stat Primary Key (nzp_stat),
CONSTRAINT FK_nzp_land Foreign Key (nzp_land) References s_land (nzp_land) 
);

	insert into s_stat (rajon) values ('������������� �������')

update s_stat
set nzp_land = s_land.nzp_land from s_land


Create Table s_town(
nzp_town int IDENTITY (1, 1), --���������� ��� ������
nzp_stat int, --��� �������
town varchar(30), -- ������������ ������
town_t char(30), --������������ �� ���. �����
soato char(15), --��� �����
CONSTRAINT PK_nzp_town Primary Key (nzp_town),
CONSTRAINT FK_nzp_stat Foreign Key (nzp_stat) References s_stat (nzp_stat)
);

	insert into s_town (town) values ('������ ��������')

update s_town
set nzp_stat=s_stat.nzp_stat
from s_stat 

Create Table s_rajon(
nzp_raj int IDENTITY (1, 1), --���������� ��� ���������� ������
nzp_town int, --��� ������ ������� (�������� ������)
rajon1 varchar(30), --������������ ���������� ������
rajon_t char(30), --������������ �� ���. �����
soato char(15), --��� �����
CONSTRAINT PK_nzp_raj Primary Key (nzp_raj),
CONSTRAINT FK_nzp_town Foreign Key (nzp_town) References s_town (nzp_town)
);

	insert into s_rajon(rajon1) values ('������ ��������')
	
update s_rajon
set nzp_town=s_town.nzp_town
from s_town

Create Table s_ulica(
nzp_ul int IDENTITY (1, 1), --���������� ��� �����
nzp_raj int, --��� ���������� ������
ulica varchar(40),--������������ �����
ulicareg char(40),--���(����.)
soato char(15),--��� �����
CONSTRAINT PK_nzp_ul Primary Key (nzp_ul),
CONSTRAINT FK_nzp_raj Foreign Key (nzp_raj) References s_rajon (nzp_raj)
);

	insert into s_ulica (ulica) values ('��������� �������')

update s_ulica
set nzp_raj=s_rajon.nzp_raj
from s_rajon

Create Table s_rajon_dom(
nzp_raj_dom int IDENTITY (1, 1),--���������� ��� ������ ������
rajon_dom varchar(30),--������������ ������ ������
alt_rajon_dom char(30),--������������ � ���. ������
CONSTRAINT PK_nzp_raj_dom Primary Key (nzp_raj_dom)
);
	
	insert into s_rajon_dom(rajon_dom) values ('����������� �����')

Create Table dom(
nzp_dom int IDENTITY (1, 1),--���������� ��� ����
nzp_land int,--��� ������
nzp_stat int,--��� �������
nzp_raj int,--��� ������� ������
nzp_ul int,--��� �����
nzp_area int,--��� ����������
nzp_geu int,--��� ���
idom int,--����� ���� ��� ����������
ndom char(10),--����� ����
nkor char(3),--����� �������
indecs char(6),--�������� ������
nzp_bh int,--������
kod_uch int,--��� �������
nzp_wp int,--��� ���������� �����
pref char(100),--������� ���������� �����
old_nzp_geu int,--��� �������� ���
CONSTRAINT PK_nzp_dom Primary Key (nzp_dom),
CONSTRAINT FK_nzp_ul Foreign Key (nzp_ul) References s_ulica (nzp_ul),
CONSTRAINT FK_nzp_raj1 Foreign Key (nzp_raj) References s_rajon_dom (nzp_raj_dom)
);
	
	insert into dom(ndom,nkor) values ('7','3')

Update dom
set nzp_land=s_land.nzp_land from s_land
update dom
set nzp_stat=s_stat.nzp_stat from s_stat
update dom
set nzp_raj=s_rajon.nzp_raj from s_rajon
update dom
set nzp_ul=s_ulica.nzp_ul from s_ulica

create table kvar (
nzp_kvar int IDENTITY (1,1) Not NULL, --���������� ��� ��������
nzp_dom int, --��� ����
nkvar char(10) check (nkvar>0 and nkvar<200), --����� ��������
nkvar_n char(10), --����� �������
num_ls int check (num_ls>99999999 and num_ls<1000000000), --����� �������� �����
porch smallint, --�������
phone char(10), --�������
fio varchar(50), --��� ����������/������������
uch int, --�������
typek int check (typek>=1 and typek<=3), --��� ����� 
pkod numeric(13,0), -- �������� ���
pkod10 integer, --���.�������� ���
nzp_area int, --��� ����������
nzp_geu int, --��� ���
dat_notp_s date, --������
dat_not_po date, --������
ikvar int, --����� �������� ��� ����������
gil_s float, --������
remark char(100),--����������
type_k int,--��� �����
pref character(10),--������� ���������� �����
is_open char(1),--������/������
nzp_wp int,--��� ���������� �����
area_code int,--��� ��� ������ � ��
old_nzp_geu bigint,--��� �������� ���
constraint nzp_kvar_pk primary key (nzp_kvar),
constraint nzp_dom_fk foreign key (nzp_dom) references dom (nzp_dom)
);

	insert into kvar(nkvar,nkvar_n,porch,phone,num_ls) values ('11','2','1','1234567890',100000000),('12','3','1','1234567832',100000001),('13','3','1','1234567832',100000002),('14','3','1','1234567832',100000003)

update kvar
set nzp_dom=dom.nzp_dom from dom

create table gilec (
nzp_gil int IDENTITY (1, 1) Not null, -- ���������� ��� ������
sogl integer check (sogl=1 or sogl=0), --������� �������� �� ��������� ������������ ������: 1=��������, 0=�����
constraint nzp_gin_pk primary key (nzp_gil)
);


create table kart (
nzp_kart int IDENTITY (1,1) Not null, -- ���������� ��� ��������
nzp_gil int, --��� ������ 
isactual character(1) check (isactual=1 or isactual=0), --������� ������������
fam character(40), --�������
ima character(40), --��� 
otch character (40), --��������
dat_rog date, --���� ��������
gender char(1) check (gender='�' or gender='�'), --���
tprp char(1) check (tprp='�' or tprp='�'), --��� �����������
dat_prop date, --���� ��������� �����������
dat_oprp date, --���� ��������� ��������� �����������
dat_pvu date, --���� �������� �� ����. ����
who_pvu char(40), --������������ ������ ����.�����
dat_svu date, --���� ������ � ����.�����
nzp_tkrt int check (nzp_tkrt in (1,2)), --��������/������
nzp_kvar int, --��� ��������
namereg char(80), --����� �����������
kod_namereg_prn char(7), --��� ������ �����������
nzp_nat int, --��� ��������������
nzp_rod int, --��� ������������ ���������
nzp_celp int, --��� ���� ����������
nzp_celu int, --��� ���� ��������
nzp_dok int, --��� ������������� ��������
serij char(10), --����� ������������� ��������
nomer char (7), --����� ������������� ��������
vid_mes char (70), --����� ������������� ��������
vid_dat date, --���� ������������� ��������
nzp_sud int, --������� ���������
jobpost char(40), --���������
jobname char (40), --����� ������
kod_podazd char(20), --��� �������������, ��������� ������������� ��������
dat_sost date, --���� ����������� ��������
dat_ofor date, --���� ���������� ��������
ndees char(1), --������� ����������������
neuch char(1) check (neuch in (0,1)), --������� ������� � ��������
strana_mr char(30), --����� ��������: ������
region_mr char(30), --����� ��������: �������, ����, ���������� � �.�
okrug_mr char(30), --����� ��������: �����
gorod_mr char(30), --����� ��������: �����
npunkt_mr char(30), --����� ��������: ��������� �����
rem_mr varchar(80), --����� ��������: ����� ���.����������
strana_op char(30), --������ ������: ������
region_op char(30), --������ ������: �������, ����, ���������� � �.�
okrug_op char(30), --������ ������: �����
gorod_op char(30), --������ ������: �����
npunkt_op char(30), --������ ������: ��������� �����
rem_op varchar(80), --������ ������: ����� ���.����������
strana_ku char(30), --���� �����: ������
region_ku char(30), --���� �����: �������
okrug_ku char(30), --���� �����: �����
gorod_ku char(30), --���� �����: �����
npunkt_ku char(30), --���� �����: ��������� �����
rem_ku varchar(80), -- ���� �����: ����� ���. ����������
rodstvo char(30), -- ������� �� ��������� � ��������
constraint nzp_kart_pk primary key (nzp_kart),
constraint nzp_gil_fk foreign key (nzp_gil) references gilec (nzp_gil),
constraint nzp_kvar_fk foreign key (nzp_kvar) references kvar (nzp_kvar)
); 
insert into kart(fam,ima,otch,dat_rog,gender) values('�����','������','���������','19-04-2000','�'),('�����','������','���������','19-04-2000','�')

update kart
set nzp_gil=gilec.nzp_gil from gilec
update kart
set nzp_kvar=kvar.nzp_kvar from kvar

create table VST (
num_lsv int,--������� ����
OGV decimal(16,6),--����� ������� ����
OHV decimal(16,6),--����� �������� ����
TGV decimal(16,6),--����� ������� ���� (���)
THV decimal(16,6),--����� �������� ���� (���)
NS decimal(16,6),--���������� �� ��������
Ludi int,--���-�� �����
NGV decimal (16,6),--�������� ������� ����
NHV decimal (16,6),--�������� �������� ����
NN decimal (16,6),--���������� �� ���������
KO decimal (16,6),--����� �����������
KT decimal (16,6),--����� �����������
KN decimal (16,6)--���������� �� �����������
)


create table lg(
num_ls int,
d datetime,
nach varchar(100),
stat varchar(100)
)

--drop table lg
--drop table VST


--drop database VS
--create database VS

/*
Use VS
select * from s_land
select * from s_stat
select * from s_town
select * from s_rajon
select * from s_ulica
select * from s_rajon_dom
select * from dom
select * from kvar
select * from gilec
select * from kart
select * from VST;
*/

/*
use VS
select 
(land +' '+rajon ) as '����� ����������',
(town + ' ' +rajon_dom+ ' ' + ulica ) as '�����',
(ndom + ' ������ ' +nkor) as '���',
(num_ls) as '������� ����'

from s_land as a 
join s_stat as b on a.nzp_land=b.nzp_land
join s_town as c on b.nzp_stat=c.nzp_stat
join s_rajon as d on c.nzp_town=d.nzp_town
join s_ulica as e on d.nzp_raj=e.nzp_raj
join s_rajon_dom as f on e.nzp_ul=f.nzp_raj_dom
join dom as g on e.nzp_ul=g.nzp_ul
join kvar as h on g.nzp_dom=h.nzp_dom
*/

/*
use VS
select 
(fam + '' + substring(ima,1,1) + '.' +substring(otch,1,1))as '���',(gender) as '���', (dat_rog) as '���� ��������'
from kart;
*/


