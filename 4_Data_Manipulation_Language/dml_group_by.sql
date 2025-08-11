create database dml_group_by;
use dml_group_by;

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


-- GROUP BY (JOINs, FROM, WHERE)


-- 1. Đếm số người dùng theo thành phố. Đếm bao nhiêu user ở mỗi city trong bảng addresses.
-- FROM → WHERE → GROUP BY → HAVING → SELECT → ORDER BY → LIMIT / OFFSET
select city, count(distinct user_id) as user_count
from addresses
group by city
order by user_count desc;

-- 2.Đếm số người dùng theo quốc gia. Lấy country, đếm số user trong từng country.
select country, count(distinct user_id) as user_count
from addresses
group by country
order by user_count desc;

-- 3. Đếm số sản phẩm theo danh mục. Lấy category_id, đếm số sản phẩm mỗi category.
select category_id, count(*) as product_count
from products
group by category_id
order by product_count desc;

-- 4. Tổng giá sản phẩm trong mỗi danh mục. Tính tổng price theo từng category_id.
select category_id, sum(price) as product_sum
from products
group by category_id
order by product_sum desc;

-- 5. Tính giá trung bình của sản phẩm trong mỗi danh mục. Lấy category_id, tính AVG(price)
select category_id, avg(price) as price_avg
from products
group by category_id
order by price_avg desc;

-- 1. Đếm số người dùng theo thành phố (addresses.city).
select city, count(user_id) as user_count
from addresses
group by city
order by user_count desc;

-- 2. Đếm số user theo quốc gia (addresses.country).
select country , count(user_id) as country_count
from addresses
group by country
order by country_count desc;


-- 3. Đếm số sản phẩm theo danh mục (products.category_id).
select category_id, count(*) as product_count
from products
group by category_id
order by product_count desc;


-- 4. Tính tổng giá sản phẩm theo danh mục (products.category_id).
select category_id, sum(price) as price_sum
from products
group by category_id
order by price_sum desc;

-- 5. Tính giá trung bình sản phẩm theo danh mục (products.category_id).
select category_id, avg(price) as price_avg
from products
group by category_id 
order by price_avg desc;

-- 6. Đếm số đơn hàng theo trạng thái (orders.status).
select status, count(*) as status_count
from orders 
group by status
order by status_count desc;

-- 7. Đếm số user theo ngày tạo tài khoản (dựa vào ngày created_at trong users).
select created_at, count(id) as user_count
from users
group by created_at 
order by user_count;

-- 8. Tính tổng số đơn hàng mỗi user đã đặt (orders.user_id).
select user_id, count(*) as total_user 
from orders
group by user_id
order by total_user desc;

-- 9. Đếm số sản phẩm có cùng giá trong bảng products.
select price, count(*) as product_equal_price
from products
group by price
order by product_equal_price desc;

-- 10. Tính tổng giá sản phẩm theo từng mô tả (products.description).
select description , sum(price) as total_price_in_description
from products
group by description
order by total_price_in_description;

-- 11. Đếm số đơn hàng mỗi ngày (orders.order_date lấy phần ngày).
select order_date, count(*) as count_order_in_date
from orders
group by order_date
order by count_order_in_date;

-- 12. Đếm số địa chỉ theo thành phố (addresses.city).
select city, count(*) as city_count
from addresses 
group by city
order by city_count desc;


-- 13. Tính giá trung bình sản phẩm theo từng mô tả (products.description).
select description, avg(price) as product_avg_in_description
from products
group by description
order by product_avg_in_description;

-- 14. Đếm số đơn hàng mỗi trạng thái theo từng user (orders.user_id, orders.status).

-- 15. Tính tổng giá các sản phẩm theo từng mô tả (products.description).
select description, sum(price) as total_product_in_description
from products
group by description
order by total_product_in_description;


-- 16. Đếm số user theo tên (cột users.name) — để tìm tên bị trùng (ví dụ bạn thêm dữ liệu trùng tên).
select name, count(id) as count_id_in_name
from users
group by name
order by count_id_in_name;

-- 17. Đếm số sản phẩm theo tên (products.name) — tìm sản phẩm bị trùng.
select name, count(id) as count_product_in_name
from products
group by name
order by count_product_in_name;

-- 18. Tính tổng giá sản phẩm theo từng danh mục (category_id), sắp xếp theo tổng giá giảm dần.
select category_id, sum(price) as sum_product_in_category
from products
group by category_id
order by sum_product_in_category;

-- 19. Đếm số user theo email domain (ví dụ lấy phần sau dấu @ trong email).
select substring_index(email, "@", -1) as email_domain,
count(id) as count_user_in_domain
from users
group by email_domain
order by count_user_in_domain desc;

-- 20. Đếm số sản phẩm theo mô tả (products.description).
select description , count(id) as count_product_in_description
from products
group by description
order by count_product_in_description;
