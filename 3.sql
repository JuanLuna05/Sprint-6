--p3
SELECT account_id FROM cuenta where balance < 0;

SELECT customer_name, customer_surname, dob FROM cliente WHERE customer_surname like '%Z%';

SELECT 
    customer_name AS nombre,
    customer_surname AS apellido,
    (strftime('%Y', 'now') - strftime('%Y', dob)) - 
    (strftime('%m-%d', 'now') < strftime('%m-%d', dob)) AS edad,
    s.branch_name AS nombre_sucursal
FROM 
    Cliente AS c
JOIN 
    Sucursal AS s ON c.branch_id = s.branch_id
WHERE 
    c.customer_name = 'Brendan'
ORDER BY 
    s.branch_name;
	
SELECT loan_type,loan_total 
FROM prestamo 
WHERE loan_type = "PRENDARIO" AND loan_total > 8000000;

SELECT loan_total  FROM prestamo WHERE loan_total > (SELECT AVG(loan_total) FROM prestamo);

SELECT COUNT(*) AS clientes_menores_50
FROM cliente
WHERE strftime('%Y', 'now') - strftime('%Y', dob) < 50;

SELECT * FROM cuenta 
WHERE balance > 8000 
LIMIT 5;

SELECT *
FROM prestamo
WHERE strftime('%m', loan_date) IN ('04', '06', '08')
ORDER BY loan_total;

SELECT loan_type, SUM(loan_total) AS loan_total_accunt
FROM prestamo
GROUP BY loan_type;