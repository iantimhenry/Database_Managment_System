/*
Assignment 2

Ian Timothy Henry Suárez
47519843

COMP1350 
Introduction to Database Design and Management
*/

use schema_project;

/* ------------------------------------------------
   ------------------- SECTION A ------------------
   ------------------------------------------------*/

-- Task 1
/* In order to create the cruise table we need to create the tables route and location. 
This is because cruise has a foreign key from the table route, and route has a foreign
key from the table location*/

create table MODEL
	(ModelID varchar(5),
    ModelName varchar(10),
    ModelCapacity integer,
    primary key(ModelID)
    );
    
create table LOCATION
	(LocationCode varchar(5),
    LocationName varchar(20),
    primary key(LocationCode)
    );

create table STAFF
	(StaffID varchar(5),
    StaffName varchar(30),
    ManagerID varchar(5),
    Position varchar(15),
    StaffPay decimal(6,2),
    primary key(StaffID),
    foreign key(ManagerID) references STAFF(StaffID)
    );
    
create table VESSEL
	(VesselID varchar(5),
    VesselName varchar(20),
    VPurchaseYear integer,
    ModelID varchar(5),
    primary key(VesselID),
    foreign key(ModelID) references MODEL(ModelID)
    );
    
create table ROUTE
	(RouteID varchar(5),
    RouteDesc varchar(100),
    SourceLocationCode varchar(5),
    DesLocationCode varchar(5),
    primary key(RouteID),
    foreign key(SourceLocationCode) references LOCATION(LocationCode),
    foreign key (DesLocationCode) references LOCATION(LocationCode)
    );
    
create table CRUISE
	(CruiseID varchar(5),
    CruiseName varchar(20),
    NumOfDays integer,
    RouteID varchar(5),
    primary key(CruiseID),
    foreign key(RouteID) references ROUTE(RouteID)
    );
    
create table SCHEDULE
	(ScheduleID varchar(5),
    StartDate varchar(10),
    MaxCapacity integer,
    CruiseID varchar(5),
    primary key(ScheduleID),
    foreign key(CruiseID) references CRUISE(CruiseID)
    );   

create table BOOKING
	(VesselID varchar(5),
    CruiseID varchar(5),
    FromDate varchar(10),
    ToDate varchar(10),
    primary key(VesselID, CruiseID),
    foreign key(VesselID) references VESSEL(VesselID),
    foreign key(CruiseID) references CRUISE(CruiseID)    
    );
    
create table TOUR
	(CruiseID varchar(5),
    TourCode varchar(5),
    TourName varchar(20),
    TourCost decimal(8,2),
    TourType varchar(10),
    primary key(CruiseID, TourCode),
    foreign key(CruiseID) references CRUISE(CruiseID)
    );    

create table QUALIFICATIONS
	(StaffID varchar(5),
    SkillName varchar(20),
    primary key(StaffID, SkillName),
    foreign key(StaffID) references STAFF(StaffID)
    );

create table ROSTER
	(ScheduleID varchar(5),
    StaffID varchar(5),
    StartDateTime varchar(19),
    EndDateTime varchar(19),
    primary key(ScheduleID, StaffID),
    foreign key(ScheduleID) references SCHEDULE(ScheduleID),
    foreign key(StaffID) references STAFF(StaffID)
    );
    
insert into MODEL values('M01', 'MODEL-101', 120);
insert into MODEL values('M02', 'MODEL-102', 140);
insert into MODEL values('M03', 'MODEL-103', 135);
insert into MODEL values('M04', 'MODEL-104', 110);
insert into MODEL values('M05', 'MODEL-105', 150);
insert into MODEL values('M06', 'MODEL-200', 105);

insert into LOCATION values('L01', 'Macquarie');
insert into LOCATION values('L02', 'Newcastle');
insert into LOCATION values('L03', 'Sydney');
insert into LOCATION values('L04', 'Melbourne');
insert into LOCATION values('L05', 'Adelaide');

insert into STAFF values('S02', 'Joseph Brown', null, 'Manager', 100.00);
insert into STAFF values('S01', 'Lachlan Macquarie', 'S02', 'Pilot', 80.00);
insert into STAFF values('S03', 'James Smith', 'S02', 'Copilot', 70.00);
insert into STAFF values('S05', 'William Baker', 'S02', 'Pilot', 80.00);
insert into STAFF values('S04', 'Robert Miles', 'S05', 'Crew', 50.00);
insert into STAFF values('S06', 'Alexander Johnson', 'S01', 'Crew', 50.00);

