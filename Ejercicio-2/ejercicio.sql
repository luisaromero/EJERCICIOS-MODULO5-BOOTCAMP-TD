-- Crear las siguientes consultas:
-- 3. Listar el saldo de cada cuenta del cliente con más años de edad.

SELECT saldo
FROM Cuentas
WHERE id_cliente IN (
    SELECT id_cliente
    FROM Clientes
    WHERE edad = (
        SELECT MAX(edad)
        FROM Clientes
    )
);
-- 4. Listar el promedio de edad de los clientes con saldo negativo.

SELECT AVG(edad) AS promedio_edad
FROM Clientes
WHERE id_cliente IN (
    SELECT id_cliente
    FROM Cuentas
    WHERE saldo < 0
);
-- 5. Listar el nombre y cantidad de cuentas de quienes tienen más de
-- una.

-- Aqui empezamos a usar JOIN para las filas que tienen valores coincidentes en ambas tablas.
SELECT nombre, COUNT(*) AS cantidad_cuentas
FROM Clientes
JOIN Cuentas
    ON Clientes.id_cliente = Cuentas.id_cliente
GROUP BY nombre, Clientes.id_cliente
HAVING COUNT(*) > 1;
-- 6. Listar el saldo combinado (suma) de cada cliente con más de una
-- cuenta.

SELECT nombre, SUM(saldo) AS saldo_total
FROM Clientes
JOIN Cuentas
    ON Clientes.id_cliente = Cuentas.id_cliente
GROUP BY nombre, Clientes.id_cliente
HAVING COUNT(*) > 1;
-- 7. Listar todos los clientes y su saldo combinado de todos aquellos
-- clientes que tengan al menos una cuenta con saldo negativo.

SELECT nombre, SUM(saldo) AS saldo_total
FROM Clientes
JOIN Cuentas
    ON Clientes.id_cliente = Cuentas.id_cliente
WHERE Clientes.id_cliente IN (
    SELECT id_cliente
    FROM Cuentas
    WHERE saldo < 0
)
GROUP BY nombre, Clientes.id_cliente;