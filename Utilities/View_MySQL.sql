#A view is a SELECT query that is stored within the schema as an object.
#In a view, the results from a SELECT query are stored and will be dynamically updated as data is updated in the tables

#Why use view?
#Views enable us to save intricate queries within the database. Instead of having to run a complicated SQL query every time we wish to retrieve data, we can simply execute a straightforward query like this: SELECT column_list FROM view_name;
#Views enable you to organize data tailored for a particular set of users.
#Views play a crucial role in preserving database security. Instead of providing users direct access to the database tables, you establish a view to expose only the essential data, and then grant users access to that view.

#Create a view
CREATE VIEW view_name AS
  SELECT_query

#Example:
CREATE VIEW member_contacts AS
    SELECT first_name, last_name, email, phone_number, institute_name
    FROM member AS m
      INNER JOIN institute AS i
      ON m.institute_id = i.institute_id
    ORDER BY first_name;

#Change a view
CREATE OR REPLACE VIEW view_name AS
  SELECT_query;

#Delete a view
DROP VIEW view_name;
