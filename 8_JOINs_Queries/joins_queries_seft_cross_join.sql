create database joins_queries_seft_cross_join;
use joins_queries_seft_cross_join;

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


-- seft join
-- 1. Tìm tất cả các cặp người dùng có cùng tên.
select  a.id as user_a_id, a.name as user_a_name,
		b.id as user_b_id, b.name as user_b_name
from users a
join users b on a.name=b.name and a.id < b.id;

-- cross join
-- 1.Tạo danh sách tất cả các cặp kết hợp có thể có giữa tên người dùng và tên danh mục.











