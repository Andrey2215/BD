--create database VS
use VS
Create Table s_land(
nzp_land int IDENTITY(1, 1), --Уникальный код страны
land varchar(30), --Наименование
land_t char(30), --Наименование на нац. языке
soato char(15), --Код СОАТО
CONSTRAINT PK_nzp_land Primary Key (nzp_land)
);

	insert into s_land (land) values ('Россия')

Create Table s_stat(
nzp_stat int IDENTITY (1, 1), --Уникальный код региона
nzp_land int, --Код страны
rajon varchar(30), --Наименование региона
rajon_t char(30), --Наименование региона на нац. языке
soato char(30), --Код СОАТО
CONSTRAINT PK_nzp_stat Primary Key (nzp_stat),
CONSTRAINT FK_nzp_land Foreign Key (nzp_land) References s_land (nzp_land) 
);

	insert into s_stat (rajon) values ('Нижегородская область')

update s_stat
set nzp_land = s_land.nzp_land from s_land


Create Table s_town(
nzp_town int IDENTITY (1, 1), --Уникальный код района
nzp_stat int, --Код региона
town varchar(30), -- Наименование района
town_t char(30), --Наименование на нац. языке
soato char(15), --Код СОАТО
CONSTRAINT PK_nzp_town Primary Key (nzp_town),
CONSTRAINT FK_nzp_stat Foreign Key (nzp_stat) References s_stat (nzp_stat)
);

	insert into s_town (town) values ('Нижний Новгород')

update s_town
set nzp_stat=s_stat.nzp_stat
from s_stat 

Create Table s_rajon(
nzp_raj int IDENTITY (1, 1), --Уникальный код Населённого пункта
nzp_town int, --Код района области (Крупного города)
rajon1 varchar(30), --Наименование населённого пункта
rajon_t char(30), --Наименование на нац. языке
soato char(15), --Код СОАТО
CONSTRAINT PK_nzp_raj Primary Key (nzp_raj),
CONSTRAINT FK_nzp_town Foreign Key (nzp_town) References s_town (nzp_town)
);

	insert into s_rajon(rajon1) values ('Нижний Новгород')
	
update s_rajon
set nzp_town=s_town.nzp_town
from s_town

Create Table s_ulica(
nzp_ul int IDENTITY (1, 1), --Уникальный код улицы
nzp_raj int, --Код населённого пункта
ulica varchar(40),--Наименование улицы
ulicareg char(40),--Тип(сокр.)
soato char(15),--Код СОАТО
CONSTRAINT PK_nzp_ul Primary Key (nzp_ul),
CONSTRAINT FK_nzp_raj Foreign Key (nzp_raj) References s_rajon (nzp_raj)
);

	insert into s_ulica (ulica) values ('Мещерский бульвар')

update s_ulica
set nzp_raj=s_rajon.nzp_raj
from s_rajon

Create Table s_rajon_dom(
nzp_raj_dom int IDENTITY (1, 1),--Уникальный код района города
rajon_dom varchar(30),--Наименование района города
alt_rajon_dom char(30),--Наименование в род. падеже
CONSTRAINT PK_nzp_raj_dom Primary Key (nzp_raj_dom)
);
	
	insert into s_rajon_dom(rajon_dom) values ('Канавинский район')

Create Table dom(
nzp_dom int IDENTITY (1, 1),--Уникальный код дома
nzp_land int,--Код страны
nzp_stat int,--Код региона
nzp_raj int,--Код районна города
nzp_ul int,--Код улицы
nzp_area int,--Код территории
nzp_geu int,--Код ЖЭУ
idom int,--Номер дома для сортировки
ndom char(10),--Номер дома
nkor char(3),--Номер корпуса
indecs char(6),--Почтовый индекс
nzp_bh int,--Резерв
kod_uch int,--Код участка
nzp_wp int,--Код локального банка
pref char(100),--Префикс локального банка
old_nzp_geu int,--Код прежнего ЖЭУ
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
nzp_kvar int IDENTITY (1,1) Not NULL, --Уникальный код квартиры
nzp_dom int, --Код дома
nkvar char(10) check (nkvar>0 and nkvar<200), --Номер квартиры
nkvar_n char(10), --Номер комнаты
num_ls int check (num_ls>99999999 and num_ls<1000000000), --Номер лицевого счёта
porch smallint, --Подъезд
phone char(10), --Телефон
fio varchar(50), --ФИО нанимателя/собственника
uch int, --Участок
typek int check (typek>=1 and typek<=3), --Тип жилья 
pkod numeric(13,0), -- Платёжный код
pkod10 integer, --Доп.платёжный код
nzp_area int, --Код территории
nzp_geu int, --Код ЖЭУ
dat_notp_s date, --Резерв
dat_not_po date, --Резерв
ikvar int, --Номер квартиры для сортировки
gil_s float, --Резерв
remark char(100),--Примечание
type_k int,--Тип жилья
pref character(10),--Префикс локального банка
is_open char(1),--Открыт/Закрыт
nzp_wp int,--Код локального банка
area_code int,--Код для работы с УК
old_nzp_geu bigint,--Код прежнего ЖЭУ
constraint nzp_kvar_pk primary key (nzp_kvar),
constraint nzp_dom_fk foreign key (nzp_dom) references dom (nzp_dom)
);

	insert into kvar(nkvar,nkvar_n,porch,phone,num_ls) values ('11','2','1','1234567890',100000000),('12','3','1','1234567832',100000001),('13','3','1','1234567832',100000002),('14','3','1','1234567832',100000003)

