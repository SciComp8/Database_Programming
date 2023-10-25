Reference https://www.w3schools.com/sql/sql_datatypes.asp

# Data types for MySQL
## Numeric data types for integers
- TINYINT(size)
- SMALLINT(size)
- MEDIUMINT(size)
- INT(size)
  A medium integer. Signed range is from -2147483648 to 2147483647. Unsigned range is from 0 to 4294967295. The size parameter specifies the maximum display width (which is 255)
- BIGINT(size)

## Numeric data types for decimals
- FLOAT(size,d)
- DOUBLE(size,d)
- DECIMAL(size,d)

## Text data types
- CHAR(size)
- VARCHAR(size)
  A VARIABLE length string (can contain letters, numbers, and special characters). The size parameter specifies the maximum string length in characters - can be from 0 to 65535
- TINYTEXT
- TEXT
- MEDIUMTEXT
- LONGTEXT
- BLOB
- MEDIUMBLOB
- LONGBLOB
- ENUM(x,y,z,etc.)
- SET

## Date/time data types
- DATE()
  A date. Format: YYYY-MM-DD. The supported range is from '1000-01-01' to '9999-12-31'
- DATETIME()
- TIMESTAMP()
- TIME()
- YEAR()

  
