create database joins_queries_left_join;
use joins_queries_left_join;

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

-- 1. Liệt kê tất cả người dùng và địa chỉ của họ (nếu có)
select u.*, a.street, a.city, a.country
from users u
left join addresses a on a.user_id=u.id;

-- 2. Liệt kê tất cả người dùng và trạng thái đơn hàng của họ (nếu có)
select u.name, o.status
from users u
left join orders o on o.user_id=u.id;

-- 3. Liệt kê tất cả danh mục sản phẩm và các sản phẩm thuộc từng danh mục
select c.name as category_name, p.name as product_name
from categories c
left join products p on p.category_id=c.id;

-- 4. Liệt kê tất cả người dùng và địa chỉ, sắp xếp theo tên người dùng
select u.name, a.city
from users u
left join addresses a on a.user_id=u.id
order by u.name;

-- 5. Liệt kê tất cả sản phẩm và danh mục của chúng (nếu có), sắp xếp theo tên sản phẩm
select p.name as products_name, c.name as category_name
from products p
left join categories c on c.id=p.category_id
order by p.name;

-- 6. Liệt kê tất cả người dùng và đơn hàng của họ (nếu có), chỉ lấy đơn hàng có trạng thái là 'Pending'
select u.id, u.name, o.status
from users u
left join orders o on o.user_id=u.id and o.status = "Pending";

-- 7. Liệt kê tất cả người dùng và địa chỉ của họ, chỉ hiển thị những người dùng chưa có địa chỉ
select u.id, u.name
from users u
left join addresses a on a.user_id=u.id
where a.id is null;

-- 9. Liệt kê tất cả sản phẩm và danh mục của chúng, chỉ hiển thị những sản phẩm có giá lớn hơn 10.000.000
select p.name as product_name, c.name as category_name, format(p.price, 0) as price_vnd
from products p
inner join categories c on c.id=p.category_id
where p.price > 10000000;

-- 8. Liệt kê tất cả đơn hàng và tên người dùng tương ứng (nếu có)
select o.status, u.name
from orders o
left join users u on u.id=o.user_id;

-- 10. Liệt kê tất cả danh mục và các sản phẩm thuộc danh mục đó, nhưng chỉ hiển thị các sản phẩm có category_id là 1 (Smartphone)
select c.id as category_id, c.name as category_name, p.name as product_name
from categories c
left join products p on p.category_id=c.id
where p.category_id = 1;

-- 11. Liệt kê tất cả người dùng và số lượng đơn hàng của mỗi người (nếu có)
select u.id as user_id, u.name as user_name, count(o.id) as total_order_only_user
from users u
left join orders o on u.id=o.user_id 
group by u.id, u.name;

-- 12. Liệt kê tất cả danh mục và số lượng sản phẩm trong mỗi danh mục (nếu có)
select c.id as category_id, c.name as catgory_name, count(p.id) as total_product
from categories c
left join products p on c.id=p.category_id
group by c.id, c.name;

-- 13. Liệt kê tất cả người dùng và tổng số tiền của các đơn hàng của họ (giả định mỗi đơn hàng có 1 sản phẩm)
select u.id as user_id, u.name as user_name, sum(p.price) as total_price_only_user
from users u
left join orders o on u.id=o.user_id
left join products p on o.product_id=p.id
group by u.id, u.name;

-- 14. Tìm tất cả người dùng chưa có bất kỳ đơn hàng nào
select u.id, u.name, o.status
from users u
left join orders o on u.id=o.user_id
where o.id is null; 

-- 15. Tìm tất cả danh mục không có bất kỳ sản phẩm nào
select * from categories;
select c.id, c.name
from categories c
left join products p on c.id=p.category_id
where p.id is null;

-- 16. Liệt kê tất cả sản phẩm và tên danh mục của chúng. Nếu một sản phẩm không có danh mục, vẫn hiển thị sản phẩm đó.
select p.id as product_id, p.name as product_name, c.name as category_name
from products p 
left join categories c on p.category_id=c.id;

-- 17. Liệt kê tất cả người dùng và địa chỉ của họ. Hiển thị 'Chưa có địa chỉ' cho những người dùng không có địa chỉ:
select u.id as user_id, u.name as user_name, coalesce(a.city, "Chua co dia chi") as address_city
from users u
left join addresses a on u.id=a.user_id;

-- 18***. Liệt kê tất cả người dùng và trạng thái đơn hàng gần đây nhất của họ (nếu có)
select u.id as user_id, u.name as user_name, o.status as order_status
from users u
left join orders o on u.id=o.user_id 
and o.order_date = (
select max(order_date) from orders where user_id = u.id
);

