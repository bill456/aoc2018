

drop table aoc_day4;
create table aoc_day4 (date_str text, date timestamp, day int, month int, yr int, hrs int, mins int, guard int, state text);

select * from aoc_day4 order by 2;

with cte as (
SELECT x
FROM   generate_series(timestamp '2018-04-01 00:00'
                     , timestamp '2018-11-23 23:59'
                     , interval  '1 min') t(x)
)
select cte.x, a.date, a.guard, a.state, cte.x::time
from cte
left outer join aoc_day4 a on cte.x = a.date
where date_part('hour', cte.x) in (23,0,1)

order by 1
;

create table aoc_day4_2 (date timestamp, time_str text, guard int, state text);


select count(*), guard, state -- Guard: 3203
from (
select a.date, a.guard, a.state
from aoc_day4_2 a 
where date_part('hour', a.date) in (0)
and state = 'fallsasleep'  
)s 
group by 2,3
order by 1 desc
limit 1
; 

select count(*), min
from (
select date_part('minute', date) as min
from aoc_day4_2 
where date_part('hour', date) in (0)
and guard = 3203
and state = 'fallsasleep'  
order by 1
)s
group by min
order by 1 desc
;

select (44 * 3203); -- Part 1 answer

select count(*), min, guard
from (

select date_part('minute', date) as min, guard
from aoc_day4_2 
where date_part('hour', date) in (0)
and state = 'fallsasleep'  
order by 1

)s
group by min, guard
order by 1 desc
;

select (32 * 1601); -- Part 1 answer

