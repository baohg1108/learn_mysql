create database advenced_functions;
use advenced_functions;

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
-- order_items
CREATE TABLE order_items (
    id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);
-- payment
CREATE TABLE payments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    amount DECIMAL(10,2) NOT NULL,
    payment_method ENUM('Credit Card', 'COD', 'Bank Transfer', 'E-Wallet') NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES orders(id)
);
-- reviews 
CREATE TABLE reviews (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    product_id INT,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);
-- suppliers
CREATE TABLE suppliers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    contact_email VARCHAR(100) UNIQUE,
    phone VARCHAR(20),
    address VARCHAR(255)
);
-- inventory
CREATE TABLE inventory (
    id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    stock_quantity INT NOT NULL,
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(id)
);
-- shipping
CREATE TABLE shipping (
    id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    address_id INT,
    shipping_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    delivery_date TIMESTAMP NULL,
    shipping_status ENUM('Pending', 'In Transit', 'Delivered', 'Returned') DEFAULT 'Pending',
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (address_id) REFERENCES addresses(id)
);



insert into users (name, email, password)  values
("Hoang Gia Bao", "bao@ut.edu.vn", "baostupid"),
("Nguyen Huu Tuan Khang", "khang@ut.edu.vn", "khanghoidau"),
("Van Ngoc Phuong", "phuongvn@ut.edu.vn", "phuongthichchi"),
("Ha Nguyen Dinh Phu", "phuhnd@ut.edu.vn", "phuyeunguyen"),
("Nguyen Le Minh", "minh@ut.edu.vn", "minhdeptrai"),
('Nguyen Van A', 'nguyenvana@email.com', 'password123'),
('Tran Thi B', 'tranthib@email.com', 'password456'),
('Le Van C', 'levanc@email.com', 'password789'),
('Pham Van D', 'phamvand@email.com', 'pass123'),
('Do Thi E', 'dothie@email.com', 'pass456'),
('Hoang Van F', 'hoangvanf@email.com', 'pass789'),
('Bui Thi G', 'buithig@email.com', 'pass111'),
('Vu Van H', 'vuvang@email.com', 'pass222'),
('Dang Thi K', 'dangthik@email.com', 'pass333'),
('Phan Van L', 'phanvanl@email.com', 'pass444'),
('Truong Thi M', 'truongthim@email.com', 'pass555'),
('Ngo Van N', 'ngovann@email.com', 'pass666'),
('Duong Thi O', 'duongthio@email.com', 'pass777'),
('Nguyen Van P', 'nguyenvanp@email.com', 'pass888'),
('Tran Thi Q', 'tranthiq@email.com', 'pass999'),
('Le Van R', 'levanr@email.com', 'pass101'),
('Pham Van S', 'phamvans@email.com', 'pass102'),
('Do Thi T', 'dothit@email.com', 'pass103'),
('Hoang Van U', 'hoangvanu@email.com', 'pass104'),
('Bui Thi V', 'buithiv@email.com', 'pass105');


insert into categories(name) values
("Smartphone"),
("Laptop"),
("Fashion"),
("Book"),
("Toy");


insert into products (name, description, price, category_id) values
("iPhone 15 Promax", "Smart Phone", 40000000.00, 1),
("iPhone 15 Pro", "Smart Phone", 35000000.00, 1),
("iPhone 15 Plus", "Stupid", 23450000.00, 1),
("iPhone 15", "Crazy", 15000000.00, 1),
("SamSung S21 Ultra","Good, Fast. Should buy fast", 23500000.00, 1),
("MacBook Air M3", "Very good", 29000000.00, 2),
("MacBook Air M1", "Very good hahaha", 21456000.00, 2),
("Dell XPS 5600", "Medium, hot", 21500040.00, 2),
("XP 6500", "bad, battery low", 9000000.00, 2),
("Gaming Tiger Nitro 5", "Very good - perfect", 39800000.00, 2),
("Men's vest", "ok", "5500000.00", 3),
("Jeans", "ok ", 300000.00, 3),
("Woman's dress", "fine", 800000.00, 3),
("Hat", "ok fine", 45000.00, 3),
("Doraemon", "ok-1", 99000.00, 4),
("Nobita", "ok-2", 59000.00, 4),
("Pikachu", "ok-3", 35000.00, 4),
("Naruto", "ok-4", "109000.00", 4),
("Ghost at Thailand", "crazy", 699000.00, 4),
("Gau bong hinh bong", "omggg", 19000.00, 5),
("Dat set nan", "", 49000.00, 5),
("Blind box", "good", 83000.00, 5),
("Sieu xe lamborghini","", 579000.00, 5),
("Dieu soc xam","",675000, 5);


