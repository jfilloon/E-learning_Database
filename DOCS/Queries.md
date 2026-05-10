1. Which students are missing assignments in active courses? 



SELECT s.sid,

&#x20;      s.firstname,

&#x20;      s.lastname,

&#x20;      c.cname,

&#x20;      a.atitle

FROM student s

JOIN enrollment e ON s.sid = e.sid

JOIN course c ON e.cid = c.cid

JOIN assignment a ON c.cid = a.cid

LEFT JOIN submission sub

&#x20;      ON sub.sid = s.sid

&#x20;     AND sub.aid = a.aid

WHERE e.cstatus = 'Active'

&#x20; AND sub.subid IS NULL;

+--------+-----------+----------+---------------------+------------------------+

| sid    | firstname | lastname | cname               | atitle                 |

+--------+-----------+----------+---------------------+------------------------+

| DM5178 | Donna     | McIver   | Abnormal Psychology | Treatment Plan Project |

+--------+-----------+----------+---------------------+------------------------+



2\. Which Instructor Teaches the most courses 

SELECT i.iid,

&#x20;      i.prefix,

&#x20;      i.firstname,

&#x20;      i.lastname,

&#x20;      COUNT(c.cid) AS total\_courses

FROM instructor i

JOIN course c ON i.iid = c.iid

GROUP BY i.iid, i.prefix, i.firstname, i.lastname

ORDER BY total\_courses DESC

LIMIT 1;

+----------+--------+-----------+----------+---------------+

| iid      | prefix | firstname | lastname | total\_courses |

+----------+--------+-----------+----------+---------------+

| AGMAT173 | Dr.    | Astrid    | Garrett  |             2 |





3\. Which active undergraduate students are enrolled in Database Systems?

SELECT s.sid,

&#x20;      s.firstname,

&#x20;      s.lastname,

&#x20;      s.major,

&#x20;      c.cname,

&#x20;      e.cstatus

FROM student s

JOIN enrollment e ON s.sid = e.sid

JOIN course c ON e.cid = c.cid

WHERE c.cname = 'Database Systems'

&#x20; AND s.gradelevel = 'Undergraduate'

&#x20; AND e.cstatus = 'Active';



+--------+-----------+----------+------------------+------------------+---------+

| sid    | firstname | lastname | major            | cname            | cstatus |

+--------+-----------+----------+------------------+------------------+---------+

| RL6619 | Reid      | Lyon     | Computer Science | Database Systems | Active  |

| CW8336 | Connor    | White    | Computer Science | Database Systems | Active  |

| MS6632 | Marcus    | Small    | Computer Science | Database Systems | Active  |

+--------+-----------+----------+------------------+------------------+---------+

3 rows in set (0.00 sec)



4\. Which students have an average grade below 75%?

SELECT s.sid,

&#x20;   ->        s.firstname,

&#x20;   ->        s.lastname,

&#x20;   ->        ROUND(AVG(COALESCE(g.gradepercent, 0)), 2) AS average\_grade

&#x20;   -> FROM student s

&#x20;   -> LEFT JOIN submission sub

&#x20;   ->        ON s.sid = sub.sid

&#x20;   -> LEFT JOIN grade g

&#x20;   ->        ON sub.subid = g.subid

&#x20;   -> GROUP BY s.sid, s.firstname, s.lastname

&#x20;   -> HAVING AVG(COALESCE(g.gradepercent, 0)) < 75;

+--------+-----------+----------+---------------+

| sid    | firstname | lastname | average\_grade |

+--------+-----------+----------+---------------+

| CB9186 | Chloe     | Bennett  |          0.00 |

| TC2744 | Tessa     | Cole     |          0.00 |





5.Which courses have dropped students 

&#x20;SELECT c.cid,

&#x20;   ->        c.cname,

&#x20;   ->        s.sid,

&#x20;   ->        s.firstname,

&#x20;   ->        s.lastname,

&#x20;   ->        e.cstatus

&#x20;   -> FROM course c

&#x20;   -> JOIN enrollment e

&#x20;   -> ON c.cid = e.cid

&#x20;   -> JOIN student s

&#x20;   -> ON e.sid = s.sid

&#x20;   -> WHERE e.cstatus = 'Dropped'

