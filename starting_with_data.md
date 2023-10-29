# Question 1: find all duplicate records

SQL Queries:

select  sku, count(*) 
from products
group by sku
having count(*) > 1

*0 rows returned*

select productsku,count(*)
from sales_by_sku
group by productsku
having count(*) > 1

*0 rows returned*

select productsku,count(*)
from sales_report
group by productsku
having count(*) > 1

*0 rows returned*

select visitid, count(*) from all_sessions 
group by visitid
having count(*) > 1; 

*returned rows but was for different products, hence ignored*

Answer: 

*0 rows returned for all queries except the last one*


# Question 2: find the total number of unique visitors (`fullVisitorID`)

SQL Queries:

select count(distinct fullvisitorid) 
from all_sessions;

Answer:

14223

# Question 3: find the total number of unique visitors by referring sites

SQL Queries:

select count(distinct fullvisitorid) 
from all_sessions 
where channelgrouping='Referral';


Answer:
2419


# Question 4: find each unique product viewed by each visitor

SQL Queries:

select distinct fullvisitorid, v2productname 
from all_sessions 
order by 1;

Answer:

*15115 rows returned - dataset too large to paste here*


# Question 5: compute the percentage of visitors to the site that actually makes a purchase

SQL Queries:

###### Assumption: Total transaction revenue should be not null if the site visit resulted in an order.

select (count(distinct fullvisitorid)/(select count(distinct fullvisitorid) from all_sessions))*100
from all_sessions 
where totaltransactionrevenue::numeric >0

Answer:

0

