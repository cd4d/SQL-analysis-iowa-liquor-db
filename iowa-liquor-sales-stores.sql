/*** GA Project SQL - Stores ****/
 -- How many stores: 1973 stores, 1425 active stores, 548 inactive
select count(*) from stores where store_status ilike 'a'
-- County with most active stores: Polk with 194 active stores, Linn 98 stores Dickinson only 15 stores
select b.county, count(distinct c.store) as stores_in_county from sales a left join counties b using(county) left join stores c using(store)
where c.store_status ilike 'A' group by b.county order by 2 desc
-- Stores with most sales total : Hy-vee #3 / Bdi / Des Moines : $13,920,087.22
select b.name,  cast(sum(a.total)as money) as total_sales from sales a left join stores b using(store) 
group by b.name order by 2 desc
-- details
select * from sales inner join stores using(store) where stores.name ilike 'Hy-vee #3%' order by total desc limit 200
-- Stores with highest average sale: Paradise Distilling Company $7,578.15 ONLY 6 SALES
select b.name, a.county,a.convenience_store,  avg(total)::money  as avg_total from sales a left join stores b using(store) 
group by b.name, a.county, a.convenience_store order by 4 desc limit 100

-- stores with at least one sale of 500+ bottles
select b.name, a.county, max(a.bottle_qty) as max_bottles_sold, avg(bottle_qty)::integer as avg_bottles_sold, avg(total)::money as avg_total 
from sales a inner join stores b using(store) 
group by b.name, a.county having max(a.bottle_qty) > 500 order by 4 desc limit 200

-- percentage of sales 100+ bottles these stores have made? Only stores with at least 500 sales
select sel_2.store, name, county, count(sel_2.store) as nr_sales, sel1_total::money as total_sales, 
 sel1_avg::money as avg_sales, (avg(over_x))::numeric as percent_over_100 from
(select store, sum(total)  as sel1_total,avg(total) as sel1_avg from sales group by store order by 2 desc limit 100
) as sel_1
inner join
(select a.store, b.name, a.county, a.bottle_qty, a.total,
CASE
	when a.bottle_qty > 100 then 1
	else 0
END as over_x
from sales a inner join stores b using(store) 
group by a.store, b.name, a.county, a.bottle_qty, a.total 
order by 5 asc) as sel_2
using(store)
group by sel_2.store, name,county, total_sales, avg_sales  having count(sel_2.store) > 1000  order by 5 desc limit 100

select store, avg(total)::money from sales where store = 2633 group by store order by 2 desc

-- stores have made 2255 sales on average
select avg(count) from (select store,count(total) from sales group by store order by 2 desc) as all_stores

-- stores by nr of sales top 100
select  a.store, name, county, count(total), avg(total)::money 
from sales a inner join stores b using(store) group by store, name, county order by 4 desc limit 100
