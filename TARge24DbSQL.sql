-- 1tund 26.02.25
--loome db
crEaTE database TARge24

--db valimine
use TARge24

-- db kustutamine
drop database TARge24

-- 2tund 05.03.2025

--tabeli loomine
create table Gender
(
Id int not null primary key,
Gender nvarchar(10) not null
)

--andmete sisestamine
insert into Gender (Id, Gender)
values (2, 'Male')
insert into Gender (Id, Gender)
values (1, 'Female'),
(3, 'Unknown')

--vaatame tabeli andmeid
select * from Gender

create table Person
(
Id int not null primary key,
Name nvarchar(30),
Email nvarchar(30),
GenderId int
)

--andmete sisestamine
insert into Person (Id, Name, Email, GenderId)
values (1, 'Superman', 's@s.com', 2),
(2, 'Wonderwoman', 'w@w.com', 1),
(3, 'Batman', 'b@b.com', 2),
(4, 'Aquaman', 'a@a.com', 2),
(5, 'Catwoman', 'c@c.com', 1),
(6, 'Antman', 'ant"ant.com', 2),
(8, NULL, NULL, 2)

select * from Person

--v��rv�tme �henduse loomine kahe tabeli vahel
alter table Person add constraint tblPerson_GenderId_FK
foreign key (GenderId) references Gender(Id)

--- kui sisestad uue rea andmeid ja ei ole sisestanud GenderId alla v��rtust, siis
--- see automaatselt sisestab sellele reale v��rtuse 3 e nagu meil on unknown
alter table Person
add constraint DF_Person_GenderId
default 3 for GenderId

select * from Person

insert into Person (Id, Name, Email)
values (7, 'Spiderman', 'spider@s.com')

--piirangu kustutamine
alter table Person
drop constraint DF_Person_GenderId

--lisame veeru
alter table Person
add Age nvarchar(10)

--lisame nr piirangu vanuse sisestamisel
alter table Person
add constraint CK_Person_Age check (Age > 0 and Age < 155)

-- rea kustutamine
delete from Person where Id = 8

select * from Person

--kuidas uuendada andmeid
update Person
set Age = 19
where Id = 7

select * from Person

--lisame veeru juurde
alter table Person
add City nvarchar(50)

-- k]ik, kes elavad Gothami linnas
select * from Person where City = 'Gotham'
-- k�ik, kes ei ela Gothamis
select * from Person where City != 'Gotham'
select * from Person where City <> 'Gotham'

-- n�itab teatud vanusega olevaid inimesi
select * from Person where Age = 100 or Age = 45 or Age = 19
select * from Person where Age in (100, 45, 19)

-- n�itab teatud vanusevahemikus olevaid inimesi
select * from Person where Age between 27 and 31

-- wildcard e n�itab k�ik g-t�hega linnad
select * from Person where City like 'g%'
select * from Person where City like '%g%'

--n�itab k�iki, kellel ei ole @-m�rki emailis
select * from Person where Email not like '%@%'

-- n'tiab k�iki, kellel on emailis ees ja peale @-m�rki ainult �ks t�ht
select * from Person where Email like '_@_.com'

-- k�ik, kellel nimes ei ole esimene t�ht W, A, S
select * from Person where Name Like '[^WAS]%'
select * from Person

--k�ik, kes elavad Gothamis ja New Yorkis
select * from Person where City in ('Gotham','New York')

--- k�ik, kes elavad v�lja toodud linnades ja on nooremad 
--  kui 30 a 
select * from Person where (City = 'Gotham' or City = 'New York')
and Age < 30

-- kuvab t�hestikulises j�rjekorras inimesi ja v�tab aluseks nime
select * from Person order by Name
-- kuvab vastupidises j�rjestuses
select * from Person order by Name desc

-- v�tab kolm esimest rida
select top 3 * from person

-- kolm esimest, aga tabeli j�rjestus on Age ja siis Name
select top 3 Age, Name from Person

-- 3tund 12.03.2025

--n�ita esimesed 50% tabelis
select top 50 percent * from Person

--j�rjestab vanuse j�rgi isikud
-- see p�ring ei j�rjesta numbreid �igesti kuna Age on nvarchar
select * from Person order by Age desc

--castime Age int andmet��biks ja siis j�rjestab �igesti
select * from Person order by CAST(Age as int)

-- k�ikide isikute koondvanus
select sum(cast(Age as int)) as [Total Age] from Person

--k]ige noorem isik
select min(cast(Age as int)) from Person
--k]ige vanem isik
select max(cast(Age as int)) from Person

-- n'eme konkreetsetes linnades olevate isikute koondvanust
-- enne oli Age nvarchar, aga enne p�ringut muudame selle int-ks
select City, sum(Age) as TotalAge from Person group by City

-- n��d muudame muutuja andmet��pi koodiga
alter table Person
alter column Name nvarchar(25)

--- kuvab esimeses reas v�lja toodud j�rjestuses ja kuvab Age-i TotalAge-ks
--- j�rjestab City-s olevate nimede j�rgi ja siis GenderId j�rgi
select City, GenderId, sum(Age) as TotalAge from Person
group by City, GenderId order by City

--- n�itab, et mitu rida on selles tabelis
select count(*) from Person
select * from Person

--- n�itab tulemust, et mitu inimest on GenderId v��rtusega 2 konkreetses linnas
-- veel arvutab vanuse kokku
select City, GenderId, sum(Age) as TotalAge, count(Id)as [Total Person(s)]
from Person
where GenderId = '2'
group by GenderId, City

insert into Person values
(10, 'Black Panther', 'b@b.com', 2, 34, 'New York')

--- n�itab �ra inimeste koondvanuse, kelle vanus on v�hemalt 29 a
-- kui palju neid igas linnas elab
select GenderId, City, sum(Age) as TotalAge, count(Id)
as [Total Person(s)]
from Person
group by GenderId, City having sum(Age) > 29


--loome tabelid Employees ja Department
create table Department
(
Id int primary key,
DepartmentName nvarchar(50),
Location nvarchar(50),
DepartmentHead nvarchar(50)
)

create table Employees
(
Id int primary key,
Name nvarchar(50),
Gender nvarchar(50),
Salary nvarchar(50),
DepartmentId int
)
select * from Employees


insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (1, 'Tom', 'Male', 4000, 1)
insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (2, 'Pam', 'Female', 3000, 3)
insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (3, 'John', 'Male', 3500, 1)
insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (4, 'Sam', 'Male', 4500, 2)
insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (5, 'Todd', 'Male', 2800, 2)
insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (6, 'Ben', 'Male', 7000, 1)
insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (7, 'Sara', 'Female', 4800, 3)
insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (8, 'Valarie', 'Female', 5500, 1)
insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (9, 'James', 'Male', 6500, NULL)
insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (10, 'Russell', 'Male', 8800, NULL)

insert into Department(Id, DepartmentName, Location, DepartmentHead)
values 
(1, 'IT', 'London', 'Rick'),
(2, 'Payroll', 'Delhi', 'Ron'),
(3, 'HR', 'New York', 'Christie'),
(4, 'Other Department', 'Sydney', 'Cindrella')

select * from Department
select * from Employees

--left join
select Name, Gender, Salary, DepartmentName
from Employees
left join Department
on Employees.DepartmentId = Department.Id

-- arvutab k]ikide palgad kokku
select sum(cast(Salary as int)) from Employees
-- k]ige v'iksema palgasaaja palk
select min(cast(Salary as int)) from Employees
--�he kuu palgafond linnade l�ikes
select Location, sum(cast(Salary as int)) as TotalSalary
from Employees
left join Department
on Employees.DepartmentId = Department.Id
group by Location

alter table Employees
add City nvarchar(30)

--sooline erip'ra palkade osas
select City, Gender, sum(cast(Salary as int)) as TotalSalary 
from Employees
group by City, Gender
-- sama nagu eelmine, aga linnad on t'hestikulises j'rjekorras
select City, Gender, sum(cast(Salary as int)) as TotalSalary 
from Employees
group by City, Gender
order by City

-- loeb �ra, mitu rida andmeid on tabelis,
-- * asemele v�ib panna ka muid veergude nimetusi
select count(DepartmentId) from Employees

--mitu t��tajat on soo ja linna kaupa selles tabelis
select Gender, City,
count (Id) as [Total Employee(s)]
from Employees
group by Gender, City

-- n�itab k�ik mehed linnade kaupa
select Gender, City,
count (Id) as [Total Employee(s)]
from Employees
where Gender = 'Male'
group by Gender, City

-- n�itab k�ik naised linnade kaupa
select Gender, City,
count (Id) as [Total Employee(s)]
from Employees
group by Gender, City
having Gender = 'Female'

-- kelle palk on v�hemalt �le 4000
select * from Employees where sum(cast(Salary as int)) > 4000
-- n��d �ige p�ring
select * from Employees where Salary > 4000

-- k]igil,kellel on palk �le 4000 ja arvutab need kokku ning n�itab soo kaupa
select Gender, City, sum(cast(Salary as int)) as TotalSalary, count (Id) as [Total Employee(s)]
from Employees group by Gender, City
having sum(cast(Salary as int)) > 4000

--loome tabeli, milles hakatakse automaatselt nummerdama Id-d
create table Test1
(
Id int identity(1,1),
Value nvarchar(20)
)
insert into Test1 values('X')
select * from Test1

--kustutage �ra City veerg Employees tabelist
alter table Employees
drop column City

--- inner join
-- kuvab neid, kellel on DepartmentName all olemas v��rtus
select Name, Gender, Salary, DepartmentName
from Employees
inner join Department
on Employees.DepartmentId = Department.Id

-- left join
-- kuidas saada k]ik andmed Employees tabelist k�tte
select Name, Gender, Salary, DepartmentName
from Employees
left join Department -- v�ib kasutada ka LEFT OUTER JOIN-i
on Employees.DepartmentId = Department.Id

-- right join
-- kuidas saada Deparmtentname alla uus nimetus e antud juhul Other Department
select Name, Gender, Salary, DepartmentName
from Employees
right join Department
on Employees.DepartmentId = Department.Id

-- full outer join
--- kuidas saada k�ikide tabelite v��rtused �hte p�ringusse
select Name, Gender, Salary, DepartmentName
from Employees
full outer join Department
on Employees.DepartmentId = Department.Id

--- cross join v�tab kaks allpool olevat tabelit kokku ja korrutab need omavahel l�bi
select Name, Gender, Salary, DepartmentName
from Employees
cross join Department

--p�ringu sisu e loogika
select ColumnList
from LeftTable
joinType RightTable
on JoinCondition

--- kuidas kuvada ainult need isikud, kellel on DepartmentName NULL
select Name, Gender, Salary, DepartmentName
from Employees
left join Department
on Employees.DepartmentId = Department.Id
where Employees.DepartmentId is null

-- 4 tund 19.03.2025
--teine variant
select Name, Gender, Salary, DepartmentName
from Employees
left join Department
on Employees.DepartmentId = Department.Id
where Department.Id is null

-- kuidas saame Department tabelis oleva rea, kus on NULL
select Name, Gender, Salary, DepartmentName
from Employees
right join Department
on Employees.DepartmentId = Department.Id
where Employees.DepartmentId is null

-- full join
-- m�lema tabeli mitte-kattuvate v��rtustega read kuvab v�lja
select Name, Gender, Salary, DepartmentName
from Employees
full join Department
on Employees.DepartmentId = Department.Id
where Employees.DepartmentId is null
or Department.Id is null

-- saame muuta tabeli nimetust, alguses vana tabeli nimi ja siis uus soovitud
sp_rename 'Department123' , 'Department'

--teeme left join-i, aga Employees tabeli nimetus on l�hendina: E
select E.Name as Employee, M.Name as Manager
from Employees E
left join Employees M
on E.ManagerId = M.Id

alter table Employees
add ManagerId int

--inner join
--kuvab ainult ManagerId all olevate isikute v��rtuseid
select E.Name as Employee, M.Name as Manager
from Employees E
inner join Employees M
on E.ManagerId = M.Id

--cross join
--k�ik saavad k�ikide �lemused olla
select E.Name as Employee, M.Name as Manager
from Employees E
cross join Employees M

select isnull('Asd', 'No manager') as Manager

