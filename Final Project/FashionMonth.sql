---Creating tables and inserting data

DROP TABLE IF EXISTS ModelCredits;
DROP TABLE IF EXISTS DirectorCredits;
DROP TABLE IF EXISTS DesignerCredits;
DROP TABLE IF EXISTS FabricUses;
DROP TABLE IF EXISTS SupplierCatalog;
DROP TABLE IF EXISTS Garments;
DROP TABLE IF EXISTS FashionShows;
DROP TABLE IF EXISTS Brands;
DROP TABLE IF EXISTS Fabrics;
DROP TABLE IF EXISTS FabricSuppliers;
DROP TABLE IF EXISTS Designers;
DROP TABLE IF EXISTS Models;
DROP TABLE IF EXISTS FashionShowDirectors;

DROP TABLE IF EXISTS People;

CREATE TABLE People (
	pid			int not null   PRIMARY KEY,
	firstName	text not null,
	lastName	text not null,
	homeCity	text,
	DOB			date
	
);

CREATE TABLE Designers (
    DID int not null PRIMARY KEY REFERENCES People(PID),
    DesignyearStarted INT,
    favoriteColor text
);

CREATE TABLE FashionShowDirectors (
    SDID int not null PRIMARY KEY REFERENCES People(PID),
    DirectyearStarted int
);



CREATE TABLE Models (
    MID int not null PRIMARY KEY REFERENCES People(PID),
    ModelyearStarted int,
    favoriteColor text,
    heightInInches int
);


CREATE TABLE Brands (
    BID int not null PRIMARY KEY,
    BrandName text not null,
    YearCreated int
);

CREATE TABLE FashionShows (
    showID int not null PRIMARY KEY,
    BID int REFERENCES Brands(BID),
    date DATE ,
    city text ,
    NumberOfGarments int
	
	CONSTRAINT garments_non_negative check (NumberOfGarments >= 0)
);

CREATE TABLE DesignerCredits (
    DID int not null REFERENCES Designers(DID),
    showID int REFERENCES FashionShows(showID),
    PRIMARY KEY (DID, showID)
);

CREATE TABLE DirectorCredits (
    SDID int not null REFERENCES FashionShowDirectors(SDID),
    showID int REFERENCES FashionShows(showID),
    PRIMARY KEY (SDID, showID)
);

CREATE TABLE ModelCredits (
    MID int not null REFERENCES Models(MID),
    showID int REFERENCES FashionShows(showID),
    PRIMARY KEY (MID, showID)
);

CREATE TABLE Fabrics (
    FabricID int not null PRIMARY KEY,
    fabricName text not null,
    costUSDperYard decimal(10, 2),
    color text
);

CREATE TABLE Garments (
    garmentID int not null PRIMARY KEY,
    garmentName text not null,
	garmentPrice decimal(10, 2),
    showID int REFERENCES FashionShows(showID)
);

CREATE TABLE FabricSuppliers (
    supplierID int not null PRIMARY KEY,
    supplierName text not null,
    homeCity text 
	
);



CREATE TABLE SupplierCatalog (
    SupplierID int not null REFERENCES FabricSuppliers(supplierID),
    fabricID int not null REFERENCES Fabrics(FabricID),
    PRIMARY KEY (SupplierID,fabricID)
);

CREATE TABLE FabricUses (
    FabricID int not null REFERENCES Fabrics(FabricID),
    garmentID int not null REFERENCES Garments(garmentID),
    supplierID int not null REFERENCES FabricSuppliers(supplierID),
    PRIMARY KEY (FabricID, garmentID, supplierID)
);



