with cte_1 as (select *
from(
-- step 2
select author,year,lag(year,4) over (partition by author order by year) as lag_5
from
-- step 1
(select author,year from books group by author,year having genre = 'Fiction' order by 1,2) t
) t2
-- step 3
where lag_5 is not null
)


select author,max(year) as year,count(*) + 4 as depth
from cte_1 
where (year-lag_5)=4 
group by author;