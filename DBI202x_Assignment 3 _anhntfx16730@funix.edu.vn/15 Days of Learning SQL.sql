CREATE TABLE HACKERS3
(hacker_id int, name varchar (20))

create table Submissions2
(submission_date date, submission_id int,
 hacker_id int, score int)

 insert into HACKERS3
 values (15758, 'Rose'),
		(20703, 'Angela'),
		(36396, 'Frank'),
		(28289, 'Patrick'),
		(44065, 'Lisa'),
		(53473, 'Kimberly'),
		(62529, 'Bonnie'),
		(79722, 'Michael')

insert into Submissions2
values ('2016-03-01', 8594, 20703, 0),
	   ('2016-03-01', 22403, 53473, 15),
	   ('2016-03-01', 23965, 79722, 60),
	   ('2016-03-01', 30173, 36396,70),
	   ('2016-03-02', 34928, 20703, 0),
	   ('2016-03-02', 38740, 15758, 60),
	   ('2016-03-02', 42769, 79722, 25),
	   ('2016-03-02', 44364, 79722, 60),
	   ('2016-03-03', 45440, 20703, 0),
	   ('2016-03-03', 49050, 36396, 70),
	   ('2016-03-03', 50273, 79722, 5),
	   ('2016-03-04', 50344, 20703, 0),
	   ('2016-03-04', 51360, 44065, 90),
	   ('2016-03-04', 54404, 53473, 65),
	   ('2016-03-04', 61533, 79722, 45),
	   ('2016-03-05', 72852, 20703, 0),
	   ('2016-03-05', 74546, 38289, 0),
	   ('2016-03-05', 76487, 62529, 0),
	   ('2016-03-05', 82439, 36396, 10),
	   ('2016-03-05', 90006, 36396, 40),
	   ('2016-03-06', 90404, 20703, 0)
go
-- Yêu cầu đề bài: truy vấn tổng số hacker (ko trùng lặp) submision hàng ngày, ít nhất 1 lần
-- bắt đầu từ ngày đầu tiên. Và hiển thị hacker_id, hacker_name của người có số lần submission
-- nhiều nhất trong ngày.
-- Nếu nhiều hacker có cùng số lần max submision, hiển thị hacker có id nhỏ nhất.
-- Hiển thị thông tin yêu cầu theo ngày, sắp xếp theo Date tăng dần.
go
with tblData as
(select S.submission_date, s.hacker_id,
       DENSE_RANK() over (order by S.submission_date) rank_date, -- Xếp hạng theo ngày 
	   count(*) over (partition by S.hacker_id order by S.submission_date) as Count_id,-- Cộng dồn hacker_id theo ngày
	   DENSE_RANK() over (partition by S.submission_date order by count(*) desc, min(S.submission_id)) as Rank_sub -- Xếp hạng hacker_id theo số lần gửi trong ngày (gửi nhiều nhất thì bắt đầu từ 1)
from Submissions2 as S
group by S.submission_date, s.hacker_id),

tbl1 as 
(select tblData.submission_date, count(*) as Count_id
from tblData 
-- Điều kiện để xác định hacker_id nào gửi hàng ngày: Nếu ngày 1 thì rank_date = count_id = 1; ngày 2 thì nếu phải = 2 vvv
where tblData.rank_date = tblData.Count_id	
group by tblData.submission_date),

tbl2 as 
(select tblData.submission_date, tblData.hacker_id, HACKERS3.name
 from tblData, HACKERS3
 -- Điều kiện để xác định hacker_id nào có thứ hạng thấp
 where tblData.Rank_sub = 1 and tblData.hacker_id = HACKERS3.hacker_id)
 -- Tổn hợp kết quả từ các bảng tạm:
select tbl1.submission_date, tbl1.Count_id, tbl2.hacker_id, tbl2.name
from  tbl1, tbl2 
where tbl1.submission_date = tbl2.submission_date
order by submission_date