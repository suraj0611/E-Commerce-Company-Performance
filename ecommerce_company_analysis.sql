

create database company_performance

use company_performance

select * from [dbo].[ecommerce_company_dataset]


-- 1 : Total Revenue & Profit

select sum(profit) as total_profit , sum(revenue) as total_revenue,
(sum(profit)*100 / sum(revenue)) as profit_margin_percent
from ecommerce_company_dataset

-- 2 :	Return Rate

select count(*) as total_return,
sum(case when returned = 1 then 1 else 0 end) as Returned_Orders,
(sum(case when returned = 1 then 1 else 0 end)*100/count(*)) as Return_Rate_Percent
from ecommerce_company_dataset

--3 : Revenue & Profit by Category

select category,sum(profit) as total_profit,sum(revenue) as total_revenue,
(sum(profit)*100/sum(revenue)) as total_profit_margin_percent
from ecommerce_company_dataset
group by Category

-- 4 : Revenue & Profit by Category

select category , count(*) as total_order,
sum(case when returned = 1 then 1 else 0 end) as returned_order,
(sum(case when returned = 1 then 1 else 0 end)*100/count(*)) as return_rate_percant
from ecommerce_company_dataset
group by Category

-- 5 : Repeat Customers

select customerID, count(orderID) as total_orders,
sum(revenue) as total_revenue
from ecommerce_company_dataset
group by CustomerID
having count(orderID) > 1

-- 6 : One-Time vs Repeat Revenue

with cte as (
select customerID , 
count(orderID) as order_count,
sum(revenue) as total_revenue
from ecommerce_company_dataset
group by CustomerID
)
select 
	case
		when order_count = 1 then 'One-Time'
		else 'Repeat'
	end as Customer_Type,
	count(*) as customers,
	sum(total_revenue) as revenue
	from cte
group by 
	case 
		WHEN Order_Count = 1 THEN 'One-Time'
        ELSE 'Repeat'
	end


-- 7 : Monthly Revenue 

ALTER TABLE ecommerce_company_dataset
ALTER COLUMN OrderDate datetime2;

select * from ecommerce_company_dataset

select format(OrderDate,'yyyy-MM') as YearMonth,
sum(profit) as total_profit,
sum(revenue) as total_revenue
from ecommerce_company_dataset
group by format(OrderDate,'yyyy-MM')
order by YearMonth

