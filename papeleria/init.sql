CREATE DATABASE IF NOT EXISTS DB_Yaml;
USE DB_Yaml;

-- Tabla de Productos
CREATE TABLE productos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL
);

-- Tabla de Clientes
CREATE TABLE clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefono VARCHAR(20)
);

-- Tabla de Ventas
CREATE TABLE ventas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id) ON DELETE SET NULL
);

-- Tabla de Detalles de Venta
CREATE TABLE detalles_venta (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_venta INT,
    id_producto INT,
    cantidad INT NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_venta) REFERENCES ventas(id) ON DELETE CASCADE,
    FOREIGN KEY (id_producto) REFERENCES productos(id) ON DELETE CASCADE
);

-- Tabla de Proveedores
CREATE TABLE proveedores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    contacto VARCHAR(100),
    telefono VARCHAR(20),
    direccion TEXT
);

-- 🚀 Insertar algunos datos de prueba
INSERT INTO Clientes (nombre, telefono, email) VALUES 
('Juan Pérez', '123456789', 'juan@example.com'),
('María García', '987654321', 'maria@example.com');

INSERT INTO Productos (nombre, precio, stock) VALUES 
('Cuaderno', 5.00, 50),
('Lapicero', 2.50, 100),
('Borrador', 1.00, 30);

INSERT INTO Proveedores (nombre, telefono, email) VALUES 
('Papelera S.A.', '321654987', 'contacto@papelera.com');

-- 🚀 Querys adicionales (eliminación, actualización y joins)
-- 🔹 Actualizar el stock de un producto
UPDATE Productos SET stock = stock - 5 WHERE id = 1;

-- 🔹 Eliminar un cliente
DELETE FROM Clientes WHERE id = 2;

-- 🔹 Consultar ventas con INNER JOIN
SELECT Ventas.id, Clientes.nombre AS Cliente, Ventas.fecha, Ventas.total
FROM Ventas
INNER JOIN Clientes ON Ventas.cliente_id = Clientes.id;

-- 🔹 Consulta con LEFT JOIN (muestra todas las ventas, incluso si no tienen cliente asociado)
SELECT Ventas.id, Clientes.nombre AS Cliente, Ventas.fecha, Ventas.total
FROM Ventas
LEFT JOIN Clientes ON Ventas.cliente_id = Clientes.id;

-- 🔹 Consulta con RIGHT JOIN (muestra todos los clientes, incluso si no tienen ventas)
SELECT Ventas.id, Clientes.nombre AS Cliente, Ventas.fecha, Ventas.total
FROM Ventas
RIGHT JOIN Clientes ON Ventas.cliente_id = Clientes.id;
