--Yêu cầu: Truy vấn Employee có thu nhập nhiều nhất (thu nhập = số tháng * lương tháng)
-- và có bao nhiêu người cùng mức thu nhập đó.
drop table NewEmployee
create table NewEmployee
(employee_Id int,
 name varchar(10),
 months int,
 salary int)

 insert into NewEmployee
 values (12228,'Rose', 15, 1968),
		(33645,'Angela',1,3443),
		(45692,'Frank',17,1608),
		(56118,'Patrick',7,1345),
		(59725,'Lisa',11,2330),
		(74197,'Kimberly',16,4372),
		(74197,'Kimberly2',16,4372),
		(78454,'Bonnie',8,1771),
		(83565,'Michael',6,2017),
		(98607,'Todd',5,3396),
		(99989,'Joe',9,3573)

-- SoVent (Tạo bảng tạm với bảng tính Earning = months*salary)
-- Sau đó select Max Earning và count Earning với điều kiện Earning = giá trị Max
go
with
EmpEarning as 
(select employee_Id, months*salary as Earning
from NewEmployee)
select max(Earning) as MaxEarning, count(Earning) as CountEarning from EmpEarning 
where Earning = (select max(Earning) from EmpEarning)


