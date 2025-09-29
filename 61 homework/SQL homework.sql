mySQL -u root -p
SHOW DATABASES;
USE carmiel_2025;
SHOW TABLES;
DESCRIBE products;
SELECT * FROM products;

/* task 1
1) Add 15 products to the table with codes that already exist, prices ranging from 0.9 to 3.5, 
and non-repeating names. Do this in a single list.
*/
INSERT INTO products VALUES
(NULL, 'PEN', 'Pen 1', 6666, 1.0),
(NULL, 'PEN', 'Pen 2', 6666, 1.1),
(NULL, 'PEN', 'Pen 3', 6666, 1.2),
(NULL, 'PEN', 'Pen 4', 6666, 1.3),
(NULL, 'PEN', 'Pen 5', 6666, 1.4),
(NULL, 'PEN', 'Pen 6', 6666, 1.5),
(NULL, 'PEN', 'Pen 7', 6666, 1.6),
(NULL, 'PEN', 'Pen 8', 6666, 1.7),
(NULL, 'PEC', 'Pencil 1', 7777, 2.0),
(NULL, 'PEC', 'Pencil 2', 7777, 2.1),
(NULL, 'PEC', 'Pencil 3', 7777, 2.2),
(NULL, 'PEC', 'Pencil 4', 7777, 2.3),
(NULL, 'PEC', 'Pencil 5', 7777, 2.4),
(NULL, 'PEC', 'Pencil 6', 7777, 2.5),
(NULL, 'PEC', 'Pencil 7', 7777, 2.6);

/* TASK 2
2) Insert using 1 command 2 new rows into the table 'products'. The 'productCode' of both new 
   rows to be equal 'PEX', other fields ('name', 'quantity', price') specify any by your choice.
*/
INSERT INTO products VALUES
(NULL,'PEX', 'Pex blue',1111, 3.0),
(NULL,'PEX', 'Pex red',1111, 3.0);

/* TASK 3
3) Delete from table 'products' all rows with 'productId' greater than 1015.
*/
DELETE FROM products WHERE productID > 1015;

/* TASK 4
4) Display all data from table 'products'.
*/
SELECT * FROM products;

/* TASK 5
5) Display 'name' and 'quantity' of all products with 'productCode' equal 'PEC'.
*/
SELECT name, quantity FROM products WHERE productCode = 'PEC';

/* TASK 6
6) Display 'productID' of all products, having word 'Blue' in its 'name'
*/
SELECT productID FROM products WHERE name LIKE '%Blue%';

/* TASK 7
7) Display 'name' of all products having letter '2' in its 'name' and 'quantity' 
*/
SELECT name FROM products WHERE name LIKE '%2%' AND quantity LIKE '%2%';

/* TASK 8
8) Display name and price of all products with quantity between 4000 and 9000. 
   Order output in alphabetical order by name
*/
SELECT name, price FROM products WHERE quantity BETWEEN 4000 AND 9000 ORDER BY name;

/* TASK 9
9) Display all existing information about products having price 2.0, 1.1 or 1.25
*/
SELECT * FROM products WHERE price IN(2.0, 1.1, 1.25);

-------------------------------------
-- Working with new table 'months':--
-------------------------------------
/* TASK 10
10) Create new table 'months' in your database and fill it with numbers and names of months
*/
CREATE TABLE IF NOT EXISTS months(
monthNum INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
monthName VARCHAR(10) NOT NULL DEFAULT '');

INSERT INTO months (monthName) VALUES
('Januar'),
('Februar'),
('March'),
('April'),
('May'),
('Juny'),
('July'),
('August'),
('September'),
('October'),
('November'),
('December');

/* TASK 11
11) Display all data stored in newly created table 'months'
*/
SELECT * FROM months;

/* TASK 12
12*) [Optional for self investigation] Display all names of month where number of month even.
*/
SELECT monthName FROM months WHERE monthNum % 2 = 0;