--NULL asemel kuvab No Manager
select coalesce(NULL, 'No Manager') as Manager

--- neil kellel ei ole �lemust, siis paneb neile No Manager teksti
select E.Name as Employee, isnull(M.Name, 'No Manager') as Manager
from Employees E
left join Employees M
on E.ManagerId = M.Id

--teeme p'ringu, kus kasutame case-i
select E.Name as Employee, case when M.Name is null then 'No Manager'
else M.Name end as Manager
from Employees E
left join Employees M
on E.ManagerId = M.Id

--lisame tabelisse uued veerud
alter table Employees
add MiddleName nvarchar(30)
alter table Employees
add LastName nvarchar(30)

---muudame veeru nime
sp_rename 'Employees.Name', 'FirstName'

update Employees
set FirstName = 'Tom', MiddleName = 'Nick', LastName = 'Jones'
where Id = 1

update Employees
set FirstName = 'Pam', MiddleName = NULL, LastName = 'Anderson'
where Id = 2

update Employees
set FirstName = 'John', MiddleName = NULL, LastName = NULL
where Id = 3

update Employees
set FirstName = 'Sam', MiddleName = NULL, LastName = 'Smith'
where Id = 4

update Employees
set FirstName = NULL, MiddleName = 'Todd', LastName = 'Someone'
where Id = 5

update Employees
set FirstName = 'Ben', MiddleName = 'Ten', LastName = 'Sven'
where Id = 6

update Employees
set FirstName = 'Sara', MiddleName = NULL, LastName = 'Connor'
where Id = 7

update Employees
set FirstName = 'Valarie', MiddleName = 'Balerine', LastName = NULL
where Id = 8

update Employees
set FirstName = 'James', MiddleName = '007', LastName = 'Bond'
where Id = 9

update Employees
set FirstName = NULL, MiddleName = NULL, LastName = 'Crowe'
where Id = 10

select * from Employees

--igast reast v�tab esimesena t�idetud lahtri ja kuvab ainult seda
select Id, coalesce(FirstName, MiddleName, LastName) as Name
from Employees

--loome kaks tabelit juurde
create table IndianCustomers
(
Id int identity(1,1),
Name nvarchar(25),
Email nvarchar(25)
)

create table UKCustomers
(
Id int identity(1,1),
Name nvarchar(25),
Email nvarchar(25)
)

--sisestame tabelisse andmeid
insert into IndianCustomers (Name, Email)
values ('Raj', 'R@R.com'),
('Sam', 'S@S.com')

insert into UKCustomers (Name, Email)
values ('Ben', 'B@B.com'),
('Sam', 'S@S.com')

select * from IndianCustomers
select * from UKCustomers

--kasutame union all, n�itab k�iki ridu
select Id, Name, Email from IndianCustomers
union all
select Id, Name, Email from UkCustomers

--korduvate v��rtustega read pannakse �hte ja ei korrata
select Id, Name, Email from IndianCustomers
union
select Id, Name, Email from UKCustomers

--kasuta union all ja sorteeri nime j�rgi
select Id, Name, Email from IndianCustomers
union all
select Id, Name, Email from UkCustomers
order by Name

--- stored procedure
create procedure spGetEmployees
as begin
	select FirstName, Gender from Employees
end

-- kutsuda stored procedure esile
spGetEmployees
exec spGetEmployees
execute spGetEmployees

create proc spGetEmployeesByGenderAndDepartment
@Gender nvarchar(20),
@DepartmentId int
as begin
	select FirstName, Gender, DepartmentId from Employees where Gender = @Gender
	and DepartmentId = @DepartmentId
end

-- kutsume selle sp esile ja selle puhul tuleb sisestada parameetrid
spGetEmployeesByGenderAndDepartment 'Male', 1

--niimoodi saab sp tahetud j�rjekorrast m��da minna, kui ise paned muutujad paika
spGetEmployeesByGenderAndDepartment @DepartmentId = 1, @Gender = 'Male'

--saab sp sisu vaadata result vaates
sp_helptext spGetEmployeesByGenderAndDepartment

-- kuidas muuta sp-d ja v�ti peale panna, et keegi teine peale teie ei saaks muuta
alter proc spGetEmployeesByGenderAndDepartment
@Gender nvarchar(20),
@DepartmentId int
with encryption --paneb v�tme peale
as begin 
	select FirstName, Gender, DepartmentId from Employees where Gender = @Gender
	and DepartmentId = @DepartmentId
end

sp_helptext spGetEmployeesByGenderAndDepartment

-- sp tegemine
create proc spGetEmployeeCountByGender
@Gender nvarchar(20),
@EmployeeCount int output
as begin
	select @EmployeeCount = count(Id) from Employees where Gender = @Gender
end

--annab tulemuse, kus loendab 'ra n]uetele vastavad read
--prindib ka tulemuse kirja teel
declare @TotalCount int
execute spGetEmployeeCountByGender 'Female', @TotalCount out
if(@TotalCount = 0)
	print '@TotalCount is null'
else
	print '@Total is not null'
print @TotalCount


--- n�itab �ra, et mitu rida vastab n�uetele
declare @TotalCount int
execute spGetEmployeeCountByGender @EmployeeCount = @totalCount out, @Gender = 'Male'
print @TotalCount

--sp sisu vaatamine
sp_help spGetEmployeeCountByGender
-- tabeli info
sp_help Employees
-- kui soovid sp teksti n�ha
sp_helptext spGetEmployeeCountByGender

--millest s�ltub seesp
sp_depends spGetEmployeeCountByGender
-- vaatame tabeli s�ltuvust
sp_depends Employees

-- 
create proc spGetNameById
@Id int,
@Name nvarchar(20) output
as begin
	select @Id = Id, @Name = FirstName from Employees
end
--veateadet ei n�ita, aga tulemust ka ei ole
spGetNameById 1, 'Tom'

--t��tav variant
declare @FirstName nvarchar(20)
execute spGetNameById 1, @FirstName output
print 'Name of the employee = ' + @FirstName

-- uus sp
create proc spGetNameById1
@Id int,
@Name nvarchar(20) output
as begin
	select @Id = Id, @Name = FirstName from Employees where Id = @Id
end

