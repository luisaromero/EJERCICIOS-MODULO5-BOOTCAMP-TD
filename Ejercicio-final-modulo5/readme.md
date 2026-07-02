# Ejercicio Final Módulo 5

_Parte 2 de la evaluación . La Primera parte está en el documento ejercicio.sql_

#### Datos que tenemos 📜 :

-Tenemos tres tablas vacías

-ACTORES
-REPARTO_ACTORES
-TELESERIES

Normalizaremos de acuerdo a la base de dato anterior de teleseries y actores y la base de datos está representada en este diagrama:

![Imagen](./ASSETS/IMAGENES/panel.png)

Por qué se construyó así :

-Porque un actor puede participar en muchas teleseries:
-Y una teleserie tiene muchos actores.

Relación: Muchos a Muchos (N:M)

Por eso existe la tabla intermedia:REPARTO_ACTORES
