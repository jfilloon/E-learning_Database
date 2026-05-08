Create Database elearningdatabase;
use elearningdatabase
create table instructor (
	iid varchar(30) primary key
	, firstname varchar(50) not null,
	lastname varchar(50) not null,
	email varchar(100) unique not null,
	dept varchar(10) not null
	);
create table student (
	sid varchar(30) primary key,
	firstname varchar(50) not null,
	lastname varchar(50) not null,
	email varchar(100) unique not null,
	dob date,
	edate date not null
	);
create table course (
    cid varchar(30) primary key,
    iid varchar(30) not null,
    cname varchar(100) not null,
    cdesc text,
    credits int not null check (credits > 0),
    clevel varchar(50) not null,
    foreign key (iid) references instructor(iid)
    );
create table enrollment (
	eid varchar(30) primary key,
	sid varchar(30) not null,
	cid varchar(30) not null,
	edate date not null,
	cstatus varchar(20) not null check (cstatus in ('Active', 'Complete', 'Dropped')),
	foreign key (sid) references student(sid),
	foreign key (cid) references course(cid)
	);
create table assignment (
	aid varchar(30) primary key,
	cid varchar(30) not null,
	atitle varchar(100) not null,
	adesc text,
	duedate date not null,
	points int not null check (points > 0),
	foreign key (cid) references course(cid)
	);
     create table submission (
          subid varchar(30) primary key,
          aid varchar(30) not null,
          sid varchar(30) not null,
          subdate date not null,
          sublink text,
          foreign key (aid) references assignment(aid),
          foreign key (sid) references student(sid)
          );
create table attendance (
          attid varchar(30) primary key,
          sid varchar(30) not null,
          cid varchar(30) not null,
          cdate date not null,
          attstatus varchar(20) not null check (attstatus in ('Present', 'Absent', 'Late')),
          foreign key (sid) references student(sid),
          foreign key (cid) references course(cid)
          );
CREATE TABLE grade (
    gid VARCHAR(10) PRIMARY KEY,
    subid VARCHAR(10) UNIQUE NOT NULL,
    score INT NOT NULL,
    gletter VARCHAR(2),
    feedback TEXT,
    FOREIGN KEY (subid) REFERENCES submission(subid)
);
    
    
