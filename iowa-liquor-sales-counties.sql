-- Counties that sell the most bottles per capita: Dickinson 22 bottles/person (polk is 15 btl/person)
select a.county, (sum(a.bottle_qty) / b.population) as bottles_per_capita from sales a
inner join counties b using(county)
group by  a.county, b.population order by 2 desc limit 100
-- Counties that have the most sales per capita: Dickinson $308/person, Polk $200/person
select a.county,b.population, cast(sum(a.total) / b.population as money) as total_per_capita from sales a
inner join counties b using(county)
group by  a.county, b.population order by 3 desc limit 100

-- per capita spending, only counties with 100k+ pop: Focus on Linn
select a.county,b.population, count(distinct store) as num_stores,sum(total)::money as total_sales, cast(sum(a.total) / b.population as money) as total_per_capita from sales a
inner join counties b using(county) 
where b.population >= 100000
group by  a.county, b.population order by 2 desc limit 100

-- per store spending,  only counties with 100k+ pop:
select a.county,b.population, count(distinct store) as num_stores,sum(total)::money as total_sales, cast(sum(a.total) / count(distinct store) as money) as total_per_store from sales a
inner join counties b using(county) 
where b.population >= 100000
group by  a.county, b.population order by 2 desc limit 100

-- per store spending,  only counties with 25-100k pop:
select a.county,b.population, count(distinct store) as num_stores,sum(total)::money as total_sales, cast(sum(a.total) / count(distinct store) as money) as total_per_store from sales a
inner join counties b using(county) 
where b.population between 25000 and 100000
group by  a.county, b.population order by 5 desc limit 100

-- per capita spending, only counties with 25-100k pop: 
select a.county,b.population, count(distinct store) as num_stores,sum(total)::money as total_sales, cast(sum(a.total) / b.population as money) as total_per_capita from sales a
inner join counties b using(county) 
where b.population between 25000 and 100000
group by  a.county, b.population order by 2 desc limit 100

-- percentage of total sales top 10 counties (total sales: $392,293,023)

select county, population,  sum(total)::money  as 
subtotal_sales, (sum(total) / (select sum(total) from sales)) * 100 as percent_of_total_sales from sales 
inner join counties using(county)
group by county, population order by 3 desc limit 10


