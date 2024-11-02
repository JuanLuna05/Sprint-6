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

	
SELECT loan_type FROM prestamo WHERE loan_type = "PRENDARIO" AND loan_total > 100
