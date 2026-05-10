
SELECT s.sid,
       s.firstname,
       s.lastname,
       s.major,
       c.cname,
       e.cstatus
FROM student s
JOIN enrollment e
ON s.sid = e.sid
JOIN course c
ON e.cid = c.cid
WHERE c.cname = 'Database Systems'
AND s.gradelevel = 'Undergraduate'
AND e.cstatus = 'Active';


SELECT s.sid,
       s.firstname,
       s.lastname,
       ROUND(AVG(COALESCE(g.gradepercent, 0)), 2) AS average_grade
FROM student s
LEFT JOIN submission sub
ON s.sid = sub.sid
LEFT JOIN grade g
ON sub.subid = g.subid
GROUP BY s.sid, s.firstname, s.lastname
HAVING AVG(COALESCE(g.gradepercent, 0)) < 75;


SELECT c.cid,
       c.cname,
       s.sid,
       s.firstname,
       s.lastname,
       e.cstatus
FROM course c
JOIN enrollment e
ON c.cid = e.cid
JOIN student s
ON e.sid = s.sid
WHERE e.cstatus = 'Dropped'
ORDER BY c.cname, s.lastname;


SELECT s.sid,
       s.firstname,
       s.lastname,
       c.cname,
       g.gradepercent,
       g.gletter
FROM student s
JOIN submission sub
ON s.sid = sub.sid
JOIN grade g
ON sub.subid = g.subid
JOIN assignment a
ON sub.aid = a.aid
JOIN course c
ON a.cid = c.cid
WHERE c.cid = 'GFINA625'
AND g.gletter = 'A';


SELECT a.aid,
       a.atitle,
       c.cname,
       ROUND(AVG(g.gradepercent), 2) AS average_grade
FROM assignment a
JOIN course c
ON a.cid = c.cid
JOIN submission sub
ON a.aid = sub.aid
JOIN grade g
ON sub.subid = g.subid
GROUP BY a.aid, a.atitle, c.cname
ORDER BY average_grade ASC
LIMIT 5;


SELECT s.sid,
       s.firstname,
       s.lastname,
       COUNT(e.cid) AS total_courses
FROM student s
JOIN enrollment e
ON s.sid = e.sid
WHERE s.gradelevel = 'Undergraduate'
GROUP BY s.sid, s.firstname, s.lastname
HAVING COUNT(e.cid) = 1;


SELECT DISTINCT s.sid,
       s.firstname,
       s.lastname,
       c.cname,
       a.atitle,
       g.gradepercent,
       g.gletter
FROM student s
JOIN submission sub
ON s.sid = sub.sid
JOIN grade g
ON sub.subid = g.subid
JOIN assignment a
ON sub.aid = a.aid
JOIN course c
ON a.cid = c.cid
WHERE g.gletter IN ('D', 'F')
ORDER BY s.lastname;


SELECT c.cid,
       c.cname,
       ROUND(
           (SUM(a.attstatus = 'Present') / COUNT(a.attid)) * 100,
           2
       ) AS attendance_rate
FROM course c
JOIN attendance a
ON c.cid = a.cid
GROUP BY c.cid, c.cname
ORDER BY attendance_rate ASC
LIMIT 1;


SELECT s.sid,
       s.firstname,
       s.lastname,
       c.cname,
       ROUND(AVG(g.gradepercent), 2) AS course_average
FROM student s
JOIN submission sub
ON s.sid = sub.sid
JOIN grade g
ON sub.subid = g.subid
JOIN assignment a
ON sub.aid = a.aid
JOIN course c
ON a.cid = c.cid
GROUP BY s.sid, s.firstname, s.lastname, c.cname
HAVING AVG(g.gradepercent) = 100;


SELECT c.cid,
       c.cname,
       COUNT(e.sid) AS total_students
FROM course c
JOIN enrollment e
ON c.cid = e.cid
WHERE c.clevel = 'Undergraduate'
GROUP BY c.cid, c.cname
ORDER BY total_students DESC
LIMIT 1;


