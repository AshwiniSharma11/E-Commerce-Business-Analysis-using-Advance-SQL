-- Using Snowflake schema >> first Parent table, then child table which is parent to others then child table 

-- Category Table
CREATE TABLE Category(
    category_id INT PRIMARY KEY,
    category_name VARCHAR(255)
);

-- Customers Table
CREATE TABLE Customers(
    customer_id INT PRIMARY KEY,
	f_name VARCHAR(255),
	l_name VARCHAR(255),
    state VARCHAR(255),
    address VARCHAR(255) DEFAULT('xxxx')   
);

-- Sellers Table
CREATE TABLE Sellers(
    seller_id INT PRIMARY KEY,
	seller_name VARCHAR(255),
    origin VARCHAR(255)   
);

-- Products Table
CREATE TABLE Products(
    product_id INT PRIMARY KEY,
	product_name VARCHAR(255),
    price FLOAT,
    cogs FLOAT,
    category_id INT,
	CONSTRAINT products_fk_category FOREIGN KEY(category_id) REFERENCES Category(category_id)
);

-- Orders Table
CREATE TABLE Orders(
	order_id INT PRIMARY KEY,
    order_date DATE ,
    customer_id INT , -- FK
    seller_id INT, -- FK
	order_status VARCHAR(255) ,
	CONSTRAINT orders_fk_customers FOREIGN KEY(customer_id) REFERENCES Customers(customer_id),
	CONSTRAINT orders_fk_sellers FOREIGN KEY(seller_id) REFERENCES Sellers(seller_id)
);

-- Order_items Table
CREATE TABLE Order_items(
	order_item_id INT PRIMARY KEY,
	order_id INT , -- FK
	product_id INT , --FK
    quantity INT ,
    price_per_unit FLOAT ,
	CONSTRAINT order_items_fk_orders FOREIGN KEY(order_id) REFERENCES Orders(order_id),
	CONSTRAINT order_items_fk_products FOREIGN KEY(product_id) REFERENCES Products(product_id)
);

ALTER TABLE Order_items
ADD COLUMN total_sales FLOAT

-- Payments Table
CREATE TABLE Payments(
    payment_id INT PRIMARY KEY,
	order_id INT , -- FK
    payment_date DATE ,
    payment_status VARCHAR(255) ,
	CONSTRAINT payments_fk_orders FOREIGN KEY(order_id) REFERENCES Orders(order_id)
);

-- Shipping Table
CREATE TABLE Shipping(
	shipping_id INT PRIMARY KEY,
	order_id INT , -- FK
	shipping_date DATE ,
    return_date DATE ,
	shipping_providers VARCHAR(255) ,
	delivery_status VARCHAR(255) ,
    CONSTRAINT shipping_fk_orders FOREIGN KEY(order_id) REFERENCES Orders(order_id) 
);

-- Inventory Table
CREATE TABLE Inventory(
	inventory_id INT PRIMARY KEY,
	product_id INT , -- FK
    stock INT ,
	warehouse_id INT ,
    last_stock_date DATE ,
    CONSTRAINT inventory_fk_products FOREIGN KEY(product_id) REFERENCES Products(product_id)
);