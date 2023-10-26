#Add a foreign key into an existing table
ALTER TABLE child_table_name
  ADD FOREIGN KEY (fk_1) REFERENCES parent_table_name_1(pk_1)
    ON UPDATE CASCADE,
  ADD FOREIGN KEY (fk_2) REFERENCES parent_table_name_2(pk_2)
    ON UPDATE CASCADE;

#Add a foreign key with the assigned name (fk_name) into an existing table
ALTER TABLE child_table_name
ADD CONSTRAINT fk_name FOREIGN KEY (fk_column)
   REFERENCES parent_table_name(pk_column);

#Remove a foreign key from an existing table
ALTER TABLE child_table_name
  DROP FOREIGN KEY fk_name_1,
  DROP FOREIGN KEY fk_name_2;


