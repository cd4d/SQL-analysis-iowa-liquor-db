/*** GA Project SQL - Sales ****/
-- ranking sales: $500+ highest, $100+ High, $20+ medium, rest low
select store, name,
COALESCE(sum(CASE WHEN sales_rank = 'Highest' THEN 1 ELSE 0 END),0) as highest_sales,
COALESCE(sum(CASE WHEN sales_rank = 'High' THEN 1 ELSE 0 END),0) as high_sales,
COALESCE(sum(CASE WHEN sales_rank = 'Mid.' THEN 1 ELSE 0 END),0) as mid_sales,
COALESCE(sum(CASE WHEN sales_rank = 'Low' THEN 1 ELSE 0 END),0) as low_sales
from
	(
	select store, count(store),
		CASE
			when total >= 500 then 'Highest'
			when total >= 100 then 'High'
			when total >= 20 then 'Mid.'
			else coalesce('Low')
		END as sales_rank
		from sales
	group by store, total
	) as rankings
inner join stores using(store)
group by store, name  order by 3 desc limit 100


-- Most profitable product by unit, products sold at least 100 times: 
select description, count(description), (avg((btl_price::numeric - state_btl_cost::numeric)))::money as profit_unit 
from sales group by description having count(description) > 100 order by 2 desc limit 20
--  categories with most profit by unit
select distinct category_name, sum(cast((btl_price - state_btl_cost)  as money)) as profit 
from sales group by category_name order by 2 desc limit 20

-- Products with the highest profit / margin by unit: 
select description, (avg((btl_price::numeric - state_btl_cost::numeric)))::money as profit_unit,
round(avg((((btl_price - state_btl_cost) / state_btl_cost) * 100)::numeric),2) as margin, 
count(description) from sales group by description order by count desc limit 20

-- Products with the highest profit total: 
select description, avg(btl_price::numeric)::money as avg_bottle_price, (sum((btl_price::numeric - state_btl_cost::numeric) * bottle_qty))::money as profit_total,
count(description) as nr_sales from sales group by description order by profit_total desc limit 20


-- Products with the highest profit / margin unit by percentage: 
select description, avg(btl_price::numeric)::money as avg_btl_price, avg(state_btl_cost::numeric)::money as avg_state_btl_cost,
sum(((btl_price::numeric) - (state_btl_cost::numeric)) * bottle_qty)::money as sum_profit,
round((((avg(btl_price::numeric) - avg(state_btl_cost::numeric))/ avg(state_btl_cost::numeric)) * 100),2) as margin_percent, 
count(description) as nr_sales from sales group by description order by 5 desc limit 10