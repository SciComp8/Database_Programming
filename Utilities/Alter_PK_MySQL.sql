#In a relational database, all rows in each table must be unique.
#A primary key is a unique index that's designated as the identifier for each row of a table.
#Values entered into the primary key must be (1) unique in each row; (2) non-null
#If there is more than 1 column as the primary key, its **combination** of values in those columns must be unique.

#Add a primary key to an existing table
ALTER TABLE table_name
  ADD PRIMARY KEY(var_as_pk_1, var_as_pk_2);

#Remove a primary key from an existing table
ALTER TABLE table_name
  DROP PRIMARY KEY;