declare @FirstName nvarchar(20)
execute spGetNameById1 1, @FirstName output
print 'Name of the employee = ' + @FirstName

--- 5 tund 26.03.2025

declare 
@FirstName nvarchar(20)
execute spGetNameById1 1, @FirstName out
print 'Name = ' + @FirstName

create proc spGetnameById2
@Id int 
as begin
	return (select FirstName from Employees where Id = @Id)
end

-- tuleb veateade kuna kutsusime v'lja int-i, aga Tom on string
declare @EmployeeName nvarchar(50)
execute @EmployeeName = spGetNameById2 1
print 'Name of the employee = ' + @EmployeeName

-- sisseehitatud string funktsioonid
-- see konverteerib ASCII t�he v��rtuse numbriks
select ASCII('a')
-- kuvab A-t�he
select char(65)

---prindime kogu t�hestiku v�lja
declare @Start int
set @Start = 97
while (@Start <= 122)
begin 
	select char (@Start)
	set @Start = @Start + 1
end

---eemaldame t�hjad kohad sulgudes vasakult poolt
select ltrim('             Hello')

select * from Employees

--t�hikute eemaldamine veerust
select LTRIM(FirstName) as [First Name], MiddleName, LastName from Employees

---paremalt poolt eemaldab t�hjad stringid
select rtrim('    Hello     --      ')

-- 6 tund 02.04.2025

--keerab kooloni sees olevad andmed vastupidiseks
--vastavalt upper ja lower-ga saan muuta m�rkide suurust
--reverse funktsioon p��rab k�ik �mber
select REVERSE(upper(ltrim(FirstName))) as [First Name], MiddleName, lower(LastName) as LastName,
RTRIM(LTRIM(FirstName)) + ' ' + MiddleName + ' ' + LastName as FullName
from Employees

--n�itab, et mitu t�hte on s�nal ja loeb t�hikud sisse
select FirstName, len(FirstName) as [Total Characters] from Employees
--eemaldame t[hikud ja ei loe sisse ????
select FirstName, len(ltrim(FirstName)) as [Total Characters] from Employees
select * from Employees

--left, right ja substring
--vasakult poolt neli esimest t�hte
select LEFT('ABCDEF', 4)
--paremalt poolt kolm t�hte
select RIGHT('ABCDEF', 3)

--kuvab @-t�hem�rgi asetust
select CHARINDEX('@', 'sara@aaa.com')

--esimene nr peale komakohta n�itab, et mitmendast alustab 
--ja siis mitu nr peale seda kuvada
select SUBSTRING('pam@bbb.com', 4, 4)

--- @-m�rgist kuvab kom t�hem�rki. Viimase nr saab m��rata pikkust
select substring('pam@bbb.com', CHARINDEX('@', 'pam@bbb.com') + 1, 2)

--peale @-m�rki reguleerib t�hem�rkide pikkuse n�itamist
select substring('pam@bbb.com', CHARINDEX('@', 'pam@bbb.com') + 1, 
len('pam@bbb.com') - charindex('@', 'pam@bbb.com')) 


alter table Employees
add Email nvarchar(20)

select * from Employees

update Employees set Email = 'Tom@aaa.com' where Id = 1
update Employees set Email = 'Pam@bbb.com' where Id = 2
update Employees set Email = 'John@aaa.com' where Id = 3
update Employees set Email = 'Sam@bbb.com' where Id = 4
update Employees set Email = 'Todd@bbb.com' where Id = 5
update Employees set Email = 'Ben@ccc.com' where Id = 6
update Employees set Email = 'Sara@ccc.com' where Id = 7
update Employees set Email = 'Valarie@aaa.com' where Id = 8
update Employees set Email = 'James@bbb.com' where Id = 9
update Employees set Email = 'Russel@bbb.com' where Id = 10

---tahame teada saada domeeninimed emailides
select SUBSTRING(Email, CHARINDEX('@', Email) + 1,
len(Email) - charindex('@', Email)) as EmailDomain
from Employees

--lisame *-m�rgi alates teatud kohast
select FirstName, LastName,
	SUBSTRING(Email, 1, 2) + REPLICATE('*', 5) + --peale teist t�hem�rki paneb viis t�rni
	SUBSTRING(Email, CHARINDEX('@', Email), len(Email) - CHARINDEX('@', Email)+1) as Email --kuni @-m�rgini on d�naamiline
from Employees

---kolm korda n�itab stringis olevat v��rtust
select REPLICATE('asd', 3)

-- kuidas sisestada t�hikut kahe nime vahele
select space(5)

--t�hikute arv kahe nime vahel
select FirstName + space(20) + LastName as FullName
from Employees

--PATINDEX
--sama, mis charindex, aga d�naamilisem ja saab kasutada wildcardi
select Email, PATINDEX('%@aaa.com', Email) as FirstOccurence
from Employees
where PATINDEX('%@aaa.com', Email) > 0 ---leian k�ik selle domeeni esindajad ja
-- alates mitmendast m�rgist algab @

--- k�ik .com-d asendatakse .net-ga
select Email, REPLACE(Email, '.com', '.net') as ConvertedEmail
from Employees

--soovin asendada peale esimest m�rki kolm t�hte viie t�rniga
--peate kasutama stuff-i
select FirstName, LastName, Email,
	stuff(Email, 2, 3, '*****') as StuffedEmail
from Employees

---- aja�hikute tabel
create table DateTime
(
c_time time,
c_date date,
c_smalldatetime smalldatetime,
c_datetime datetime,
c_datetime2 datetime2,
c_datetimeoffset datetimeoffset
)

select * from DateTime

---konkreetse masina kellaaeg
select GETDATE(), 'GETDATE()'

insert into DateTime
values (getdate(), getdate(), getdate(), getdate(), getdate(), getdate())

--muudame tabeli andmeid
update DateTime set c_datetimeoffset = '2025-04-02 14:06:17.0566667 +10:00'
where c_datetimeoffset = '2025-04-02 14:06:17.0566667 +00:00'

select CURRENT_TIMESTAMP, 'CURRENT TIMESTAMP' -- aja p�ring
-- leida veel kolm aja p�ringut
select SYSDATETIME(), 'SYSDATETIME' --natuke t�psem aja p�ring
select SYSDATETIMEOFFSET(), 'SYSDATETIMEOFFSET' --t�pne aeg koos ajalise nihkega UTC suhtes
select GETUTCDATE(), 'GETUTCDATE' --utc aeg

---
select isdate('asd') --tagastab 0 kuna string ei ole date
select isdate(GETDATE()) --tagastab 1 kuna on aeg
select isdate('2025-04-02 14:06:17.0566667') --tagastab 0 kuna max 3 numbrit peale koma tohib olla
select isdate('2025-04-02 14:06:17.056') --tagastab 1
select day(getdate()) -- annab t�nase p�eva nr
select day('01/31/2025')-- annab stringis oleva kp ja j�rjestus peab olema �ige
select month(getdate()) -- annab jooksva kuu arvu
select month('01/31/2025') --annab stringis oleva kuu nr
select year(getdate()) -- annab jooksva aasta arvu
select year('01/31/2025') --annab stringis oleva aasta nr

create table EmployeesWithDates
(
	Id nvarchar(2),
	Name nvarchar(20),
	DateOfBirth datetime
)

INSERT INTO EmployeesWithDates  (Id, Name, DateOfBirth)  
VALUES (1, 'Sam', '1980-12-30 00:00:00.000');
INSERT INTO EmployeesWithDates  (Id, Name, DateOfBirth)  
VALUES (2, 'Pam', '1982-09-01 12:02:36.260');
INSERT INTO EmployeesWithDates  (Id, Name, DateOfBirth)  
VALUES (3, 'John', '1985-08-22 12:03:30.370');
INSERT INTO EmployeesWithDates  (Id, Name, DateOfBirth)  
VALUES (4, 'Sara', '1979-11-29 12:59:30.670');

--- kuidas v]tta [hest veerust andmeid ja selle abil luua uued veerud
select Name, DateOfBirth, DATENAME(WEEKDAY, DateOfBirth) as [Day], --vt DoB veerust p'eva ja kuvab p'eva nimetuse s]nana
	MONTH(DateOfBirth) as MonthNumber,  -- vt DoB veerust kp-d ja kuvab kuu nr
	DATENAME(Month, DateOfBirth) as [MonthName], -- vt DoB veerust kp-d ja kuvab kuu s�nana
	Year(DateOfBirth) as [Year] -- v�tab DoB veerust aasta