insert into VESSEL values('V01', 'Vessel Diamond', 2010, 'M01');
insert into VESSEL values('V02', 'Vessel Queens', 2017, 'M02');
insert into VESSEL values('V03', 'Vessel Islander', 2019, 'M05');
insert into VESSEL values('V04', 'Vessel Rider', 2018, 'M03');
insert into VESSEL values('V05', 'Vessel Castle', 2015, 'M04');
insert into VESSEL values('V06', 'Vessel Ocean', 2017, 'M06');
insert into VESSEL values('V07', 'Vessel Royal', 2018, 'M06');

insert into ROUTE values('R01', 'Multiple stopover locations', 'L01', 'L01');
insert into ROUTE values('R02', 'Only from source to destination', 'L03', 'L01');
insert into ROUTE values('R03', 'Multiple stopover locations', 'L02', 'L05');
insert into ROUTE values('R04', 'Good weather', 'L03', 'L04');
insert into ROUTE values('R05', 'Impressive views', 'L04', 'L03');

insert into CRUISE values('C01', 'HiraethCruise', 10, 'R01');
insert into CRUISE values('C02', 'PrincessCruise', 15, 'R03');
insert into CRUISE values('C03', 'RoyalCruise', 9, 'R05');
insert into CRUISE values('C04', 'AustraliaCruise', 12, 'R02');
insert into CRUISE values('C05', 'CarnivalCruise', 20, 'R04');
insert into CRUISE values('C06', 'NativeCruise', 11, 'R02');
insert into CRUISE values('C07', 'PartyCruise', 19, 'R03');

insert into SCHEDULE values('SC01', '2022-09-13', 100, 'C01');
insert into SCHEDULE values('SC02', '2021-08-14', 110, 'C04');
insert into SCHEDULE values('SC03', '2020-06-28', 90, 'C02');
insert into SCHEDULE values('SC04', '2022-05-07', 95, 'C03');
insert into SCHEDULE values('SC05', '2022-10-15', 80, 'C05');
insert into SCHEDULE values('SC06', '2022-07-15', 90, 'C04');
insert into SCHEDULE values('SC07', '2022-03-20', 100, 'C02');
insert into SCHEDULE values('SC08', '2021-01-10', 90, 'C03');

insert into BOOKING values('V01', 'C01', '2022-09-13', '2022-09-23');
insert into BOOKING values('V02', 'C02', '2020-06-28', '2020-07-13');
insert into BOOKING values('V03', 'C03', '2022-05-07', '2022-05-16');
insert into BOOKING values('V04', 'C04', '2021-08-14', '2021-08-26');
insert into BOOKING values('V05', 'C05', '2022-10-15', '2022-11-04');
insert into BOOKING values('V06', 'C02', '2022-03-20', '2022-04-04');
insert into BOOKING values('V07', 'C04', '2022-07-15', '2022-07-27');
insert into BOOKING values('V07', 'C03', '2021-01-10', '2021-01-19');

insert into TOUR values('C01', 'T01', 'HiraethBusiness', 300.00, 'Business');
insert into TOUR values('C02', 'T02', 'PrincessTour', 290.00, 'Basic');
insert into TOUR values('C03', 'T03', 'RoyalBusiness', 320.00, 'Business');
insert into TOUR values('C04', 'T04', 'AustraliaBaseTour', 250.00, 'Basic');
insert into TOUR values('C05', 'T05', 'CarnivalTravel', 280.00, 'Basic');
insert into TOUR values('C06', 'T06', 'NativeBusiness', 285.00, 'Business');
insert into TOUR values('C07', 'T07', 'PartyBusiness', 260.00, 'Business');
insert into TOUR values('C01', 'T08', 'HiraethTour', 250.00, 'Basic');
insert into TOUR values('C02', 'T09', 'PrincessBusiness', 310.00, 'Business');

insert into QUALIFICATIONS values('S01', 'Swimming');
insert into QUALIFICATIONS values('S02', 'Lidership');
insert into QUALIFICATIONS values('S03', 'Communication');
insert into QUALIFICATIONS values('S04', 'First Aid');
insert into QUALIFICATIONS values('S05', 'Swimming');
insert into QUALIFICATIONS values('S02', 'Accountability');
insert into QUALIFICATIONS values('S01', 'First Aid');

