DELETE FROM products;
INSERT INTO products VALUES(
1001, 'PEN','PEN Red', 5000,1.23, 101);

INSERT INTO products VALUES
(NULL,'PEN','Pen Blue',8000,1.25, 101),
(NULL,'PEN','Pen Black',2000,1.25, 101);

INSERT INTO products(productCode, name, quantity, price, supplierID) VALUES
('PEC','Pencil 2B', 10000, 0.48, 101);

INSERT INTO products(price, productCode, name, quantity, supplierID) VALUES
(0.49,'PEC','Pencil 2H', 8000, 101);

INSERT INTO products(productCode, name) VALUES
('PEC', 'Pencil HB');

INSERT INTO products(productCode, name, quantity, price, supplierID) VALUES
('PEC','Pencil M', 6000, 0.52, 101),
('PEN','Pen Dark Blue', 6000, 1.52, 101),
('PEN','Pen Grey', 1500, 1.7, 101);
SELECT * FROM products;