INSERT INTO People (pid, firstName,    lastName,       homeCity,      DOB)
VALUES             (001, 'Shannon',    'Maier',       'New York',    '1970-05-04'),
                   (002, 'Maggie',     'Lawrence',    'Paris',      '2000-05-02'),
				   (003, 'Alan',      'Labouseur',    'Ontario',    '1968-07-17'),
				   (004,  'Cindy',      'Crawford',   'Louisville', '1969-08-18'),
				   (005,   'Virgil',    'Abloh',      'London' ,    '1989-04-23'),
				   (006,   'Christy',      'Turlington', 'New York',  '1995-03-24'),
				   (007,   'Denise',      'Smith',      'Los Angeles',  '1967-02-02'),
				   (008,   'Colin',         'Burrow',    'Charleston',    '2000-01-17'),
				   (009,   'Tucker' ,       'Angelo',     'London' ,     '2001-02-19'),
				   (010,    'Kate',        'Sandler',     'Milan',      '1990-03-03');
				   
INSERT INTO Designers (DID,   DesignYearStarted,    favoriteColor)		
VALUES                (001,       1990,        'yellow'),
					  (002,    	  2023,        'blue'),
					  (005,       2010 ,       'blue'),
					  (008,       2020,     'orange'),
					  (007,       1995,      'pink');

					   
INSERT INTO FashionShowDirectors (SDID,     DirectyearStarted)
VALUES                           (002,     2020),
								 (003,     1992),
								 (007,     1989),
								(010,      2015);
								
								 



INSERT INTO Models 	(MID,   ModelyearStarted,  favoriteColor,  heightinInches)
VALUES               (001,    1990,        'yellow',     70),
                     (004,    1987,         'blue',     71),
					 (006,    2010,       'blue',      71),
					 (008,    2020,       'orange',    76),
					 (009,    2021 ,     'pink',       75);
			
					 
INSERT INTO Brands  (BID,   BrandName,  YearCreated)
VALUES              (1000,  'Fendi',       1985),
					(1001,  'Louis Vuitton',  1950),
					(1002,  'Staud',        2005),
					(1003,  'Dior',        1953),
					(1004,  'Moschino',    1999),
					(1005,  'Coach',      1974); 	
					
INSERT INTO FashionShows (showID,   BID,    date,   city,  NumberOfGarments)
VALUES                  (3001,     1000,   '2010-09-10',  'New York',   48),
						 (3002,     1001,   '2020-09-29',  'Milan',   30),
						 (3003,     1002,   '2023-09-25',  'Paris',   33),
						 (3004,     1005,   '2010-09-16',  'New York',   32),
						 (3005,     1004,   '2021-09-10',  'London',   34),
						 (3006,     1000,   '2022-09-8',  'London',   40),
						 (3007,     1003,   '2020-09-22',  'Milan',   42),
						 (3008,     1005,   '2010-09-25',  'Paris',   27);


INSERT INTO DesignerCredits (DID,  showID)
VALUES                      (001,   3001),
							(001,   3004),
							(002,   3003),
							(005,   3002),
							(008,   3006),
							(005,   3006),
							(007,   3008),
							(007,   3007),
							(008,   3005);
							

INSERT INTO DirectorCredits (SDID,  showID)
VALUES                      (002,  3003),
							(003,   3001),
							(007,    3002),
							(002,    3007),
							(007,     3004),
							(010,      3005);
							

INSERT into ModelCredits  (MID,  showID)
VALUES                    (001, 3003),
						  (004,3007),
						  (006, 3007),
						  (008, 3003),
						  (009, 3005),
						  (004,3005),
						  (006, 3002),
						  (009, 3006);

INSERT INTO Fabrics (FabricID,  fabricName,  costUSDperYard,  color)
VALUES               (202,     'BlueSilk',      15.30,         'blue'),
					 (203,     'RedSilk',      15.30,         'red'),
					 (204,     'PinkRayon',     20.50,         'pink'),
					 (205,     'BlueMesh',     10.25,         'Blue'),
					 (206,     'OrangePolyester',     9.05,       'Orange');
 
					 
