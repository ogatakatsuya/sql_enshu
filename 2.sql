select distinct lecturer.name from lecturer
join lectured_by on lectured_by.number = lecturer.number
join registration on registration.code = lectured_by.code
join (select student.number from student where student.name = 'Aomori') as e on e.number = registration.number;

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

 select f.code, f.count from 
(select code, count(*) from registration group by registration.code) as f 
where f.count = 
(select min(e.count) from (select count(*) from registration group by registration.code) as e);

 code | count 
------+-------
 C14  |     2
 C15  |     2

select student.name, e.code, e.max from student
join registration on registration.number = student.number
join
(select registration.code, max(registration.grade) from registration
group by registration.code) as e
on registration.code = e.code and registration.grade = e.max;

          title          | max 
-------------------------+-----
 Bio-Engineering Intro   |  90
 Coding Theory           |  95
 Database                |  95
 Mathematics             |  99
 Knowledge Engineering   |  95
 Computer Architecture   |  99
 Mathematical Logic      |  95
 Program Design          |  95
 Applied Mathematics     |  95
 Programming             |  99
 Computer Science Basics |  95
 Thesis Work             |  95
 Numerical Computation   |  95
 Data Science            |  95
 Mathematical Statistics |  95
(15 rows)

