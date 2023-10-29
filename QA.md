What are your risk areas? Identify and describe them.

1. There are too many vital columns with missing information, this is going to negatively impact the data analysis. 

Examples of some vital information missing are as below:

1. City information missing in all_sessions and that was vital to answer most of the questions in "starting with questions"
2. It would have been beneficial to have visitid in the sales_report csv to help connect to the actual successful transactions that resulted in revenue.
3. Most of the rows in all_sessions had the totalrevenue unavailable, hence leading to the assumption that the rest of the rows in the table did not result in any successful transaction/order.
4. Could not make much use of sales_by_sku or sales_report datasets due to inadequate means to uniquely connect with all_sessions table.



# QA Process:
Describe your QA process and include the SQL queries used to execute it.

First step was to review the data in all the tables and identify its content. This included summarizing each table and what data it held.


1. All_sessions:
Table with info on visitor sessions and behavior
- city - has null values
- currency code - has null values
- product variant - not set for a lot of rows
- timeonsite - has null values
- country - has null values
- What is "time" column?
- date is in YYYYMMDD format
- productrevenue - mostly empty - only 4 values

2. analytics - table with analytical data on user behavior

3. products - table with info on products, sales, inventory, lead time, sentiments

4. sales_by_sku - table with info on sales qty by sku 

5. sales_report - very similar to products table

## Tried to validate the order numbers in products table v/s the order numbers in sales_by_sku - there was a total mismatch of numbers

select sku, sum(orderedquantity::numeric) ordered_prod,total_ordered tot_ord_sales
from products
join sales_by_sku on productsku = sku
group by sku,total_ordered;


**Verify total ordered in sales_by_sku and sales_report match**

select productsku, a.total_ordered, b.total_ordered from sales_report a
join sales_by_sku b using (productsku)
where  a.total_ordered <>b.total_ordered ;

*0 rows returned*

**Check if there are SKUs in sales_by_sku without a matching record in "products" master table**
select * from sales_by_sku a
where not exists (select 1 from products where sku=a.productsku);

*8 rows returned*

**Check if there are SKUs in sales_report without a matching record in "products" master table**
select * from sales_report a
where not exists (select 1 from products where sku=a.productsku);

*0 rows returned*

**Check if there are SKUs in all_sessions without a matching record in "products" master table**
select * from all_sessions a
where not exists (select 1 from products where sku=a.productsku);

*2033 rows affected*

**Verify product names in products table match with that in all_sessions**
select productsku, v2productname, name
from all_sessions
join products on sku=productsku
where v2productname <> name;

*9887 rows returned indicating mismatch in majority of product names*

**Verify order count in products table matches with the sales_by_sku table**
with prod_orders as (select sku, sum(orderedquantity::numeric) ordered_prod,total_ordered tot_ord_sales
from products
join sales_by_sku on productsku = sku
group by sku,total_ordered )
select sku, ordered_prod, tot_ord_sales
from prod_orders
where ordered_prod::numeric<>tot_ord_sales::numeric;

*371 rows have data mismatch*

**Verify all visitorids in analytics are present in all_sessions table**

SELECT *
FROM ANALYTICS A
WHERE NOT EXISTS
		(SELECT *
			FROM ALL_SESSIONS B
			WHERE B.FULLVISITORID = A.FULLVISITORID);

*4099657 records returned without matching records*


