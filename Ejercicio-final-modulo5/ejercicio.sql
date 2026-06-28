-- Primera Parte de la actividad:
--1. Crear una consulta para obtener todos los actores que participaron en ambas teleseries, el
-- sueldo que obtuvieron en cada una y la suma de ambos sueldos, todo esto ordenado por el
-- nombre del actor.

SELECT s.nombre,
       s.sueldo AS sueldo_soltera_otra_vez,
       p.sueldo AS sueldo_papi_ricky,
       (s.sueldo + p.sueldo) AS sueldo_total
FROM reparto_soltera_otra_vez s
INNER JOIN reparto_papi_ricky p
    ON s.nombre = p.nombre
ORDER BY s.nombre;