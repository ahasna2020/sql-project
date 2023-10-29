What issues will you address by cleaning the data?





Queries:
Below, provide the SQL queries you used to clean your data.

Which csv can be considered the absolute correct one?

**Cleanup unit price**
select unit_price, round(unit_price::numeric/1000000,2) from analytics;

--adding new column so raw data is left intact in original column
alter table if exists analytics add unit_price_new numeric;

update analytics
set unit_price_new=round(unit_price::numeric/1000000,2);


select unit_price, unit_price_new from analytics

**Cleanup productprice in all_sessions**

update all_sessions
set productprice=round((productprice::numeric/1000000),2)::text;


**Cleanup all revenue columns in all_sessions as those might be impacted by the old value of unit_price**
update all_sessions
set totaltransactionrevenue=round((totaltransactionrevenue::numeric/1000000),2)::text
where totaltransactionrevenue is not null;


update all_sessions
set productrevenue=round((productrevenue::numeric/1000000),2)::text
where productrevenue is not null;


update all_sessions
set transactionrevenue=round((transactionrevenue::numeric/1000000),2)::text
where transactionrevenue is not null;

**Verify total ordered in sales_by_sku and sales_report match**

select productsku, a.total_ordered, b.total_ordered from sales_report a
join sales_by_sku b using (productsku)
where  a.total_ordered <>b.total_ordered ;

*0 rows returned*

**Check if there are SKUs in sales_by_sku without a matching record in "products" master table**
select * from sales_by_sku a
where not exists (select 1 from products where sku=a.productsku);

*8 rows returned*

**Remove rows from sales_by_sku that do not have a matching record in "products" master table**
delete from sales_by_sku a
where not exists (select 1 from products where sku=a.productsku);

*8 rows deleted*

**Check if there are SKUs in sales_report without a matching record in "products" master table**
select * from sales_report a
where not exists (select 1 from products where sku=a.productsku);

*0 rows returned*

**Check if there are SKUs in all_sessions without a matching record in "products" master table**
select * from all_sessions a
where not exists (select 1 from products where sku=a.productsku);

*2033 rows affected*

**Check if there are SKUs in all_sessions without a matching record in "products" master table but has totaltransactionrevenue**
select * from all_sessions a
where not exists (select 1 from products where sku=a.productsku)
and totaltransactionrevenue is not null;

*13 rows returned* 

*However removing these rows will impact further questions as very few rows have totaltransactionrevenue information*

**Check if there are duplicate records for a given sku in products, sales_by_sku and sales_report tables**

*Created all three of these tables with SKU as primary key, therefore confirming that there are no duplicates*


**Drop columns without any values in it as they are not going to help with the analysis**

select count(*) null_rows, (select count(*) from all_sessions) tot_rows
from all_sessions
where productrefundamount is null ;

alter table all_sessions drop column productrefundamount;