insert into addresses (user_id, street, city, country) values 
(1, '123 Le Loi', 'Ha Noi', 'Viet Nam'),
(2, '456 Tran Hung Dao', 'Ho Chi Minh', 'Viet Nam'),
(3, '789 Nguyen Trai', 'Da Nang', 'Viet Nam'),
(4, '101 Hai Ba Trung', 'Ha Noi', 'Viet Nam'),
(5, '202 Pham Ngoc Thach', 'Ho Chi Minh', 'Viet Nam'),
(6, '303 Dinh Tien Hoang', 'Da Nang', 'Viet Nam'),
(7, '404 Ly Thai To', 'Ha Noi', 'Viet Nam'),
(8, '505 Cach Mang Thang 8', 'Ho Chi Minh', 'Viet Nam'),
(9, '606 3 Thang 2', 'Da Nang', 'Viet Nam'),
(10, '707 Le Duan', 'Ha Noi', 'Viet Nam'),
(11, '10 Phan Chu Trinh', 'Ha Noi', 'Viet Nam'),
(12, '20 Vo Van Tan', 'Ho Chi Minh', 'Viet Nam'),
(13, '30 Pasteur', 'Da Nang', 'Viet Nam'),
(14, '40 Nam Ky Khoi Nghia', 'Ha Noi', 'Viet Nam'),
(15, '50 Nguyen Thi Minh Khai', 'Ho Chi Minh', 'Viet Nam'),
(16, '60 Dien Bien Phu', 'Da Nang', 'Viet Nam'),
(17, '70 Ba Trieu', 'Ha Noi', 'Viet Nam'),
(18, '80 Tran Phu', 'Ho Chi Minh', 'Viet Nam'),
(19, '90 Nguyen Hue', 'Da Nang', 'Viet Nam'),
(20, '100 Hoang Hoa Tham', 'Ha Noi', 'Viet Nam'),
(21, '105 Hoang Hoa Tham', 'Ha Noi', 'Viet Nam'),
(22, '106 Hoang Hoa Tham', 'Ha Noi', 'Viet Nam'),
(23, '107 Hoang Hoa Tham', 'Ha Noi', 'Viet Nam');


insert into  orders (user_id, status) values
(1, 'Delivered'),
(2, 'Delivered'),
(3, 'Shipped'),
(4, 'Shipped'),
(5, 'Pending'),
(6, 'Delivered'),
(7, 'Pending'),
(8, 'Shipped'),
(9, 'Delivered'),
(10, 'Pending'),
(11, 'Delivered'),
(12, 'Shipped'),
(13, 'Pending'),
(14, 'Delivered'),
(15, 'Shipped'),
(16, 'Pending'),
(17, 'Delivered'),
(18, 'Shipped'),
(19, 'Delivered'),
(20, 'Pending'),
(21, 'Shipped'),
(22, 'Pending'),
(23, 'Delivered');

INSERT INTO suppliers (name, contact_email, phone, address) VALUES
('Apple Inc.', 'contact@apple.com', '+1-800-275-2273', 'Cupertino, USA'),
('Samsung Electronics', 'support@samsung.com', '+82-2-2255-0114', 'Seoul, Korea'),
('Dell Technologies', 'sales@dell.com', '+1-512-338-4400', 'Texas, USA'),
('Nike Fashion', 'fashion@nike.com', '+1-503-671-6453', 'Oregon, USA'),
('NXB Tre', 'book@nxbtre.vn', '+84-28-3829-9123', 'Ho Chi Minh, Viet Nam'),
('Lego Toys', 'lego@lego.com', '+45-79-50-60-70', 'Billund, Denmark');