insert into ROSTER values('SC01', 'S01', '2022-09-13 18:30:00', '2022-09-23 10:00:00');
insert into ROSTER values('SC02', 'S02', '2021-08-14 18:30:00', '2021-08-26 10:00:00');
insert into ROSTER values('SC03', 'S03', '2020-06-28 18:30:00', '2020-07-13 10:00:00');
insert into ROSTER values('SC04', 'S04', '2022-05-07 13:30:00', '2022-05-16 10:00:00');
insert into ROSTER values('SC05', 'S05', '2022-10-15 13:30:00', '2022-11-04 10:00:00');
insert into ROSTER values('SC06', 'S01', '2022-07-15 18:30:00', '2022-07-27 10:00:00');
insert into ROSTER values('SC07', 'S06', '2022-03-20 18:30:00', '2022-04-04 10:00:00');

-- Task 2
select TourName, TourType, concat('$',TourCost) as TourCost from TOUR
order by TourCost desc;

-- Task 3
select VesselID, FromDate, ToDate, datediff(ToDate, FromDate) as NumberOfDays from BOOKING;

-- Task 4
select v.* from VESSEL as v, MODEL as m
where m.ModelID = v.ModelID and m.ModelName = 'Model-200' and v.VPurchaseYear > 2015;

-- Task 5
select distinct v.VesselName from VESSEL as v
join BOOKING as b
using(VesselID)
where datediff(b.ToDate, b.FromDate) >= 10 and v.VPurchaseYear between 2015 and 2020;

-- Task 6
select ModelName, ModelCapacity from MODEL
where ModelID in(select ModelID from VESSEL
				where VPurchaseYear >= YEAR(now())-5);

-- Task 7
select s1.StaffName, s1.Position, s2.StaffName as ManagerName from STAFF as s1
left join STAFF as s2 on s1.ManagerID = s2.StaffID
where s1.StaffID in (select StaffID from ROSTER
					where year(date(EndDateTime)) >= YEAR(now())-5);

-- Task 8
select v.VesselName as VName, count(b.CruiseID) as CruiseNumber from BOOKING as b
join vessel as v on b.VesselID = v.VesselID
group by b.VesselID
order by CruiseNumber desc;

-- Task 9
select * from CRUISE
where CruiseID not in(select CruiseID from schedule);

-- Task 10
/*ASSUMPTION: Total cost of the cruise is the cost of the tour per day 
  multiplied by the number of days of the cruise. This is the amount 
  printed on the table. We only include in the table if the total cost 
  including the tax exceeds $3000.*/ 
  
select c.CruiseName, t.TourName, (c.NumOfDays * t.TourCost) as TotalAmount 
from TOUR as t
inner join CRUISE as c using(CruiseID)
where ((c.NumOfDays * t.TourCost)*1.1) > 3000;

-- Task 11
select s.StaffName, count(q.SkillName) as NumberOfSkills 
from STAFF as s join qualifications as q using(StaffID)
group by s.StaffName
having count(q.SkillName) > 1;

-- Task 12
select s.StaffName as Staff, max(datediff(r.EndDateTime, r.StartDateTime)) as MaxNumberOfDays, t.TourCost as TourPrice, cast(t.TourCost*1.027 as decimal(10,2)) as UpdatedTourPrice
from STAFF as s 
join ROSTER as r on s.StaffID = r.StaffID 
join SCHEDULE as sc on sc.ScheduleID = r.ScheduleID
join TOUR as t on t.CruiseID = sc.CruiseID
where t.TourType = 'Business'
group by s.StaffName ;

-- Task 13
select t.* from TOUR as t 
join CRUISE as c using(CruiseID)
where c.CruiseID in (select CruiseID from SCHEDULE
				   where month(StartDate) = 01 or year(StartDate) in (2020, 2022)) 
and t.TourCost > 250
order by t.TourCost desc;

/* ------------------------------------------------
   ------------------- SECTION B ------------------
   ------------------------------------------------*/
/*We have already created table 'Route'*/

create table SERVICEDOCK
	(ServiceDockID varchar(5),
    ServiceDockName varchar(20),
    primary key(ServiceDockID)
    );
    
