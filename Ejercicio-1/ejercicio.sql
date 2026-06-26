-- Querys para el ejercicio

-- 1. A quién(es) le debe más dinero y cuánto , en este caso colocamos a la PERSONA que le 
-- debe más dinero , si queremos poner lo s 5 que más le deben dinero podemos cambiar 
-- el LIMIT 1 por LIMIT 5 , etc
SELECT nombre, le_debo
FROM finanzas_personales
ORDER BY le_debo DESC
LIMIT 3;

-- 2. Quién(es) le debe más dinero a ud. y cuánto , lo mismo que arriba sólo arrojamos a la persona
-- que yo le debo más dinero , si queremos mostrar más , cambiamos el LIMIT por el n de personas

SELECT nombre, me_debe
FROM finanzas_personales
ORDER BY me_debe DESC
LIMIT 3;


-- 3. Cuánto dinero debe en total

SELECT SUM(le_debo) AS deuda_total
FROM finanzas_personales;

-- 4. Cuánto dinero debe en promedio.
SELECT AVG(le_debo) AS deuda_promedio
FROM finanzas_personales;

-- 5. Suponiendo que no puede pagar más de una cuota al mes. ¿Cuántos
-- meses demoraría en saldar su deuda?

SELECT SUM(cuotas_pagar) AS meses_para_saldar
FROM finanzas_personales;

--6. Suponga que logar cobrar todo lo que le deben en un mismo día y
-- decide usar todo eso para pagar lo que se pueda de su deuda.
-- o ¿A cuánto ascendería su nueva deuda reducida?
SELECT SUM(le_debo) - SUM(me_debe) AS nueva_deuda
FROM finanzas_personales;
-- o ¿Cuánto tendría que pagar mensualmente para pagar todo lo
-- que resta en las cuotas ya acordadas?
SELECT (SUM(le_debo) - SUM(me_debe)) / SUM(cuotas_pagar) AS cuota_nueva_aprox
FROM finanzas_personales;

-- 7. Insertar un nuevo registro en la tabla.Tal cómo sale en el PDF:
INSERT INTO finanzas_personales (nombre, me_debe, cuotas_cobrar, le_debo, cuotas_pagar)
VALUES ('pareja', 0, 0, 50000, 1);


-- 8. Con este cambio empezó a temblar realmente tu situación
-- económica y lo primero que quisiera averiguar es ¿De cuánto será la
-- cuota a pagar este mes?

-- la consulta toma cada deuda, la divide por sus cuotas, 
-- suma todas esas cuotas mensuales y luego redondea el resultado a 0 decimales.

SELECT ROUND(SUM(le_debo::numeric / NULLIF(cuotas_pagar, 0)), 0) AS cuota_total_mes
FROM finanzas_personales;

-- No tuviste la valentía para negociar las cuotas con tu pareja, pero la señora
-- del almacén de la esquina te tiene buena y te permitió bondadosamente
-- pagarle en 13 cuotas.
-- 9. Realizar el update en la tabla.

UPDATE finanzas_personales
SET cuotas_pagar = 13
WHERE nombre = 'almacén esquina';

-- 10. Ahora que realizaste este pequeño (pero importante) ajuste ¿De
-- cuánto será la cuota a pagar este mes?

-- ya lo habiamos aplicado en el paso 8, pero lo volvemos a aplicar para ver el 
-- cambio en la cuota mensual.

SELECT ROUND(SUM(le_debo::numeric / NULLIF(cuotas_pagar, 0)), 0) AS cuota_total_mes
FROM finanzas_personales;
