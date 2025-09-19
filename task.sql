DROP DATABASE IF EXISTS ShopDB;
SOURCE create-database.sql;
USE ShopDB;

START TRANSACTION;
INSERT INTO Orders (CustomerID, `Date`)
 VALUES (1, '2023-01-01');
SET @order_id = LAST_INSERT_ID();
INSERT INTO OrderItems (OrderID, ProductID, Count)
 VALUES (@order_id, 1, 1);
UPDATE Products
 SET WarehouseAmount = WarehouseAmount - 1
 WHERE ID = 1 AND WarehouseAmount >= 1;

IF ROW_COUNT() = 0 THEN
	ROLLBACK;
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Product not found';
END IF;

COMMIT;