create table SERVICE
	(VesselID varchar(5),
    ServiceDockID varchar(5),
    ServiceDate varchar(10),
    primary key(VesselID, ServiceDockID),
    foreign key(VesselID) references VESSEL(VesselID),
    foreign key(ServiceDockID) references SERVICEDOCK(ServiceDockID)
    );

insert into SERVICEDOCK values('SD01', 'Dock Macquarie');
insert into SERVICEDOCK values('SD02', 'Dock Sydney');
insert into SERVICEDOCK values('SD03', 'Dock Melbourne');
insert into SERVICEDOCK values('SD04', 'Dock Adelaide');
insert into SERVICEDOCK values('SD05', 'Dock Newcastle');

insert into SERVICE values('V01', 'SD01', '2019-08-01');
insert into SERVICE values('V03', 'SD03', '2018-02-15');
insert into SERVICE values('V02', 'SD05', '2020-10-21');
insert into SERVICE values('V04', 'SD02', '2021-03-12');
insert into SERVICE values('V02', 'SD03', '2022-04-07');
insert into SERVICE values('V01', 'SD04', '2020-07-17');

-- Task 14
/*ASSUMPTION: A cruise is created over a single route, and each route has a single 
source location. For this question it is assumed that a cruise can have 
multiple source locations if it is assigned to multiple tours.*/

select sd.ServiceDockName from SERVICE as s
left join SERVICEDOCK as sd on s.ServiceDockID = sd.ServiceDOckID
left join BOOKING as b on s.VesselID = b.VesselID
where b.CruiseID in (select CruiseID from TOUR
					group by CruiseID
                    having count(TourCode) > 1);

-- Task 15
select CruiseID, CruiseName, NumOfDays from CRUISE
where CruiseID in (select CruiseID from TOUR
				   where TourType = 'Basic')
and NumOfDays > 10;

/* ------------------------------------------------
   ------------------- SECTION C ------------------
   ------------------------------------------------*/

-- Task 16
select round(avg(StaffPay), 0) as AverageEarnings from STAFF
where StaffID in (select StaffID from roster
				  where month(EndDateTime) in (10, 11, 12) and year(EndDateTime) = 2022);

-- Task 17
select s.StaffName, m.StaffName as ManagerName, c.CruiseName from ROSTER as r
left join STAFF as s on r.StaffID = s.StaffID
left join STAFF as m on s.ManagerID = m.StaffID
left join SCHEDULE as sc on r.ScheduleID = sc.ScheduleID
left join CRUISE as c on sc.CruiseID = c.CruiseID
where hour(r.StartDateTime) between 12 and 15 and hour(r.EndDateTime) between 6 and 12;

/* ------------------------------------------------
   ------------------- SECTION D ------------------
   ------------------------------------------------*/

-- Task 18
select c.CruiseName, l1.LocationCode, l1.LocationName as SourceLocationName, l2.LocationCode, l2.LocationName as SourceDestinationName from CRUISE as c
join ROUTE as r on c.RouteID = r.RouteID
join LOCATION as l1 on r.SourceLocationCode = l1.LocationCode
join LOCATION as l2 on r.DesLocationCode = l2.LocationCode
where l1.LocationName = 'Sydney' or l2.LocationName = 'Sydney';

-- Task 19
with AvgPay as
(
select year(r.EndDateTime) as Year, avg(s.StaffPay) as AverageYearPay from roster as r
join STAFF as s on s.StaffID = r.StaffID
group by year(r.EndDateTime)
)
select ap.Year, ap.AverageYearPay, s.StaffName from roster as r
join STAFF as s on s.StaffID = r.StaffID
right join AvgPay as ap on ap.Year = year(r.EndDateTime)
group by year(r.EndDateTime), s.StaffID
having avg(s.StaffPay) < ap.AverageYearPay;

-- Task 20
select sd.ServiceDockName, count(s.VesselID) as CruiseCount, count(r.StaffID) as StaffCount from SERVICE as s
left join SERVICEDOCK as sd on s.ServiceDockID = sd.ServiceDockID
left join BOOKING as b on b.VesselID = s.VesselID
left join CRUISE as c on c.CruiseID = b.CruiseID
left join SCHEDULE as sc on b.FromDate = sc.StartDate
left join ROSTER as r on sc.ScheduleID = r.ScheduleID
left join STAFF as st on r.StaffID = st.StaffID
where SUBSTRING(st.StaffName, LOCATE(' ', st.StaffName) + 1, 1) != 'E'
group by s.ServiceDockID;
