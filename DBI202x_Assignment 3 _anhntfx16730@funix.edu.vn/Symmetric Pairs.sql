
create table Functions
(X int, Y int)

insert into Functions values
(20,20),(20,20),(20,21),(23,22),(22,23),(21,20)
go
	with
	cte_temp as (select X,Y, ROW_NUMBER() over (order by X) as RankOfRow from Functions)
	select distinct a.X, a.Y
	from cte_temp as a
	join
	cte_temp as b
	on a.X = b.Y and a.Y = b.X and a.RankOfRow <> b.RankOfRow
	where a.X <= a.Y
	order by a.X ASC
