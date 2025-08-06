create database data_manipulation_language_joins;
use data_manipulation_language_joins;

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


/*Bài tập Left join*/
-- 1. Liệt kê tất cả người dùng và địa chỉ (nếu có).
select u.id, u.name, a.street, a.city, a.country
from users u
left join addresses a on u.id=a.user_id;

-- 2. Liệt kê tất cả người dùng và đơn hàng (nếu có).
select u.id, u.name, o.status, o.order_date
from users u
left join orders o on u.id=o.user_id;

-- 3. Liệt kê tất cả sản phẩm và tên danh mục (nếu có).
select p.id, p.name, c.name as category_name
from products p
left join categories c on p.category_id=c.id;

-- 4. Tìm người dùng chưa có địa chỉ.
select u.id, u.name, a.street, a.city, a.country
from users u
left join addresses a on u.id=a.user_id
where a.id is null;
-- ở đây lấy .id vif id là khóa chính và nó không bao giờ null. .street hay .city vẫn ok nếu trong create table có trường not null;

-- 5. Tìm người dùng chưa có đơn hàng.
select u.id, u.name
from users u
left join orders o on u;

-- 6. Tìm sản phẩm không thuộc danh mục nào.
select p.id, p.name
from products p
left join categories c on p.category_id=c.id
where c.id is null;

-- 7. Hiển thị người dùng và tất cả đơn hàng của họ (kể cả khi chưa có đơn).
select u.id, u.name, o.id as order_id, o.status
from users u
left join orders o on u.id=o.user_id;

-- 8. Hiển thị đơn hàng và địa chỉ giao hàng của người đặt (nếu có).
select o.id, o.status, a.street, a.city
from orders o
left join addresses a on o.user_id=a.user_id;


-- 9. Liệt kê tất cả địa chỉ và thông tin người dùng (nếu có).
select a.street, a.city, a.country, u.id, u.name, u.email
from addresses a
left join users u on a.user_id=u.id;

-- 10. Liệt kê tất cả danh mục và sản phẩm (nếu có).
select c.id, c.name, p.id as product_id, p.name
from categories c 
left join products p on c.id=p.category_id;


-- 11. Tìm danh mục chưa có sản phẩm nào.
select c.id, c.name
from categories c
left join products p on c.id=p.category_id
where p.id is null;

-- 12. Liệt kê sản phẩm cùng với địa chỉ người tạo (nếu có)
select p.id as product_id, p.name as product_name , u.id as user_id, u.name as user_name, a.street, a.city
from products p
left join users u on p.user_id=u.id
left join addresses a on u.id=a.user_id;





/* Bài tập INNER JOIN (Thực tế)
INNER JOIN chỉ trả về các bản ghi có liên kết ở cả hai bảng.*/

-- 1. Liệt kê tên người dùng và thành phố họ sống.
select users.name, addresses.city
from users
inner join addresses on users.id=addresses.user_id;

select u.name , a.city
from users u
inner join addresses a on u.id=a.user_id;


-- 2. Liệt kê người dùng có địa chỉ ở “Ha Noi”.
select users.name , addresses.city
from users
inner join addresses on users.id=addresses.user_id
where addresses.city = "Ha Noi";

select u.name , a.city
from users u
inner join addresses a on u.id=a.user_id
where a.city = "Ha Noi";


-- 3. Liệt kê người dùng cùng với địa chỉ đầy đủ của họ.
select  users.name, addresses.street, addresses.city, addresses.country
from users
inner join addresses on users.id=addresses.user_id;

select u.name, a.street, a.city, a.country
from users u
inner join addresses a on u.id=a.user_id;

-- 4. Tìm email của những người sống tại “Da Nang”.
select users.email, addresses.city
from users
inner join addresses on users.id=addresses.user_id
where addresses.city = "Da Nang";

select u.email, a.city
from users u
inner join addresses a on u.id=a.user_id
where a.city = "Da Nang";


-- 5. Tìm tất cả người dùng và quốc gia họ ở.
select users.*, addresses.country
from users
inner join addresses on users.id=addresses.user_id;

select u.*, a.city
from users u
inner join addresses a on u.id=a.user_id;

-- 6. Liệt kê tên người dùng và trạng thái đơn hàng của họ.
select users.name, orders.status
from users
inner join orders on users.id=orders.user_id;

select u.name, o.status
from users u
inner join orders o on u.id=o.user_id;


-- 7. Tìm những người có đơn hàng đã được giao (Delivered).
select users.id, users.name, orders.id, orders.status
from users
inner join orders on users.id=orders.user_id
where orders.status = "Delivered";

select u.id, u.name, o.id, o.status
from users u
inner join orders o on u.id=o.user_id
where o.status = "Delivered";


