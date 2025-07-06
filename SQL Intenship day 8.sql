use ecommercedb;
select * from Customers;

-- 1.Use CREATE PROCEDURE and CREATE FUNCTION
-- 2.Use parameters and conditional logic
DELIMITER $$

CREATE PROCEDURE GetCustomerOrders(IN cust_id INT)
BEGIN
    SELECT o.order_id, o.order_date, o.total_amount
    FROM Orders o
    WHERE o.customer_id = cust_id;
END $$

DELIMITER ;

CALL GetCustomerOrders(5);
DELIMITER $$

CREATE FUNCTION GetTotalPaymentByCustomer(cust_id INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10,2);

    SELECT SUM(p.amount_paid) INTO total
    FROM Payments p
    JOIN Orders o ON p.order_id = o.order_id
    WHERE o.customer_id = cust_id;

    RETURN IFNULL(total, 0);
END $$

DELIMITER ;

SELECT name, GetTotalPaymentByCustomer(customer_id) AS total_paid
FROM Customers;

#1.Difference between procedure and function?


#2.What is IN/OUT parameter?
-- IN → Input parameter (default).
-- OUT → Outputs a value to the caller.
-- INOUT → Can be both input and output 

#3.Can functions return tables?
# MySQL functions can't return full tables directly.
# But you can create table-valued functions in other databases like SQL Server or PostgreSQL.

#4.What is RETURN used for?
 -- It sends back a single value.
#5.How to call stored procedures?
CALL ProcedureName(params);


#6.What is the benefit of stored routines?
-- Code reuse and modularity
-- Centralized business logic
-- Performance boost via precompiled execution
-- Security (controlled access)

#7.Can procedures have loops?
DECLARE i INT DEFAULT 1;
WHILE i <= 10 DO
   -- logic
   SET i = i + 1;
END WHILE;


#8.Difference between scalar and table-valued functions?


#9.What is a trigger?


#10.How to debug stored procedures?

