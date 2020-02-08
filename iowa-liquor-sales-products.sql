/*** GA Project SQL - Products ****/
-- How many products ? 2925 distinct UPC (most relevant), 7276 item description that can share UPC
select distinct upc from products
select item_description, upc, scc, category_name, bottle_price,bottle_size,case_cost, vendor_name from products 
where upc is not Null order by item_description asc limit 1000
select upc, item_description from products 
where upc is not Null group by upc, item_description order by item_description asc limit 1000
-- How many vendors? 271
select distinct on(vendor) * from  sales where vendor is not null
-- How many categories? 68
select category_name from  sales where category_name is not null group by category_name
-- Products sold the most by number of sales: Black Velvet 81095, Hawkeye Vodka 74264
select description,category_name, avg(btl_price::numeric)::money as avg_btl_price,  avg(total)::money as avg_sale, 
round(avg(bottle_qty), 2) as avg_btl_qty, count(total) as nr_of_sales from sales 
group by description, category_name order by 6 desc limit 10

-- Category of products sold by the most vendors: 80 proof vodka 413703 Canadian Whiskies 290921
select category_name, count(vendor) from sales group by category_name order by 2 desc
-- Item making most $ in sales: black velvet, hawkeye vodka
select description, category_name, sum(total)::money as total_sales 
from sales group by description, category_name order by 3 desc limit 10

-- percentage of total sales in $ top 10 items (total sales: $392,293,023)
select description, category_name,  sum(total)::money  as 
subtotal_sales, (sum(total) / (select sum(total) from sales)) * 100 as percent_of_total_sales from sales 
group by description, category_name order by 3 desc limit 10

-- percentage of total sales in amount top 10 items (nr of sales: 3,049,913 sales)
select description,  count(total)  as 
subcount_sales, (count(total)::float / (select count(total)::float from sales)) * 100 as percent_of_count_sales from sales 
group by description order by 3 desc limit 10

--averages of total
select avg(btl_price::numeric) from sales
select avg(total::numeric) from sales
select avg(bottle_qty::numeric) from sales


