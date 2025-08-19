create database joins_queries_inner_join;
use joins_queries_inner_join;

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


-- 1. Lấy danh sách tên người dùng và địa chỉ đường phố của họ.
select users.name, addresses.street
from users
inner join addresses on addresses.user_id=users.id;

select u.name, a.street
from users u
inner join addresses a on a.user_id=u.id; 

-- 2. Hiển thị tên sản phẩm và tên danh mục của chúng.
select products.name, categories.name
from products
inner join categories on categories.id=products.category_id;

select p.name as product_name, c.name as category_name
from products p
inner join categories c on c.id=p.category_id;


-- 3. Lấy tên người dùng và trạng thái đơn hàng của họ.
select users.name, orders.status
from users
inner join orders on orders.user_id=users.id;

select u.name, o.status
from users u
inner join orders o on o.user_id=u.id;

-- 4. Liệt kê tên sản phẩm và giá của chúng thuộc danh mục 'Laptop'.
select products.name as product_name, products.price, categories.name as category_name
from products
inner join categories on categories.id=products.category_id
where categories.name = "Laptop";

select p.name as product_name, p.price, c.name as category_name
from products p
inner join categories c on c.id=p.category_id
where c.name = "Laptop";

-- 5. Tìm tên người dùng đã đặt hàng có trạng thái 'Delivered'.
select users.name, orders.status
from users
inner join orders on orders.user_id=users.id
where orders.status = "Delivered";

select u.name, o.status
from users u
inner join orders o on o.user_id=u.id
where o.status = "Delivered";

-- 6. Hiển thị tên và email của những người dùng có địa chỉ ở 'Ha Noi'.
select users.name, users.email, addresses.city 
from users
inner join addresses on addresses.user_id=users.id
where addresses.city = "Ha Noi";

select u.name, u.email, a.city
from users u
inner join addresses a on a.user_id=u.id
where a.city = "Ha Noi";

-- 7. Tìm tên sản phẩm có giá lớn hơn 20,000,000 và thuộc danh mục 'Smartphone'.
select products.name as product_name, products.price, categories.name as category_name
from products
inner join categories on categories.id=products.category_id
where products.price > 20000000 and categories.name = "Smartphone";

select p.name
from products p
inner join categories c on c.id=p.category_id
where p.price > 20000000 and c.name = "Smartphone";


-- 8. Lấy tên người dùng và ngày đặt hàng của họ, sắp xếp theo ngày đặt hàng mới nhất.
select users.name, orders.order_date
from users
inner join orders on orders.user_id=users.id
order by orders.order_date desc;

select u.name, o.order_date
from users u
inner join orders o on o.user_id=u.id
order by o.order_date desc;

-- 9. Liệt kê tên danh mục và số lượng sản phẩm trong mỗi danh mục.
select c.name, count(p.id) as total_product_in_category
from categories c
inner join products p on p.category_id=c.id
group by c.name;

-- 10. Tìm tên người dùng và số lượng đơn hàng của họ, chỉ hiển thị những người có hơn 1 đơn hàng (mặc dù với dữ liệu này sẽ không có ai).
select u.name, count(o.id) as total_order
from users u
inner join orders o on o.user_id=u.id
group by u.name
having count(o.id) > 1;