INSERT INTO GARMENTS (garmentID, garmentName,  showID, garmentPrice)
VALUES			     (303,    'Layla Top',    3001,  100.92),
					 (304,    'Sandy Pants',    3002,  300.70),
					 (305,    'Best Shoes',    3003,   700.80),
					 (306,    'Sandra Cardigan',    3003, 600.20),
					 (307,    'Layla Top',    3001,   500.30),
					 (308,    'HA Sweater',  3004,   200.50),
					 (309,    'Kendra Skirt',  3005,    350.00),
					 (310,    'Aubrey Skirt',  3006,    375.25),
					 (311,    'Pat Top',  3007,    300.00),
					 (312,    'Summer Shots',  3008,    1000.25);

INSERT INTO FabricSuppliers (SupplierID,  supplierName,   homecity)
VALUES						(701,   'Sender', 'New York'),
							(702,   'Fabrics Expert', 'Ontario'),
							(703,   'BuyHere', 'Ontario'),
							(704,   'SellerStuff',  'Charleston');

INSERT INTO SupplierCatalog (SupplierID, FabricID)
VALUES						(701,202),
							(701,203),
							(702,204),
							(703,205),
							(704,206),
							(704, 205),
							(704,203),
							(702, 203),
							(703, 206);

INSERT INTO FabricUses (FabricID, GarmentID, supplierID)
VALUES					(202,303,701),
						(203,303, 701),
						(204,304, 702),
						(205,305, 703),
						(206, 306,704),
						(204,307, 702),
						(203,308, 702),
						(203,309, 704),
						(204,310,702),
						(202, 311,701),
						(206, 312, 703);


-------RUN THE ABOVE PART OF SCRIPT FIRST AND ALONE --> BEFORE THE VIEWS ARE CREATED, AFTER VIEWS CREATED CANNOT DROP TABLES
------TO DROP VIEWS (IF NEEDED) RUN THE FOLLOWING BEFORE RERUNNING THE CREATE TABLE SCRIPTS --> CAN RECREATE VIEWS AFTER
DROP VIEW IF EXISTS MultipleJobs;
DROP VIEW IF EXISTS MostExpensiveGarmentInMilan;
DROP VIEW IF EXISTS CityShowsByYear;

---Report #1 = All models who have ever walked in a show based in Paris


select distinct p.pid, p.firstName, p.LastName
from
    People p
	inner join Models m on p.pid = m.MID
	inner join ModelCredits mc on m.MID = mc.MID
	inner join FashionShows fs on mc.showID = fs.showID
where fs.city = 'Paris';
					 

-----Report #2 = All models who walked their first show in London under the age of 21

select p.firstName,p.lastName,m.heightInInches,m.ModelyearStarted,p.DOB, 
	min(fs.date) as firstShowDate,
	extract(year from AGE(min(fs.date), p.DOB)) as ageAtFirstShow
from People p
	inner join Models m on p.pid = m.MID
	inner join ModelCredits mc on m.MID = mc.MID
	inner join FashionShows fs on mc.showID = fs.showID
where fs.city = 'London'
group by p.pid, p.firstName, p.lastName, m.heightInInches, m.ModelyearStarted, p.DOB
Having extract(year from age(min(fs.date), p.DOB)) < 21;


---Report #3 = All brands who have worked with supplier 701
select distinct b.BrandName
from Brands b
where b.BID in 
	(select distinct fs.BID
    from FashionShows fs
    	inner join Garments g on fs.showID = g.showID
    	inner join FabricUses fu on g.garmentID = fu.garmentID
    where fu.supplierID = 701);


/*View #1: View to find the people who have more than one role/job are not
just a model, designer, OR, director*/

create or replace view MultipleJobs as
select p.pid, p.firstName, p.lastName, p.homeCity, p.DOB,
       count(distinct t.job) as NumberOfJobs
from People p
	left join (
    	select DID as pid, 'Designer' AS job FROM Designers
    	union all
    	select MID as pid, 'Model' as job from Models
    	union all
    	select SDID as pid, 'Director' as job from FashionShowDirectors
		) t ON p.pid = t.pid
group by p.pid, p.firstName, p.lastName, p.homeCity, p.DOB
having count(distinct t.job) > 1;


select *
from MultipleJobs;

/* View #2 = Finding the most expensive item shown in Milan, when it was shown, and what 
brands made it */

