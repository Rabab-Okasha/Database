CREATE TABLE student(
student_id INT PRIMARY KEY,
name VARCHAR(20),
major VARCHAR(20),
);

--DESCRIBE student

DROP TABLE student;

ALTER TABLE student ADD gpa DECIMAL(3, 2);

ALTER TABLE student DROP COLUMN gpa;

SELECT *from student; --Show all the table

INSERT INTO student VALUES(1, 'Jack', 'Biology');
INSERT INTO student VALUES(2, 'Kate', 'Chemistry');
INSERT INTO student VALUES(3, 'Claire', 'English');
INSERT INTO student VALUES(4, 'Jack', 'Biology');
INSERT INTO student VALUES(5, 'Mike', 'Comp. Sci');

UPDATE student 
SET major = 'Bio'
WHERE major = 'Biology';

UPDATE student 
SET major = 'Comp. Sci'
WHERE student_id = 4;


UPDATE student
SET major = 'Biochemistry'
WHERE major = 'Bio' OR major = 'Chemistry';

UPDATE student 
SET name = 'Claire' , major = 'undecided'
WHERE student_id = 1;

DELETE FROM student;

DELETE FROM student
WHERE student_id = 5;

DELETE FROM student 
WHERE name = 'Claire' AND major = 'undecided';

SELECT name FROM student;

--SELECT name, major FROM student ORDEDBY name;

SELECT name, major
FROM student
ORDER BY name DESC;

SELECT *
FROM student 
ORDER BY student_id DESC;

SELECT * 
FROM student 
ORDER BY major, student_id;

SELECT TOP 2 * 
FROM student;

SELECT * 
FROM student 
WHERE major = 'Biochemistry';

SELECT *
FROM student 
WHERE major = 'English' OR major = 'Comp. Sci';

SELECT * 
FROM student 
WHERE student_id <= 3 AND name <> 'Jack';

SELECT * 
FROM student 
WHERE name IN ('Jack','Mike', 'Claire');

SELECT * 
FROM student
WHERE major IN ('English') AND student_id > 2;