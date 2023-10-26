ALTER TABLE child_table_name
  ADD FOREIGN KEY (fk_1) REFERENCES parent_table_name_1(pk_1)
    ON UPDATE CASCADE,
  ADD FOREIGN KEY (fk_2) REFERENCES parent_table_name_2(pk_2)
    ON UPDATE CASCADE;
