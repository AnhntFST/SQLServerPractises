-- Truy vấn để tìm ra từng loại node trong bảng BST gồm 2 cột: N (node) và P (parent).
-- Sắp xếp theo giá trị của nốt(ASC)
go
CREATE TABLE BST
(N INT, P INT)

INSERT INTO BST	(N,P)
VALUES (1,2),(3,2),(6,8),(9,8),(2,5),(8,5),(5,NULL)

GO
SELECT * FROM BST
-- XÉT CỘT N: 1 PHẦN TỬ LÀ LEAF NẾU NÓ KHÔNG CÓ PHẦN TỬ P (KHÔNG NẰM TRONG CỘT P )
-- LÀ ROOT NẾU NÓ KHÔNG CÓ PHẦN TỬ P TƯƠNG ỨNG
-- CÒN LẠI LÀ INNER
GO
SELECT CASE WHEN N IN (SELECT N FROM BST
                       EXCEPT -- Lấy các phần tử N mà không có trong P thì là node leaft
                       SELECT P FROM BST) THEN CAST(N AS VARCHAR(5)) + ' Leaf'
			WHEN N IN (SELECT N FROM BST WHERE P IS NULL) THEN CAST(N AS VARCHAR(5)) + ' Root'
		    ELSE CAST(N AS VARCHAR(5)) + ' Inner'
			END	AS DIFINE
FROM BST
ORDER BY N
