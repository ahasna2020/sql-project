
--#########################################################################################
--TABLE: products
--#########################################################################################

drop TABLE public.products;

CREATE TABLE public.products
(
    sku varchar(2000) NOT NULL,
    name varchar(30000) NOT NULL,
    orderedquantity varchar(2000),
    stocklevel varchar(2000),
    restockingleadtime varchar(2000),
    sentimentscore varchar(2000),
    sentimentmagnitude varchar(2000),
    CONSTRAINT products_pk PRIMARY KEY (sku)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.products
    OWNER to postgres;

COMMENT ON TABLE public.products
    IS 'Products master table';

COPY public.products FROM 'C:\Hasna\Learning\LHL\sql_project\Data\products.csv' WITH (FORMAT csv)
DELIMITER ','
CSV HEADER;


--#########################################################################################
--TABLE: sales_by_sku
--#########################################################################################

drop TABLE if exists public.sales_by_sku;

CREATE TABLE public.sales_by_sku
(
    productsku varchar(2000) NOT NULL,
    total_ordered varchar(2000),
    CONSTRAINT sales_by_sku_pk PRIMARY KEY (productsku)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.sales_by_sku
    OWNER to postgres;

COMMENT ON TABLE public.sales_by_sku
    IS 'Sales by SKU';

COPY public.sales_by_sku FROM 'C:\Hasna\Learning\LHL\sql_project\Data\sales_by_sku.csv' WITH (FORMAT csv)
DELIMITER ','
CSV HEADER;


select * from sales_by_sku


ALTER TABLE sales_by_sku
    ADD CONSTRAINT fk_salesbysku_product FOREIGN KEY (productsku) REFERENCES products (sku);

--#########################################################################################
--TABLE: sales_report
--#########################################################################################

drop TABLE if exists public.sales_report;

CREATE TABLE public.sales_report
(
    productSKU varchar(2000) NOT NULL,
    total_ordered varchar(2000),
    name varchar(30000) NOT NULL,
    stocklevel varchar(2000),
    restockingleadtime varchar(2000),
    sentimentscore varchar(2000),
    sentimentmagnitude varchar(2000),
    ratio varchar(2000),
    CONSTRAINT sales_report_pk PRIMARY KEY (productsku)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.sales_report
    OWNER to postgres;

COMMENT ON TABLE public.sales_report
    IS 'Products sales report';

COPY public.sales_report
FROM 'C:\Hasna\Learning\LHL\sql_project\Data\sales_report.csv'
DELIMITER ','
CSV HEADER;

select * from sales_report

ALTER TABLE sales_report
    ADD CONSTRAINT fk_salesreport_product FOREIGN KEY (productsku) REFERENCES products (sku);

--#########################################################################################
--TABLE: analytics
--#########################################################################################

drop TABLE if exists public.analytics;

CREATE TABLE public.analytics
(
    visitNumber varchar(2000) NOT NULL,
    visitId varchar(2000) not null,
    visitStartTime varchar(2000) ,
    visitdate varchar(2000),
    fullvisitorId varchar(2000),
    userid varchar(2000),
    channelGrouping varchar(2000),
    socialEngagementType varchar(2000),
    units_sold varchar(2000) ,
    pageviews varchar(2000),
    timeonsite varchar(2000),
    bounces varchar(2000),
    revenue varchar(2000),
    unit_price varchar(2000)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.analytics
    OWNER to postgres;

COMMENT ON TABLE public.analytics
    IS 'Visit analytics report';

COPY public.analytics
FROM 'C:\Hasna\Learning\LHL\sql_project\Data\analytics.csv'
DELIMITER ','
CSV HEADER;

select * from analytics


--#########################################################################################
--TABLE: all_sessions
--#########################################################################################
				
drop TABLE if exists public.all_sessions;

CREATE TABLE public.all_sessions
(
    fullVisitorId varchar(2000) NOT NULL,
    channelGrouping varchar(2000) ,
    time varchar(2000) ,
    country varchar(2000),
    city varchar(2000),
    totalTransactionRevenue varchar(2000),
    transactions varchar(2000),
    timeOnSite varchar(2000),
    pageviews varchar(2000) ,
    sessionQualityDim varchar(2000),
    date varchar(2000),
    visitId varchar(2000),
    type varchar(2000),
    productRefundAmount varchar(2000) ,
    productQuantity varchar(2000) ,
    productPrice varchar(2000) ,
    productRevenue varchar(2000),
    productSKU varchar(2000),
    v2ProductName varchar(32000),
    v2ProductCategory varchar(32000),
    productVariant varchar(2000),
    currencyCode varchar(2000),
    itemQuantity varchar(2000),
    itemRevenue varchar(2000),
    transactionRevenue varchar(2000),
    transactionId varchar(2000) ,
    pageTitle varchar(32000) ,
    searchKeyword varchar(2000) ,
    pagePathLevel1 varchar(2000),
    eCommerceAction_type varchar(2000),
    eCommerceAction_step varchar(2000),
    eCommerceAction_option varchar(2000)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.all_sessions
    OWNER to postgres;

COMMENT ON TABLE public.all_sessions
    IS 'Visitor sessions report';

COPY public.all_sessions
FROM 'C:\Hasna\Learning\LHL\sql_project\Data\all_sessions.csv'
DELIMITER ','
CSV HEADER;

select * from all_sessions





