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