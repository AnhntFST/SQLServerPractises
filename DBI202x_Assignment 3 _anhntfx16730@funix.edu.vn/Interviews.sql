
create table Contests
(contest_id int, hacker_id int, name varchar (20))

create table Colleges
(college_id int, contest_id int)

create table Challengess
(challenge_id int, college_id int)

create table View_Stats
(challenge_id int, total_views int, total_unique_views int)

create table Submission_Stats
(challenge_id int, total_submissions int, total_accepted_submissions int)

go
insert into Contests
values(66406, 17973,'Rose'),
	  (66556, 79153, 'Angela'),
	  (94828,80275, 'Frank')

insert into Colleges
values(11219, 66406),
	  (32473,66556),
	  (56685, 94828)

insert into View_Stats
values (47127,26,19),
	   (47127,15,14),
	   (18765, 43,10),
	   (18765,72,13),
	   (75516,35, 17),
	   (60292, 11, 10),
	   (72974, 41, 15),
	   (75516, 75, 11)

insert into Challengess
values( 18765, 11219),
	  (47127, 11219),
	  (60292, 32473),
	  (72974, 56685)

insert into Submission_Stats
values (75516, 34, 12),
	   (47127, 27, 10),
	   (47127, 56, 18),
	   (75516, 74, 12),
	   (75516, 83, 8),
	   (72974, 68, 24),
	   (72974, 82, 14),
	   (47127, 28, 11)
go

with tblAllJoin1 as	  -- tbl1 truy van 1/2 yêu cầu
(select Con.contest_id, con.hacker_id, con.name, sum(total_views) as ttv , sum(total_unique_views)as ttuv 
from Contests as Con join Colleges as Col on Con.contest_id = col.contest_id
join Challengess as Cha on cha.college_id = col.college_id
join View_Stats as V on V.challenge_id = cha.challenge_id
group by Con.contest_id, con.hacker_id, con.name),
-- right join Submission_Stats as S on S. challenge_id = V.challenge_id) (kHÔNG JOIN bảng Submision_stats vì bảng này không có được contest 66556)

tblAllJoin2 as	 -- tb2 truy vấn 1/2 yêu cầu
(select Con.contest_id, sum(total_submissions) as ttsm , sum(total_accepted_submissions)as ttacsm 
from Contests as Con join Colleges as Col on Con.contest_id = col.contest_id
join Challengess as Cha on cha.college_id = col.college_id
left join Submission_Stats as S on S. challenge_id = Cha.challenge_id
group by Con.contest_id)
-- Join 2 bảng để được yêu cầu đầu bài
select t1.contest_id, t1.hacker_id, t1.name, 
case when t2.ttsm is null then 0 else t2.ttsm end as ttsm, case when t2.ttacsm is null then 0 else t2.ttacsm end as ttacsm,
t1.ttv ,t1.ttuv
from tblAllJoin1 as t1 join tblAllJoin2 as t2 on t1.contest_id = t2.contest_id




