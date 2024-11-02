--p4
SELECT 
    branch_id AS nombre_sucursal,
    COUNT(*) AS cantidad_clientes
FROM cliente
GROUP BY branch_id
ORDER BY cantidad_clientes DESC;

SELECT 
    c.branch_id AS nombre_sucursal,
    c.customer_name AS nombre_cliente,
    c.customer_surname AS apellido_cliente,
    COUNT(e.employee_id) AS cantidad_empleados
FROM empleado e
JOIN cliente c ON e.branch_id = c.branch_id
GROUP BY c.branch_id, c.customer_id
ORDER BY c.branch_id, cantidad_empleados DESC;

SELECT 
    branch_name AS nombre_sucursal,
    tipo_tarjeta AS tipo,
    COUNT(t.numero) AS cantidad_tarjetas
FROM 
    Tarjeta AS t
JOIN 
    Cliente AS c ON t.customer_id = c.customer_id
JOIN 
    Sucursal AS s ON c.branch_id = s.branch_id
WHERE 
    t.tipo_tarjeta = 'crédito'
GROUP BY 
    s.branch_name, t.tipo_tarjeta;

SELECT 
    s.branch_id AS nombre_sucursal,
    AVG(p.loan_total) AS promedio_creditos
FROM prestamo p
JOIN cliente c ON p.customer_id = c.customer_id
JOIN sucursal s ON c.branch_id = s.branch_id
WHERE p.loan_type = 'crédito'
GROUP BY s.branch_id
ORDER BY promedio_creditos DESC;


CREATE TABLE auditoria_cuenta (
    old_id INTEGER,
    new_id INTEGER,
    old_balance DECIMAL,
    new_balance DECIMAL,
    old_iban TEXT,
    new_iban TEXT,
    old_type TEXT,
    new_type TEXT,
    user_action TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);


CREATE TRIGGER trigger_auditoria_cuenta
AFTER UPDATE ON cuenta 
WHEN NEW.balance != OLD.balance OR NEW.iban != OLD.iban OR NEW.tipo != OLD.tipo;

BEGIN
    INSERT INTO auditoria_cuenta (
        old_id, new_id, old_balance, new_balance,
        old_iban, new_iban, old_type, new_type,
        user_action, created_at
    )
    VALUES (
        OLD.id, NEW.id, OLD.balance, NEW.balance,
        OLD.iban, NEW.iban, OLD.tipo, NEW.tipo,
        'UPDATE', CURRENT_TIMESTAMP
    );
END;


UPDATE cuenta
SET balance = balance - 100
WHERE account_id IN (10, 11, 12, 13, 14);

CREATE TABLE movimientos (
    movimiento_id INTEGER PRIMARY KEY AUTOINCREMENT,
    cuenta_numero INTEGER,
    monto DECIMAL,
    tipo_operacion TEXT,
    hora DATETIME DEFAULT CURRENT_TIMESTAMP
);



BEGIN TRANSACTION;

UPDATE cuenta
SET balance = balance - 1000
WHERE account_id = 200;


UPDATE cuenta
SET balance = balance + 1000
WHERE account_id = 400;


INSERT INTO movimientos (cuenta_numero, monto, tipo_operacion)
VALUES (200, -1000, 'transferencia');

INSERT INTO movimientos (cuenta_numero, monto, tipo_operacion)
VALUES (400, 1000, 'transferencia');


COMMIT;