INSERT INTO inventory (product_id, stock_quantity) VALUES
(1, 50),   -- iPhone 15 Promax
(2, 40),   -- iPhone 15 Pro
(6, 30),   -- MacBook Air M3
(10, 20),  -- Gaming Tiger Nitro 5
(11, 100), -- Men's vest
(15, 200), -- Doraemon (book)
(20, 500), -- Gau bong hinh bong
(23, 150); -- Sieu xe lamborghini


INSERT INTO order_items (order_id, product_id, quantity, price) VALUES
(1, 1, 1, 40000000.00),   -- user 1 mua iPhone 15 Promax
(2, 2, 1, 35000000.00),   -- user 2 mua iPhone 15 Pro
(3, 6, 1, 29000000.00),   -- user 3 mua MacBook Air M3
(4, 11, 2, 5500000.00),   -- user 4 mua 2 Men's vest
(5, 15, 3, 99000.00),     -- user 5 mua 3 Doraemon
(6, 20, 5, 19000.00),     -- user 6 mua Gau bong
(7, 23, 1, 579000.00),    -- user 7 mua Sieu xe lamborghini
(8, 10, 1, 39800000.00),  -- user 8 mua Gaming laptop
(9, 18, 1, 109000.00);    -- user 9 mua Naruto book


INSERT INTO payments (order_id, amount, payment_method) VALUES
(1, 40000000.00, 'Credit Card'),
(2, 35000000.00, 'Bank Transfer'),
(3, 29000000.00, 'Credit Card'),
(4, 11000000.00, 'E-Wallet'),
(5, 297000.00, 'COD'),
(6, 95000.00, 'COD'),
(7, 579000.00, 'E-Wallet'),
(8, 39800000.00, 'Credit Card'),
(9, 109000.00, 'Bank Transfer');


INSERT INTO reviews (user_id, product_id, rating, comment) VALUES
(1, 1, 5, 'Rất xịn, chạy mượt'),
(2, 2, 4, 'Đẹp nhưng hơi đắt'),
(3, 6, 5, 'Laptop siêu nhẹ, pin trâu'),
(4, 11, 3, 'Áo vest ổn, hơi chật'),
(5, 15, 5, 'Truyện Doraemon tuổi thơ'),
(6, 20, 4, 'Gấu bông đáng yêu'),
(7, 23, 2, 'Xe mô hình dễ gãy'),
(8, 10, 5, 'Laptop gaming cực mạnh'),
(9, 18, 4, 'Naruto đọc cuốn hút');


INSERT INTO shipping (order_id, address_id, shipping_date, delivery_date, shipping_status) VALUES
(1, 1, NOW(), NOW() + INTERVAL 2 DAY, 'Delivered'),
(2, 2, NOW(), NOW() + INTERVAL 3 DAY, 'Delivered'),
(3, 3, NOW(), NULL, 'In Transit'),
(4, 4, NOW(), NULL, 'In Transit'),
(5, 5, NOW(), NULL, 'Pending'),
(6, 6, NOW(), NOW() + INTERVAL 1 DAY, 'Delivered'),
(7, 7, NOW(), NULL, 'Pending'),
(8, 8, NOW(), NOW() + INTERVAL 5 DAY, 'Delivered'),
(9, 9, NOW(), NOW() + INTERVAL 2 DAY, 'Delivered');


-- 1. Lấy giá sản phẩm và hiển thị FLOOR(price/1000000) để biết giá theo đơn vị triệu.
select p.id as product_id, p.name as product_name, floor(p.price/1000000) as product_price
from products p;