-- 19. Liệt kê tất cả người dùng và địa chỉ của họ, sắp xếp những người có địa chỉ lên trước
select u.id as user_id, u.name as user_name, a.city as address_city
from users u
inner join addresses a on u.id=a.user_id
order by a.city;

-- 20. Liệt kê tất cả người dùng và email của họ, chỉ những người có ít nhất một đơn hàng
select u.id as user_id, u.name as user_name, u.email as user_email
from users u
left join orders o on u.id=o.user_id
group by u.id, u.name, u.email
having count(o.id) > 0;

-- 21. Liệt kê tất cả sản phẩm và tên danh mục của chúng, chỉ hiển thị sản phẩm thuộc danh mục có tên là 'Smartphone'
select p.id as product_id, p.name as product_name, c.name as category_name
from products p
inner join categories c on c.id=p.category_id
where c.name = "Smartphone";

-- 22. Liệt kê tất cả người dùng và số lượng đơn hàng của họ, chỉ hiển thị những người dùng có nhiều hơn 1 đơn hàng.
select u.id as user_id, u.name as user_name, count(o.id) as total_order_only_user
from users u 
left join orders o on u.id=o.user_id
group by u.id, u.name
having count(o.id) > 1;

-- 23. Tìm tên người dùng và tên đường phố của họ cho tất cả những người dùng có địa chỉ.
select u.id, u.name, a.street
from users u
left join addresses a on u.id=a.user_id 
where a.street is not null;

-- 24. Liệt kê tất cả danh mục và tổng giá trị của các sản phẩm trong mỗi danh mục (nếu có)
select * from categories;
select c.id as category_id, c.name as category_name, sum(p.price) as total_price
from categories c
left join products p on c.id=p.category_id
group by c.id, c.name
order by total_price desc;

-- 25. Tìm tên sản phẩm và tên danh mục của chúng. Nếu sản phẩm không có danh mục, vẫn hiển thị sản phẩm đó và cột danh mục là NULL
select p.id as product_id, p.name as product_name, c.name as category_name
from products p
left join categories c on c.id=p.category_id;

-- 26. Liệt kê tất cả người dùng và trạng thái đơn hàng của họ. Nếu người dùng chưa có đơn hàng, hiển thị 'Không có đơn hàng'
select u.id as user_id, u.name as user_name, ifnull(o.status, "Chua co don hang") as order_status
from users u 
left join orders o on u.id=o.user_id;

-- 27. Liệt kê tất cả người dùng và số lượng đơn hàng của họ, sắp xếp theo số lượng đơn hàng giảm dần
select u.id as user_id, u.name as user_name, count(o.id) as total_order
from users u 
left join orders o on u.id=o.user_id
group by u.id, u.name
order by total_order desc;

-- 28. Tìm tất cả các sản phẩm có giá nhỏ hơn 1.000.000 VNĐ và tên danh mục của chúng (nếu có)
select p.id as product_id, p.name as product_name, c.name as category_name
from products p 
left join categories c on c.id=p.category_id
where p.price < 1000000;

-- 29.  Liệt kê tất cả người dùng và thông tin địa chỉ của họ, bao gồm tên đường, thành phố và quốc gia
select u.id as user_id, u.name as user_anme, a.street as address_street, a.city as address_city, a.country as address_country
from users u 
left join addresses a on u.id=a.user_id;

-- 30. Liệt kê tất cả người dùng và tổng số đơn hàng của họ, chỉ hiển thị những người dùng có tổng số đơn hàng là 0.
select u.id as user_id, u.name as user_name, count(o.id) as total_order
from users u 
left join orders o on u.id=o.user_id
group by u.id, u.name
having count(o.id) = 0
order by total_order;

-- 31. 
-- 32***. Liệt kê tất cả các danh mục và tên của tất cả các sản phẩm có giá trị trung bình lớn hơn 15.000.000 VNĐ
select c.id as category_id
from products p
inner join categories c on c.id=p.category_id
group by c.id
having avg(price) > 15000000;

select c.id as category_id, c.name as category_name, p.name as product_name
from categories c 
left join products p on c.id=p.category_id
where c.id in (
select category_id from products group by category_id having avg(price) > 15000000 
)
order by c.id, p.name;

-- 33. Liệt kê tất cả người dùng và tổng số tiền của các đơn hàng có trạng thái 'Delivered' của họ

-- 34. Liệt kê tất cả người dùng đã đặt hàng ở thành phố 'Ha Noi"
select u.id as user_id, u.name as user_name
from users u 
left join orders o on u.id=o.user_id
left join addresses a on u.id=a.user_id 
where a.city = "Ha Noi";

-- 35. Tìm các danh mục không có sản phẩm nào có giá dưới 10.000.000 VNĐ.
select c.id as category_id, c.name as category_name
from categories c 
left join products p on c.id=p.category_id
group by c.id, c.name
having min(p.price) >= 10000000;

