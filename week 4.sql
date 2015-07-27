DROP TABLE IF EXISTS employees;

CREATE TABLE employees (
    employee_id numeric NOT NULL,
    employee_name text NOT NULL,
    manager_name text,
    manager_id numeric,
    job_title text
);

INSERT INTO employees ( employee_id, employee_name, manager_name, manager_id, job_title ) VALUES (1, 'Tom Haverford', 'Leslie Knope', 2, 'Assistnant');
INSERT INTO employees ( employee_id, employee_name, manager_name, manager_id, job_title ) VALUES (2, 'Leslie Knope', 'Ron Swanson', 3, 'Deputy Director');
INSERT INTO employees ( employee_id, employee_name, manager_name, manager_id, job_title ) VALUES (3, 'Ron Swanson', NULL, NULL, 'Director');
INSERT INTO employees ( employee_id, employee_name, manager_name, manager_id, job_title ) VALUES (4, 'April Ludgate', 'Leslie Knope', 2, 'Intern');
INSERT INTO employees ( employee_id, employee_name, manager_name, manager_id, job_title ) VALUES (5, 'Jerry Gergich', 'Leslie Knope', 2, 'Accountant');

SELECT
employees.employee_name AS "Employee Name",
Managers.employee_name AS "Manager Name"
FROM employees
INNER JOIN employees as Managers
ON employees.manager_id = managers.employee_id
ORDER BY Managers.employee_id;
