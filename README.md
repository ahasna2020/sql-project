# Final-Project-Transforming-and-Analyzing-Data-with-SQL

## Project/Goals
### To transform and analyze the dataset provided for an ecommerce portal to summarize data trends, top performing products, top sales regions, ordering trends for products by area etc.

## Process
### As a first step, a new database called "ecommerce" was created. Subsequently, tables for each of the datasets were created and loaded into the database. Where possibile, primary keys were applied.
### As a second step, all the datasets provided were analyzed to understand the data in it.
### As a third step, effort was made to cleanup data where possible, derive connections between tables, check correctness of data provided etc.
### As a fourth step, the queries to derive data trends were formulated to arrive at conclusions.
### As a fifth step, the quality assurance process was carried out through a series of cross reference queries. 


## Results
The results show that United States leads the list providing the most revenue. Amongst the cities, San Francisco was seen to be contributing the most to the revenue with a total revenue of $1564.32. 
Amongst products, Google NEST products topped the list followed by Men's and Women's Apparel as popular products.


## Challenges 
There are too many vital columns with missing information, this is going to negatively impact the data analysis. 

Examples of some vital information missing are as below:

1. City information missing in all_sessions and that was vital to answer most of the questions in "starting with questions"
2. It would have been beneficial to have visitid in the sales_report csv to help connect to the actual successful transactions that resulted in revenue.
3. Most of the rows in all_sessions had the totalrevenue unavailable, hence leading to the assumption that the rest of the rows in the table did not result in any successful transaction/order.
4. Could not make much use of sales_by_sku or sales_report datasets due to inadequate means to uniquely connect with all_sessions table.

## Future Goals
IF I had more time, I would try to find a direct connection between data in all_sessions table to other tables such as analytics, sales_by_sku and sales_report tables to be able to gather more data insights.
