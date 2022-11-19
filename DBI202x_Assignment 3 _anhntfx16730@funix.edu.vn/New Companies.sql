-- Yêu cầu: Cho 5 bảng theo sơ đồ Company -> Lead_manager -> Senior_manager -> Manager -> Employee
-- Viết truy vấn in ra: Company_code, Founder_name, tổng số Lead_manager, Tổng số Senior Manager, Tổng số Manager, tổng số Employee
CREATE TABLE Company
(company_code VARCHAR(5),
 founder VARCHAR(20))
 go
 insert into Company
 values('C1','Monika'),('C2','Samantha')

 go
 create table Lead_Manager
 (lead_manager_code varchar(5),
  company_code varchar(5))
  insert into Lead_Manager
  values('LM1','C1'),('LM2','C2')

go
create table Senior_Manager
(senior_manager_code varchar(5),
 lead_manager_code varchar(5),
 company_code varchar(5))

 insert into Senior_Manager
 values('S1','LM1','C1'),('S2','LM1','C1'),('S3','LM2','C2')

 GO

create table Manager
(manager_code varchar(5),
 senior_manager_code varchar(5),
 lead_managere_code varchar(5),
 company_code varchar(5))

 insert into Manager
 values('M1','SM1','LM1','C1'),('M2','SM3','LM2','C2'),('M3','SM3','LM2','C2')
 GO
 
 create table Employee
 (employee_code varchar(5),
  manager_code varchar(5),
  senior_manager_code varchar(5),
  lead_manager_code varchar(5),
  compan_code varchar(5))

  insert into Employee
  values('E1','M1','SM1','LM1','C1'),('E2','M1','SM1','LM1','C1'),
  ('E3','M2','SM3','LM2','C2'),('E4','M3','SM3','LM2','C2')

GO

-- Cách làm: Sử dụng with, tạo từng bảm tạm với 2 cột là Company_code và số lượng nhân viên.
-- Sau đó join truy suất các trường cần select
with 
totalE as (select compan_code, count(employee_code) as TotalEmployee from Employee group by compan_code),
totalM as (select company_code, count(manager_code) as TotalMng from Manager group by company_code),
totalS as (select company_code, count(senior_manager_code) as TotalSenior from Senior_Manager group by company_code),
totalL as (select company_code, count(lead_manager_code) as TotalLeader from Lead_Manager group by company_code)

select C.company_code, C.founder, L.TotalLeader, S.TotalSenior,M.TotalMng,  E.TotalEmployee 
from Company as C join totalL as L on C.company_code = L.company_code
	 join totalS as S on S.company_code = L.company_code
	 join totalM as M on M.company_code = S.company_code
	 join totalE as E on E.compan_code = M.company_code