&#x20;   -> ORDER BY c.cname, s.lastname;

+----------+-----------------------------------+--------+-----------+----------+---------+

| cid      | cname                             | sid    | firstname | lastname | cstatus |

+----------+-----------------------------------+--------+-----------+----------+---------+

| PSY101   | Introduction to Psychology        | PB1754 | Paige     | Benson   | Dropped |

| GFINA625 | Investment and Portfolio Analysis | CB9186 | Chloe     | Bennett  | Dropped |

| HIST110  | World History                     | TC2744 | Tessa     | Cole     | Dropped |

+----------+-----------------------------------+--------+-----------+----------+---------+           

6\. Which students earned an A in graduate finance courses?

SELECT s.sid,

&#x20;      s.firstname,

&#x20;      s.lastname,

&#x20;      c.cname,

&#x20;      g.gradepercent,

&#x20;      g.gletter

FROM student s

JOIN submission sub ON s.sid = sub.sid

JOIN grade g ON sub.subid = g.subid

JOIN assignment a ON sub.aid = a.aid

JOIN course c ON a.cid = c.cid

WHERE c.cid = 'GFINA625'

AND g.gletter = 'A';

+--------+-----------+----------+-----------------------------------+--------------+---------+

| sid    | firstname | lastname | cname                             | gradepercent | gletter |

+--------+-----------+----------+-----------------------------------+--------------+---------+

| PS3925 | Priya     | Shah     | Investment and Portfolio Analysis |        94.40 | A       |

+--------+-----------+----------+-----------------------------------+--------------+---------+     



7\. Which assignments have the lowest average grades?

&#x20;SELECT a.aid,

&#x20;   ->        a.atitle,

&#x20;   ->        c.cname,

&#x20;   ->        ROUND(AVG(g.gradepercent), 2) AS average\_grade

&#x20;   -> FROM assignment a

&#x20;   -> JOIN course c ON a.cid = c.cid

&#x20;   -> JOIN submission sub ON a.aid = sub.aid

&#x20;   -> JOIN grade g ON sub.subid = g.subid

&#x20;   -> GROUP BY a.aid, a.atitle, c.cname

&#x20;   -> ORDER BY average\_grade ASC

&#x20;   -> LIMIT 5;

+---------+-----------------------------+-----------------------------+---------------+

| aid     | atitle                      | cname                       | average\_grade |

+---------+-----------------------------+-----------------------------+---------------+

| ASG0098 | Historical Methods Essay    | Historical Research Methods |         71.20 |

| ASG0092 | DNA Sequencing Analysis     | Advanced Molecular Biology  |         72.00 |

| ASG0127 | Healthcare Systems Analysis | Public Health Policy        |         72.80 |

| ASG0007 | Punnett Square Practice     | Genetics                    |         74.00 |

| ASG0031 | Linear Equations Quiz       | College Algebra             |         75.00 |

+---------+-----------------------------+-----------------------------+---------------+

5 rows in set (0.00 sec)



8\. Which undergrad students are enrolled in only one course?

SELECT s.sid,

&#x20;      s.firstname,

&#x20;      s.lastname,

&#x20;      COUNT(e.cid) AS total\_courses

FROM student s

JOIN enrollment e ON s.sid = e.sid

WHERE s.gradelevel = 'Undergraduate'

GROUP BY s.sid, s.firstname, s.lastname

HAVING COUNT(e.cid) = 1;

+--------+-----------+----------+---------------+

| sid    | firstname | lastname | total\_courses |

+--------+-----------+----------+---------------+

| NB7038 | Noah      | Bennett  |             1 |

| TC2744 | Tessa     | Cole     |             1 |

+--------+-----------+----------+---------------+    





9\. Which students have received a D or F grade?

SELECT DISTINCT s.sid,

&#x20;   ->        s.firstname,

&#x20;   ->        s.lastname,

&#x20;   ->        c.cname,

&#x20;   ->        a.atitle,

&#x20;   ->        g.gradepercent,

&#x20;   ->        g.gletter

&#x20;   -> FROM student s

&#x20;   -> JOIN submission sub

&#x20;   -> ON s.sid = sub.sid

&#x20;   -> JOIN grade g

&#x20;   -> ON sub.subid = g.subid

