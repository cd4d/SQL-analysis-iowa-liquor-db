/*** GA Project SQL - 2014 monthly growth of top products ****/

-- Item making most sales: black velvet, hawkeye vodka
select a.description, a.category_name, sum(total)::money as total_sales,percent_sales_jan,percent_sales_feb,percent_sales_mar,percent_sales_apr,percent_sales_may,percent_sales_jun,percent_sales_jul,percent_sales_aug,percent_sales_sep,
percent_sales_oct,percent_sales_nov,percent_sales_dec from sales a

join

(select description, category_name,
(1 /((select sum(total) from sales where date between '2014-01-01' and '2014-01-31') / sum(total)) * 100)::decimal(3,2) as percent_sales_jan
from sales where date between '2014-01-01' and '2014-01-31'
group by description, category_name order by 3 desc limit 10) as jan
using (description)


join
(select description, category_name,
(1 /((select sum(total) from sales where date between '2014-02-01' and '2014-02-28') / sum(total)) * 100)::decimal(3,2) as percent_sales_feb
from sales where date between '2014-02-01' and '2014-02-28'
group by description, category_name order by 3 desc limit 10) as feb
using (description)

join
(select description, category_name,
(1 /((select sum(total) from sales where date between '2014-03-01' and '2014-03-31') / sum(total)) * 100)::decimal(3,2) as percent_sales_mar
from sales where date between '2014-03-01' and '2014-03-31'
group by description, category_name order by 3 desc limit 10) as mar
using (description)

join
(select description, category_name,
(1 /((select sum(total) from sales where date between '2014-04-01' and '2014-04-30') / sum(total)) * 100)::decimal(3,2) as percent_sales_apr
from sales where date between '2014-04-01' and '2014-04-30'
group by description, category_name order by 3 desc limit 10) as apr
using (description)

join
(select description, category_name,
(1 /((select sum(total) from sales where date between '2014-05-01' and '2014-05-31') / sum(total)) * 100)::decimal(3,2) as percent_sales_may
from sales where date between '2014-05-01' and '2014-05-31'
group by description, category_name order by 3 desc limit 10) as may
using (description)

join
(select description, category_name,
(1 /((select sum(total) from sales where date between '2014-06-01' and '2014-06-30') / sum(total)) * 100)::decimal(3,2) as percent_sales_jun
from sales where date between '2014-06-01' and '2014-06-30'
group by description, category_name order by 3 desc limit 10) as jun
using (description)

join
(select description, category_name,
(1 /((select sum(total) from sales where date between '2014-07-01' and '2014-07-31') / sum(total)) * 100)::decimal(3,2) as percent_sales_jul
from sales where date between '2014-07-01' and '2014-07-31'
group by description, category_name order by 3 desc limit 10) as jul
using (description)

join
(select description, category_name,
(1 /((select sum(total) from sales where date between '2014-08-01' and '2014-08-31') / sum(total)) * 100)::decimal(3,2) as percent_sales_aug
from sales where date between '2014-08-01' and '2014-08-31'
group by description, category_name order by 3 desc limit 10) as aug
using (description)

join
(select description, category_name,
(1 /((select sum(total) from sales where date between '2014-09-01' and '2014-09-30') / sum(total)) * 100)::decimal(3,2) as percent_sales_sep
from sales where date between '2014-09-01' and '2014-09-30'
group by description, category_name order by 3 desc limit 10) as sep
using (description)

join
(select description, category_name,
(1 /((select sum(total) from sales where date between '2014-10-01' and '2014-10-31') / sum(total)) * 100)::decimal(3,2) as percent_sales_oct
from sales where date between '2014-10-01' and '2014-10-31'
group by description, category_name order by 3 desc limit 10) as oct
using (description)

join
(select description, category_name,
(1 /((select sum(total) from sales where date between '2014-11-01' and '2014-11-30') / sum(total)) * 100)::decimal(3,2) as percent_sales_nov
from sales where date between '2014-11-01' and '2014-11-30'
group by description, category_name order by 3 desc limit 10) as nov
using (description)

join
(select description, category_name,
(1 /((select sum(total) from sales where date between '2014-12-01' and '2014-12-31') / sum(total)) * 100)::decimal(3,2) as percent_sales_dec
from sales where date between '2014-12-01' and '2014-12-31'
group by description, category_name order by 3 desc limit 10) as dece
using (description)

group by a.description, a.category_name,
percent_sales_jan,percent_sales_feb,percent_sales_mar,percent_sales_apr,percent_sales_may,percent_sales_jun,percent_sales_jul,percent_sales_aug,percent_sales_sep,
percent_sales_oct,percent_sales_nov,percent_sales_dec order by 3 desc limit 10
