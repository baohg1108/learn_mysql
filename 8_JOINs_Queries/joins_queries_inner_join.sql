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

-- 11. Tính tổng giá trị (không phải số lượng) của tất cả sản phẩm trong mỗi danh mục.
select c.name, sum(p.price) as total_price
from categories c
inner join products p on p.category_id=c.id
group by c.name;

-- 12. Tìm tên người dùng và thành phố của họ, nhưng chỉ cho những người dùng có email chứa 'ut.edu.vn'.
select u.name, a.city
from users u
inner join addresses a on a.user_id=u.id
where u.email like "%ut.edu.vn%";

-- 13. Liệt kê các danh mục có sản phẩm giá trung bình trên 15,000,000.
select c.name, avg(p.price) as avg_product_price
from categories c
inner join products p on p.category_id=c.id
group by c.name
having avg(p.price > 15000000);

-- 14. 
-- 15.  Hiển thị tên người dùng và trạng thái đơn hàng của họ, chỉ cho những người dùng có địa chỉ ở 'Ho Chi Minh'.
select u.name, o.status
from users u
inner join orders o on o.user_id=u.id
inner join addresses a on a.user_id=u.id
where a.city = "Ho Chi Minh";

-- 16. Đếm số đơn hàng cho mỗi trạng thái.
select o.status, count(*) as toatl_order
from orders o
group by o.status;

-- 17. Tìm tên người dùng và tổng số đơn hàng đã được giao ('Delivered').
select u.name, count(o.id) as total_order_delivered
from users u
inner join orders o on o.user_id=u.id
group by u.name;

-- 18. Liệt kê tên các danh mục có ít nhất 5 sản phẩm.
select c.name, count(p.id) as total_product_category
from categories c
inner join products p on p.category_id=c.id
group by c.name
having count(p.id) >= 5;

-- 19. 
-- 20. Lấy tên người dùng và ngày đặt hàng của họ, sắp xếp theo tên người dùng.
select u.name, o.order_date
from users u
inner join orders o on o.user_id=u.id
order by u.name;

-- 21. Hiển thị tên người dùng, email và thành phố của họ.
select u.name, u.email, a.city
from users u
inner join addresses a on a.user_id=u.id;

-- 22. Lấy tên sản phẩm, giá và tên danh mục của sản phẩm.
select p.name as product_name, p.price, c.name as category_name
from products p
inner join categories c on c.id=p.category_id;

-- 23.  Tìm tên người dùng, địa chỉ (đường phố, thành phố) và trạng thái đơn hàng của họ.
select u.name, a.street, a.city, o.status
from users u
inner join addresses a on a.user_id=u.id
inner join orders o on o.user_id=u.id;

-- 24. Hiển thị tên người dùng và ngày đặt hàng của những người dùng có địa chỉ ở 'Ho Chi Minh' và đơn hàng có trạng thái 'Shipped'.
select u.name, o.order_date
from users u
inner join orders o on o.user_id=u.id
inner join addresses a on a.user_id=u.id
where a.city = "Ho Chi Minh" and o.status = "Delivered";

-- 25.  
-- 26. Liệt kê tên người dùng và thành phố của họ, chỉ cho những người dùng đã có đơn hàng.
select u.name, a.city
from users u
inner join addresses a on a.user_id=u.id
inner join orders o on o.user_id=u.id;

-- 27. Tìm tên các danh mục có sản phẩm giá cao nhất.
select c.name, max(p.price)
from categories c
inner join products p on p.category_id=c.id
group by c.name
order by max(p.price) desc;
-- limit 1;

-- 28.  Hiển thị tên người dùng, trạng thái đơn hàng và thành phố của họ, sắp xếp theo tên người dùng.
select u.name, o.status, a.city
from users u
inner join orders o on o.user_id=u.id
inner join addresses a on a.user_id=u.id
order by u.name;

-- 29. Đếm số sản phẩm trong mỗi danh mục và hiển thị tên danh mục đó.
select c.name, count(p.id) as total_product_in_category
from categories c 
inner join products p on p.category_id=c.id
group by c.name;

-- 30.  Tìm tên người dùng, email, và số lượng đơn hàng của họ.
select u.name, u.email, count(o.id) as total_order_only_person
from users u
inner join orders o on o.user_id=u.id
group by u.name, u.email;

-- 31. Tìm tên người dùng có đơn hàng 'Shipped' và sống ở 'Ho Chi Minh'.
select u.name, o.status, a.city
from users u
inner join orders o on o.user_id=u.id
inner join addresses a on a.user_id=u.id
where o.status = "Shipped" and a.city = "Ho Chi Minh";

