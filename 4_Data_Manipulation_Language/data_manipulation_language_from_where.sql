create database data_manipulation_language_from_where;
use data_manipulation_language_from_where;

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

-- 1. Hiển thị tất cả người dùng tên là "Nguyen Le Minh"
select * from users where name = "Nguyen Le Minh";

-- 2. Tìm các sản phẩm có giá lớn hơn 30 triệu
select * from products where price > 30000000;

-- 3. Liệt kê người dùng sống ở thành phố "Ha Noi"
select * from addresses where city = "Ha Noi";

-- 4. Tìm các đơn hàng có trạng thái "Delivered"
select * from orders where status = "Delivered";

-- 5. Lấy danh sách sản phẩm thuộc danh mục "Laptop"
select * from categories where name = "Laptop";
select * from products where category_id = 2;

-- 6. Tìm người dùng được tạo sau ngày 2025-01-01
select * from users where created_at > "2025-01-01";

-- 7. Tìm đơn hàng của người dùng có ID là 5
select * from orders where user_id = 5;

-- 8. Tìm các sản phẩm có mô tả chứa từ “good”
select * from products where description like "%good%";

-- 9. Tìm người dùng có email chứa '@ut.edu.vn'
select * from users where email like "%@ut.edu.vn%";

-- 10. Tìm địa chỉ thuộc quốc gia “Viet Nam”
select * from addresses where country = "Viet Nam";

-- 11. Tìm các sản phẩm có giá từ 10 triệu đến 20 triệu
select * from products where price between 10000000 and 20000000;

-- 12. Tìm người dùng tên bắt đầu bằng “Nguyen”
select * from users where name like "Nguyen%";

-- 13. Tìm sản phẩm có giá dưới 1 triệu hoặc trên 40 triệu
select * from products where price < 1000000 or price > 40000000;

-- 14. Tìm người dùng có ID nằm trong danh sách (1, 2, 3)
select * from users where id in (1, 2,3 );

-- 15. Tìm các địa chỉ ở thành phố "Ha Noi" nhưng không phải ở quốc gia "Viet Nam"
select * from addresses where city = "Ha Noi" and country <> "Viet Nam";

-- 16. Tìm thông tin sản phẩm có id = 10
select * from products where id = 10;

























































