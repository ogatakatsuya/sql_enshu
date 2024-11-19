SELECT DISTINCT 
    lecturer.name
FROM 
    lecturer
JOIN 
    lectured_by 
    ON lectured_by.number = lecturer.number
JOIN 
    registration 
    ON registration.code = lectured_by.code
JOIN 
    student 
    ON student.number = registration.number
WHERE 
    student.name = 'Aomori';


    name    
------------
 Eisenhower
 Johnson
 Lincoln
 Oda
 Roosevelt
 Takeda
 Tokugawa
 Toyotomi
 Uesugi
 Washington

WITH num_registration AS (
    SELECT code, COUNT(*) AS count
    FROM registration
    GROUP BY code
)
SELECT f.code, f.count
FROM num_registration AS f
WHERE f.count = (
    SELECT MIN(e.count)
    FROM num_registration AS e
);

 code | count 
------+-------
 C14  |     2
 C15  |     2

WITH max_grades_per_code AS (
    SELECT 
        code, 
        MAX(grade) AS max_grade
    FROM 
        registration
    GROUP BY 
        code
)
SELECT 
    s.name, 
    r.code, 
    r.grade AS max_grade
FROM 
    student AS s
JOIN 
    registration AS r 
    ON r.number = s.number
JOIN 
    max_grades_per_code AS mg
    ON r.code = mg.code AND r.grade = mg.max_grade;


   name   | code | max_grade 
----------+------+-----------
 Miyagi   | C01  |        99
 Yamagata | C02  |        99
 Akita    | C03  |        95
 Miyagi   | C04  |        95
 France   | C05  |        95
 Miyagi   | C06  |        95
 Yamagata | C07  |        95
 Chicago  | C08  |        99
 Yamagata | C09  |        95
 America  | C10  |        95
 Iwate    | C11  |        95
 Akita    | C12  |        95
 Aomori   | C13  |        95
 Gumma    | C14  |        95
 Gumma    | C15  |        90

SELECT 
    s.number
FROM 
    student AS s
WHERE 
    NOT EXISTS (
        SELECT 
            c.code
        FROM 
            course AS c
        WHERE 
            c.type = 'R'
            AND NOT EXISTS (
                SELECT 
                    1
                FROM 
                    registration AS r
                WHERE 
                    r.number = s.number
                    AND r.code = c.code
            )
    );

 number 
--------
 S16   
 S17   
 S18   
 S19   
 S20   