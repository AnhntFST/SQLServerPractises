
CREATE TABLE PROJECTS
(Task_ID INT, StartDate DATE, EndDate DATE)

INSERT INTO PROJECTS
VALUES (1,'2015-10-01','2015-10-02'),
	   (2,'2015-10-02','2015-10-03'),
	   (3,'2015-10-03','2015-10-04'),
	   (4,'2015-10-13','2015-10-14'),
	   (5,'2015-10-14','2015-10-15'),
	   (6,'2015-10-28','2015-10-29'),
	   (7, '2015-10-30','2015-10-31')
GO
WITH
A AS (SELECT StartDate FROM PROJECTS Where StartDate not in (select EndDate from PROJECTS)),
B AS (SELECT EndDate FROM PROJECTS Where EndDate not in (select StartDate from PROJECTS) )

select StartDate, min(endDate) as End_date from A, B
where StartDate < EndDate 
group by StartDate
order by datediff(day,StartDate,min(endDate)), StartDate

-- datediff trả về số ngày giữa startdate và endDate 


