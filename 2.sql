-- P2
CREATE VIEW vista_clientes AS
SELECT 
    customer_id AS id,
    branch_id AS numero_sucursal,
    customer_name AS nombre,
    customer_surname AS apellido,
    customer_dni AS DNI,
    strftime('%Y', 'now') - strftime('%Y', dob) AS edad
FROM cliente;

SELECT 
    customer_id AS id,
    branch_id AS numero_sucursal,
    customer_name AS nombre,
    customer_surname AS apellido,
    customer_dni AS DNI,
    strftime('%Y', 'now') - strftime('%Y', dob) AS edad
FROM cliente
WHERE (strftime('%Y', 'now') - strftime('%Y', dob)) > 40
ORDER BY customer_dni ASC;


SELECT 
    customer_id AS id,
    customer_name AS nombre,
    customer_surname AS apellido,
    customer_dni AS DNI,
    strftime('%Y', 'now') - strftime('%Y', dob) AS edad
FROM cliente
WHERE customer_name IN ('Anne', 'Tyler')
ORDER BY edad ASC;

INSERT INTO cliente (customer_name, customer_surname, customer_dni, branch_id, dob)
VALUES 
('Lois', 'Stout', 47730534, 80, '1984-07-07'),
('Hall', 'Mcconnell', 52055464, 45, '1968-04-30'),
('Hilel', 'Mclean', 43625213, 77, '1993-03-28'),
('Jin', 'Cooley', 21207908, 96, '1959-08-24'),
('Gabriel', 'Harmon', 57063950, 27, '1976-04-01');

SELECT * FROM cliente
WHERE customer_dni IN (47730534, 52055464, 43625213, 21207908, 57063950);


UPDATE cliente
SET branch_id = 10
WHERE customer_dni IN (47730534, 52055464, 43625213, 21207908, 57063950);

DELETE FROM cliente
WHERE customer_name = 'Noel' AND customer_surname = 'David';

SELECT loan_type, MAX(loan_total) AS max_importe
FROM prestamo
GROUP BY loan_type
ORDER BY max_importe DESC
LIMIT 1;