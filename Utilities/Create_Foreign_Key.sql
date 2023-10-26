CREATE TABLE child_table_name(
  PRIMARY KEY (pk_1, pk_2),
  var_1 TINYINT(3),
  var_2 TINYINT(2),
  FOREIGN KEY (fk_1) REFERENCES parent_table_name_1(pk_1)
    ON UPDATE CASCADE,
  FOREIGN KEY (fk_2) REFERENCES parent_table_name_2(pk_2)
    ON UPDATE CASCADE
);

#TD: ON UPDATE CASCADE
