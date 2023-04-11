# Note: answer rate = answer actions / total non-answer actions (e.g., show and skip) 
SELECT TOP 1 question_id AS survey_log
FROM survey_log
GROUP BY question_id
ORDER BY COUNT(answer_id)/(COUNT(*)-COUNT(answer_id)) DESC; 

# Another variant
SELECT question_id AS 'survey_log'
FROM survey_log
GROUP BY question_id
ORDER BY COUNT(answer_id) / SUM(IF(action = 'show', 1, 0)) DESC
LIMIT 1; 