from EmployeesWithDates

-- tund 7 09.04.25
select DATEPART(WEEKDAY, '2025-01-29 12:59:30.670') --n�itab nelja kuna USA n�dal algab p�hap�evast
select DATEPART(month, '2025-01-29 12:59:30.670') --n�itab kuu numbrit
select dateadd(day, 20, '2025-01-29 12:59:30.670') --liidab stringis olevale kp-le 20 p�eva juurde
select dateadd(day, -20, '2025-01-29 12:59:30.670') --lahutab 20 p�eva maha
select datediff(month, '11/30/2024', '01/30/2024') --kuvab kahe stringi vahel olevat kuudevahelist aega
select datediff(year, '11/30/2020', '01/30/2025') --kuvab kahe stringi vahel olevat aastatevahelist aega

create function fnComputeAge(@DOB datetime)
returns nvarchar(50)
as begin
	declare @tempdate datetime, @years int, @months int, @days int
		select @tempdate = @DOB

		select @years = datediff(year, @tempdate, getdate()) - case when (month(@DOB) > month(getdate())) or (month(@DOB)
		= MONTH(getdate()) and day(@DOB) > day(getdate())) then 1 else 0 end
		select @tempdate = DATEADD(year, @years, @tempdate)

		select @months = datediff(MONTH, @tempdate, getdate()) - case when day(@DOB) > day(getdate()) then 1 else 0 end
		select @tempdate = DATEADD(Month, @months, @tempdate)

		select @days = datediff(day, @tempdate, getdate())

	declare @Age nvarchar(50)
		set @Age = cast(@years as nvarchar(4)) + ' Years ' + cast(@months as nvarchar(2)) + ' Months ' + CAST(@days as nvarchar(2)) + 
		' Days old'
	return @Age
end

--saame vaadata kasutajate vanust
select Id, Name, DateOfBirth, dbo.fnComputeAge(DateOfBirth) as Age 
from EmployeesWithDates

-- kui kasutame seda funktsiooni, 
-- siis saame teada t'nase p�eva vahet stringis v�lja tooduga
select dbo.fnComputeAge('11/30/2010')

--nr peale DOB muutujat n'itab, et mismoodi kuvada DOB-d
select Id, Name, DateOfBirth,
convert(nvarchar, DateOfBirth, 126) as ConvertedDOB
from EmployeesWithDates

select Id, Name, Name + ' - ' + cast(Id as nvarchar) as [Name-Id]
from EmployeesWithDates

select cast(getdate() as date) --t�nane kp
select convert(date, getdate())  --t�nane kp

---matemaatilised funktsioonid
select ABS(-101.5) --abs on absoluutv��rtus ja miinus v�etakse �ra
select CEILING(15.2) --�mardab suurema arvu poole
select CEILING(-15.2) --tulemus on -15 ja suurendab positiivse t�isarvu suunas
select floor(15.2) --�mardab v�iksema numbri poole
select floor(-15.2)--�mardab v�iksema numbri poole e -16
select POWER(2, 4) --hakkab korrutama 2x2x2x2, esimene nr on korrutatav
select SQUARE(9) --antud juhul 9 ruudus
select sqrt(81) --annab vastuse 9, ruutjuur

select rand() --annab suvalise nr
select floor(rand() * 100) --korrutab sajaga iga suvalise nr

--iga kord n�itab 10 suvalist nr-t
declare @counter int
set @counter = 1
while (@counter <= 10)
	begin
		print floor(rand() * 1000)
		set @counter = @counter + 1
	end

select round(850.556, 2) --�mardab kaks kohta peale komat, tulemus 850.560
select round(850.556, 2, 1) --�mardab allpoole, tulemus 850.550
select round(850.556, 1) --�mardab �lespoole ja v�tab ainult esimese nr peale koma 850.600
select round(850.556, 1, 1) --�mardab allapoole
select round(850.556, -2) --�mardab t�isnr �lesse
select round(850.556, -1) --�mardab t�isnr allapoole

