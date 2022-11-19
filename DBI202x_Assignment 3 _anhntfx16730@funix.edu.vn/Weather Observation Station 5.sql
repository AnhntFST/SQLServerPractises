﻿--Yêu cầu: Truy vấn tên 2 thành phố trong trạm quan sát Station	có ít ký tự và nhiều ký tự nhất
-- Nếu có nhiều hơn 1 thành phố thoả mãn yêu cầu thì chọn City đầu tiên theo bảng Aphabe

CREATE TABLE STATION
(CITY VARCHAR(10))

GO
INSERT INTO STATION
VALUES('ABC'), ('CDE'),('EFF'),('IKLM'),('PQRH'), ('XYZK')

GO
-- Tạo 1 rank sếp hạng các THÀNH PHỐ THEO THỨ TỰ CHIỀU DÀI TÊN CITY VÀ TÊN CTIY. NẾU TRÙNG NHAU ĐỘ DÀI, THÌ SẮP XẾP THEO APHABE
WITH MyTable AS
(SELECT CITY, LEN(TRIM(CITY)) AS LENGTHCITY, RANK() OVER(ORDER BY LEN(TRIM(CITY)), CITY) AS RANKTB
FROM STATION)
-- CHỌN TỪ BẢNG TRÊN TÊN CITY CÓ RANK NHỎ NHẤT
SELECT CITY, LENGTHCITY FROM MyTable
WHERE LENGTHCITY = (SELECT MIN(LENGTHCITY) FROM MyTable) AND RANKTB = (SELECT MIN(RANKTB) FROM MyTable)

GO

WITH MyTable AS
(SELECT CITY, LEN(TRIM(CITY)) AS LENGTHCITY, RANK() OVER(ORDER BY LEN(TRIM(CITY)), CITY) AS RANKTB
FROM STATION),
NewTable AS
(SELECT * FROM MyTable
WHERE LENGTHCITY = (SELECT MAX(LENGTHCITY) FROM MyTable))
SELECT CITY, LENGTHCITY FROM NewTable
WHERE RANKTB = (SELECT MIN(RANKTB) FROM NewTable)
