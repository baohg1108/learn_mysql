create database aggregate_queries;
use aggregate_queries;

-- users
create table users (
id int primary key auto_increment,
name varchar(100) not null,
email varchar(100) unique not null,
password varchar(255) not null,
created_at timestamp default current_timestamp
);
-- categories
create table categories (
id int primary key auto_increment,
name varchar(100) not null
);
-- products
CREATE TABLE products (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10 , 2 ) NOT NULL,
    category_id INT,
    FOREIGN KEY (category_id)
        REFERENCES categories (id)
);
-- addresses
create table addresses (
id int primary key auto_increment,
user_id int,
street varchar(255) not null,
city varchar(100) not null,
country varchar(100) not null,
foreign key (user_id) references users(id)
);
-- orders
create table orders (
id int primary key auto_increment,
user_id int,
order_date timestamp default current_timestamp,
status enum("Pending", "Shipped", "Delivered") default "Pending",
foreign key (user_id) references users(id)
);



-- 1. Tổng giá trị trung bình của tất cả sản phẩm
select avg(price) as avg_product_price
from products;

-- 2. Sản phẩm có giá cao nhất và thấp nhất
select max(price) as max_price, min(price) as min_price
from products;

-- 3. Tổng số người dùng đã đăng ký
select count(*) as sum_users
from users;

-- 4. Đếm số user theo từng thành phố
select city, count(*) as count_user
from addresses
group by city;

-- 5. Trung bình giá sản phẩm theo từng loại category
select categories.name as category, avg(products.price) as avg_product_price
from products
join categories on products.category_id=categories.id
group by categories.name;

-- 6. Tổng số đơn hàng theo từng trạng thái
select status, count(*) as count_order_in_status
from orders
group by status;

-- 7. Thành phố nào có nhiều user nhất
select city, count(*) as total_user
from addresses
group by city
order by total_user desc
limit 1;

-- 8. Tổng giá trị sản phẩm trong từng loại category
select categories.name, sum(products.price) as sum_product_in_category
from products
join categories on products.category_id=categories.id
group by categories.name;

-- 9. Loại category nào có số sản phẩm nhiều nhất
select categories.name, count(products.id) as count_product_id
from products
join categories on categories.id=products.category_id
group by categories.name
order by count_product_id desc
limit 1;

-- 10. Trung bình giá sản phẩm chỉ lấy những category có nhiều hơn 3 sản phẩm
select categories.name, avg(products.price) as avg_price
from products
join categories on categories.id=products.id
group by categories.name
having count(products.id) > 3;