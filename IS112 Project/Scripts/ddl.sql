create schema g1t9;

use g1t9;

create table service 
(sid int not null primary key,
normal boolean not null);

create table company
(sid int not null,
company varchar(20) not null,
constraint company_pk primary key(sid,company),
constraint company_fk1 foreign key(sid) references service(sid));

create table normal
(sid int not null primary key,
weekdayfreq int not null,
weekendfreq int not null,
constraint normal_fk1 foreign key(sid) references service(sid));

create table express
(sid int not null primary key,
availableweekend boolean not null,
availableph boolean not null,
constraint express_fk1 foreign key(sid) references service(sid));

create table bus
(plateno char(8) not null primary key,
fueltype varchar(10) not null,
capacity int not null);

create table driver
(did int not null primary key,
nric char(9) not null,
name varchar(50) not null,
dob date not null,
gender char(1) not null);

create table bustrip
(sid int not null,
tdate date not null,
starttime time not null,
endtime time not null,
plateno char(8) not null,
did int not null,
constraint bustrip_pk primary key(sid,tdate,starttime),
constraint bustrip_fk1 foreign key(plateno) references bus(plateno),
constraint bustrip_fk2 foreign key(did) references driver(did),
constraint bustrip_fk3 foreign key(sid) references service(sid));


create table officer
(officerid int not null primary key,
name varchar(50) not null,
yearsemp int not null);

create table cardtype
(type varchar(10) not null primary key,
discount float not null,
mintopamount int not null,
description varchar(200) not null);

create table citylink
(cardid int not null primary key,
balance float not null,
expiry date not null,
type varchar(10) not null,
oldcardid int,
constraint citylink_fk1 foreign key(type) references cardtype(type),
constraint citylink_fk2 foreign key(oldcardid) references citylink(cardid));

create table offence
(id int not null primary key,
nric char(9) not null,
time time not null,
penalty float not null,
paycard int,
sid int not null,
sdate date not null,
stime time not null,
oid int not null,
constraint offence_fk1 foreign key(paycard) references citylink(cardid),
constraint offence_fk2 foreign key(sid, sdate, stime) references bustrip(sid, tdate, starttime),
constraint offence_fk3 foreign key(oid) references officer(officerid));

create table stop
(stopid int not null primary key,
locationdes varchar(50) not null,
address varchar(50) not null);

create table stoppair
(fromstop int not null,
tostop int not null,
basefee float not null,
constraint stoppair_pk1 primary key(fromstop,tostop),
constraint stoppair_fk1 foreign key(fromstop) references stop(stopid),
constraint stoppair_fk2 foreign key(tostop) references stop(stopid));

create table stoprank
(stopid int not null,
sid int not null,
rankorder int not null,
constraint stoprank_pk1 primary key (stopid,sid),
constraint stoprank_fk1 foreign key(stopid) references stop(stopid),
constraint stoprank_fk2 foreign key (sid) references service(sid)
);

create table ride
(cardid int not null,
rdate date not null,
usephone boolean not null,
boardstop int not null,
sid int not null,
alightstop int,
boardtime time not null,
alighttime time,
constraint ride_pk primary key(cardid,rdate,boardtime),
constraint ride_fk1 foreign key(cardid) references citylink(cardid),
constraint ride_fk2 foreign key(boardstop,sid) references stoprank(stopid,sid),
constraint ride_fk3 foreign key(alightstop) references stop(stopid)
);

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\service.txt' INTO TABLE service FIELDS TERMINATED BY '\t' LINES TERMINATED BY '\r\n' IGNORE 1 LINES; 

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\company.txt' INTO TABLE company FIELDS TERMINATED BY '\t' LINES TERMINATED BY '\r\n' IGNORE 1 LINES; 

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\normal.txt' INTO TABLE normal FIELDS TERMINATED BY '\t' LINES TERMINATED BY '\r\n' IGNORE 1 LINES; 

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\express.txt' INTO TABLE express FIELDS TERMINATED BY '\t' LINES TERMINATED BY '\r\n' IGNORE 1 LINES; 

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\bus.txt' INTO TABLE bus FIELDS TERMINATED BY '\t' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\driver.txt' INTO TABLE driver FIELDS TERMINATED BY '\t' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\bustrip.txt' INTO TABLE bustrip FIELDS TERMINATED BY '\t' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\officer.txt' INTO TABLE officer FIELDS TERMINATED BY '\t' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\cardtype.txt' INTO TABLE cardtype FIELDS TERMINATED BY '\t' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\citylink.txt' INTO TABLE citylink FIELDS TERMINATED BY '\t' optionally enclosed by '"' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\offence.txt' INTO TABLE offence FIELDS TERMINATED BY '\t' optionally enclosed by '"' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\stop.txt' INTO TABLE stop FIELDS TERMINATED BY '\t' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\stoppair.txt' INTO TABLE stoppair FIELDS TERMINATED BY '\t' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\stoprank.txt' INTO TABLE stoprank FIELDS TERMINATED BY '\t' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\ride.txt' INTO TABLE ride FIELDS TERMINATED BY '\t' optionally enclosed by '"' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;
