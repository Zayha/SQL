USE lesson_4;

# Создайте представление, в которое попадет информация о пользователях (имя, фамилия, город и пол), которые не старше 20 лет.
CREATE OR REPLACE VIEW view_users_under_20 AS
SELECT u.id, u.firstname, u.lastname, p.hometown, p.gender
FROM users u
         JOIN profiles p on u.id = p.user_id
WHERE p.birthday >= DATE_SUB(CURRENT_DATE(), INTERVAL 20 YEAR);
SELECT *
FROM view_users_under_20;


# Найдите кол-во, отправленных сообщений каждым пользователем и выведите ранжированный список пользователей, указав имя
# и фамилию пользователя, количество отправленных сообщений и место в рейтинге (первое место у пользователя с
# максимальным количеством сообщений) . (используйте DENSE_RANK)
SELECT DENSE_RANK() OVER (ORDER BY COUNT(*) DESC) AS message_rank,
       COUNT(*)                                   AS num_messages,
       u.lastname,
       u.firstname
FROM messages m
         JOIN users u ON m.from_user_id = u.id
GROUP BY u.id
ORDER BY message_rank;

# Выберите все сообщения, отсортируйте сообщения по возрастанию даты отправления (created_at) и найдите разницу дат
#     отправления между соседними сообщениями, получившегося списка. (используйте LEAD или LAG)
SELECT created_at,
       LAG(created_at) OVER (ORDER BY created_at)                                    AS prev_created_at,
       TIMESTAMPDIFF(SECOND, LAG(created_at) OVER (ORDER BY created_at), created_at) AS time_diff
FROM messages
ORDER BY created_at;


