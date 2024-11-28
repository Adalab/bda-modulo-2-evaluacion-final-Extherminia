
-- EVALUACIÓN MODULO 2

-- 1. Selecciona todos los nombres de las películas sin que aparezcan duplicados.

USE sakila;

SELECT DISTINCT title
FROM film;

------------------------------------------------------------------------------

-- 2. Muestra los nombres de todas las películas que tengan una clasificación de "PG-13".

SELECT title
FROM film
WHERE rating = 'PG-13';

------------------------------------------------------------------------------

-- 3. Encuentra el título y la descripción de todas las películas que contengan la palabra "amazing" en su descripción.

SELECT title, description
FROM film
WHERE description LIKE '%amazing%'; 
-- LIKE '%amazing%' permite buscar "amazing" sin importar la posición, además sin % las columnas no se cargan y el % permite  
-- ver cualquier número de caracteres.


------------------------------------------------------------------------------


-- 4. Encuentra el título de todas las películas que tengan una duración mayor a 120 minutos.

SELECT title, length
FROM film
WHERE length > 120;

------------------------------------------------------------------------------

-- 5. Recupera los nombres de todos los actores.

SELECT first_name, last_name
FROM actor;

------------------------------------------------------------------------------

-- 6. Encuetra el nombre y apellido de los actores que tengan "Gibson" en su apellido.

SELECT first_name, last_name
FROM actor
WHERE last_name = 'Gibson';

------------------------------------------------------------------------------

-- 7. Encuentra los nombres de los actores que tengan un actor_id entre 10 y 20.

SELECT first_name, last_name
FROM actor
WHERE actor_id BETWEEN 10 AND 20;
-- Con Between And selecciono lo que está entre 10 y 20, ambos inclusive.


------------------------------------------------------------------------------

-- 8. Encuentra el título de las películas en la tabla film que no sean ni "R" ni "PG-13" en cuanto a su clasificación.

SELECT title, rating
FROM film
WHERE rating NOT IN ('R','PG-13');
-- NOT IN excluye varios valores

------------------------------------------------------------------------------

-- 9. Encuentra la cantidad total de películas en cada clasificación de la tabla film y muestra la clasificación junto 
-- con el recuento.


SELECT  rating, COUNT(*) AS total_films
FROM film
GROUP BY rating;
-- Con COUNT(*) contamos el total de películas de cada grupo y con GROUP BY agrupa por la columna rating.

------------------------------------------------------------------------------

-- 10. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre 
-- y apellido junto con la cantidad de películas alquiladas.

-- OPCIÓN1

SELECT c.customer_id, c.first_name, c.last_name, COUNT(r.rental_id) AS total_rentals
FROM customer c
INNER JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name;
-- Con UNNER JOIN relacionamos los clientes con los alquileres de las tablas customer y rental
-- Con COUNT(r.rental_id): Contamos los clientes por alquiler
-- Con GROUP BY: Agrupamos los clientes con los recuentos por cada uno
-- ** Uso c.customer y r.rental como alias temporales y no confundir columnas de diferentes tablas

-- OPCIÓN2

SELECT c.customer_id, c.first_name, c.last_name, COUNT(r.rental_id) AS total_rentals
FROM customer c
LEFT JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name;
-- Con LEFT JOIN aparecen también los clientes que no tienen alquileres, con total_rentals = 0

-- OPCIÓN3

SELECT 
customer.customer_id AS ID_Cliente,
customer.first_name AS Nombre,
customer.last_name AS Apellido,
COUNT(rental.rental_id) AS Peliculas_Alquiladas
FROM customer 
LEFT JOIN rental 
ON customer.customer_id = rental.customer_id
GROUP BY 
customer.customer_id, customer.first_name, customer.last_name
ORDER BY 
Peliculas_Alquiladas DESC;


------------------------------------------------------------------------------


-- 11. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con 
-- el recuento de alquileres.


-- OPCIÓN1
SELECT cat.name AS category_name, COUNT(r.rental_id) AS total_rentals
FROM rental r
INNER JOIN inventory i ON r.inventory_id = i.inventory_id
INNER JOIN film f ON i.film_id = f.film_id
INNER JOIN film_category fc ON f.film_id = fc.film_id
INNER JOIN category cat ON fc.category_id = cat.category_id
GROUP BY cat.name;
-- Con INNER vemos las categorías ocn alguileres registrados


-- OPCIÓN2
SELECT cat.name AS category_name, COUNT(r.rental_id) AS total_rentals
FROM category cat
LEFT JOIN film_category fc ON cat.category_id = fc.category_id
LEFT JOIN film f ON fc.film_id = f.film_id
LEFT JOIN inventory i ON f.film_id = i.film_id
LEFT JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY cat.name;
-- Con LEFT JOIN vemos también las categorías sin alguileres, con total_rentals = 0

------------------------------------------------------------------------------


-- 12. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la
--  clasificación junto con el promedio de duración.

SELECT rating, AVG(length) AS average_length
FROM film
GROUP BY rating;


------------------------------------------------------------------------------

-- 13. Encuentra el nombre y apellido de los actores que aparecen en la película con title "Indian Love".

SELECT a.first_name, a.last_name
FROM actor a
INNER JOIN film_actor fa ON a.actor_id = fa.actor_id
INNER JOIN film f ON fa.film_id = f.film_id
WHERE f.title = 'Indian Love';

------------------------------------------------------------------------------

-- 14. Muestra el título de todas las películas que contengan la palabra "dog" o "cat" en su descripción.

SELECT title
FROM film
WHERE description LIKE "%dog%" OR description LIKE '%cat%';

------------------------------------------------------------------------------

-- 15. Encuentr a el título de todas las películas que fueron lanzadas entre el año 2005 y 2010.

SELECT title
FROM film
WHERE release_year BETWEEN 2005 AND 2010;

------------------------------------------------------------------------------

-- 16. Encuentra el título de todas las películas que son de la misma categoría que "Family".

SELECT f.title
FROM film f
INNER JOIN film_category fc ON f.film_id = fc.film_id
INNER JOIN category c ON fc.category_id = c.category_id 
WHERE c.name = 'Family';

------------------------------------------------------------------------------

-- 17. Encuentra el título de todas las películas que son "R" y tienen una duración mayor a 2 horas en la tabla film.

SELECT title
FROM film
WHERE rating = 'R' AND length > 120;

------------------------------------------------------------------------------
