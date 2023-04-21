USE lesson_4;

# 1. Подсчитать общее количество лайков, которые получили пользователи
# младше 13 лет.
SELECT COUNT(*) AS 'лайки'
FROM likes
         LEFT JOIN profiles ON likes.user_id = profiles.user_id
WHERE TIMESTAMPDIFF(YEAR, profiles.birthday, NOW()) > 13;

# 2. Определить кто больше поставил лайков (всего): мужчины или
# женщины.
SELECT profiles.gender, COUNT(*) AS total_likes
FROM likes
         JOIN profiles ON likes.user_id = profiles.user_id
GROUP BY profiles.gender
ORDER BY total_likes DESC;

# 3. Вывести всех пользователей, которые не отправляли сообщения.
SELECT u.id, CONCAT(u.firstname, ' ', u.lastname) AS users_not_send
FROM users u
         LEFT JOIN messages m ON u.id = m.from_user_id
WHERE m.from_user_id IS NULL;

# 4. (по желанию)* Пусть задан некоторый пользователь. Из всех друзей
# этого пользователя найдите человека, который больше всех написал
# ему сообщений.
#ЭТАПЫ
SELECT *
FROM friend_requests
WHERE (initiator_user_id = 1 OR target_user_id = 1)
  AND status = 'approved';

SELECT initiator_user_id AS id
FROM friend_requests
WHERE target_user_id = 1
  AND status = 'approved'
UNION
SELECT target_user_id
FROM friend_requests
WHERE initiator_user_id = 1
  AND status = 'approved';


# Решение 4*
# Зададим номер id того, кого хотим найти
SET @user_id = 1;
SELECT from_user_id, COUNT(*) as num_messages
FROM messages
WHERE to_user_id = @user_id
  AND from_user_id IN (SELECT initiator_user_id AS friend_id
                       FROM friend_requests
                       WHERE target_user_id = @user_id
                         AND status = 'approved'
                       UNION
                       SELECT target_user_id AS friend_id
                       FROM friend_requests
                       WHERE initiator_user_id = @user_id
                         AND status = 'approved')
GROUP BY from_user_id
ORDER BY num_messages DESC;
