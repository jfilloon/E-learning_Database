-- which students are missing assignments in active courses? 
SELECT s.sid,
       s.firstname,
       s.lastname,
       c.cname,
       a.atitle
FROM student s
JOIN enrollment e ON s.sid = e.sid
JOIN course c ON e.cid = c.cid
JOIN assignment a ON c.cid = a.cid
LEFT JOIN submission sub
       ON sub.sid = s.sid
      AND sub.aid = a.aid
WHERE e.cstatus = 'Active'
  AND sub.subid IS NULL;
  
  -- Which courses have fewer than three active students?

SELECT c.cid,
       c.cname,
       COUNT(e.eid) AS active_students
FROM course c
JOIN enrollment e ON c.cid = e.cid
WHERE e.cstatus = 'Active'
GROUP BY c.cid, c.cname
HAVING COUNT(e.eid) < 3;

-- Which instructor teaches the most courses?
SELECT i.iid,
       i.prefix,
       i.firstname,
       i.lastname,
       COUNT(c.cid) AS total_courses
FROM instructor i
JOIN course c ON i.iid = c.iid
GROUP BY i.iid, i.prefix, i.firstname, i.lastname
ORDER BY total_courses DESC
LIMIT 1;
-- Which students habe an average grade below 75%
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
ORDER BY average_grade DESC;
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



  