&#x20;   -> JOIN assignment a

&#x20;   -> ON sub.aid = a.aid

&#x20;   -> JOIN course c

&#x20;   -> ON a.cid = c.cid

&#x20;   -> WHERE g.gletter IN ('D', 'F')

&#x20;   -> ORDER BY s.lastname;

+--------+-----------+----------+----------------------------+-------------------------------+--------------+---------+

| sid    | firstname | lastname | cname                      | atitle                        | gradepercent | gletter |

+--------+-----------+----------+----------------------------+-------------------------------+--------------+---------+

| HC3947 | Hannah    | Carter   | College Algebra            | Polynomial Practice           |        65.33 | D       |

| MG7612 | Mia       | Garcia   | Nutrition and Wellness     | Food Log Analysis             |        68.00 | D       |

| MH1027 | Mary      | Hampson  | Introduction to Psychology | Learning Theory Response      |        62.67 | D       |

| JR4106 | Jason     | Reed     | Financial Management       | Portfolio Analysis Assignment |        69.33 | D       |

| MS6632 | Marcus    | Small    | Database Systems           | ER Diagram Assignment         |        69.33 | D       |

| DT4820 | Daniel    | Turner   | Engineering Graphics       | Orthographic Sketches         |        69.33 | D       |

+--------+-----------+----------+----------------------------+-------------------------------+--------------+---------+





10\. Which courses have the lowest attendance rates?

&#x20;SELECT c.cid,

&#x20;   ->        c.cname,

&#x20;   ->        ROUND(

&#x20;   ->            (SUM(a.attstatus = 'Present') / COUNT(a.attid)) \* 100,

&#x20;   ->            2

&#x20;   ->        ) AS attendance\_rate

&#x20;   -> FROM course c

&#x20;   -> JOIN attendance a

&#x20;   -> ON c.cid = a.cid

&#x20;   -> GROUP BY c.cid, c.cname

&#x20;   -> ORDER BY attendance\_rate ASC

&#x20;   -> LIMIT 1;

+----------+-------------------------------+-----------------+

| cid      | cname                         | attendance\_rate |

+----------+-------------------------------+-----------------+

| GENGL630 | Literary Theory and Criticism |           50.00 |

+----------+-------------------------------+-----------------+      



11\. Which students have perfect grades in a course?

&#x20;SELECT s.sid,

&#x20;   ->        s.firstname,

&#x20;   ->        s.lastname,

&#x20;   ->        c.cname,

&#x20;   ->        ROUND(AVG(g.gradepercent), 2) AS course\_average

&#x20;   -> FROM student s

&#x20;   -> JOIN submission sub

&#x20;   -> ON s.sid = sub.sid

&#x20;   -> JOIN grade g

&#x20;   -> ON sub.subid = g.subid

&#x20;   -> JOIN assignment a

&#x20;   -> ON sub.aid = a.aid

&#x20;   -> JOIN course c

&#x20;   -> ON a.cid = c.cid

&#x20;   -> GROUP BY s.sid, s.firstname, s.lastname, c.cname

&#x20;   -> HAVING AVG(g.gradepercent) = 100;

Empty set (0.00 sec)

Means: No student has a perfect score in a course 



12\. Which undergraduate courses have the highest enrollment?

&#x20;SELECT c.cid,

&#x20;   ->        c.cname,

&#x20;   ->        COUNT(e.sid) AS total\_students

&#x20;   -> FROM course c

&#x20;   -> JOIN enrollment e

&#x20;   -> ON c.cid = e.cid

&#x20;   -> WHERE c.clevel = 'Undergraduate'

&#x20;   -> GROUP BY c.cid, c.cname

&#x20;   -> ORDER BY total\_students DESC

&#x20;   -> LIMIT 1;

+--------+----------------+----------------+

| cid    | cname          | total\_students |

+--------+----------------+----------------+

| BIO101 | Biology Basics |              3 |

+--------+----------------+----------------+

1 row in set (0.00 sec)



13\. Which student is enrolled in the most credit hours 

SELECT s.sid,

&#x20;   ->        s.firstname,

&#x20;   ->        s.lastname,

&#x20;   ->        SUM(c.credits) AS total\_credits

