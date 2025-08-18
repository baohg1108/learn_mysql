create database sub_queries;
use sub_queries;

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



-- 1. Tìm sản phẩm có giá cao nhất: Viết truy vấn để tìm tên của sản phẩm có giá cao nhất trong bảng products.
select id, name, price 
from products
where price = ( select max(price) from products);


-- 2. Tìm người dùng có địa chỉ ở Hà Nội: Tìm tên và email của tất cả người dùng sống ở "Ha Noi".
select users.id, users.name, addresses.city 
from users
join addresses on users.id=addresses.user_id
where addresses.city like "%Ha Noi%";


-- 3. Liệt kê sản phẩm có giá thấp hơn giá trung bình: Hiển thị tên và giá của các sản phẩm có giá thấp hơn giá trung bình của tất cả sản phẩm.
select products.id, products.name, products.price
from products
where price < (select avg(price) from products);

-- 4. Tìm các danh mục không có sản phẩm: Tìm tên của các danh mục không có bất kỳ sản phẩm nào.
select categories.name
from categories
left join products on products.category_id=categories.id
where products.id is null;


-- 5. Tìm các đơn hàng đang chờ xử lý: Hiển thị user_id và order_date của các đơn hàng có trạng thái là 'Pending
select orders.user_id, orders.order_date, orders.status
from orders
where orders.status = "Pending";


-- 6. Hiển thị người dùng đã có đơn hàng: Liệt kê tên của tất cả người dùng đã đặt ít nhất một đơn hàng.
select users.name
from users
join orders on orders.user_id=users.id
group by users.name;

select distinct users.id, users.name
from users
join orders on orders.user_id=users.id;

-- 7.Sản phẩm đắt nhất trong mỗi danh mục: Hiển thị tên sản phẩm, giá và tên danh mục của sản phẩm đắt nhất trong từng danh mục.
select products.name as product_name, products.price, categories.name as category_name
from products 
inner join categories on categories.id=products.category_id
where products.price = (
	select max(products.price)
    from products
    where products.id=products.id
);

select p.name as product_name, p.price, c.name as category_name
from products as p
inner join categories as c on c.id=p.category_id
where p.price = (
	 select max(p2.price)
     from products as p2
     where p2.category_id=p.category_id
);

-- 8. Tìm người dùng sống ở Ho Chi Minh và đã có đơn hàng: Liệt kê tên người dùng đáp ứng cả hai điều kiện trên.
select users.name
from users
where users.id in (select user_id from addresses where addresses.city = "Ho Chi Minh")
and 
users.id in (select user_id from orders);


-- 9. Liệt kê tên và email của người dùng có đơn hàng 'Delivered': Hiển thị danh sách người dùng đã nhận được hàng.
select users.name, users.email, orders.status
from users
join orders on orders.user_id=users.id
where orders.status in (select orders.status from orders where orders.status = "Delivered");

select users.name, users.email, orders.status
from users
join orders on orders.user_id=users.id
where orders.status = "Delivered";


-- 10. Tìm sản phẩm có giá cao hơn giá của 'MacBook Air M3': Hiển thị tên và giá của các sản phẩm có giá cao hơn MacBook Air M3.
select products.id, products.name , products.price
from products
where products.price > (select products.price from products where products.name = "MacBook Air M3");


-- hard
-- 11. Hiển thị số lượng sản phẩm trong mỗi danh mục: Hiển thị tên danh mục và số lượng sản phẩm của nó.
select c.name as category_name, count(p.id) as total_product 
from categories as c
left join products as p on p.category_id=c.id
group by c.id, c.name;

