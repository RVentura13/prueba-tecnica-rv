

-- Seccion 4

-- 4.2 *****************************************************************
-- Consulta ejemplo de subconsunlta
SELECT * FROM empleados
WHERE sueldo >=(
    SELECT AVG(sueldo)
    FROM empleados
)



-- 4.3 *****************************************************************
-- Tabla
CREATE TABLE empleados(
    id INT PRIMARY KEY,
    nombre VARCHAR(100),
    salario DECIMAL(6,2)
    );

-- Consulta
SELECT id, nombre, salario
FROM empleados
ORDER BY salario DESC
LIMIT 3;



-- 4.4 *****************************************************************
-- Tabla departamentos
CREATE TABLE departamentos(
    id INT PRIMARY KEY,
    nombre VARCHAR(50)
);

-- Tabla empleados
CREATE TABLE empleados(
    id INT PRIMARY KEY,
    nombre VARCHAR(100),
    salario DECIMAL(6,2),
    departamento_id INT,
    FOREIGN KEY (departamento_id) REFERENCES departamentos(id)
);

-- Consulta
SELECT d.nombre AS nombre_departamento, COUNT(e.id) AS numero_de_empleados
FROM departamentos d
LEFT JOIN empleados e ON d.id = e.departamento_id
GROUP BY d.nombre;



-- 4.5 *****************************************************************
-- Tablas
CREATE TABLE clientes(
    id INT PRIMARY KEY,
    nombre VARCHAR(100),
    fecha_compra date,
);

CREATE TABLE productos(
    id INT PRIMARY KEY,
    nombre VARCHAR(50),
    categoria VARCHAR(50),
    precio DECIMAL(5,2)
);

CREATE TABLE transacciones(
    id INT PRIMARY KEY,
    id_cliente INT,
    id_producto INT,
    cantidad INT,
    fecha date,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id),
    FOREIGN KEY (id_producto) REFERENCES productos(id)
);



-- 4.5.1 *****************************************************************
-- Consulta
SELECT
COUNT(t.id) AS Total_Ventas,
SUM(p.precio * t.cantidad) AS Total_Ingresos,
AVG(p.precio * t.cantidad) AS Pomedio_Ingreso_Venta
FROM transacciones t
JOIN productos p ON t.id_producto = p.id
WHERE YEAR(t.fecha) = 2022
GROUP BY MONTH(t.fecha)
ORDER BY MONTH(t.fecha) ASC;



-- 4.5.2 *****************************************************************
-- Consulta
SELECT COUNT(DISTINCT t.id_cliente) AS Clientes_Unicos
FROM transacciones t
JOIN productos p ON t.id_producto = p.id
GROUP BY t.id_cliente
HAVING COUNT(DISTINCT p.categoria) = (SELECT COUNT(DISTINCT categoria) FROM productos);