---
create function dbo.CalculateAge(@DOB date)
returns int
as begin
declare @Age int

set @Age = DATEDIFF(YEAR, @DOB, GETDATE()) -
	case
		when (MONTH(@DOB) > MONTH(getdate())) or
			 (MONTH(@DOB) > MONTH(GeTDatE()) and day(@DOB) > day(getdate()))
			 then 1
			 else 0
			 end
		return @Age
end

exec CalculateAge '08/14/2010'

--arvutab v�lja, kui vana on isik ja v�tab arvesse kuud ja p�evad
--antud juhul n�itab k�ike, kes on �le 36 a vanad
select Id, Name, dbo.CalculateAge(DateOfBirth) as Age from EmployeesWithDates
where dbo.CalculateAge(DateOfBirth) > 42

---inline table valued functions
alter table EmployeesWithDates
add DepartmentId int
alter table EmployeesWithDates
add Gender nvarchar(10)

select * from EmployeesWithDates

-- scalare function annab mingis vahemikus olevaid andmeid, aga 
-- inline table values ei kasuta begin ja ned funktsioone
-- scalar annab v��rtused ja inline annab tabeli

create function fn_EmployeesByGender(@Gender nvarchar(10))
returns table
as
return (select Id, Name, DateOfBirth, DepartmentId, Gender
		from EmployeesWithDates
		where Gender = @Gender)

-- k�ik female t��tajad
select * from fn_EmployeesByGender('female')

select * from fn_EmployeesByGender('female')
where Name = 'Pam'

select * from Department


select Name, Gender, DepartmentName
from fn_EmployeesByGender('male') E
join Department D on D.Id = E.DepartmentId

-- inline funktsioon
create function fn_GetEmployees()
returns table as
return (select Id, Name, cast(DateOfBirth as date)
		as DOB
		from EmployeesWithDates)

select * from fn_GetEmployees()

-- teha multi-state funktsioon
-- peab defineerima uue tabeli veerud koos muutujatega
-- Id int, Name nvarchar(20), DOB date
-- funktsiooni nimi on fn_MS_getEmployees()
create function fn_MS_GetEmployees()
returns @Table Table (Id int, Name nvarchar(20), DOB date)
as begin
	insert into @Table
	select Id, Name, cast(DateOfBirth as date) from EmployeesWithDates

	return
end

select * from fn_MS_GetEmployees()

--- inline tabeli funktsioonid on paremini t��tamas kuna k�sitletakse vaatena
--- multi puhul on pm tegemist stored proceduriga ja kulutab ressurssi rohkem

update fn_GetEmployees() set Name = 'Sam1' where Id = 1 -- saab muuta andmeid
update fn_MS_GetEmployees() set Name = 'Sam 1' where Id = 1 --ei saa muuta andmeid multistate puhul

-- deterministic ja non-deterministic
select count(*) from EmployeesWithDates
select SQUARE(3) -- k�ik tehtem�rgid on deterministic funktdsioonid,
--sinna kuuluvad veel sum, avg ja square

-- non-deterministic 
select getdate()
select CURRENT_TIMESTAMP
select rand() --see funktsioon saab olla m�lemas kategoorias, k�ik oleneb sellest
-- kas sulgudes on 1 v�i ei ole midagi

--loome funktsiooni
alter function fn_GetNameById(@id int)
returns nvarchar(30)
with encryption
as begin
	return (select Name from EmployeesWithDates where Id = @id)
end

select dbo.fn_GetNameById(1)

alter function fn_getEmployeeNameById(@Id int)
returns nvarchar(20)
with encryption
as begin
	return (select Name from EmployeesWithDates where Id = @Id)
end

sp_helptext fn_GetNameById

--muudame �levalpool olevat funktsiooni. 
--Kindlasti tabeli ette panna dbo.TabeliNimi
alter function dbo.fn_getEmployeeNameById(@Id int)
returns nvarchar(20)
with schemabinding
as begin
	return (select Name from dbo.EmployeesWithDates where Id = @Id)
end

--ei saa kustutada tabeleid ilma funktsiooni kustutamata
drop table dbo.EmployeesWithDates

--- temporary tables

--- #-m�rgi ette panemisel saame aru, et tegemist on temp tabeliga
--- seda tabelit saab ainult selles p�ringus avada
create table #PersonDetails(Id int, Name nvarchar(20))

insert into #PersonDetails values(1, 'Mike')
insert into #PersonDetails values(2, 'John')
insert into #PersonDetails values(3, 'Todd')

select * from #PersonDetails

select Name from sysobjects
where Name like '#PersonDetails%'

--- kustuta temp table
drop table #PersonDetails

create proc spCreateLocalTempTable
as begin
create table #PersonDetails(Id int, Name nvarchar(20))

insert into #PersonDetails values(1, 'Mike')
insert into #PersonDetails values(2, 'John')
insert into #PersonDetails values(3, 'Todd')

select * from #PersonDetails
end

exec spCreateLocalTempTable

--globaalse temp tabeli tegemine
create table ##PersonDetails(Id int, Name nvarchar(20))

--Erinevused lokaalse ja globaalse ajutise tabeli osas:
--1. Lokaalsed ajutised tabelid on �he # m�rgiga, 
--aga globaalsel on kaks t�kki.
--2. SQL server lisab suvalisi numbreid lokaalse ajutise tabeli nimesse, 
--aga globaalse puhul seda ei ole.
--3. Lokaalsed on n�htavad ainult selles sessioonis, 
--mis on selle loonud, aga globaalsed on n�htavad k�ikides sessioonides.
--4. Lokaalsed ajutised tabelid on automaatselt kustutatud, 
--kui selle loonud sessioon on kinni pandud, 
--aga globaalsed ajutised tabelid l�petatakse alles 
--peale viimase �henduse l�petamist.

--  8 tund 16.04.2025

--index
create table EmployeeWithSalary
(
Id int primary key,
Name nvarchar(35),
Salary int,
Gender nvarchar(10)
)