create or replace view MostExpensiveGarmentInMilan as
select g.garmentName, g.garmentPrice,b.BrandName,fs.city AS showCity,fs.date AS showDate
from Garments g
	inner join FashionShows fs ON g.showID = fs.showID
	inner join Brands b ON fs.BID = b.BID
Where fs.city = 'Milan'
Order By g.garmentPrice DESC
Limit 1;


select * 
from MostExpensiveGarmentInMilan;

/*View #3 = A view to query the number of shows in each city divided up by years*/


create or replace view CityShowsByYear AS
select city, extract(year from date) as year,
count(*) as NumberOfShows
from FashionShows
Group by city,extract(year from date)
order by year ASC, city ASC;
	
	
select * 
from CityShowsByYear;


---Stored Procedure #1 

create or replace function getBrandsByFabricAndSupplier(text, int, REFCURSOR) returns refcursor as
$$
declare
   EnterfabricName text       := $1;
   EntersupplierId int		 := $2;
   brandName  REFCURSOR      := $3;
Begin
	open brandName for
		select distinct b.Brandname
		from Brands b
			inner join FashionShows fs ON b.BID = fs.BID
			inner join Garments g ON fs.showID = g.showID
			inner join FabricUses fu ON g.garmentID = fu.garmentID
			inner join Fabrics f ON fu.FabricID = f.FabricID
		where f.fabricName = EnterfabricName AND fu.supplierID = EntersupplierId;
	return brandName;
end;
$$
language plpgsql;

select getBrandsByFabricAndSupplier('BlueSilk', 701, 'results');
fetch all from results;
		


---Stored Procedure #2

create or replace function getAverageGarmentPrice(text, REFCURSOR) returns refcursor as
$$
declare
	enterBrandName text            := $1;
	AverageGarmentPrice REFCURSOR  := $2;
Begin
	open AverageGarmentPrice for
		select ROUND(avg(g.garmentPrice), 2) as AverageGarmentPrice
		from garments g
			inner join FashionShows fs on g.showID = fs.showID
			inner join Brands b on fs.BID = b.BID
		Where b.Brandname = enterBrandname;
	return AverageGarmentPrice;
end;
$$
language plpgsql;


select getAverageGarmentPrice('Staud', 'results');
fetch all from results;
		




---Trigger #1

create or replace function checkDirectorStartYear() returns trigger as 
$$
Begin
    If (select DirectyearStarted 
		from FashionShowDirectors 
		where SDID = new.SDID) > 
		(EXTRACT(year from (select date from FashionShows where showID = NEW.showID))) 
	then raise exception 'Director cannot work a show before their career start year.';
    end if;
    return new;
end;
$$ 

language plpgsql;

Create  trigger CheckingDirectorStartYear
Before insert or update on DirectorCredits
For each row
execute procedure CheckDirectorStartYear();

INSERT INTO DirectorCredits (SDID, showID)
Values						(002,3001);



--Trigger #2

create or replace function DiorDoesNotGo() returns trigger as 
$$
Begin
	if old.Brandname = 'Dior' or old.BID = 1003
	then raise exception 'Deletion of Dior is prohibited becuase it is just too iconic!';
	end if;
	
	return old;
end;
$$
language plpgsql;


Create trigger DiorIsntGoing
Before delete on Brands
For each row
Execute procedure DiorDoesNotGo();
		

DELETE from Brands
where BrandName = 'Dior';


---Security: Admin
Create Role Admin;
Grant all on all tables in schema public to admin;


---Security: Brand CEO
Create Role BrandCEO;
Grant select, insert on all tables in Schema Public to BrandCEO;

---Security: Fashion Planner
Create Role FashionPlanner;
Grant select on People, Designers, Models, FashionShowDirectors, Brands, Fabrics, FabricSuppliers to FashionPlanner;
Grant select, insert, update on FashionShows, Garments to FashionPlanner;
Grant select, insert on DesignerCredits, ModelCredits, DirectorCredits to FashionPlanner;


















