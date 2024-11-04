/*Problem Statement 15 (Joins & Subqueries using MySQL) 
Consider Following Schema 
Employee(Employee_id, First_name, Last_name, hire_date, salary, Job_title, manager_id, 
department_id) 
Department(Department_id, Department_name, Manager_id, Location_id) 
Locations(location_id, street_address, postal_code, city, state, country_id) 
Manager(Manager_id,Manager_name) 
Create the tables with referential integrity. Solve following queries using joins and 
subqueries. 
1.Write a query to find the names(first_name, last_name), the salary of employees who earn 
more than the average salary and who works in any of the IT departments. 
2.Write a query to find the names(first_name, last_name) the salary of employees who earn 
the same salary as the minimum salary for all departments. 
3.Write a query to display the employee ID, first name, last name , salary of all employees 
whose salary is above average for their departments. 
4.Write a query to display the department name, manager name and city. 
5.Write a query to display thename(first_name, last_name) hire date, salary of all managers 
whose experience is more than 15 years. */

create database sknsit;
use sknsit;

CREATE TABLE Locations (
    Location_id INT PRIMARY KEY,
    Street_address VARCHAR(255),
    Postal_code VARCHAR(20),
    City VARCHAR(100),
    State VARCHAR(100),
    Country_id INT
);

INSERT INTO Locations (Location_id, Street_address, Postal_code, City, State, Country_id) VALUES
(1, '1 MG Road', '560001', 'Bangalore', 'Karnataka', 1),
(2, '2 Park Street', '700016', 'Kolkata', 'West Bengal', 1);

CREATE TABLE Manager (
    Manager_id INT PRIMARY KEY,
    Manager_name VARCHAR(100)
);

INSERT INTO Manager (Manager_id, Manager_name) VALUES
(1, 'Rajesh Kumar'),
(2, 'Anita Singh');

CREATE TABLE Departments (
    Department_id INT PRIMARY KEY,
    Department_name VARCHAR(100),
    Manager_id INT,
    Location_id INT,
    FOREIGN KEY (Manager_id) REFERENCES Manager(Manager_id),
    FOREIGN KEY (Location_id) REFERENCES Locations(Location_id)
);

INSERT INTO Departments (Department_id, Department_name, Manager_id, Location_id) VALUES
(1, 'IT', 1, 1),
(2, 'HR', 2, 2),
(3, 'Finance', 1, 1);

CREATE TABLE Employee (
    Employee_id INT PRIMARY KEY,
    First_name VARCHAR(100),
    Last_name VARCHAR(100),
    Hire_date DATE,
    Salary DECIMAL(10, 2),
    Job_title VARCHAR(100),
    Manager_id INT,
    Department_id INT,
    FOREIGN KEY (Manager_id) REFERENCES Manager(Manager_id),
    FOREIGN KEY (Department_id) REFERENCES Departments(Department_id)
);

INSERT INTO Employee (Employee_id, First_name, Last_name, Hire_date, Salary, Job_title, Manager_id, Department_id) VALUES
(1, 'Amit', 'Sharma', '2010-05-15', 75000, 'Developer', 1, 1),
(2, 'Priya', 'Gupta', '2012-06-20', 60000, 'HR Specialist', 2, 2),
(3, 'Rahul', 'Verma', '2005-08-30', 80000, 'Finance Manager', 1, 3),
(4, 'Sneha', 'Reddy', '2015-12-10', 70000, 'IT Support', 1, 1),
(5, 'Vikram', 'Mehta', '2018-01-01', 50000, 'Intern', 2, 2),
(6, 'Neha', 'Bhatia', '2020-11-15', 45000, 'Junior Developer', 1, 1);


SELECT First_name, Last_name, Salary
FROM Employee
WHERE Salary = (SELECT MIN(Salary) FROM Employee);

SELECT E.Employee_id, E.First_name, E.Last_name, E.Salary
FROM Employee E
WHERE E.Salary > (
    SELECT AVG(Salary)
    FROM Employee
    WHERE Department_id = E.Department_id
);

SELECT D.Department_name, M.Manager_name, L.City
FROM Departments D
JOIN Manager M ON D.Manager_id = M.Manager_id
JOIN Locations L ON D.Location_id = L.Location_id;

SELECT E.First_name, E.Last_name, E.Hire_date, E.Salary
FROM Employee E
WHERE E.Manager_id IS NOT NULL
AND DATEDIFF(CURDATE(), E.Hire_date) > (15 * 365);