Answer the following questions and provide the SQL queries used to find the answer.

# Assumptions: Total transaction revenue should be not null if the site visit resulted in an order.
    
**Question 1: Which cities and countries have the highest level of transaction revenues on the site?**


SQL Queries:

select * from all_sessions

select country, city, sum(totaltransactionrevenue::numeric) tot_revenue
from all_sessions
group by country, city
having sum(totaltransactionrevenue::numeric)>0
order by 3 desc



Answer:

"Country"		"City"		"Revenue"
"United States"	"not available in demo dataset"	6092.56
"United States"	"San Francisco"	1564.32
"United States"	"Sunnyvale"	992.23
"United States"	"Atlanta"	854.44
"United States"	"Palo Alto"	608.00
"Israel"	"Tel Aviv-Yafo"	602.00
"United States"	"New York"	530.36
"United States"	"Mountain View"	483.36
"United States"	"Los Angeles"	479.48
"United States"	"Chicago"	449.52
"United States"	"Seattle"	358.00
"Australia"	"Sydney"	358.00
"United States"	"San Jose"	262.38
"United States"	"Austin"	157.78
"United States"	"Nashville"	157.00
"United States"	"San Bruno"	103.77
"Canada"	"Toronto"	82.16
"Canada"	"New York"	67.99
"United States"	"Houston"	38.98
"United States"	"Columbus"	21.99
"Switzerland"	"Zurich"	16.99


**Question 2: What is the average number of products ordered from visitors in each city and country?**


SQL Queries:
    
# Assumptions: Total transaction revenue should not be null if the site visit resulted in an order.

select country, city, round(avg(productquantity::numeric)) avg_no_of_products
from all_sessions
where totaltransactionrevenue is not null
group by country, city
order by 3 desc nulls last;

Answer:

"Country"       "City"      "Avg number of products"        
"United States"	"not available in demo dataset"	20
"United States"	"Atlanta"	4
"United States"	"New York"	1
"United States"	"Palo Alto"	1
"United States"	"San Francisco"	1
"United States"	"Chicago"	1
"United States"	"Seattle"	1
"United States"	"Mountain View"	1
"United States"	"Sunnyvale"	1
"United States"	"Columbus"	1
"United States"	"San Jose"	
"United States"	"Los Angeles"	
"Canada"	"New York"	
"Canada"	"Toronto"	
"Israel"	"Tel Aviv-Yafo"	
"Switzerland"	"Zurich"	
"United States"	"Austin"	
"United States"	"Houston"	
"Australia"	"Sydney"	
"United States"	"Nashville"	
"United States"	"San Bruno"	



**Question 3: Is there any pattern in the types (product categories) of products ordered from visitors in each city and country?**

# Assumptions: Total transaction revenue should be not null if the site visit resulted in an order.

SQL Queries:

# Top 10 Product categories
select country, city, v2productcategory,  count(v2productcategory) prod_category_cnt 
from all_sessions
where totaltransactionrevenue is not null
group by country, city,v2productcategory
order by 4 desc
limit 10;

Answer:

Nest products and apparels seem to be very popular product category in the  United States

"Country"       "City"                          "Product Category"                          "Count"
"United States"	"not available in demo dataset"	"Home/Nest/Nest-USA/"	                    6
"United States"	"San Francisco"	                "Home/Nest/Nest-USA/"	                    3
"United States"	"Palo Alto"	                    "Home/Nest/Nest-USA/"	                    2
"United States"	"not available in demo dataset"	"Home/Apparel/Women's/Women's-T-Shirts/"	2
"United States"	"not available in demo dataset"	"Home/Apparel/Men's/Men's-T-Shirts/"	    2
"United States"	"not available in demo dataset"	"Nest-USA"	                                2
"United States"	"Mountain View"	                 "Apparel"	                                2
"United States"	"not available in demo dataset"	"Electronics"	                            2
"United States"	"Atlanta"	                    "Home/Apparel/Men's/Men's-T-Shirts/"	    1
"United States"	"Atlanta"	                    "Bags"	1



**Question 4: What is the top-selling product from each city/country? Can we find any pattern worthy of noting in the products sold?**

# Assumptions: Total transaction revenue should be not null if the site visit resulted in an order.
SQL Queries:

with product_by_rank as 
	(select country, city, v2productname,count(v2productname) prod_cnt,  dense_rank() over (partition by country,city order by count(v2productname) desc) prod_rank
	from all_sessions
	where totaltransactionrevenue is not null
	group by country, city,v2productname)
select country, city, v2productname,prod_cnt
from product_by_rank
where prod_rank=1


Answer:

