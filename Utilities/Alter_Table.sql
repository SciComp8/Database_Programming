#Add one or more variables
ALTER TABLE table_name
  ADD var_name data_type;

ALTER TABLE table_name
  ADD var_name_1 data_type_1,
  ADD var_name_2 data_type_2,
  ADD var_name_2 data_type_2;

#Delete one or more variables
ALTER TABLE table_name
  DROP var_name;

ALTER TABLE table_name
  DROP var_name_1,
  DROP var_name_2,
  DROP var_name_3;

#Change the data type of one or more variables
ALTER TABLE table_name
  MODIFY var_name new_data_type;

ALTER TABLE table_name
  MODIFY var_name_1 new_data_type_1,
  MODIFY var_name_2 new_data_type_2,
  MODIFY var_name_3 new_data_type_3;

#Rename one or more variables
ALTER TABLE table_name
  RENAME COLUMN var_old_name to var_new_name;

ALTER TABLE table_name
  RENAME COLUMN var_old_name_1 to var_new_name_1,
  RENAME COLUMN var_old_name_2 to var_new_name_2,
  RENAME COLUMN var_old_name_3 to var_new_name_3;

#Add a primary key to an existing table
ALTER TABLE table_name
  ADD CONSTRAINT pk_name PRIMARY KEY(var_as_pk);

#Remove a primary key from an existing table
ALTER TABLE table_name
  DROP CONSTRAINT pk_name;