update kvar
set nzp_dom=dom.nzp_dom from dom

create table gilec (
nzp_gil int IDENTITY (1, 1) Not null, -- Уникальный код жильца
sogl integer check (sogl=1 or sogl=0), --признак согласия на обработку персональных данных: 1=Согласие, 0=Отказ
constraint nzp_gin_pk primary key (nzp_gil)
);


create table kart (
nzp_kart int IDENTITY (1,1) Not null, -- Уникальный код карточки
nzp_gil int, --код жильца 
isactual character(1) check (isactual=1 or isactual=0), --Признак актуальности
fam character(40), --Фамилия
ima character(40), --Имя 
otch character (40), --Отчество
dat_rog date, --Дата рождения
gender char(1) check (gender='М' or gender='Ж'), --Пол
tprp char(1) check (tprp='П' or tprp='В'), --Тип регистрации
dat_prop date, --Дата первичной регистрации
dat_oprp date, --Дата окончания временной регистрации
dat_pvu date, --Дата поставки на воен. учёт
who_pvu char(40), --Наименование органа воен.учёта
dat_svu date, --Дата снятия с воен.учёта
nzp_tkrt int check (nzp_tkrt in (1,2)), --Прибытие/убытие
nzp_kvar int, --Код квартиры
namereg char(80), --Орган регистрации
kod_namereg_prn char(7), --Код органа регистрации
nzp_nat int, --Код национальности
nzp_rod int, --Код родственного отношения
nzp_celp int, --Код цели прибывания
nzp_celu int, --Код цели убывания
nzp_dok int, --Код удостоверения личности
serij char(10), --Серия удостоверения личности
nomer char (7), --Номер удостоверения личности
vid_mes char (70), --Место удостоверения личности
vid_dat date, --Дата удостоверения личности
nzp_sud int, --Признак судимости
jobpost char(40), --Должность
jobname char (40), --Место работы
kod_podazd char(20), --Код подразделения, выдавшего удостоверение личности
dat_sost date, --Дата составления карточки
dat_ofor date, --Дата оформления карточки
ndees char(1), --Признак недееспособности
neuch char(1) check (neuch in (0,1)), --Признак неучёта в расчётах
strana_mr char(30), --Место рождения: страна
region_mr char(30), --Место рождения: область, край, республика и т.д
okrug_mr char(30), --Место рождения: район
gorod_mr char(30), --Место рождения: город
npunkt_mr char(30), --Место рождения: населённый пункт
rem_mr varchar(80), --Место рождения: любые доп.коментарии
strana_op char(30), --Откуда прибыл: Страна
region_op char(30), --Откуда прибыл: Область, край, республика и т.д
okrug_op char(30), --Откуда прибыл: район
gorod_op char(30), --Откуда прибыл: город
npunkt_op char(30), --Откуда прибыл: населённый пункт
rem_op varchar(80), --Откуда прибыл: любые доп.коментарии
strana_ku char(30), --Куда выбыл: страна
region_ku char(30), --Куда выбыл: область
okrug_ku char(30), --Куда выбыл: Район
gorod_ku char(30), --Куда выбыл: Город
npunkt_ku char(30), --Куда выбыл: Населённый пункт
rem_ku varchar(80), -- Куда выбыл: любые доп. коментарии
rodstvo char(30), -- Родство по отношению к абоненту
constraint nzp_kart_pk primary key (nzp_kart),
constraint nzp_gil_fk foreign key (nzp_gil) references gilec (nzp_gil),
constraint nzp_kvar_fk foreign key (nzp_kvar) references kvar (nzp_kvar)
); 
insert into kart(fam,ima,otch,dat_rog,gender) values('Гущин','Андрей','Сергеевич','19-04-2000','М'),('Гущин','Андрей','Сергеевич','19-04-2000','М')

update kart
set nzp_gil=gilec.nzp_gil from gilec
update kart
set nzp_kvar=kvar.nzp_kvar from kvar

create table VST (
num_lsv int,--Лицевой счёт
OGV decimal(16,6),--Объём горячей воды
OHV decimal(16,6),--Объём холодной воды
TGV decimal(16,6),--Тариф горячей воды (руб)
THV decimal(16,6),--Тариф холодной воды (руб)
NS decimal(16,6),--Начисление по счётчику
Ludi int,--Кол-во людей
NGV decimal (16,6),--Норматив горячей воды
NHV decimal (16,6),--Норматив холодной воды
NN decimal (16,6),--Начисление по нормативу
KO decimal (16,6),--Объём канализации
KT decimal (16,6),--Тариф канализации
KN decimal (16,6)--Начисление за канализацию
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
(land +' '+rajon ) as 'Место жительства',
(town + ' ' +rajon_dom+ ' ' + ulica ) as 'Город',
(ndom + ' Корпус ' +nkor) as 'Дом',
(num_ls) as 'Лицевой счёт'

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
(fam + '' + substring(ima,1,1) + '.' +substring(otch,1,1))as 'ФИО',(gender) as 'Пол', (dat_rog) as 'Дата рождения'
from kart;
*/


