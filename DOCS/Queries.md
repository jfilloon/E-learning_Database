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



2\. Which courses have fewer than three active students?



SELECT c.cid,

&#x20;      c.cname,

&#x20;      COUNT(e.eid) AS active\_students

FROM course c

JOIN enrollment e ON c.cid = e.cid

WHERE e.cstatus = 'Active'

GROUP BY c.cid, c.cname

HAVING COUNT(e.eid) < 3;

&#x20;+----------+-----------------------------------+-----------------+

| cid      | cname                             | active\_students |

+----------+-----------------------------------+-----------------+

| BIO101   | Biology Basics                    |               1 |

| ENGL220  | Creative Writing                  |               2 |

| HSCI250  | Nutrition and Wellness            |               2 |

| HIST240  | Modern American History           |               1 |

| MATH210  | Statistics                        |               1 |

| ENGI105  | Introduction to Engineering       |               2 |

| ENGI230  | Engineering Graphics              |               1 |

| ENGL101  | English Composition               |               2 |

| MATH115  | College Algebra                   |               1 |

| FINA101  | Introduction to Finance           |               1 |

| PSY101   | Introduction to Psychology        |               1 |

| GCS670   | Database Architecture             |               2 |

| GPSY650  | Clinical Assessment Techniques    |               1 |

| GENGI640 | Engineering Systems Design        |               2 |

| GFINA625 | Investment and Portfolio Analysis |               1 |

| GBIO610  | Advanced Molecular Biology        |               2 |

| GMATH605 | Applied Statistical Modeling      |               2 |

| GENGL630 | Literary Theory and Criticism     |               1 |

| GHSCI615 | Public Health Policy              |               1 |

+----------+-----------------------------------+-----------------+



3\. Which Instructor Teaches the most courses 

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

+--------+-----------+----------+---------------+

