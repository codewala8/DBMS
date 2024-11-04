-- *Problem statement 2 
Employee(emp_id, emp_name,salary,designation) 
Salary_Backup(rmp_id, old_salary, new_salary, salary_difference) 
Create a Trigger to record salary change of the employee. Whenever salary is updated insert 
the details in Salary_Backup table. * 

create database pratik;
drop pratik;
use pratik;

-- Create Employee table
CREATE TABLE Employee (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(100),
    salary DECIMAL(10, 2),
    designation VARCHAR(50)
);

-- Create Salary_Backup table
CREATE TABLE Salary_Backup (
    rmp_id INT,
    old_salary DECIMAL(10, 2),
    new_salary DECIMAL(10, 2),
    salary_difference DECIMAL(10, 2),
    FOREIGN KEY (rmp_id) REFERENCES Employee(emp_id)
);

-- Create the trigger to record salary changes
DELIMITER $$

CREATE TRIGGER trg_salary_update
AFTER UPDATE ON Employee
FOR EACH ROW
BEGIN
    -- Check if the salary has changed
    IF OLD.salary <> NEW.salary THEN
        INSERT INTO Salary_Backup (rmp_id, old_salary, new_salary, salary_difference)
        VALUES (NEW.emp_id, OLD.salary, NEW.salary, NEW.salary - OLD.salary);
    END IF;
END$$

DELIMITER ;

-- Sample data insertion for testing
INSERT INTO Employee (emp_id, emp_name, salary, designation) VALUES (1, 'John Doe', 50000.00, 'Developer');
INSERT INTO Employee (emp_id, emp_name, salary, designation) VALUES (2, 'Jane Smith', 60000.00, 'Manager');

-- Example of updating salary to trigger the backup
UPDATE Employee SET salary = 55000.00 WHERE emp_id = 1;

-- Check the contents of Salary_Backup
SELECT * FROM Salary_Backup;