select distinct u.id, u.name
from users u
inner join orders o on o.user_id=u.id
inner join addresses a on a.user_id=u.id
where o.status = "Shipped" and a.city = "Ho Chi Minh";

-- 32. Liệt kê tên sản phẩm và tên danh mục của những sản phẩm có giá trên 10,000,000.
select p.name as product_name, c.name as category_name
from products p
inner join categories c on c.id=p.category_id
where p.price > 10000000;

-- 33. Tìm tên người dùng và số lượng đơn hàng của họ, chỉ hiển thị những người dùng có địa chỉ ở 'Ha Noi'.
select u.name, count(o.id) as total_order_only_person
from users u 
inner join orders o on o.user_id=u.id
inner join addresses a on a.user_id=u.id
where a.city = "Ha Noi"
group by u.name;

-- 34. Tìm tên danh mục có giá sản phẩm trung bình cao nhất.
select c.name, avg(p.price) as avg_product_only_category 
from categories c 
inner join products p on p.category_id=c.id
group by c.name
order by avg(p.price) desc
limit  1;

-- 35. Lấy tên người dùng và ngày đặt hàng của họ, chỉ cho những đơn hàng có trạng thái 'Pending'.
select u.name, o.order_date
from users u
inner join orders o on o.user_id=u.id
where o.status = "Pending";

-- 36. Liệt kê tên người dùng và thành phố của họ, sắp xếp theo thành phố, sau đó theo tên người dùng.
select u.name, a.city 
from users u
inner join addresses a on a.user_id=u.id
order by a.city, u.name;

-- 37. Tìm tổng số sản phẩm và tổng giá trị của tất cả sản phẩm trong danh mục 'Laptop'.
select count(p.id) as total_product_in_category_laptop, sum(p.price) as total_price_in_category_laptop
from products p 
inner join categories c on c.id=p.category_id
where c.name = "Laptop";

-- 38.  Hiển thị tên người dùng và số lượng đơn hàng đã giao (Delivered) của họ.
select u.name, count(o.id) as total_order_is_delivered
from users u
inner join orders o on o.user_id=u.id
where o.status = "Delivered"
group by u.name;

-- 39. Tìm tên các danh mục có tổng giá trị sản phẩm lớn hơn 50,000,000.
select c.name, sum(p.price) as total_price
from categories c
inner join products p on p.category_id=c.id
group by c.name
having sum(p.price) > 50000000;

-- 40. Liệt kê tên người dùng, ngày đặt hàng và thành phố của họ, chỉ cho những người dùng đã đặt hàng có trạng thái 'Delivered'.
select u.name, o.order_date, a.city
from users u
inner join orders o on o.user_id=u.id
inner join addresses a on a.user_id=u.id
where o.status = "Delivered";

-- 41. 
-- 42. Tìm tên người dùng và trạng thái đơn hàng của họ, chỉ hiển thị những người dùng có địa chỉ ở 'Da Nang' và đơn hàng có trạng thái 'Pending'.
select u.name, o.status 
from users u
inner join orders o on o.user_id=u.id
inner join addresses a on a.user_id=u.id
where a.city = "Da Nang" and o.status = "Pending";

-- 43.  Đếm số sản phẩm trong mỗi danh mục có giá dưới 1,000,000.
select c.name, count(p.id) as count_product
from categories c
inner join products p on p.category_id=c.id
where p.price < 1000000
group by c.name;

-- 44. Tìm tên danh mục có sản phẩm giá cao nhất, và tên của sản phẩm đó.
select c.name as category_name, p.name as product_name, p.price
from categories c
inner join products p on p.category_id=c.id
order by p.price desc limit 1;

-- 45. Liệt kê tên người dùng và tổng số đơn hàng đã đặt của họ, sắp xếp theo tổng số đơn hàng giảm dần.
select u.name, count(o.id) as total_order
from users u
inner join orders o on o.user_id=u.id
group by u.name
order by count(o.id) desc;

-- 46. Tìm tên sản phẩm, giá và tên danh mục của những sản phẩm không có mô tả (description là rỗng hoặc NULL).
select p.name as product_name, p.price, c.name as category_name
from products p
inner join categories c on c.id=p.category_id
where p.description = "" or p.description is null;

-- 47.  Liệt kê tên người dùng, email và ngày đặt hàng, chỉ cho những người dùng có địa chỉ ở 'Ho Chi Minh' và đã đặt hàng sau ngày 1 tháng 1 năm 2023. 
select u.name, u.email, o.order_date
from users u
inner join addresses a on a.user_id=u.id
inner join orders o on o.user_id=u.id
where a.city = "Ho Chi Minh" and o.order_date > "2023-01-01";