/* 12. Tìm người dùng đã đặt nhiều đơn hàng hơn mức trung bình: Hiển thị tên của người dùng có số lượng đơn hàng cao hơn số đơn hàng trung 
bình của tất cả người dùng.



Gợi ý: Dùng truy vấn con để tính số lượng đơn hàng trung bình, sau đó dùng truy vấn con tương quan để so sánh.

Cập nhật trạng thái đơn hàng thành 'Shipped' cho người dùng ở 'Ho Chi Minh': Viết một câu lệnh UPDATE sử dụng truy vấn con để xác định user_id.

Gợi ý: Truy vấn con sẽ lấy user_id từ bảng addresses.

Hiển thị tên người dùng và tổng giá trị đơn hàng của họ (giả định): Giả sử mỗi đơn hàng chỉ có một sản phẩm duy nhất. Hãy hiển thị tên người dùng và giá của sản phẩm trong đơn hàng của họ.

Gợi ý: Cần một truy vấn con để lấy giá sản phẩm, sau đó dùng truy vấn tương quan.

Tìm sản phẩm có giá nằm trong khoảng 10% giá của sản phẩm đắt nhất: Hiển thị tên và giá của các sản phẩm có giá lớn hơn 90% giá của sản phẩm đắt nhất.

Gợi ý: Dùng truy vấn con vô hướng để tìm MAX(price).

Tìm người dùng không có đơn hàng: Liệt kê tên của người dùng chưa từng đặt bất kỳ đơn hàng nào.

Gợi ý: Dùng NOT IN với truy vấn con trên bảng orders.

Xóa tất cả đơn hàng của người dùng không có địa chỉ: Viết một câu lệnh DELETE dùng truy vấn con để tìm các user_id không tồn tại trong bảng addresses.

Gợi ý: Dùng NOT IN để lọc user_id.

Hiển thị tên người dùng và số lượng đơn hàng của họ: Liệt kê tên của tất cả người dùng và tổng số đơn hàng mà họ đã đặt.

Gợi ý: Dùng truy vấn con trong mệnh đề SELECT để đếm đơn hàng cho mỗi người dùng.

Tìm những người dùng có địa chỉ và đã có đơn hàng: Liệt kê tên của những người dùng có mặt trong cả hai bảng addresses và orders.

Gợi ý: Sử dụng IN hoặc EXISTS với truy vấn con.

Tìm các danh mục có ít hơn 3 sản phẩm: Liệt kê tên các danh mục có số lượng sản phẩm nhỏ hơn 3.

Gợi ý: Dùng GROUP BY và HAVING với truy vấn con.

Hiển thị tên sản phẩm và tên danh mục của nó mà không cần JOIN: Dùng truy vấn con để lấy tên danh mục cho từng sản phẩm.

Gợi ý: Dùng truy vấn con vô hướng trong mệnh đề SELECT.

Tìm các sản phẩm có giá thấp nhất trong mỗi danh mục: Hiển thị tên sản phẩm, giá và tên danh mục của sản phẩm rẻ nhất trong từng danh mục.

Gợi ý: Dùng truy vấn con tương quan, tương tự như bài tập số 7.

Tìm tên người dùng và trạng thái đơn hàng của họ (nếu có): Hiển thị tất cả người dùng và trạng thái của đơn hàng cuối cùng của họ (nếu có).

Gợi ý: Dùng LEFT JOIN và truy vấn con để tìm đơn hàng mới nhất.

Đếm số lượng người dùng sống ở mỗi thành phố: Liệt kê tên thành phố và số lượng người dùng sống ở đó.

Gợi ý: Dùng GROUP BY trên cột city.

Tìm người dùng đã đặt đơn hàng có trạng thái 'Delivered' và sống ở 'Ho Chi Minh': Liệt kê tên của họ.

Gợi ý: Kết hợp hai truy vấn con với toán tử AND.

Xóa tất cả người dùng không có đơn hàng: Viết một câu lệnh DELETE sử dụng truy vấn con.

Gợi ý: Dùng NOT IN để xác định các user_id cần xóa.

Hiển thị tên và giá của sản phẩm có giá cao hơn giá trung bình của danh mục của nó: Đây là một bài toán kinh điển về truy vấn tương quan.

Gợi ý: Dùng truy vấn con tương quan để tính giá trung bình cho từng danh mục và so sánh.

Tìm các đơn hàng được đặt bởi người dùng đã đăng ký trước ngày '2025-01-01': Giả sử created_at trong bảng users có thể dùng để lọc.

Gợi ý: Dùng truy vấn con để lấy user_id từ bảng users dựa trên created_at.

Hiển thị tên người dùng và số lượng sản phẩm họ đã mua (giả định): Giả sử mỗi đơn hàng chứa một sản phẩm.

Gợi ý: Dùng truy vấn con để đếm số đơn hàng cho mỗi người dùng.

Tìm tên và email của những người dùng có số lượng đơn hàng cao nhất: Hiển thị tên của người dùng có số đơn hàng lớn nhất.

Gợi ý: Dùng hai truy vấn con lồng nhau. Truy vấn trong cùng tìm MAX của số đơn hàng, truy vấn ngoài cùng tìm người dùng có số đơn hàng bằng giá trị đó.
*/