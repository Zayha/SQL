CREATE TABLE staff
(
    id        INT AUTO_INCREMENT PRIMARY KEY,
    firstname VARCHAR(40)  NOT NULL,
    lastname  VARCHAR(40)  NOT NULL,
    post      VARCHAR(40)  NOT NULL,
    seniority INT,
    salary    INT,
    age       INT UNSIGNED NOT NULL
) CHARACTER SET utf8;

INSERT INTO staff (firstname, lastname, post, seniority, salary, age)
VALUES ('Вася', 'Петров', 'Начальник', 40, 100000, 60),
       ('Петр', 'Власов', 'Начальник', 8, 70000, 30),
       ('Катя', 'Катина', 'Инженер', 2, 70000, 30),
       ('Саша', 'Сасин', 'Инженер', 12, 50000, 35),
       ('Иван', 'Иванов', 'Рабочий', 40, 30000, 59),
       ('Петр', 'Петров', 'Рабочий', 20, 25000, 40),
       ('Сидр', 'Сидоров', 'Рабочий', 10, 20000, 35),
       ('Антон', 'Антонов', 'Рабочий', 8, 19000, 28),
       ('Юрий', 'Юрков', 'Рабочий', 5, 15000, 25),
       ('Максим', 'Максимов', 'Рабочий', 2, 11000, 22),
       ('Юрий', 'Галкин', 'Рабочий', 3, 12000, 24),
       ('Людмила', 'Маркина', 'Уборщик', 10, 10000, 49);

SELECT *
FROM staff
ORDER BY salary DESC;

SELECT *
FROM staff
ORDER BY salary;

SELECT salary
FROM staff
ORDER BY salary DESC
LIMIT 5;

SELECT post, SUM(salary) AS total_salary
FROM staff
GROUP BY post
ORDER BY total_salary DESC;

SELECT post, COUNT(post) AS total_post
FROM staff
WHERE post = 'Рабочий'
  AND age BETWEEN 24 AND 49;

SELECT COUNT(DISTINCT post) AS unique_job_titles
FROM staff;

SELECT post
FROM staff
GROUP BY post
HAVING AVG(age) < 30;

SELECT post, AVG(age) AS avg_age
FROM staff
GROUP BY post;