-- 8. Liệt kê những người dùng chưa có đơn hàng (NOT IN, LEFT JOIN sẽ dùng sau).


-- 9. Hiển thị tất cả thông tin người dùng và ngày đặt đơn hàng.
select users.*, orders.order_date
from users
inner join orders on users.id=orders.user_id;

select u.* , o.order_date
from users u
inner join orders o on u.id=o.user_id;

-- 10. Thống kê số lượng đơn hàng mỗi người dùng đã đặt.
select users.*, orders.*
from users
inner join orders on users.id=orders.user_id;


-- 11. Liệt kê tên sản phẩm và danh mục của sản phẩm đó.
select products.id , products.name, categories.name
from products
inner join categories on products.category_id=categories.id;

select p.id, p.name, c.name
from categories c
inner join products p on c.id=p.category_id;

-- 12. Liệt kê tất cả sản phẩm thuộc danh mục “Laptop”.
select products.*, categories.name
from products
inner join categories on categories.id=products.category_id
where categories.name = "Laptop";

select p.*, c.name
from products p
inner join categories c on p.category_id=c.id
where c.name = "Laptop";

-- 13. Liệt kê tất cả sản phẩm có giá trên 20 triệu và danh mục của chúng.
select products.*, categories.name
from products
inner join categories on products.category_id=categories.id
where products.price > 20000000;

select p.*, c.name
from products p
inner join categories c on p.category_id=c.id
where p.price > 20000000;

-- 14. Tìm tên sản phẩm cùng với tên danh mục và mô tả sản phẩm.
select products.id, products.name, categories.name, products.description
from products
inner join categories on products.category_id=categories.id;

select p.id, p.name, c.name, p.description
from products p
inner join categories c on p.category_id=c.id;

-- 15. Tìm các sản phẩm có trong danh mục “Toy” và giá < 100000.
select products.*, categories.name
from products
inner join categories on products.category_id=categories.id
where categories.name = "Toy" and products.price < 100000;

select p.*, c.name
from products p
inner join categories c on p.category_id=c.id
where c.name = "Toy" and p.price < 100000;


-- 16. Liệt kê tất cả đơn hàng, tên người đặt và trạng thái.
select orders.id, orders.order_date,  users.name, orders.status 
from orders
inner join users on orders.user_id=users.id;

select o.id, o.order_date, u.name, o.status
from orders o
inner join users u on u.id=o.user_id;

-- 17. Liệt kê email người dùng và trạng thái đơn hàng của họ.
select users.id, users.email, orders.status
from users
inner join orders on users.id=orders.user_id;

select u.id, u.email, o.status
from users u
inner join orders o on u.id=o.user_id;

-- 18. Tìm người dùng có nhiều hơn 1 đơn hàng.

-- 19. Thống kê tổng số đơn hàng theo từng trạng thái.


-- 20. Liệt kê những người dùng có đơn hàng được giao (Delivered), kèm theo ngày đặt.
select users.id, users.name, orders.status, orders.order_date
from users
inner join orders on users.id=orders.user_id;

select u.id, u.name, o.status, o.order_date
from users u
inner join orders o on u.id=o.user_id;


-- 21. Hiển thị mỗi sản phẩm cùng với tên danh mục và giá.
select products.id, products.name, categories.name, products.price
from products
inner join categories on products.category_id=categories.id;

select p.id, p.name, c.name, p.price
from products p
inner join categories c on p.category_id=c.id;

-- 22. Tìm tất cả sản phẩm có giá lớn nhất trong từng danh mục.


-- 23. Hiển thị sản phẩm thuộc danh mục “Smartphone” có giá dưới 30 triệu.
select categories.id, categories.name, products.id, products.name, products.price
from categories
inner join products on categories.id=products.category_id
where categories.name = "Smartphone" and products.price < 30000000;

-- 24. Liệt kê tất cả sản phẩm và phân nhóm theo tên danh mục.


-- 25. Tính trung bình giá sản phẩm của mỗi danh mục.


-- 26. Liệt kê tên người dùng, địa chỉ, và trạng thái đơn hàng.
select users.id, users.name, addresses.street, addresses.city, addresses.country, orders.id, orders.status
from users
inner join addresses on users.id=addresses.user_id
inner join orders on users.id=orders.user_id;

-- 27. Hiển thị tên người dùng, tên sản phẩm đã mua (nếu có), và ngày đặt hàng (giả định có thêm bảng order_items — bạn có thể tạo thêm).

-- 28. Liệt kê tất cả người dùng cùng với địa chỉ và tổng số đơn hàng.

-- 29. Liệt kê người dùng sống tại “Ho Chi Minh” có đơn hàng đã giao.

-- 30. Liệt kê danh mục có ít nhất một sản phẩm giá > 10 triệu.




