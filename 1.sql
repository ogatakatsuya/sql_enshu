select registration.code, avg(registration.grade) from registration join course on registration.code=course.code where course.credit>=3 group by registration.code;
select registration.code, avg(registration.grade) from registration join student on registration.number=student.number where student.year = 2 group by registration.code;
select registration.code, avg(registration.grade) from registration join lectured_by on registration.code=lectured_by.code join lecturer on lectured_by.number=lecturer.number where lecturer.affiliation='ICS' group by registration.code;
select student.name from student join registration on student.number=registration.number join course on registration.code=course.code where course.room is null;

--  code |         avg         
-- ------+---------------------
--  C01  | 84.5000000000000000
--  C04  | 85.0000000000000000
-- (2 rows)

--  code |         avg         
-- ------+---------------------
--  C01  | 84.0000000000000000
--  C02  | 78.0000000000000000
--  C08  | 83.2000000000000000
--  C11  | 82.0000000000000000
-- (4 rows)

--  code |         avg         
-- ------+---------------------
--  C01  | 84.5000000000000000
--  C02  | 82.2000000000000000
--  C03  | 83.4000000000000000
--  C09  | 81.1250000000000000
--  C10  | 81.1250000000000000
--  C11  | 83.8000000000000000
--  C12  | 85.0000000000000000
--  C13  | 85.0000000000000000
-- (8 rows)

--    name   
-- ----------
--  Aomori
--  Akita
--  Iwate
--  Yamagata
--  Miyagi
-- (5 rows)