insert into EmployeeWithSalary values(1, 'Sam', 2500, 'Male')
insert into EmployeeWithSalary values(2, 'Pam', 6500, 'Female')
insert into EmployeeWithSalary values(3, 'John', 4500, 'Male')
insert into EmployeeWithSalary values(4, 'Sara', 5500, 'Female')
insert into EmployeeWithSalary values(5, 'Todd', 3100, 'Male')


--Miks indeksid?
--Indekseid kasutatakse p�ringute tegemisel, mis annavad meile kiiresti andmeid. 
--Indekseid luuakse tabelites ja vaadetes. Indeks tabelis v�i vaates on samasugune raamatu indeksile.

--Kui raamatus ei oleks indeksit ja tahaksin �les leida konkreetse peat�ki, 
--siis sa peaksid kogu raamatu l�bi vaatama. 

--Kui indeks on olemas, siis vaatad peat�ki lehek�ljenumbrit ja 
--liigud vastavale lehek�ljele.

--Raamatuindeks aitab oluliselt kiiremini �les leida vajaliku peat�ki. 
--Sama teevad ka tabeli ja vaate indeksid serveris.

--�igete indeksite eksisteerimine l�hendab oluliselt p�ringu tulemust. 
--Kui indeksit ei ole, siis p�ring teeb kogu tabeli �levaatuse 
--ja seda kutsutakse Table Scan-ks ja see on halb j�udlusele.

select * from EmployeeWithSalary
where Salary > 5000 and Salary < 7000

---loome indeksi, mis asetab palga kahanevasse j�rjestusse
create index IX_Employee_Salary
on EmployeeWithSalary (Salary asc)

select * from EmployeeWithSalary

--- indeksi kustutamine: IX_Employee_Salary
select * from EmployeeWithSalary with(index(IX_Employee_Salary))
select Name, Salary from EmployeeWithSalary with(index = IX_Employee_Salary)

-- saame teada, et mis on selle tabeli primaarv]ti ja index
exec sys.sp_helpindex @objname = 'EmployeeWithSalary'

--saame vaadata tabelit koos selle sisuga alates v�ga detailsest infost
select
	TableName = t.name,
	IndexName = ind.name,
	IndexId = ind.index_id,
	ColumnId = ic.index_column_id,
	ColumnName = col.name,
	ind.*,
	ic.*,
	col.*
from
	sys.indexes ind
inner join
	sys.index_columns ic on ind.object_id = ic.object_id and ind.index_id = ic.index_id
inner join
	sys.columns col on ic.object_id = col.object_id and ic.column_id = col.column_id
inner join
	sys.tables t on ind.object_id = t.object_id
where
	ind.is_primary_key = 0
	and ind.is_unique = 0
	and ind.is_unique_constraint = 0
	and t.is_ms_shipped = 0
order by 
	t.name, ind.name, ind.index_id, ic.is_included_column, ic.key_ordinal;

--indeski kustutamine
drop index EmployeeWithSalary.IX_Employee_Salary

---- indeksi t��bid:
--1. Klastrites olevad
--2. Mitte-klastris olevad
--3. Unikaalsed
--4. Filtreeritud
--5. XML
--6. T�istekst
--7. Ruumiline
--8. Veerus�ilitav
--9. Veergude indeksid
--10. V�lja arvatud veergudega indeksid

--klastris olev indeks m��rab �ra tabelis oleva f��silise j�rjestuse
--ja selle tulemusel saab tabelis olla ainult �ks klastris olev indeks

create table EmployeeCity
(
Id int primary key,
Name nvarchar(50),
Salary int,
Gender nvarchar(10),
City nvarchar(50)
)

exec sp_helpindex EmployeeCity

-- andmete �ige j�rjestuse loovad klastris olevad indeksid ja kasutab selleks nr-t
-- p�hjuseks Id kasutamisel tuleneb selle primaarv�tmest
insert into EmployeeCity values(3, 'John', 4500, 'Male', 'New York')
insert into EmployeeCity values(1, 'Sam', 2500, 'Male', 'London')
insert into EmployeeCity values(4, 'Sara', 5500, 'Female', 'Tokyo')
insert into EmployeeCity values(5, 'Todd', 3100, 'Male', 'Toronto')
insert into EmployeeCity values(2, 'Pam', 6500, 'Male', 'Sydney')

-- klastris olevad indeksid dikteerivad s�ilitatud andmete j�rjestuse tabelis 
-- ja seda saab klastrite puhul olla ainult �ks

select * from EmployeeCity

create clustered index IX_EmployeeCity_Name
on EmployeeCity(Name)

--- annab veateate, et tabelis saab olla ainult �ks klastris olev indeks
--- kui soovid, uut indeksit luua, siis kustuta olemasolev

--- saame luua ainult �he klastris oleva indeksi tabeli peale
--- klastris olev indeks on analoogne telefoni suunakoodile

--loome composite indeksi
--enne tuleb k�ik teised klastris olevad indeksid �ra kustutada

create clustered index IX_Employee_Gender_Salary
on EmployeeCity(Gender desc, Salary asc)

-- kui teed select p�ringu sellele tabelile, siis peaksid n�gema andmeid, 
-- mis on j�rjestatud selliselt:
-- Esimeseks v�etakse aluseks Gender veerg kahanevas j�rjestuses 
-- ja siis Salary veerg t�usvas j�rjestuses

select * from EmployeeCity

-- mitte klastris olev indeks
create nonclustered index IX_EmployeeCity_Name
on EmployeeCity(Name)
--teeme p�ringu tabelile
select * from EmployeeCity

--- erinevused kahe indeksi vahel
--- 1. ainult �ks klastris olev indeks saab olla tabeli peale, 
--- mitte-klastris olevaid indekseid saab olla mitu
--- 2. klastris olevad indeksid on kiiremad kuna indeks peab tagasi viitama tabelile
--- Juhul, kui selekteeritud veerg ei ole olemas indeksis
--- 3. Klastris olev indeks m��ratleb �ra tabeli ridade slavestusj�rjestuse
--- ja ei n�ua kettal lisa ruumi. Samas mitte klastris olevad indeksid on 
--- salvestatud tabelist eraldi ja n�uab lisa ruumi

create table EmployeeFirstName
(
	Id int primary key,
	FirstName nvarchar(50),
	LastName nvarchar(50),
	Salary int,
	Gender nvarchar(10),
	City nvarchar(50)
)