-- 2. Tìm CEIL(price/1000000) của tất cả sản phẩm → giá làm tròn lên theo triệu.
select p.id as product_id, p.name as product_name, ceil(p.price/1000000) as product_price
from products p;

-- 3. Hiển thị ROUND(price, -3) (làm tròn đến nghìn) cho tất cả sản phẩm.
select p.id as product_id, p.name as product_name, round(p.price, -3) as product_price
from products p;

-- 4. Lấy ABS(price - 20000000) để xem mỗi sản phẩm cách xa giá 20 triệu bao nhiêu.
select p.id as product_id, p.name as product_name, abs(p.price) as product_price
from products p;

-- 5. Hiển thị MOD(id,2) để phân loại user thành nhóm chẵn/lẻ.
select u.id as user_id_normal, mod(u.id, 2) as user_id
from users u;

-- 6. Với tất cả sản phẩm, tính FLOOR(price/5000000) để chia nhóm theo bậc 5 triệu.
select p.id as product_id, p.name as product_name, floor(p.price/5000000) as product_price
from products p;

-- 7. Lấy CEIL(price/10000000) → số “chục triệu” của sản phẩm.
select p.id as product_id, p.name as product_name, ceil(p.price/10000000) as product_name
from products p;

-- 8. Hiển thị ROUND(price/3,2) → tính giá trung bình khi mua 3 sản phẩm.
select p.id as product_id, p.name as product_name, round(p.price/3, 2) as product_price
from products p;

-- 9. Dùng ABS() để tính chênh lệch giá giữa sản phẩm đắt nhất và rẻ nhất trong mỗi category.
select  c.name as category_name, abs(max(p.price) - min(p.price) ) as different_price
from products p
join categories c on c.id=p.category_id
group by  c.name
order by different_price desc;


-- 10. Tìm tất cả order_items và hiển thị tổng tiền (quantity*price) làm tròn nghìn (ROUND(...,-3)).
select * from order_items;
select oi.* , round(oi.quantity * oi.price, -3) as total_price
from order_items oi;

-- 11. Hiển thị số lượng sản phẩm mỗi category rồi chia cho 4 → CEIL(count/4) số nhóm cần.
select * from categories;
select c.id as category_id, c.name as category_name, ceil(count(p.id)/4) as total_product_in_category
from categories c 
join products p on c.id = p.category_id
group by c.id, c.name;


-- 12. Với user_id từ 1–20, dùng MOD(user_id,5) để chia thành 5 nhóm khách hàng.
select u.id as user_id_normal, mod(u.id,5) as user_id_group
from users u
where u.id  between 1 and 20
order by u.id;

-- 13. Hiển thị đơn hàng nào có số lượng sản phẩm (SUM(quantity)) là số chẵn (MOD(...,2)=0).
select oi.order_id as order_items_id, sum(oi.quantity) as total_quantity
from order_items oi 
group by oi.order_id
having mod(sum(oi.quantity), 2) = 0
order by oi.order_id;

-- 14. Lấy FLOOR(price*1.1) → tính giá sau khi tăng 10%, làm tròn xuống.
select * from products;
select p.id as product_id, p.name as product_name, p.price as product_price, floor(p.price*1.1) as product_price_increase
from products p
order by product_price_increase;

-- 15. Lấy CEIL(price*0.9) → tính giá sau khi giảm 10%, làm tròn lên.
select p.id as product_id, p.name as product_name, p.price as product_price_normal, ceil(p.price*0.9) as product_price_discount
from products p 
order by product_price_discount;

-- 16. Tính ROUND(AVG(price),0) cho từng category.
select c.id as category_id, c.name as category_name, round(avg(p.price), 0) as avg_price_round
from products p 
join categories c on c.id=p.category_id
group by c.id, c.name
order by avg_price_round;

-- 17. Hiển thị giá trị ABS(price - AVG(price)) để xem mỗi sản phẩm chênh lệch bao nhiêu so với trung bình category.


Với bảng payments, lấy ROUND(amount/1000,0) để biết số tiền thanh toán theo nghìn.

