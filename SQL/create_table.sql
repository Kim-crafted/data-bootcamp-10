
-- Create and insert customer table
CREATE TABLE customers (
  customerid INT,
  name TEXT,
  phone TEXT
  );
  
INSERT INTO customers VALUES
	(1, 'Kim', '061-3054895'),
    	(2, 'Jane', '090-7959555'),
    	(3, 'John', '087-2930321'),
    	(4, 'Sam', '090-5701666');
    
 -- Create and insert menu table
 CREATE TABLE menu (
	menuid INT,
  	item TEXT NOT NULL,
  	description TEXT,
  	price REAL
);

INSERT INTO menu VALUES
	(1, 'Burger', 'Juicy beef burger with lettuce and tomato', 8.99),
    	(2, 'Caesar Salad', 'Crisp romaine with Caesar dressing and croutons', 7.49),
    	(3, 'Spaghetti Carbonara', 'Classic Italian pasta with creamy sauce and pancetta', 12.99),
    	(4, 'Grilled Salmon', 'Tender salmon fillet grilled with seasonal vegetables', 15.99),
    	(5, 'Chocolate Cake', 'Rich and moist chocolate cake with a creamy chocolate frosting', 6.99);
 
 
 -- Create and insert transaction table
 CREATE TABLE transactions (
  transactionid int,
  customerid int,
  menuid int,
  quantity int,
  total real
 );

INSERT INTO transactions VALUES
  (1, 1, 1, 1, 8.99),   -- Transaction 1: Kim buys 1 Burger
  (2, 1, 2, 1, 7.49),   -- Transaction 1: Kim buys 1 Caesar Salad
  (3, 2, 3, 2, 25.98),  -- Transaction 2: Jane buys 2 Spaghetti Carbonara
  (4, 3, 4, 1, 15.99),  -- Transaction 3: John buys 1 Grilled Salmon
  (5, 4, 5, 2, 13.98);  -- Transaction 4: Sam buys 2 Chocolate Cake

---------------------------------------------------
-- Querying Data
WITH bill as (
SELECT 
		cus.customerid,
    cus.name,
		count(*) 		  AS transactions ,
    SUM(tra.total) AS totalSpent 
FROM customers 		  AS cus 
JOIN transactions 	AS tra ON tra.customerid = cus.customerid
JOIN menu 			    AS men ON men.menuid = tra.menuid
group by cus.customerid
  )
  
 SELECT 
 	name,
  totalSpent
 FROM bill
 WHERE totalSpent > (
   SELECT AVG(totalSpent) FROM bill
 )