exec sp_helpindex EmployeeFirstName

-- ei saa sisestada kahte samasuguse Id v��rtusega rida
insert into EmployeeFirstName values(1, 'Mike', 'Sandoz', 4500, 'Male', 'New York')
insert into EmployeeFirstName values(1, 'John', 'Menco', 2500, 'Male', 'London')

--
drop index EmployeeFirstName.PK__Employee__3214EC07BBA3B9BA
--- kui k�ivitad �levalpool oleva koodi, siis tuleb veateade
--- et SQL server kasutab UNIQUE indeksit j�ustamaks v��rtuste unikaalsust ja primaarv�tit
--- koodiga Unikaalseid Indekseid ei saa kustutada, aga k�sitsi saab
--- minul tegi koodiga �ra

--sisestame uuesti
insert into EmployeeFirstName values(1, 'Mike', 'Sandoz', 4500, 'Male', 'New York')
insert into EmployeeFirstName values(1, 'John', 'Menco', 2500, 'Male', 'London')

--- unikaalset indeksit kasutatakse kindlustamaks v��rtuste unikaalsust (sh primaarv�ti)

create unique nonclustered index UIX_Employee_FirstName_LastName
on EmployeeFirstName(FirstName, LastName)

truncate table EmployeeFirstName

insert into EmployeeFirstName values(1, 'Mike', 'Sandoz', 4500, 'Male', 'New York')
insert into EmployeeFirstName values(2, 'John', 'Menco', 2500, 'Male', 'London')

--- lisame uue unikaalse piirangu
alter table EmployeeFirstName
add constraint UQ_EmployeeFirstName_City
unique nonclustered(City)

--ei luba tabelisse v��rtusega uut Londonit
insert into EmployeeFirstName values(3, 'John1', 'Menco1', 3000, 'Male', 'London')

---saab vaadata indeksite nimekirja
exec sp_helpconstraint EmployeeFirstName

-- 1.Vaikimisi primaarv�ti loob unikaalse klastris oleva indeksi, samas unikaalne piirang
-- loob unikaalse mitte-klastris oleva indeksi
-- 2. Unikaalset indeksit v�i piirangut ei saa luua olemasolevasse tabelisse, kui tabel 
-- juba sisaldab v��rtusi v�tmeveerus
-- 3. Vaikimisi korduvaid v��rtusied ei ole veerus lubatud,
-- kui peaks olema unikaalne indeks v�i piirang. Nt, kui tahad sisestada 10 rida andmeid,
-- millest 5 sisaldavad korduviad andmeid, siis k�ik 10 l�katakse tagasi. Kui soovin ainult 5
-- rea tagasi l�kkamist ja �lej��nud 5 rea sisestamist, siis selleks kasutatakse IGNORE_DUP_KEY


create unique index IX_EmployeeFirstName
on EmployeeFirstName(City)
with ignore_dup_key

insert into EmployeeFirstName values(3, 'John', 'Menco', 3512, 'Male', 'London')
insert into EmployeeFirstName values(4, 'John', 'Menco', 3111, 'Male', 'London1')
insert into EmployeeFirstName values(4, 'John', 'Menco', 3222, 'Male', 'London1')

select * from EmployeeFirstName
--- enne ignore k�sku oleks k�ik kolm rida tagasi l�katud, aga
--- n��d l�ks keskmine rida l�bi kuna linna nimi oli unikaalne

---view

--- view on salvestatud SQL-i p�ring. Saab k�sitleda ka virtuaalse tabelina
select FirstName, Salary, Gender, DepartmentName
from Employees
join Department
on Employees.DepartmentId = Department.Id


--loome view
create view vEmployeesByDepartment
as
select FirstName, Salary, Gender, DepartmentName
from Employees
join Department
on Employees.DepartmentId = Department.Id

-- view p�ringu esile kutsumine
select * from vEmployeesByDepartment

-- view ei salvesta andmeid vaikimisi
-- seda tasub v�tta, kui salvestatud virtuaalse tabelina

-- milleks vaja view-d:
-- saab kasutada andmebaasi skeemi keerukuse lihtsutamiseks,
-- mitte IT-inimesele
-- piiratud ligip��s andmetele, ei n�e k�iki veerge

--teeme view, kus n�eb ainult IT-t��tajaid
-- view nimi on vITEmployeesInDepartment
--kasutame tabeleid Employees ja Department
create view vITEmployeesInDepartment
as
select FirstName, Salary, Gender, DepartmentName
from Employees
join Department
on Employees.DepartmentId = Department.Id
where Department.DepartmentName = 'IT'
--�levalpool olevat p�ringut saab liigitada reataseme turvalisuse alla
--tahan ainult n�idata IT osakonna t��tajaid

select * from vITEmployeesInDepartment

--veeru taseme turvalisus
--peale selecti m��ratled veergude n�itamise �ra
alter view vEmployeesInDepartmentSalaryNoShow
as
select FirstName, Gender, DepartmentName
from Employees
join Department
on Employees.DepartmentId = Department.Id
--Salary veergu ei n�ita
select * from vEmployeesInDepartmentSalaryNoShow

---saab kasutada esitlemaks koondandmeid ja �ksikasjalike andmeid
-- view, mis tagastab summeeritud andmeid
create view vEmployeesCountByDepartment
as
select DepartmentName, count(Employees.Id) as TotalEmployees
from Employees
join Department
on Employees.DepartmentId = Department.Id
group by DepartmentName

select * from vEmployeesCountByDepartment

-- kui soovid vaadata view sisu
sp_helptext vEmployeesCountByDepartment
--muutmine
alter view vEmployeesCountByDepartment
--kustutamine
drop view vEmployeesCountByDepartment

--view uuendused
update vEmployeesDataExceptSalary
set [FirstName] =  'Tom' where Id = 2

create view vEmployeesDataExceptSalary
as
select Id, FirstName, Gender, DepartmentId
from Employees

-- kustutame ja sisestame andmeid
delete from vEmployeesDataExceptSalary where Id = 2
insert into vEmployeesDataExceptSalary (Id, Gender, DepartmentId, FirstName)
values(2, 'Female', 2, 'Pam') 

--- rida 1453
--- 9 tund