&#x20;   -> FROM student s

&#x20;   -> JOIN enrollment e

&#x20;   -> ON s.sid = e.sid

&#x20;   -> JOIN course c

&#x20;   -> ON e.cid = c.cid

&#x20;   -> WHERE e.cstatus = 'Active'

&#x20;   -> GROUP BY s.sid, s.firstname, s.lastname

&#x20;   -> ORDER BY total\_credits DESC

&#x20;   -> LIMIT 1;

+--------+-----------+----------+---------------+

| sid    | firstname | lastname | total\_credits |

+--------+-----------+----------+---------------+

| LE3841 | Linn      | Evensen  |             8 |

+--------+-----------+----------+---------------+

1 row in set (0.00 sec)



14\. Which assignments have missing submissions? 

SELECT DISTINCT a.aid,

&#x20;   ->        a.atitle,

&#x20;   ->        c.cname

&#x20;   -> FROM assignment a

&#x20;   -> JOIN course c

&#x20;   -> ON a.cid = c.cid

&#x20;   -> JOIN enrollment e

&#x20;   -> ON c.cid = e.cid

&#x20;   -> LEFT JOIN submission sub

&#x20;   -> ON sub.aid = a.aid

&#x20;   -> AND sub.sid = e.sid

&#x20;   -> WHERE e.cstatus = 'Active'

&#x20;   -> AND sub.subid IS NULL

&#x20;   -> ORDER BY c.cname, a.atitle;

+---------+------------------------+---------------------+

| aid     | atitle                 | cname               |

+---------+------------------------+---------------------+

| ASG0028 | Treatment Plan Project | Abnormal Psychology |

+---------+------------------------+---------------------+   



15\. Which student has the highest average grade 

SELECT s.sid,

&#x20;   ->        s.firstname,

&#x20;   ->        s.lastname,

&#x20;   ->        ROUND(AVG(g.gradepercent), 2) AS average\_grade

&#x20;   -> FROM student s

&#x20;   -> JOIN submission sub

&#x20;   -> ON s.sid = sub.sid

&#x20;   -> JOIN grade g

&#x20;   -> ON sub.subid = g.subid

&#x20;   -> GROUP BY s.sid, s.firstname, s.lastname

&#x20;   -> ORDER BY average\_grade DESC

&#x20;   -> LIMIT 1;

+--------+-----------+----------+---------------+

| sid    | firstname | lastname | average\_grade |

+--------+-----------+----------+---------------+

| AK5298 | Alyssa    | Kim      |         92.40 |

+--------+-----------+----------+---------------+   



16\. Which student has the most absences 

SELECT s.sid,

&#x20;   ->        s.firstname,

&#x20;   ->        s.lastname,

&#x20;   ->        COUNT(a.attid) AS total\_absences

&#x20;   -> FROM student s

&#x20;   -> JOIN attendance a

&#x20;   -> ON s.sid = a.sid

&#x20;   -> WHERE a.attstatus = 'Absent'

&#x20;   -> GROUP BY s.sid, s.firstname, s.lastname

&#x20;   -> ORDER BY total\_absences DESC

&#x20;   -> LIMIT 1;

+--------+-----------+----------+----------------+

| sid    | firstname | lastname | total\_absences |

+--------+-----------+----------+----------------+

| AJ4407 | Abigail   | John     |              1 |

+--------+-----------+----------+----------------+

1 row in set (0.00 sec)



17\. SELECT c.cid,

&#x20;   ->        c.cname,

&#x20;   ->        COUNT(\*) AS missing\_submissions

&#x20;   -> FROM course c

&#x20;   -> JOIN assignment a

&#x20;   -> ON c.cid = a.cid

&#x20;   -> JOIN enrollment e

&#x20;   -> ON c.cid = e.cid

&#x20;   -> LEFT JOIN submission sub

&#x20;   -> ON sub.sid = e.sid

&#x20;   -> AND sub.aid = a.aid

&#x20;   -> WHERE e.cstatus = 'Active'

&#x20;   -> AND sub.subid IS NULL

&#x20;   -> GROUP BY c.cid, c.cname

&#x20;   -> ORDER BY missing\_submissions DESC

&#x20;   -> LIMIT 1;

+--------+---------------------+---------------------+

