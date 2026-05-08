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

ALTER TABLE instructor
ADD prefix VARCHAR(10) NULL;
    
ALTER TABLE student
ADD major VARCHAR(50);

UPDATE student
SET major = 'Computer Science'
WHERE sid = 'MS6632';
UPDATE student
SET major = 'Psychology'
WHERE sid = 'LE3841'
UPDATE student
SET major = CASE sid
    WHEN 'LE3841' THEN 'Biology'
    WHEN 'EM2759' THEN 'English'
    WHEN 'JP9184' THEN 'Finance'
    WHEN 'AJ4407' THEN 'Health Sciences'
    WHEN 'JF5523' THEN 'History'
    WHEN 'II7391' THEN 'Mathematics'
    WHEN 'OH2846' THEN 'Engineering'
    WHEN 'DM5178' THEN 'Psychology'
    WHEN 'EM8421' THEN 'Biology'
    WHEN 'AR3905' THEN 'English'
    WHEN 'RL6619' THEN 'Computer Science'
    WHEN 'TC2744' THEN 'History'
    WHEN 'NB7038' THEN 'Finance'
    WHEN 'SK1159' THEN 'Health Sciences'
    WHEN 'DT4820' THEN 'Engineering'
    WHEN 'HC3947' THEN 'Mathematics'
    WHEN 'LM6201' THEN 'Biology'
    WHEN 'PB1754' THEN 'Psychology'
    WHEN 'CW8336' THEN 'Computer Science'
    WHEN 'AK5298' THEN 'English'
    WHEN 'JR4106' THEN 'Finance'
    WHEN 'MG7612' THEN 'Health Sciences'
    WHEN 'EB5402' THEN 'Computer Science'
    WHEN 'NV2719' THEN 'Clinical Psychology'
    WHEN 'CM6841' THEN 'Engineering'
    WHEN 'PS3925' THEN 'Finance'
    WHEN 'BH7150' THEN 'History'
    WHEN 'SD4482' THEN 'Biology'
    WHEN 'LP8304' THEN 'Applied Mathematics'
    WHEN 'GW2647' THEN 'English'
    WHEN 'NK5913' THEN 'Public Health Sciences'
    WHEN 'IM7068' THEN 'Clinical Psychology'
    WHEN 'JP3475' THEN 'Computer Science'
    WHEN 'CB9186' THEN 'Finance'
    WHEN 'MR4521' THEN 'Engineering'
    WHEN 'EF7839' THEN 'Biology'
    WHEN 'DH6254' THEN 'Applied Mathematics'
END
WHERE sid NOT IN ('MH1027', 'MS6632')
);

ALTER TABLE student
ADD gradelevel VARCHAR(20);

UPDATE student
SET gradelevel = CASE
    WHEN sid IN (
        'EB5402', 'NV2719', 'CM6841', 'PS3925', 'BH7150',
        'SD4482', 'LP8304', 'GW2647', 'NK5913', 'IM7068',
        'JP3475', 'CB9186', 'MR4521', 'EF7839', 'DH6254'
    ) THEN 'Graduate'
    ELSE 'Undergraduate'
END;