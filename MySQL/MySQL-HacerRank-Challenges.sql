/* HACKER RANK MYSQL CHALLENGES */
/*  */

/* 1. Basic Queries: */
SELECT columns FROM table;
SELECT * FROM table;
SELECT * FROM table WHERE column < = > valor o ‘texto’;
SELECT DISTINCTROW column FROM table WHERE MOD(column, 2) = 0; -- Módulo MOD o también se podría WHERE column%2 = 0
SELECT ROUND(SUM(column_1), 2), ROUND(SUM(columna_2), 2); -- Redondear y sumar
SELECT COUNT(column) - COUNT(DISTINCT column) FROM table; -- Restar y obtener valores únicos
SELECT column, LENGTH(column) FROM STATION ORDER BY LENGTH(column), column ASC LIMIT 1;
SELECT columna, LENGTH(column) FROM table ORDER BY LENGTH(column) DESC LIMIT 1;
SELECT DISTINCT column FROM table WHERE column LIKE ('a%') OR column LIKE ('e%') OR column LIKE ('i%') OR column LIKE ('o%') OR column LIKE ('u%'); -- Valores de columna que comiencen por una vocal o terminen por una vocal:
SELECT DISTINCT column FROM table WHERE column LIKE ('%a') OR column LIKE ('%e') OR column LIKE ('%i') OR column LIKE ('%o') OR column LIKE ('%u');

/* Otra forma podría ser utilizando Regex, algunos ejemplos: */
SELECT DISTINCT CITY FROM STATION WHERE CITY NOT RLIKE '^[aeiouAEIOU].*$';
SELECT DISTINCT CITY FROM STATIONWHERE CITY NOT RLIKE '[aeiouAEIOU]$';
SELECT DISTINCT CITY FROM STATION WHERE CITY NOT RLIKE '^[aeiouAEIOU].*$' OR CITY NOT RLIKE '[aeiouAEIOU]$';

/* En resumen: */
SELECT * FROM my_table WHERE upper(my_column) LIKE 'SEARCHED %';  -- starts with
SELECT * FROM my_table WHERE upper(my_column) LIKE '% SEARCHED';  -- ends with
SELECT * FROM my_table WHERE upper(my_column) LIKE '%SEARCHED%';  -- contains

SELECT name FROM students WHERE marks > 75 ORDER BY RIGHT(name,3), id ASC;
SELECT COUNT(ID) FROM CITY WHERE POPULATION > 100000;
SELECT SUM(POPULATION) FROM CITY WHERE DISTRICT = 'CALIFORNIA';
SELECT AVG(POPULATION) FROM CITY WHERE DISTRICT = 'CALIFORNIA';
SELECT ROUND(AVG(POPULATION), 0) FROM CITY;
SELECT MAX(POPULATION) - MIN(POPULATION) FROM CITY;






/* 3. Intermediate Queries: */
SELECT CONCAT(Name, '(', LEFT(Occupation,1), ')' )
FROM OCCUPATIONS
ORDER BY Name ASC
SELECT CONCAT("There are a total of ", COUNT(Occupation), " ", LOWER(Occupation), "s.") FROM OCCUPATIONS
GROUP BY Occupation
ORDER BY COUNT(Occupation), Occupation ASC;

/* 3. Case or Conditionals: */
SELECT
 (CASE
        WHEN A+B <= C OR B+C <= A OR A+C <= B THEN "Not A Triangle"
        WHEN A=B AND B=C THEN "Equilateral"
        WHEN A=B OR B=C OR A=C THEN "Isosceles"
        WHEN A<>B AND B<>C AND A<>C THEN "Scalene"
    END) AS Triangle_Type
FROM triangles;

/* 4. Joins: */
SELECT SUM(c.POPULATION) 
FROM CITY AS c
JOIN COUNTRY AS p
    ON c.COUNTRYCODE = p.CODE
WHERE p.CONTINENT = 'Asia';

SELECT p.CONTINENT, FLOOR(AVG(c.POPULATION))  FLOOR = Round Down
FROM CITY AS c
JOIN COUNTRY AS p
    ON c.COUNTRYCODE = p.CODE
GROUP BY p.CONTINENT;

SELECT  
    CASE WHEN g.Grade >= 8 THEN s.Name END AS Name,
    g.Grade,
    s.Marks
FROM Students AS s
JOIN Grades AS g
    ON s.Marks BETWEEN g.Min_Mark AND g.Max_Mark
ORDER BY g.Grade DESC, s.Name ASC;

SELECT h.hacker_id, h.name
FROM submissions AS s
    JOIN challenges AS ch
        ON s.challenge_id = ch.challenge_id
    JOIN difficulty AS d
        ON ch.difficulty_level = d.difficulty_level 
    JOIN hackers AS h
        ON s.hacker_id = h.hacker_id
WHERE s.score = d.score AND ch.difficulty_level = d.difficulty_level
GROUP BY hacker_id, h.name
    HAVING COUNT(h.hacker_id) > 1 
ORDER BY COUNT(h.hacker_id) DESC, h.hacker_id ASC;
