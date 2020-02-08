/*** GA Project SQL - 2014 yearly change by county ****/

-- Item making most sales: black velvet, hawkeye vodka
select a.county, sum(total)::money as total_sales,percent_sales_jan,percent_sales_feb,percent_sales_mar,percent_sales_apr,percent_sales_may,percent_sales_jun,percent_sales_jul,percent_sales_aug,percent_sales_sep,
percent_sales_oct,percent_sales_nov,percent_sales_dec from sales a

join

(select county,
(1 /((select sum(total) from sales where date between '2014-01-01' and '2014-01-31') / sum(total)) * 100)::decimal as percent_sales_jan
from sales where date between '2014-01-01' and '2014-01-31'
group by county order by 2 desc limit 10) as jan
using (county)


join
(select county,
(1 /((select sum(total) from sales where date between '2014-02-01' and '2014-02-28') / sum(total)) * 100)::decimal as percent_sales_feb
from sales where date between '2014-02-01' and '2014-02-28'
group by county order by 2 desc limit 10) as feb
using (county)

join
(select county,
(1 /((select sum(total) from sales where date between '2014-03-01' and '2014-03-31') / sum(total)) * 100)::decimal as percent_sales_mar
from sales where date between '2014-03-01' and '2014-03-31'
group by county order by 2 desc limit 10) as mar
using (county)

join
(select county,
(1 /((select sum(total) from sales where date between '2014-04-01' and '2014-04-30') / sum(total)) * 100)::decimal as percent_sales_apr
from sales where date between '2014-04-01' and '2014-04-30'
group by county order by 2 desc limit 10) as apr
using (county)

join
(select county,
(1 /((select sum(total) from sales where date between '2014-05-01' and '2014-05-31') / sum(total)) * 100)::decimal as percent_sales_may
from sales where date between '2014-05-01' and '2014-05-31'
group by county order by 2 desc limit 10) as may
using (county)

join
(select county,
(1 /((select sum(total) from sales where date between '2014-06-01' and '2014-06-30') / sum(total)) * 100)::decimal as percent_sales_jun
from sales where date between '2014-06-01' and '2014-06-30'
group by county order by 2 desc limit 10) as jun
using (county)

join
(select county,
(1 /((select sum(total) from sales where date between '2014-07-01' and '2014-07-31') / sum(total)) * 100)::decimal as percent_sales_jul
from sales where date between '2014-07-01' and '2014-07-31'
group by county order by 2 desc limit 10) as jul
using (county)

join
(select county,
(1 /((select sum(total) from sales where date between '2014-08-01' and '2014-08-31') / sum(total)) * 100)::decimal as percent_sales_aug
from sales where date between '2014-08-01' and '2014-08-31'
group by county order by 2 desc limit 10) as aug
using (county)

join
(select county,
(1 /((select sum(total) from sales where date between '2014-09-01' and '2014-09-30') / sum(total)) * 100)::decimal as percent_sales_sep
from sales where date between '2014-09-01' and '2014-09-30'
group by county order by 2 desc limit 10) as sep
using (county)

join
(select county,
(1 /((select sum(total) from sales where date between '2014-10-01' and '2014-10-31') / sum(total)) * 100)::decimal as percent_sales_oct
from sales where date between '2014-10-01' and '2014-10-31'
group by county order by 2 desc limit 10) as oct
using (county)

join
(select county,
(1 /((select sum(total) from sales where date between '2014-11-01' and '2014-11-30') / sum(total)) * 100)::decimal as percent_sales_nov
from sales where date between '2014-11-01' and '2014-11-30'
group by county order by 2 desc limit 10) as nov
using (county)

join
(select county,
(1 /((select sum(total) from sales where date between '2014-12-01' and '2014-12-31') / sum(total)) * 100)::decimal as percent_sales_dec
from sales where date between '2014-12-01' and '2014-12-31'
group by county order by 2 desc limit 10) as dece
using (county)

group by a.county,
percent_sales_jan,percent_sales_feb,percent_sales_mar,percent_sales_apr,percent_sales_may,percent_sales_jun,percent_sales_jul,percent_sales_aug,percent_sales_sep,
percent_sales_oct,percent_sales_nov,percent_sales_dec order by 3 desc limit 10
