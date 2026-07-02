-- Primera Parte de la actividad:
--1. Crear una consulta para obtener todos los actores que participaron en ambas teleseries, el
-- sueldo que obtuvieron en cada una y la suma de ambos sueldos, todo esto ordenado por el
-- nombre del actor.

SELECT s.nombre,
       s.sueldo AS sueldo_soltera_otra_vez,
       p.sueldo AS sueldo_papi_ricky,
FROM reparto_soltera_otra_vez s
INNER JOIN reparto_papi_ricky p
    ON s.nombre = p.nombre
ORDER BY s.nombre;

-- 2. Crear una consulta para obtener todos los actores que participaron exclusivamente en
-- soltera otra vez, con un sueldo mayor a 90.

SELECT nombre, sueldo
FROM reparto_soltera_otra_vez
WHERE sueldo > 90
AND nombre NOT IN (
    SELECT nombre
    FROM reparto_papi_ricky
);

-- 3. Crear una consulta para obtener solo los actores con sueldo inferior a 85 que actuaron en
-- cualquiera de las dos teleseries, pero no en las dos.

SELECT
    COALESCE(s.nombre, p.nombre) AS nombre,
    COALESCE(s.sueldo, p.sueldo) AS sueldo
FROM reparto_soltera_otra_vez s
FULL OUTER JOIN reparto_papi_ricky p
    ON s.nombre = p.nombre
WHERE (s.nombre IS NULL OR p.nombre IS NULL)
AND COALESCE(s.sueldo, p.sueldo) < 85;

-- Parte 2

-- MODELO ENTIDAD RELACIÓN
-- El dibujo del diagrama se adjuntará al readme

-- 2. Crear los scripts de creación de tablas, campos y llaves necesarias. Para poblar las tablas,
-- incluya inserts de los mismos datos del ejercicio anterior adaptados a este nuevo sistema
-- mejorado.

-- Creacion de tablas :

CREATE TABLE actores (
    id_actor SERIAL PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL
);
CREATE TABLE teleseries (
    id_teleserie SERIAL PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL
);
CREATE TABLE reparto_actores (
    id_actor INT NOT NULL,
    id_teleserie INT NOT NULL,
    protagonico BOOLEAN,
    sueldo INT,

    PRIMARY KEY (id_actor, id_teleserie),

    FOREIGN KEY (id_actor)
        REFERENCES actores(id_actor),

    FOREIGN KEY (id_teleserie)
        REFERENCES teleseries(id_teleserie)
);

-- Ingresar los valores a las tablas según el nuevo modelo entidad relación de los datos


-- Aquí como el id es serial no incluimos
INSERT INTO teleseries (nombre)
VALUES
('Soltera Otra Vez'),
('Papi Ricky');


-- Ingresar los valores a la tabla actores , omitimos duplicar los nombres de los actores
-- Insertamos los valores de esta tabla ya que necesitamos los id (serial) 
-- para la prox tabla donde isertaremos los id de los actores junto a otra data
INSERT INTO actores (nombre)
VALUES
('Paz Bascuñán'),
('Pablo Macaya'),
('Cristián Arriagada'),
('Josefina Montané'),
('Loreto Aravena'),
('Lorena Bosch'),
('Nicolás Poblete'),
('Héctor Morales'),
('Aranzazú Yankovic'),
('Luis Gnecco'),
('Catalina Guerra'),
('Solange Lackington'),
('Ignacio Garmendia'),
('Julio González'),
('Antonella Orsini'),
('Tamara Acosta'),
('Silvia Santelices'),
('Alejandro Trejo'),
('Grimanesa Jiménez'),
('Jorge Zabaleta'),
('Belén Soto'),
('María Elena Swett'),
('Juan Falcón'),
('Leonardo Perucci'),
('Teresita Reyes'),
('Remigio Remedy'),
('María Paz Grandjean'),
('César Caillet'),
('José Tomás Guzmán'),
('Manuel Aguirre');

INSERT INTO reparto_actores (id_actor, id_teleserie, protagonico, sueldo)
VALUES
-- Soltera Otra Vez (id_teleserie = 1) , ya que teleseries el id es serial 
(1, 1, true, 100),
(2, 1, true, 100),
(3, 1, true, 95),
(4, 1, true, 90),
(5, 1, true, 95),
(6, 1, true, 90),
(7, 1, true, 85),
(8, 1, true, 80),
(9, 1, true, 80),
(10, 1, true, 95),
(11, 1, true, 90),
(12, 1, true, 70),
(13, 1, true, 70),
(14, 1, true, 75),
(15, 1, true, 70),
(16, 1, false, 60),
(17, 1, false, 55),
(18, 1, false, 55),
(19, 1, false, 60),

-- Papi Ricky (id_teleserie = 2)
(20, 2, true, 100),
(21, 2, true, 100),
(16, 2, true, 100),
(22, 2, true, 100),
(23, 2, true, 95),
(17, 2, true, 85),
(24, 2, true, 85),
(25, 2, true, 80),
(10, 2, true, 75),
(18, 2, true, 65),
(19, 2, true, 60),
(26, 2, true, 60),
(27, 2, true, 55),
(8, 2, true, 50),
(28, 2, true, 40),
(29, 2, true, 25),
(30, 2, true, 30);

-- 3. Crear una consulta que muestre todas las teleseries y todos los actores de reparto
-- asociados. No incluya los actores de rol secundario.


SELECT t.nombre AS teleserie,
       a.nombre AS actor,
       r.sueldo
FROM teleseries t
JOIN reparto_actores r
    ON t.id_teleserie = r.id_teleserie
JOIN actores a
    ON a.id_actor = r.id_actor
WHERE r.protagonico = true
ORDER BY t.nombre, a.nombre;


