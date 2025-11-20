/*Write a solution to report the fraction of players that logged in again on the day after the day they first logged in, rounded to 2 decimal places. 
In other words, you need to determine the number of players who logged in on the day immediately following their initial login, and divide it by the number of total players.*/

-- Получаем дату первого входа для каждого игрока
WITH FirstLogin AS (
     SELECT player_id, MIN(event_date) AS first_login
       FROM Activity
      GROUP BY player_id
),
 -- Получаем игроков, которые вошли в игру на следующий день после их первого входа 
NextDayLogin AS (
    SELECT a.player_id
      FROM FirstLogin f
      JOIN Activity a
        ON f.player_id = a.player_id
     WHERE a.event_date = DATE_ADD(f.first_login, INTERVAL 1 DAY)
)
-- Вычисляем долю игроков, которые вошли в игру на следующий день после первого входа
SELECT ROUND(COUNT(DISTINCT n.player_id) / COUNT(DISTINCT f.player_id), 2) AS fraction
  FROM FirstLogin f
  LEFT JOIN NextDayLogin n
    ON f.player_id = n.player_id;


/*Table: Activity
+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| player_id    | int     |
| device_id    | int     |
| event_date   | date    |
| games_played | int     |
+--------------+---------+
(player_id, event_date) is the primary key (combination of columns with unique values) of this table.
This table shows the activity of players of some games.
Each row is a record of a player who logged in and played a number of games (possibly 0) before logging out on someday using some device.
  
Example 1:
Input: 
Activity table:
+-----------+-----------+------------+--------------+
| player_id | device_id | event_date | games_played |
+-----------+-----------+------------+--------------+
| 1         | 2         | 2016-03-01 | 5            |
| 1         | 2         | 2016-03-02 | 6            |
| 2         | 3         | 2017-06-25 | 1            |
| 3         | 1         | 2016-03-02 | 0            |
| 3         | 4         | 2018-07-03 | 5            |
+-----------+-----------+------------+--------------+
Output: 
+-----------+
| fraction  |
+-----------+
| 0.33      |
+-----------+
*/
