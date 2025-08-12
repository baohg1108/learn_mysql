create database dml_having;
use dml_having;

create database data_default;
use data_default;

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

-- Bài tập 1: Tìm các danh mục có nhiều hơn 3 sản phẩm.
-- from -> where -> group by -> having -> select -> order by -> offset/limit

-- Bài tập 2: Tìm các thành phố có ít nhất 2 người dùng.
select city, count(user_id) as user_count
from addresses
group by city
having count(user_id > 2);

-- Bài tập 3: Tìm các trạng thái đơn hàng có tổng số đơn hàng lớn hơn 5.
select status , count(id) as order_count
from orders
group by status
having count(id) > 5;

-- Bài tập 4: Tìm các người dùng có nhiều hơn 1 địa chỉ.
select users.name, count(addresses.id) as address_count
from users 
join addresses on users.id=addresses.user_id
group by users.name
having count(addresses.id) > 1;

-- Bài tập 5: Tìm các danh mục có giá sản phẩm trung bình lớn hơn 20,000,000.
select categories.name, avg(products.price) as avg_price
from products
join categories on products.category_id=categories.id
group by categories.name
having avg(products.price) > 20000000;

-- Bài tập 6: Tìm các người dùng đã đặt hàng ít nhất 2 lần.
select users.name, count(orders.id) as order_count
from orders
join users on users.id=orders.user_id
group by users.name
having count(orders.id) > 2;