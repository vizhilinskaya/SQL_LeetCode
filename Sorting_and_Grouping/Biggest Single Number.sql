/*A single number is a number that appeared only once in the MyNumbers table.
Find the largest single number. If there is no single number, report null.*/

SELECT CASE 
       WHEN COUNT(num) = 1 THEN num 
       ELSE null 
       END AS num
  FROM MyNumbers
 GROUP BY num
 ORDER BY num DESC 
 LIMIT 1;

/*Table: MyNumbers
+-------------+------+
| Column Name | Type |
+-------------+------+
| num         | int  |
+-------------+------+
This table may contain duplicates (In other words, there is no primary key for this table in SQL).
Each row of this table contains an integer.

Example 1:
Input: 
MyNumbers table:
+-----+
| num |
+-----+
| 8   |
| 8   |
| 3   |
| 3   |
| 1   |
| 4   |
| 5   |
| 6   |
+-----+
Output: 
+-----+
| num |
+-----+
| 6   |
+-----+
*/
