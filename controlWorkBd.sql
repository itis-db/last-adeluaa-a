-- Создаём таблицы
CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    category VARCHAR(50),
    price NUMERIC(10, 2)
);

CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    order_date DATE,
    customer_id INT
);

CREATE TABLE order_items (
    id SERIAL PRIMARY KEY,
    order_id INT REFERENCES orders(id),
    product_id INT REFERENCES products(id),
    quantity INT,
    amount NUMERIC(10, 2)
);

-- Очистка таблиц (если они уже есть)
TRUNCATE TABLE order_items, orders, products RESTART IDENTITY;

-- Добавляем товары
INSERT INTO products (name, category, price) VALUES
('Ноутбук Lenovo', 'Электроника', 45000.00),
('Смартфон Xiaomi', 'Электроника', 22000.50),
('Кофеварка Bosch', 'Бытовая техника', 15000.00),
('Футболка мужская', 'Одежда', 1500.00),
('Джинсы женские', 'Одежда', 3500.99),
('Шампунь Head&Shoulders', 'Косметика', 450.50),
('Книга "SQL для всех"', 'Книги', 1200.00),
('Монитор Samsung', 'Электроника', 18000.00),
('Чайник электрический', 'Бытовая техника', 2500.00),
('Кроссовки Nike', 'Одежда', 7500.00),
('Планшет Huawei', 'Электроника', 32000.00),
('Блендер Philips', 'Бытовая техника', 6500.00);

-- Добавляем заказы
INSERT INTO orders (order_date, customer_id) VALUES
('2025-05-01', 101),
('2025-05-03', 102),
('2025-05-05', 103),
('2025-05-10', 104),
('2025-05-15', 101),
('2025-05-20', 105),
('2025-06-01', 102),
('2025-06-02', 103),
('2024-05-01', 104),
('2024-05-15', 105),
('2024-06-01', 101);

-- Добавляем позиции заказов
INSERT INTO order_items (order_id, product_id, quantity, amount) VALUES
(1, 1, 1, 45000.00),
(1, 8, 1, 18000.00),
(2, 2, 1, 22000.50),
(2, 4, 2, 3000.00),
(3, 5, 1, 3500.99),
(3, 10, 1, 7500.00),
(3, 6, 3, 1351.50),
(4, 3, 1, 15000.00),
(4, 9, 1, 2500.00),
(5, 11, 1, 32000.00),
(5, 12, 1, 6500.00),
(6, 7, 5, 6000.00),
(7, 1, 1, 45000.00),
(7, 2, 1, 22000.50),
(8, 5, 2, 7001.98),
(9, 3, 1, 15000.00),
(9, 6, 2, 901.00),
(10, 4, 3, 4500.00),
(10, 10, 1, 7500.00),
(11, 7, 2, 2400.00),
(11, 11, 1, 32000.00);