"Country"   	"City"      					"Product"                   								"Count"
"Australia"		"Sydney"						"Nest® Cam Indoor Security Camera - USA"					1
"Canada"		"New York"						"Google Men's  Zip Hoodie"									1
"Canada"		"Toronto"						"Google Men's 3/4 Sleeve Raglan Henley Grey"				1
"Israel"		"Tel Aviv-Yafo"					"Nest® Protect Smoke + CO Black Wired Alarm-USA"			1
"Switzerland"	"Zurich"						"YouTube Men's 3/4 Sleeve Henley"							1
"United States"	"Atlanta"						"Google Men's Short Sleeve Hero Tee Heather"				1
"United States"	"Atlanta"						"Reusable Shopping Bag"										1
"United States"	"Austin"						"Google Men's 100% Cotton Short Sleeve Hero Tee Black"		1
"United States"	"Austin"						"Google Men's 100% Cotton Short Sleeve Hero Tee Navy"		1
"United States"	"Chicago"						"Google Sunglasses"											1
"United States"	"Chicago"						"Nest® Learning Thermostat 3rd Gen-USA - Stainless Steel"	1
"United States"	"Chicago"						"Rubber Grip Ballpoint Pen 4 Pack"							1
"United States"	"Columbus"						"Google Men's Short Sleeve Badge Tee Charcoal"				1
"United States"	"Houston"						"26 oz Double Wall Insulated Bottle"						1
"United States"	"Los Angeles"					"Google Women's Short Sleeve Hero Tee White"				1
"United States"	"Los Angeles"					"Nest® Cam Outdoor Security Camera - USA"					1
"United States"	"Mountain View"					"Android Infant Short Sleeve Tee Pewter"					1
"United States"	"Mountain View"					"Android Women's Fleece Hoodie"								1
"United States"	"Mountain View"					"Google Men's Bike Short Sleeve Tee Charcoal"				1
"United States"	"Mountain View"					"Google Men's Vintage Badge Tee Sage"						1
"United States"	"Mountain View"					"Grip Kit Cable Organizer"									1
"United States"	"Mountain View"					"Nest® Learning Thermostat 3rd Gen-USA"						1
"United States"	"Mountain View"					"Nest® Learning Thermostat 3rd Gen-USA - Stainless Steel"	1
"United States"	"Mountain View"					"Waze Mobile Phone Vent Mount"								1
"United States"	"Nashville"						"Nest® Learning Thermostat 3rd Gen-USA - Stainless Steel"	1
"United States"	"New York"						"Google Laptop and Cell Phone Stickers"						1
"United States"	"New York"						"Google Men's 100% Cotton Short Sleeve Hero Tee White"		1
"United States"	"New York"						"Google Men's Short Sleeve Performance Badge Tee Pewter"	1
"United States"	"New York"						"Google Men's Vintage Tank"									1
"United States"	"New York"						"Google Onesie Red/Graphite"								1
"United States"	"New York"						"Nest® Cam Outdoor Security Camera - USA"					1
"United States"	"New York"						"Nest® Learning Thermostat 3rd Gen-USA - Stainless Steel"	1
"United States"	"New York"						"YouTube Luggage Tag"										1
"United States"	"not available in demo dataset"	"Nest® Learning Thermostat 3rd Gen-USA - Stainless Steel"	2
"United States"	"not available in demo dataset"	"Nest® Protect Smoke + CO White Wired Alarm-USA"			2
"United States"	"Palo Alto"						"Nest® Cam Outdoor Security Camera - USA"					1
"United States"	"Palo Alto"						"Nest® Learning Thermostat 3rd Gen-USA - Stainless Steel"	1
"United States"	"Palo Alto"						"Nest® Learning Thermostat 3rd Gen-USA - White"				1
"United States"	"San Bruno"						"Google Men's Vintage Badge Tee White"						1
"United States"	"San Francisco"					"20 oz Stainless Steel Insulated Tumbler"					1
"United States"	"San Francisco"					"Android 17oz Stainless Steel Sport Bottle"					1
"United States"	"San Francisco"					"Android Rise 14 oz Mug"									1
"United States"	"San Francisco"					"Google Tri-blend Hoodie Grey"								1
"United States"	"San Francisco"					"Google Women's 3/4 Sleeve Baseball Raglan Heather/Black"	1
"United States"	"San Francisco"					"Google Women's Scoop Neck Tee White"						1
"United States"	"San Francisco"					"Nest® Cam Outdoor Security Camera - USA"					1
"United States"	"San Francisco"					"Nest® Learning Thermostat 3rd Gen-USA"						1
"United States"	"San Francisco"					"Nest® Protect Smoke + CO Black Battery Alarm-USA"			1
"United States"	"San Francisco"					"Nest® Protect Smoke + CO White Battery Alarm-USA"			1
"United States"	"San Francisco"					"Waterproof Backpack"										1
"United States"	"San Francisco"					"Windup Android"											1
"United States"	"San Jose"						"Google Men's  Zip Hoodie"									1
"United States"	"San Jose"						"Nest® Cam Outdoor Security Camera - USA"					1
"United States"	"Seattle"						"Nest® Cam Indoor Security Camera - USA"					1
"United States"	"Sunnyvale"						"Android Men's Vintage Henley"								1
"United States"	"Sunnyvale"						"Nest® Cam Indoor Security Camera - USA"					1
"United States"	"Sunnyvale"						"Nest® Protect Smoke + CO Black Wired Alarm-USA"			1
"United States"	"Sunnyvale"						"SPF-15 Slim & Slender Lip Balm"							1



**Question 5: Can we summarize the impact of revenue generated from each city/country?**

SQL Queries:

select country, city, sum(totaltransactionrevenue::numeric) tot_revenue
from all_sessions
group by country, city
having sum(totaltransactionrevenue::numeric)>0
order by 3 desc;


Answer:

"Country"       "City"       "Revenue"
"United States"	"not available in demo dataset"	6092.56
"United States"	"San Francisco"	1564.32
"United States"	"Sunnyvale"	992.23
"United States"	"Atlanta"	854.44
"United States"	"Palo Alto"	608.00
"Israel"	"Tel Aviv-Yafo"	602.00
"United States"	"New York"	530.36
"United States"	"Mountain View"	483.36
"United States"	"Los Angeles"	479.48
"United States"	"Chicago"	449.52
"United States"	"Seattle"	358.00
"Australia"	"Sydney"	358.00
"United States"	"San Jose"	262.38
"United States"	"Austin"	157.78
"United States"	"Nashville"	157.00
"United States"	"San Bruno"	103.77
"Canada"	"Toronto"	82.16
"Canada"	"New York"	67.99
"United States"	"Houston"	38.98
"United States"	"Columbus"	21.99
"Switzerland"	"Zurich"	16.99





