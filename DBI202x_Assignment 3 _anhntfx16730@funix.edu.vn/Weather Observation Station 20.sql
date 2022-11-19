--YC: Truy vấn giá trị giữa của LAT_N đã được sắp sếp.

SELECT CAST(ROUND(AVG(LAT_N),4) AS DECIMAL(10,4))
FROM (SELECT LAT_N, ROW_NUMBER() OVER(ORDER BY LAT_N ASC) AS R FROM STATION) AS TBL
WHERE TBL.R <= CEIL (((SELECT COUNT(*) FROM STATION) +1)/2) AND TBL.R >= FLOOR (((SELECT COUNT(*) FROM STATION) +1)/2);

--B1: SELECT LAT_N, ROW_NUMBER() OVER(ORDER BY LAT_N ASC) AS R FROM STATION) AS TBL: Tạo 1 bảng TBL có 2 cột là Lat_n và cột R - Sắp 
-- sếp LAT_N theo thứ tự ASC và đánh số thứ tự.
-- B2: Tính trung bình các Lat_N trong điều kiện where: 
-- Ví dụ: Khi count(*) from station	= 5: thì median = LAT_N ở Row có rank = 3  (AVG của 1 số thì cũng bằng chính nó)
-- Còn khi count(*) = 6, thì median = LAT ở vị trí 3 và 4, rồi lấy trung bình cộng của LAT_N  ở 2 vị trí đó.