-- 36. Liệt kê tất cả người dùng đã có đơn hàng nhưng chưa có địa chỉ
select distinct u.id as user_id, u.name as user_name
from users u 
left join orders o on u.id=o.user_id
left join addresses a on u.id=a.user_id
where a.id is null;

-- 37. Liệt kê tất cả người dùng và số lượng đơn hàng của họ, bao gồm cả những người dùng chưa có đơn hàng. Sau đó, hiển thị 'Không có' thay cho 0.
select u.id as user_id, u.name as user_name, coalesce(count(o.id), "Khong co") as total_order
from users u 
left join orders o on u.id=o.user_id
group by u.id, u.name
order by u.id;

-- 38. Tìm các sản phẩm có giá cao nhất trong mỗi danh mục
select p.id as product_id, p.name as product_name, c.name as category_name
from products p 
left join categories c on c.id=p.category_id
where p.price = (select max(p2.price) from products p2 where p2.category_id = p.category_id)
order by c.name, p.price desc;

-- 39. Liệt kê tất cả người dùng và thông tin về đơn hàng của họ, chỉ hiển thị những người dùng có đơn hàng được tạo trong năm 2024 (giả định created_at trong năm 2024).
select * from orders;
select distinct u.id as user_id, u.name as user_name, o.order_date as order_date
from users u 
left join orders o on u.id=o.user_id
where o.order_date >= "2024-01-10" and o.order_date < "2025-01-01"
group by u.id, u.name, o.order_date;

-- 40. Tìm tên người dùng và email của những người dùng đã đặt hàng có trạng thái 'Pending'
select u.id as user_id, u.name as user_name, u.email as user_email, o.status
from users u 
left join orders o on u.id=o.user_id
where o.status = "Pending";

-- 41. Liệt kê tất cả các danh mục và số lượng sản phẩm của chúng, sắp xếp theo số lượng sản phẩm giảm dần. Các danh mục không có sản phẩm vẫn được hiển thị.
select c.id as category_id, c.name as category_name, count(p.id) as total_product
from categories c 
left join products p on c.id=p.category_id
group by c.id, c.name
order by count(p.id) desc;

-- 42***. Liệt kê tất cả người dùng và trạng thái của đơn hàng gần nhất của họ. Nếu không có đơn hàng, hiển thị 'Chưa có đơn hàng'.
select u.id as user_id, u.name as user_name, coalesce(o.status, "Chua co don hang") as order_status
from users u 
left join orders o on u.id=o.user_id and o.order_date = (
	select max(o2.order_date)
    from orders o2
    where o2.user_id=o.user_id
) 
order by u.id;

-- 44. Liệt kê tất cả người dùng và tên sản phẩm đắt nhất mà họ đã đặt hàng

/*
-- 45.Liệt kê tất cả các sản phẩm và tên danh mục của chúng. Thêm một cột mới 'Trạng thái' 
hiển thị 'Hàng cao cấp' nếu giá > 30.000.000 và 'Hàng phổ thông' nếu giá <= 30.000.000.
 Nếu sản phẩm không có danh mục, cột 'Trạng thái' vẫn hiển thị
*/
 -- 46. Tìm các người dùng không có bất kỳ đơn hàng nào có trạng thái 'Delivered'
-- 47. Liệt kê tất cả các thành phố nơi có người dùng đã đặt hàng.
select distinct a.city, o.status
from addresses a 
left join users u on u.id=a.user_id
left join orders o on u.id=o.user_id;

-- 48. Liệt kê tất cả các sản phẩm có giá thấp hơn giá trung bình của tất cả các sản phẩm.
select p.id as product_id, p.name as product_name, p.price
from products p
where p.price < (select avg(price) from products);

-- 49. Tìm tất cả người dùng có địa chỉ và đơn hàng ở cùng một thành phố.
select distinct u.id as user_id, u.name as user_name
from users u
left join addresses a on u.id=a.user_id
left join orders o on u.id=o.user_id
where a.city = o.city;

-- 50. Liệt kê tất cả người dùng và tổng số tiền của tất cả các đơn hàng của họ. Nếu tổng giá trị > 100.000.000, hiển thị 'Khách hàng VIP', ngược lại là 'Khách hàng thường'.
select u.id as user_id,
       u.name as user_name,
       case 
           when sum(p.price) > 100000000 then 'Khach hang VIP'
           else 'Khach hang thuong'
       end as customer_type,
       coalesce(sum(p.price), 0) as total_price
from users u
left join orders o on u.id = o.user_id
left join products p on o.product_id = p.id
group by u.id, u.name
order by total_price desc;


















