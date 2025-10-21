INSERT INTO suppliers_new VALUES
(NULL, 'F company', 5678901234),
(NULL, 'G company', 6789012345);

INSERT INTO products_suppliers VALUES(
(SELECT productID FROM new_products
WHERE name='Pencil HB'),
(SELECT supplierID FROM suppliers_new 
WHERE name='F company'));

INSERT INTO products_suppliers VALUES(
(SELECT productID FROM new_products
WHERE productCode='PEC' LIMIT 2,1),
(SELECT supplierID FROM suppliers_new 
WHERE name='F company'));

SELECT * FROM products_suppliers;

-- insert based on data from tables
INSERT INTO products_suppliers
SELECT p.productID, s.supplierID
FROM new_products p 
JOIN suppliers_new s ON s.name = 'G company'
WHERE p.productID IN (1031, 1033);

INSERT INTO products_suppliers
SELECT p.productID, s.supplierID
FROM new_products p 
JOIN suppliers_new s ON s.name = 'F company'
WHERE p.productCode IN ('PEX', 'MR2');

--2--------------------------------------
SELECT s.name AS `Supplier Name`, 
phone AS `Supplier Phone`, 
GROUP_CONCAT(DISTINCT p.name SEPARATOR ', ') AS `Product Names`
FROM suppliers_new s 
JOIN products_suppliers ps USING(supplierID)
JOIN new_products p USING(productID)
GROUP BY s.supplierID 
ORDER BY COUNT(p.productID) DESC LIMIT 1;
-- if multiple equal results, request below will show all of them
-- the one above will show only one of them
SELECT s.name AS `Supplier Name`, 
phone AS `Supplier Phone`, 
GROUP_CONCAT(DISTINCT p.name SEPARATOR ', ') AS `Product Names`
FROM suppliers_new s 
JOIN products_suppliers ps USING(supplierID)
JOIN new_products p USING(productID)
GROUP BY s.supplierID 
HAVING COUNT(*) = 
(SELECT MAX(cnt)
FROM (SELECT COUNT(*) AS cnt
FROM products_suppliers
GROUP BY supplierID) t);

--3--------------------------------------
SELECT 
s.name AS `Supplier Name`,
phone AS `Supplier Phone`,
COUNT(DISTINCT productCode) 
AS `NUMBER OF PRODUCT CODES`
FROM suppliers_new s
JOIN products_suppliers ps USING(supplierID)
JOIN new_products p USING(productId)
GROUP BY s.supplierID 
HAVING COUNT(DISTINCT productCode) =
(SELECT MAX(cnt) FROM (
SELECT products_suppliers.supplierID, 
COUNT(DISTINCT new_products.productCode) AS cnt
FROM products_suppliers 
JOIN new_products USING(productID)
GROUP BY products_suppliers.supplierID) t);

--4-----------------------------
DELETE FROM products_suppliers 
WHERE supplierID IN 
(SELECT supplierID FROM suppliers_new WHERE name = 'F company');

--5-----------------------------
SELECT * FROM product_details;
--5.1
SELECT 
new_products.name AS `Product Name`,
IFNULL(comment, 'No Details') AS `Details`
FROM new_products
LEFT JOIN product_details USING(productID);
--5.2
SELECT 
new_products.name AS `Product Name`,
CASE WHEN comment IS NULL THEN 'No Details' ELSE comment END AS comment
FROM new_products
LEFT JOIN product_details USING(productID);
--5.3
SELECT 
new_products.name AS `Product Name`,
IF(comment IS NULL, 'No Details', comment) AS comment
FROM new_products
LEFT JOIN product_details USING(productID);
--5.4
SELECT 
new_products.name AS `Product Name`,
COALESCE(comment, 'No Details') AS comment
FROM new_products
LEFT JOIN product_details USING(productID);
--5.5
SELECT 
new_products.name AS `Product Name`,
NVL(comment, 'No Details') AS comment
FROM new_products
LEFT JOIN product_details USING(productID);
--5.6
SELECT 
new_products.name AS `Product Name`,
comment
FROM new_products
JOIN product_details USING(productID)
UNION
SELECT name, 'No details' AS comment
FROM new_products
LEFT JOIN product_details USING(productID)
WHERE comment IS NULL;

--6-------------------------------
UPDATE patients 
SET nextVisitDate = DATE_ADD(CURDATE(), INTERVAL 1 MONTH)
WHERE name = 'name2';

UPDATE patients 
SET nextVisitDate = DATE_ADD(CURDATE(), INTERVAL 3 MONTH)
WHERE patientID = 104;

--7-------------------------------
SELECT name, lastVisitDate FROM patients
WHERE TIMESTAMPDIFF(YEAR, lastVisitDate, nextVisitDate) > 2;