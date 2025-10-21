-- PREPARED STATEMENTS

PREPARE pstmt FROM 'SELECT * FROM new_products WHERE
productCode=? AND quantity <=?';

SET @productCode = 'PEC';
SET @quantity = 2000;

EXECUTE pstmt USING @productCode, @quantity;

DEALLOCATE PREPARE pstmt;

-- way to get all users' data in old times
SELECT password FROM user WHERE user = 'user1' OR '1' = '1';

SET @query = 'INSERT INTO new_products VALUES(?,?,?,?,?)';
PREPARE pst1 FROM @query;
SET @productId = NULL;
SET @productCode = 'PEC';
SET @name = 'Pencil H';
SET @quantity = 5000;
SET @price = 0.49;
EXECUTE pst1 USING @productId, @productCode, @name, @quantity, @price;

SELECT * FROM new_products;

-----------------------------------------
--Triggers-------------------------------
-----------------------------------------
--overall template
CREATE TRIGGER trigger_name
{AFTER|BEFORE} {DELETE|INSERT|UPDATE}
ON table_name FOR EACH ROW 
statements;

CREATE TABLE backup_persons
(personId INT UNSIGNED NOT NULL PRIMARY KEY,
name VARCHAR(20) NOT NULL,
datetimeDeleted DATETIME NOT NULL);

CREATE TABLE persons
(personId INT UNSIGNED NOT NULL PRIMARY KEY,
name VARCHAR(20) NOT NULL);

INSERT INTO persons VALUE(1, 'name1');

DELIMITER //
CREATE TRIGGER archEmps
BEFORE DELETE ON persons FOR EACH ROW 
BEGIN 
INSERT INTO backup_persons 
VALUES(OLD.personID, OLD.name, NOW());
END//
DELIMITER ;

DELETE FROM persons;

-- how to delete trigger
DROP TRIGGER archEmps;

-----------------------------------------
--Transactions---------------------------
-----------------------------------------
-- done all or nothing. Not half of request etc.
-- if something wrong during transaciton, all already done
-- changes rolled back.

CREATE TABLE bank_accounts 
(name VARCHAR(30), 
balance DECIMAL(10, 2));

INSERT INTO bank_accounts VALUES
('name1', 10000), 
('name2', 12000);

START TRANSACTION;
UPDATE bank_accounts SET balance = balance - 1000
WHERE name = 'name2';
UPDATE bank_accounts SET balance = balance + 1000
WHERE name = 'name1';
COMMIT; --end of transaction

-----------------------------------------
--BACKUPS--------------------------------
-----------------------------------------
--CREATING BACKUP
--in cmd enter "cd C:\xampp\mysql\bin"
--enter command:
mysqldump -u root -p --databases carmiel_2025>C:\Projects\Database\backup\backup_carmiel_2025.sql
--the comment above is part of a command!
-- in comand determined the path for the save

--RESTORE DATA
--in cmd go to "cd C:\xampp\mysql\bin"
--enter command:
mysql -u root -p carmiel_2025 < C:\Projects\Database\backup\backup_carmiel_2025.sql

-----------------------------------------
--SCRIPTS--------------------------------
-----------------------------------------
--write script in separate file
--go to database
--run the script from the path
mysql -u root -p carmiel_2025
source C:\Projects\Database\DatabaseRP\65_prepared_statements\script_new.sql

----------------------------------------------
-- SAVE TABLE TO FILE-------------------------
----------------------------------------------
--SAVE
--warning to slash symbols directions
SELECT * FROM products INTO OUTFILE "C:/Projects/Database/DatabaseRP/65_prepared_statements/products_out.csv"
FIELDS TERMINATED BY ', '
LINES TERMINATED BY '\r\n';

LOAD DATA LOCAL INFILE "C:/Projects/Database/DatabaseRP/65_prepared_statements/products_out.csv"
INTO TABLE products
FIELDS TERMINATED BY ', '
LINES TERMINATED BY '\r\n';