SELECT s.sid,
       s.firstname,
       s.lastname,
       SUM(c.credits) AS total_credits
FROM student s
JOIN enrollment e
ON s.sid = e.sid
JOIN course c
ON e.cid = c.cid
WHERE e.cstatus = 'Active'
GROUP BY s.sid, s.firstname, s.lastname
ORDER BY total_credits DESC
LIMIT 1;



SELECT DISTINCT a.aid,
       a.atitle,
       c.cname
FROM assignment a
JOIN course c
ON a.cid = c.cid
JOIN enrollment e
ON c.cid = e.cid
LEFT JOIN submission sub
ON sub.aid = a.aid
AND sub.sid = e.sid
WHERE e.cstatus = 'Active'
AND sub.subid IS NULL
ORDER BY c.cname, a.atitle;



SELECT s.sid,
       s.firstname,
       s.lastname,
       ROUND(AVG(g.gradepercent), 2) AS average_grade
FROM student s
JOIN submission sub
ON s.sid = sub.sid
JOIN grade g
ON sub.subid = g.subid
GROUP BY s.sid, s.firstname, s.lastname
ORDER BY average_grade DESC
LIMIT 1;


SELECT s.sid,
       s.firstname,
       s.lastname,
       COUNT(a.attid) AS total_absences
FROM student s
JOIN attendance a
ON s.sid = a.sid
WHERE a.attstatus = 'Absent'
GROUP BY s.sid, s.firstname, s.lastname
ORDER BY total_absences DESC
LIMIT 1;


SELECT a.aid,
       a.atitle,
       c.cname,
       a.points
FROM assignment a
JOIN course c
ON a.cid = c.cid
WHERE a.points > 140
ORDER BY a.points ASC;


SELECT a.aid,
       a.atitle,
       c.cname,
       a.duedate
FROM assignment a
JOIN course c
ON a.cid = c.cid
ORDER BY a.duedate ASC
LIMIT 5;


SELECT i.iid,
       i.prefix,
       i.firstname,
       i.lastname,
       COUNT(e.sid) AS total_students
FROM instructor i
JOIN course c
ON i.iid = c.iid
JOIN enrollment e
ON c.cid = e.cid
GROUP BY i.iid, i.prefix, i.firstname, i.lastname
ORDER BY total_students DESC
LIMIT 1;


SELECT s.sid,
       s.firstname,
       s.lastname,
       ROUND(AVG(g.gradepercent), 2) AS average_grade,
       SUM(e.cstatus = 'Complete') AS completed_courses,
       SUM(e.cstatus = 'Active') AS active_courses
FROM student s
JOIN enrollment e
ON s.sid = e.sid
JOIN submission sub
ON s.sid = sub.sid
JOIN grade g
ON sub.subid = g.subid
GROUP BY s.sid, s.firstname, s.lastname
HAVING SUM(e.cstatus = 'Complete') > 0
AND SUM(e.cstatus = 'Active') > 0
AND AVG(g.gradepercent) > 85
ORDER BY average_grade DESC;


SELECT s.sid,
       s.firstname,
       s.lastname,
       c.cname,
       a.atitle
FROM student s
JOIN enrollment e
ON s.sid = e.sid
JOIN course c
ON e.cid = c.cid
JOIN assignment a
ON c.cid = a.cid
LEFT JOIN submission sub
ON sub.sid = s.sid
AND sub.aid = a.aid
WHERE e.cstatus = 'Active'
AND sub.subid IS NULL;


SELECT i.iid,
       i.prefix,
       i.firstname,
       i.lastname,
       COUNT(c.cid) AS total_courses
FROM instructor i
JOIN course c
ON i.iid = c.iid
GROUP BY i.iid, i.prefix, i.firstname, i.lastname
ORDER BY total_courses DESC
LIMIT 1;
