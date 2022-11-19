
CREATE TABLE CHALLENGES (CHALLENGE_ID INT, HACKER_ID INT)
INSERT INTO CHALLENGES VALUES (63963,81041),
							  (63117,79345),
							  (28225,34856),
							  (21989,12299),
							  (4563,12299),
							  (70070,79345),
							  (36905,34856),
							  (61136,80491),
							  (17234, 12299),
							  (80308, 79345),
							  (40510, 34856),
							  (79820, 80491),
							  (22720, 12299),
							  (21394,12299),
							  (36261, 34856),
							  (15334, 12299),
							  (71435, 79345),
							  (23157, 34856),
							  (54102, 34856),
							  (69065, 80491)

go

CREATE TABLE NHACKERS
(HACKER_ID INT, NAME_HK VARCHAR(10))

INSERT INTO NHACKERS
VALUES (12299, 'ROSE'),
		(34856, 'ANGELA'),
		(79345,'FRANK'),
		(80491, 'PATRICK'),
		(81041, 'LISA')

GO
WITH
--  Tạo bảng C với cột hackerID và count số lượng challenges theo hackerID
C AS (SELECT HACKER_ID, COUNT(CHALLENGE_ID) AS nchallenges FROM CHALLENGES GROUP BY HACKER_ID),
-- Tạo bảng MC bổ sung thêm cột đếm số lượng challenges trùng nhau(sử dụng Over(partitation by...) và cột thể hiện Max challenges.
-- Cột Count_duplate: count dựa theo hàng nchallenges, nếu có trùng nhau thì nó tăng lên 1 đơn vị (ví dụ có 2 người cùng 4 nchallenges thì count_duplate = 2 vv)
-- Cột MCH (maxChallenge) thể hiện giá trị lớn nhất, để so sánh và loại bỏ giá trị nchallenges trùng nhau nhưng < MCH
MC AS(SELECT *, COUNT(nchallenges) OVER(PARTITION BY nchallenges) AS COUNT_DUPLATE, MAX (nchallenges) OVER() AS MCH FROM C)

SELECT H.HACKER_ID, H.NAME_HK, MC.NCHALLENGES
FROM MC
JOIN NHACKERS AS H ON H.HACKER_ID = MC.HACKER_ID
WHERE MC.COUNT_DUPLATE = 1 OR nchallenges = MCH
ORDER BY MC.nchallenges DESC, H.HACKER_ID