Dùng CEIL(SUM(amount)/1000000) để tính tổng doanh thu làm tròn lên theo triệu.

Với shipping, tính số ngày giao hàng ABS(DATEDIFF(delivery_date, shipping_date)).

Tính tổng tiền đơn hàng (SUM(quantity*price)), rồi chia cho 1.000.000 → CEIL để biết số “triệu”.

Lấy tất cả sản phẩm và hiển thị ROUND(price / (SELECT AVG(price) FROM products),2) → tỉ lệ giá so với trung bình.

Dùng MOD(order_id, 4) để phân loại đơn hàng thành 4 batch xử lý.

Tìm sản phẩm nào có MOD(price, 1000000) < 100000 → giá gần số tròn triệu.

Tính ROUND(SUM(amount)/COUNT(DISTINCT user_id),2) → trung bình chi tiêu mỗi khách.

Với bảng reviews, hiển thị ROUND(AVG(rating),1) mỗi sản phẩm.

Tính ABS(rating - 5) → khoảng cách so với điểm tuyệt đối.

Lấy CEIL(AVG(quantity)) số lượng trung bình sản phẩm mua trong mỗi order.

Tính số lượng sản phẩm tồn kho chia lô 50: CEIL(stock_quantity/50).

Tìm những sản phẩm có tồn kho MOD(stock_quantity,10)=0.

Hiển thị ROUND(price*exchange_rate,0) → giả sử đổi sang USD.

Tính FLOOR((price - MIN(price) OVER ())/1000000) → khoảng cách triệu đồng so với sản phẩm rẻ nhất.

Dùng MOD(id,7) → chia khách hàng thành nhóm theo ngày trong tuần.

Với bảng payments, tính ROUND(SUM(amount)/30,0) → trung bình doanh thu mỗi ngày trong tháng.

Tính ABS(SUM(quantity) - 100) trong mỗi đơn hàng → chênh lệch với mức 100 sản phẩm chuẩn.

C. Thực tế nâng cao (15 bài)

Tính chi phí vận chuyển giả định: ROUND(SUM(quantity*price)*0.05, -3) (5% giá trị đơn, làm tròn nghìn).

Xếp hạng khách hàng theo tổng chi tiêu, hiển thị cả ROUND(total/1000000,2) (tính bằng triệu).

Tìm sản phẩm nào có giá gần nhất với 20 triệu (ABS(price-20000000) nhỏ nhất).

Với mỗi order, tính số lượng sản phẩm trung bình, làm tròn lên: CEIL(AVG(quantity)).

Tìm đơn hàng nào có tổng tiền là bội số của 1 triệu (MOD(SUM(quantity*price),1000000)=0).

Tính ROUND(AVG(ABS(rating-AVG(rating) OVER (PARTITION BY product_id)))) → mức chênh lệch review trong cùng sản phẩm.

Với shipping, tính ABS(DATEDIFF(delivery_date, order_date)) → thời gian từ đặt đến nhận.

Dùng FLOOR(price/5000000) để phân sản phẩm thành phân khúc (0=giá thấp, 1=trung, 2=cao...).

Tính phần trăm tồn kho còn lại so với mức chuẩn 200: ROUND(stock_quantity/200*100,0).

Tìm khách hàng nào có MOD(user_id,10)=0 → dùng để random lucky draw.

Với payments, tính số tiền trung bình làm tròn về trăm ngàn: ROUND(AVG(amount),-5).

Hiển thị tất cả sản phẩm có giá trị CEIL(price/1234567) để test scaling bất thường.

Tính số tuần trung bình giao hàng: ROUND(AVG(ABS(DATEDIFF(delivery_date, shipping_date))/7),1).

Tìm top sản phẩm có ABS(price-AVG(price) OVER()) nhỏ nhất (giá gần trung bình toàn thị trường).

Với orders, chia nhóm xử lý dựa trên MOD(order_id,3) và tính tổng tiền mỗi nhóm.
*/

