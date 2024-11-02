--p1
CREATE TABLE Marca (
    id_marca INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre TEXT NOT NULL UNIQUE
);


CREATE TABLE Cliente (
    customer_id INTEGER PRIMARY KEY AUTOINCREMENT,
    customer_name TEXT NOT NULL,
    customer_surname TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    branch_id INTEGER,
    FOREIGN KEY (branch_id) REFERENCES Sucursal(branch_id)
);


CREATE TABLE Sucursal (
    branch_id INTEGER PRIMARY KEY AUTOINCREMENT,
    branch_name TEXT NOT NULL
);


CREATE TABLE Tarjeta (
    id_tarjeta INTEGER PRIMARY KEY,
    numero TEXT NOT NULL UNIQUE CHECK (LENGTH(numero) <= 20),
    cvv TEXT NOT NULL,
    fecha_otorgamiento DATE NOT NULL,
    fecha_expiracion DATE NOT NULL,
    tipo_tarjeta TEXT CHECK(tipo_tarjeta IN ('crédito', 'débito')) NOT NULL,
    customer_id INTEGER,
    id_marca INTEGER,
    FOREIGN KEY (customer_id) REFERENCES Cliente(customer_id),
    FOREIGN KEY (id_marca) REFERENCES Marca(id_marca)
);


CREATE TABLE Direccion (
    id_direccion INTEGER PRIMARY KEY AUTOINCREMENT,
    customer_id INTEGER,
    direccion TEXT NOT NULL,
    ciudad TEXT NOT NULL,
    provincia TEXT NOT NULL,
    codigo_postal TEXT NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Cliente(customer_id)
);


SELECT 
    Tarjeta.numero, 
    Tarjeta.tipo_tarjeta, 
    Cliente.customer_name, 
    Cliente.customer_surname, 
    Direccion.provincia
FROM Tarjeta
JOIN Cliente ON Tarjeta.customer_id = Cliente.customer_id
JOIN Direccion ON Cliente.customer_id = Direccion.customer_id
WHERE Tarjeta.tipo_tarjeta = 'crédito' 
AND Direccion.provincia = 'Provincia A';

SELECT 
    Cliente.customer_id, 
    Cliente.customer_name, 
    Cliente.customer_surname, 
    Direccion.direccion, 
    Direccion.ciudad, 
    Direccion.provincia, 
    Direccion.codigo_postal,
    Tarjeta.numero AS tarjeta_numero, 
    Tarjeta.tipo_tarjeta, 
    Tarjeta.fecha_expiracion
FROM Cliente
LEFT JOIN Direccion ON Cliente.customer_id = Direccion.customer_id
LEFT JOIN Tarjeta ON Cliente.customer_id = Tarjeta.customer_id;


SELECT 
    Cliente.customer_id, 
    Cliente.customer_name, 
    Cliente.customer_surname, 
    COUNT(Tarjeta.numero) AS numero_tarjetas
FROM Cliente
JOIN Tarjeta ON Cliente.customer_id = Tarjeta.customer_id
GROUP BY Cliente.customer_id
HAVING COUNT(Tarjeta.numero) > 1;


SELECT 
    Direccion.provincia, 
    COUNT(Cliente.customer_id) AS numero_clientes
FROM Cliente
JOIN Direccion ON Cliente.customer_id = Direccion.customer_id
GROUP BY Direccion.provincia;


SELECT 
    Sucursal.branch_name AS nombre_sucursal,
    Tarjeta.tipo_tarjeta AS tipo,
    COUNT(Tarjeta.numero) AS cantidad_tarjetas
FROM Tarjeta
JOIN Cliente ON Tarjeta.customer_id = Cliente.customer_id
JOIN Sucursal ON Cliente.branch_id = Sucursal.branch_id
WHERE Tarjeta.tipo_tarjeta = 'crédito'
GROUP BY Sucursal.branch_name, Tarjeta.tipo_tarjeta;


UPDATE Empleados
SET employee_hire_date = 
    SUBSTR(employee_hire_date, 7, 4) || '-' || 
    SUBSTR(employee_hire_date, 4, 2) || '-' || 
    SUBSTR(employee_hire_date, 1, 2);


SELECT employee_id, employee_hire_date FROM Empleado LIMIT 10;

