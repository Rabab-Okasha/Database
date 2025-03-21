CREATE TABLE employee(
emp_id INT PRIMARY KEY,
first_name VARCHAR(40),
last_name VARCHAR(40),
birth_day DATE,
sex VARCHAR(1),
salary INT,
super_id INT NULL,
branch_id INT,
);

CREATE TABLE branch(
branch_id INT PRIMARY KEY, 
branch_name VARCHAR(40),
mgr_id INT,
mgr_start_date DATE,
FOREIGN KEY(mgr_id) REFERENCES employee(emp_id) ON DELETE SET NULL,
);

ALTER TABLE employee
ADD FOREIGN KEY(branch_id)
REFERENCES branch(branch_id)
ON DELETE SET NULL

ALTER TABLE employee
ADD FOREIGN KEY(super_id)
REFERENCES employee(emp_id)
ON DELETE SET NULL;


CREATE TABLE client(
client_id INT PRIMARY KEY,
client_name VARCHAR(40),
branch_id INT,
FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE SET NULL,
);

CREATE TABLE works_with (
  emp_id INT,
  client_id INT,
  total_sales INT,
  PRIMARY KEY(emp_id, client_id),
  FOREIGN KEY(emp_id) REFERENCES employee(emp_id) ON DELETE CASCADE,
  FOREIGN KEY(client_id) REFERENCES client(client_id) ON DELETE CASCADE
);

CREATE TABLE branch_supplier (
  branch_id INT,
  supplier_name VARCHAR(40),
  supply_type VARCHAR(40),
  PRIMARY KEY(branch_id, supplier_name),
  FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE CASCADE
);

-- -----------------------------------------------------------------------------
-- Corporate
INSERT INTO employee VALUES(100, 'David', 'Wallace', '1967-11-17', 'M', 250000, NULL, NULL);

INSERT INTO branch VALUES(1, 'Corporate', 100, '2006-02-09');

UPDATE employee
SET branch_id = 1
WHERE emp_id = 100;

INSERT INTO employee VALUES(101, 'Jan', 'Levinson', '1961-05-11', 'F', 110000, 100, 1);

-- Scranton
INSERT INTO employee VALUES(102, 'Michael', 'Scott', '1964-03-15', 'M', 75000, 100, NULL);

INSERT INTO branch VALUES(2, 'Scranton', 102, '1992-04-06');

UPDATE employee
SET branch_id = 2
WHERE emp_id = 102;

INSERT INTO employee VALUES(103, 'Angela', 'Martin', '1971-06-25', 'F', 63000, 102, 2);
INSERT INTO employee VALUES(104, 'Kelly', 'Kapoor', '1980-02-05', 'F', 55000, 102, 2);
INSERT INTO employee VALUES(105, 'Stanley', 'Hudson', '1958-02-19', 'M', 69000, 102, 2);

-- Stamford
INSERT INTO employee VALUES(106, 'Josh', 'Porter', '1969-09-05', 'M', 78000, 100, NULL);

INSERT INTO branch VALUES(3, 'Stamford', 106, '1998-02-13');

UPDATE employee
SET branch_id = 3
WHERE emp_id = 106;

INSERT INTO employee VALUES(107, 'Andy', 'Bernard', '1973-07-22', 'M', 65000, 106, 3);
INSERT INTO employee VALUES(108, 'Jim', 'Halpert', '1978-10-01', 'M', 71000, 106, 3);

