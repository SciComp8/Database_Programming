CREATE TABLE child_table_name(
  PRIMARY KEY (c_pk_1, c_pk_2),
  c_pk_1 TINYINT(3),
  c_pk_2 TINYINT(2),
  FOREIGN KEY (c_pk_1) REFERENCES parent_table_name_1(p_pk_1) #c_pk_1 = p_pk_1
    ON UPDATE CASCADE,
  FOREIGN KEY (c_pk_2) REFERENCES parent_table_name_2(p_pk_2) #c_pk_2 = p_pk_2
    ON UPDATE CASCADE
);

#TD: ON UPDATE CASCADE: sync the parent table and child table

#Assign a name to a FOREIGN KEY 
CREATE TABLE genomic_project (
    sample_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    sequencing_tech VARCHAR(100),
    CONSTRAINT fk_genomic FOREIGN KEY (patient_id) #name the fk with fk_genomic
        REFERENCES whole_project (patient_id)
);
