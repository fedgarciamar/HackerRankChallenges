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
SELECT CEILING(AVG(Salary) - AVG(REPLACE(Salary, 0, ''))) FROM EMPLOYEES;
SELECT ROUND(SUM(LAT_N), 4) FROM STATION WHERE LAT_N BETWEEN 38.7880 AND 137.2345;

SELECT ROUND(ABS(MIN(LAT_N)-MAX(LAT_N))+ABS(MIN(LONG_W)-MAX(LONG_W)), 4) FROM STATION; --Manhattan distance
SELECT ROUND(SQRT(POWER(MIN(LAT_N)-MAX(LAT_N), 2)+POWER(MIN(LONG_W)-MAX(LONG_W), 2)), 4) FROM STATION; --Euclidean distance


/* 3. Intermediate Queries: */
SELECT CONCAT(Name, '(', LEFT(Occupation,1), ')' )
FROM OCCUPATIONS
ORDER BY Name ASC;

SELECT CONCAT("There are a total of ", COUNT(Occupation), " ", LOWER(Occupation), "s.")
FROM OCCUPATIONS
GROUP BY Occupation
ORDER BY COUNT(Occupation), Occupation ASC;

SELECT (salary * months) AS earnings, COUNT(*) -- returns the number of rows in a specified table
FROM Employee 
GROUP BY 1  -- means group by first column from SELECT 
ORDER BY earnings DESC -- same as ORDER BY 1 DESC
LIMIT 1;



/* 3.1 Sub Queries: */
SELECT other.maximum AS o, COUNT(employee_id)
FROM Employee,
    (
    SELECT MAX(months * salary) AS maximum
    FROM Employee
    ) AS other
WHERE (months*salary) = other.maximum
GROUP BY other.maximum

SELECT (CASE 
            WHEN P IS NULL THEN CONCAT(N, ' Root')
            WHEN N IN (SELECT DISTINCT P FROM BST) THEN CONCAT(N, ' Inner')
            ELSE CONCAT(N, ' Leaf')
        END) AS Node_Type
FROM BST
ORDER BY N ASC;


SELECT Start_Date, MIN(End_Date)
FROM 
    (SELECT Start_Date FROM Projects WHERE Start_Date NOT IN (SELECT End_Date FROM Projects)) AS a,
    (SELECT End_Date FROM Projects WHERE End_Date NOT IN (SELECT Start_Date FROM Projects)) AS b
WHERE Start_Date < End_Date
GROUP BY Start_Date
ORDER BY DATEDIFF(Start_Date, MIN(End_Date)) DESC, Start_Date;



/* 4. Case or Conditionals: */
SELECT
 (CASE
        WHEN A+B <= C OR B+C <= A OR A+C <= B THEN "Not A Triangle"
        WHEN A=B AND B=C THEN "Equilateral"
        WHEN A=B OR B=C OR A=C THEN "Isosceles"
        WHEN A<>B AND B<>C AND A<>C THEN "Scalene"
    END) AS Triangle_Type
FROM triangles;


/* 5. Joins: */
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


SELECT h.hacker_id, h.name, ready.total_score
FROM(
    SELECT hacker_id, SUM(maximum_scores) AS total_score
    FROM(
        SELECT hacker_id, challenge_id, MAX(score) as maximum_scores
        FROM Submissions
        GROUP BY hacker_id, challenge_id
        ) AS m
    GROUP BY hacker_id
    ) AS ready
    JOIN Hackers AS h
    ON ready.hacker_id = h.hacker_id
WHERE ready.total_score <> 0
ORDER BY total_score DESC, h.hacker_id ASC;


SELECT c.company_code, MAX(c.founder), COUNT(DISTINCT l.lead_manager_code), COUNT(DISTINCT s.senior_manager_code), COUNT(DISTINCT m.manager_code), COUNT(DISTINCT e.employee_code)
FROM Company AS c
    JOIN Lead_Manager AS l
        ON c.company_code = l.company_code
    JOIN Senior_Manager AS s
        ON c.company_code = s.company_code
    JOIN Manager as m
        ON c.company_code = m.company_code
    JOIN Employee as e
        ON c.company_code = e.company_code
GROUP BY c.company_code;
ORDER BY c.company_code ASC;


SELECT f1.X, f1.Y FROM Functions f1
INNER JOIN Functions f2 ON f1.X=f2.Y AND f1.Y=f2.X
GROUP BY f1.X, f1.Y
HAVING COUNT(f1.X)>1 or f1.X<f1.Y
ORDER BY f1.X;


SELECT principal.Name
FROM(
    SELECT s.ID, Name, Salary, Friend_ID
    FROM Students AS s
        JOIN Packages AS p
            ON s.ID = p.ID
        JOIN Friends AS f
            ON s.ID = f.ID
    ) AS principal
    JOIN Packages as sbf
        ON principal.Friend_ID = sbf.ID
WHERE sbf.Salary > principal.Salary
ORDER BY sbf.Salary;


/* 6. Advanced Queries: */

SELECT category, product_id, discount
FROM (
     SELECT category, product_id, discount
     ROW_NUMBER() OVER(PARTITION BY category
                       ORDER BY discount DESC, product_id ASC) AS rn
     FROM product) AS ranked
 WHERE rn = 1
 ORDER BY category;
 
 
SET @counter = 21;
SELECT REPEAT('* ', @counter := @counter - 1) FROM INFORMATION_SCHEMA.TABLES;



