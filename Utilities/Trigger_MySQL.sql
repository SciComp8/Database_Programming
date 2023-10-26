CREATE TRIGGER before_update_salary #This is a trigger name
BEFORE UPDATE ON employees #This is a table name
FOR EACH ROW
BEGIN
   IF NEW.salary <> OLD.salary THEN #<>: not equal to
	      INSERT INTO salary_changes (employee_id,old_salary,new_salary) #Refer to: Add_Record.sql
        VALUES (NEW.employee_id,OLD.salary,NEW.salary);
    END IF;
END;
