-- 	MÝSQL dont support FULL OUTER JOIN OR FULL JOIN

create database joins_queries_full_join;
use joins_queries_full_join;

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

select * from users;


-- 1. Hiển thị name người dùng và street của họ.
select u.name as user_name, a.street as address_street
from users u 
left join addresses a on u.id=a.user_id

union

select u.name as user_name, a.street as address_street
from users u
right join addresses a on u.id=a.user_id;

-- 2. Hiển thị name sản phẩm và name danh mục tương ứng.
select p.name as product_name , c.name as category_name
from products p
left join categories c on c.id=p.category_id
union
select p.name as product_name, c.name as category_name
from products p
right join categories c on c.id=p.category_id;


-- 3.














