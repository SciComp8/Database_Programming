#Create a trigger
CREATE TRIGGER before_update_salary #This is a trigger name
BEFORE UPDATE ON employees #This is a table name
FOR EACH ROW
BEGIN
   IF NEW.salary <> OLD.salary THEN #<>: not equal to
	INSERT INTO salary_changes (employee_id,old_salary,new_salary) #Refer to: Add_Record.sql
        VALUES (OLD.employee_id,OLD.salary,NEW.salary);
    END IF;
END;

#Modify a trigger
CREATE OR REPLACE TRIGGER before_update_salary 
BEFORE UPDATE ON employees
FOR EACH ROW
BEGIN
   IF NEW.salary <> OLD.salary THEN 
	INSERT INTO salary_changes (employee_id,old_salary,new_salary) 
        VALUES (OLD.employee_id,OLD.salary,NEW.salary);
    END IF;
END;

#Remove a trigger
DROP TRIGGER trigger_name;

#View all triggers in the schema
SHOW TRIGGERS;
