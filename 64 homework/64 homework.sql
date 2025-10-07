mysql -u root -p
show databases
use carmiel_2025
SELECT * FROM products_suppliers;
SELECT * FROM new_products;
SELECT * FROM suppliers_new;
SELECT * FROM product_details;

/*
1) Добавить в таблицу связи продукт-поставщик несколько новых поставщиков,
 связанных несколькими с продуктами из таблицы продуктов, 
 предварительно добавив поставщиков в соответствующую таблицу
*/
INSERT INTO suppliers_new VALUES
(106, 'Allience', 6466667587),
(107, 'Horde', 2078703597);

INSERT INTO products_suppliers VALUES
(1001, 107),
(1031, 107),
(1002, 106),
(1030, 106),
(1033, 107);

/*
2) Показать информацию о поставщике, который поставляет 
максимальное количество продуктов по имени
Сделать это в указанном виде
   `Supplier Name`   `Supplier Phone`  `Product Names`
*/
SELECT
s.name AS `Supplier Name`,
s.phone AS `Supplier Phone`,
GROUP_CONCAT(p.name SEPARATOR '; ') AS `Product Names`
FROM products_suppliers AS ps 
JOIN new_products p USING(productID)
JOIN suppliers_new s USING(supplierID)
GROUP BY supplierID
ORDER BY COUNT(p.name) DESC
LIMIT 1;

/*
Выполнить задание с сабселектами
3)Показать информацию о поставщике, который поставляет 
максимальное количество продуктов по продуктовому коду
Сделать это в указанном виде
`Supplier Name`   `Supplier Phone`  `Number Of Product Codes`
*/
-- without sub-select
SELECT
s.name AS `Supplier Name`,
s.phone AS `Supplier Phone`,
COUNT(p.productCode) AS `Number Of Product Codes`
FROM products_suppliers ps 
JOIN new_products p USING(productID)
JOIN suppliers_new s USING(supplierID)
GROUP BY supplierID
ORDER BY COUNT(p.name) DESC
LIMIT 1;

-- sub-select: supplier with the highest amount of supplies
SELECT supplierID
FROM products_suppliers
GROUP BY supplierID 
ORDER BY COUNT(productID) DESC
LIMIT 1;

-- actual solution using sub-select
SELECT
s.name AS `Supplier Name`,
s.phone AS `Supplier Phone`,
COUNT(p.productCode) AS `Number Of Product Codes`
FROM products_suppliers ps 
JOIN new_products p USING(productID)
JOIN suppliers_new s USING(supplierID)
WHERE supplierID = ( 
SELECT supplierID
FROM products_suppliers
GROUP BY supplierID 
ORDER BY COUNT(productID) DESC
LIMIT 1);

/*
4) Удалить из таблицы связи продукт-поставщик все связи 
какого-то поставщика
*/
DELETE FROM products_suppliers WHERE supplierID = 106;

/*
5) Показать все продукты и комментарии. Если комментарии отсутствуют, 
вывести в этой колонке 'No Details'. Сделать это пятью способами
*/
-- #1 -------------------------------------
SELECT productID, productCode, name, quantity, price,
IFNULL(comment, 'No Details') AS comment
FROM new_products
LEFT JOIN product_details USING(productID);
-- #2 -------------------------------------
SELECT productID, productCode, name, quantity, price,
IF(comment IS NULL, 'No Details', comment) AS comment
FROM new_products
LEFT JOIN product_details USING(productID);
-- #3 -------------------------------------
SELECT productID, productCode, name, quantity, price,
CASE 
WHEN comment IS NULL THEN 'No Details' ELSE comment 
END AS comment
FROM new_products
LEFT JOIN product_details USING(productID);
-- #4 -------------------------------------
SELECT productID, productCode, name, quantity, price,
COALESCE(comment, 'No Details') AS comment
FROM new_products
LEFT JOIN product_details USING(productID);
-- #5 -------------------------------------
CREATE TEMPORARY TABLE clear_product_details AS
SELECT 
p.productID,
IFNULL(pd.comment, 'No Details') AS comment
FROM new_products p
LEFT JOIN product_details pd USING(productID);

SELECT *
FROM new_products
LEFT JOIN clear_product_details USING(productID);
-- #6 -------------------------------------
SELECT *
FROM new_products
LEFT JOIN (
SELECT 
productID,
IFNULL(comment, 'No Details') AS comment
FROM new_products
LEFT JOIN product_details USING(productID)
) sub_select USING(productID);

/*
6) Назначить в таблице с пациентами всем, у кого нет, 
какие-то даты следующего посещения
*/
UPDATE patients
SET nextVisitDate = DATE_ADD(CURDATE(), INTERVAL 1 YEAR)
WHERE nextVisitDate IS NULL;

/*
7)Вывести из таблицы с пациентами всех пациентов, у кого между предыдущим и следующим посещением
более двух лет.
*/
SELECT *
FROM patients
WHERE TIMESTAMPDIFF(YEAR, lastVisitDate, nextVisitDate) > 2;