-- BRANCH SUPPLIER
INSERT INTO branch_supplier VALUES(2, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Patriot Paper', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'J.T. Forms & Labels', 'Custom Forms');
INSERT INTO branch_supplier VALUES(3, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(3, 'Stamford Labels', 'Custom Forms');

-- CLIENT
INSERT INTO client VALUES(400, 'Dunmore Highschool', 2);
INSERT INTO client VALUES(401, 'Lackawana Country', 2);
INSERT INTO client VALUES(402, 'FedEx', 3);
INSERT INTO client VALUES(403, 'John Daly Law, LLC', 3);
INSERT INTO client VALUES(404, 'Scranton Whitepages', 2);
INSERT INTO client VALUES(405, 'Times Newspaper', 3);
INSERT INTO client VALUES(406, 'FedEx', 2);

-- WORKS_WITH
INSERT INTO works_with VALUES(105, 400, 55000);
INSERT INTO works_with VALUES(102, 401, 267000);
INSERT INTO works_with VALUES(108, 402, 22500);
INSERT INTO works_with VALUES(107, 403, 5000);
INSERT INTO works_with VALUES(108, 403, 12000);
INSERT INTO works_with VALUES(105, 404, 33000);
INSERT INTO works_with VALUES(107, 405, 26000);
INSERT INTO works_with VALUES(102, 406, 15000);
INSERT INTO works_with VALUES(105, 406, 130000);


select *
from employee
ORDER BY sex, first_name, last_name;

select top 5*
from employee;

select first_name, last_name from employee;

-- change the column names in the table.
-- It only renames them temporarily for the duration of the query result.
-- the original column names remain unchanged in the employee table.
SELECT first_name AS forename, last_name AS surname 
FROM employee;

SELECT COUNT(emp_id) -- 9
FROM employee;

SELECT COUNT(super_id) -- 8 bec. there is 1 employee that has no super_id
FROM employee;

-- find # of F employees born after 1970
SELECT COUNT(emp_id)
FROM employee 
WHERE sex = 'F' AND birth_day > '1970-01-01';

-- find # of all rows in the table
SELECT COUNT(*)
FROM employee;

-- find how many employees have their sex stored in the table
SELECT COUNT(sex)
FROM employee;

-- find the average of all employee's salaries
SELECT AVG(salary)
FROM employee;

-- find the average of male employee's salaries
SELECT AVG(salary)
FROM employee
WHERE sex = 'M';

-- find the sum of all employee's salaries
SELECT SUM(salary)
FROM employee;

-- find how many F and M genders in employees table and print the data out
SELECT COUNT(sex), sex               -- 3 | M
FROM employee						 -- 6 | F            -- 6 | F	
GROUP BY sex;

-- find total sales of each sales man
SELECT SUM(total_sales), emp_id
FROM works_with
GROUP BY emp_id;

-- find the money each client spend with the branch
SELECT client_id, SUM(total_sales)
FROM works_with
GROUP BY client_id;

-------------------- Wildcards --------------------
-- find any client's who are an LLC 
SELECT *
FROM client
WHERE client_name LIKE '%LLC';

-- find any branch supplier who are in the label business
SELECT * 
FROM branch_supplier
WHERE supplier_name LIKE '%Label%';

-- find any employee born in october
SELECT *
FROM employee
WHERE birth_day LIKE '____-10%';

-- find any employee born in october
SELECT *
FROM client
WHERE client_name LIKE '%school%';

------------------- UNION ---------------------
-- find a list fo employee and branch names
SELECT first_name
FROM employee 
UNION
SELECT branch_name
FROM branch;

-- find a list of all client names and branch suppliers
SELECT client_name, client.branch_id
FROM client
UNION
SELECT supplier_name, branch_supplier.branch_id
FROM branch_supplier;

-- find a list of all money spent or earned by the company
SELECT salary, employee.emp_id
FROM employee
UNION
SELECT total_sales, works_with.emp_id
FROM works_with;

------------------------------ JOINs ------------------------
SELECT employee.emp_id, employee.first_name, branch.branch_name
From employee JOIN branch
ON employee.emp_id = branch.mgr_id;

SELECT * FROM branch;

INSERT INTO branch VALUES (4, 'Bufflo', NULL, NULL);

SELECT employee.emp_id, employee.first_name, branch.branch_name
From employee RIGHT JOIN branch
ON employee.emp_id = branch.mgr_id;

SELECT employee.emp_id, employee.first_name, branch.branch_name
From employee FULL OUTER JOIN branch
ON employee.emp_id = branch.mgr_id;

SELECT employee.emp_id, employee.first_name, branch.branch_name
From employee CROSS JOIN branch;

------------------------- Nest Queries----------------
-- find names of all employees who have sold over 30,000 to a single client
select employee.first_name, employee.last_name, works_with.total_sales
from employee INNER JOIN works_with
ON employee.emp_id = works_with.emp_id And total_sales > 30000; -- not accurate

SELECT employee.first_name, employee.last_name
FROM employee
WHERE employee.emp_id IN(
	SELECT works_with.emp_id
	FROM works_with
	WHERE works_with.total_sales > 30000
); 

-- find all clients who are handled by the branch 
-- that michael Scott manages
-- Assume you know Michael's ID
select client.client_name
from client
where client.branch_id IN (
	select branch.branch_id
	from branch
	Where branch.mgr_id = 102
);

DElETE from employee 
where emp_id = 102;

select *from employee;
select * from branch;

delete from branch
where branch_id = 2;

select * from branch_supplier;