| cid    | cname               | missing\_submissions |

+--------+---------------------+---------------------+

| PSY230 | Abnormal Psychology |                   1 |

+--------+---------------------+---------------------+  



18\. Which Assignments are due earliest in the semester

SELECT a.aid,

&#x20;   ->        a.atitle,

&#x20;   ->        c.cname,

&#x20;   ->        a.duedate

&#x20;   -> FROM assignment a

&#x20;   -> JOIN course c

&#x20;   -> ON a.cid = c.cid

&#x20;   -> ORDER BY a.duedate ASC

&#x20;   -> LIMIT 5;

+---------+-------------------------------+-----------------------------+------------+

| aid     | atitle                        | cname                       | duedate    |

+---------+-------------------------------+-----------------------------+------------+

| ASG0081 | Finance Vocabulary Quiz       | Introduction to Finance     | 2024-09-09 |

| ASG0061 | Variables and Data Types Quiz | Intro to Programming        | 2024-09-09 |

| ASG0041 | Grammar Diagnostic Quiz       | English Composition         | 2024-09-09 |

| ASG0051 | Engineering Fields Quiz       | Introduction to Engineering | 2024-09-10 |

| ASG0066 | SQL Basics Quiz               | Database Systems            | 2024-09-10 |

+---------+-------------------------------+-----------------------------+------------+  



19\. Which instructor has the most students across all courses?



SELECT i.iid,

&#x20;      i.prefix,

&#x20;      i.firstname,

&#x20;      i.lastname,

&#x20;      COUNT(e.sid) AS total\_students

FROM instructor i

JOIN course c

ON i.iid = c.iid

JOIN enrollment e

ON c.cid = e.cid

GROUP BY i.iid, i.prefix, i.firstname, i.lastname

ORDER BY total\_students DESC

LIMIT 1;

+---------+--------+-----------+----------+----------------+

| iid     | prefix | firstname | lastname | total\_students |

+---------+--------+-----------+----------+----------------+

| RJPS556 | Dr.    | Rory      | Jack     |              5 |

+---------+--------+-----------+----------+----------------+

1 row in set (0.00 sec)



20\. Which students have completed at least one course, are currently active in another course, and have an average grade above 85%?

&#x20;SELECT s.sid,

&#x20;   ->        s.firstname,

&#x20;   ->        s.lastname,

&#x20;   ->        ROUND(AVG(g.gradepercent), 2) AS average\_grade,

&#x20;   ->        SUM(e.cstatus = 'Complete') AS completed\_courses,

&#x20;   ->        SUM(e.cstatus = 'Active') AS active\_courses

&#x20;   -> FROM student s

&#x20;   -> JOIN enrollment e

&#x20;   -> ON s.sid = e.sid

&#x20;   -> JOIN submission sub

&#x20;   -> ON s.sid = sub.sid

&#x20;   -> JOIN grade g

&#x20;   -> ON sub.subid = g.subid

&#x20;   -> GROUP BY s.sid, s.firstname, s.lastname

&#x20;   -> HAVING SUM(e.cstatus = 'Complete') > 0

&#x20;   -> AND SUM(e.cstatus = 'Active') > 0

&#x20;   -> AND AVG(g.gradepercent) > 85

&#x20;   -> ORDER BY average\_grade DESC;

+--------+-----------+----------+---------------+-------------------+----------------+

| sid    | firstname | lastname | average\_grade | completed\_courses | active\_courses |

+--------+-----------+----------+---------------+-------------------+----------------+

| AK5298 | Alyssa    | Kim      |         92.40 |                10 |             10 |

| EM2759 | Ellen     | Messner  |         91.87 |                10 |             10 |

| RL6619 | Reid      | Lyon     |         90.47 |                10 |             10 |

| JF5523 | Julian    | Frank    |         89.73 |                10 |             10 |

| DM5178 | Donna     | McIver   |         89.56 |                 9 |              9 |

| JP9184 | Jorie     | Park     |         89.40 |                10 |             10 |

| II7391 | Isla      | Ingram   |         88.67 |                10 |             10 |

| CW8336 | Connor    | White    |         87.60 |                10 |             10 |

+--------+-----------+----------+---------------+-------------------+----------------+







