With Totalsales as
(select CustomerID, sum(TotalSales) as TotalSales from ecom_temp1
group by CustomerID),

DeclineSegment as
(select CustomerID,
case when TotalSales > '2000' then 'High Value'
	 when TotalSales between '800' and '2000' then 'Medium Value'
     when TotalSales between '500' and '799' then 'Low Value'
else 'Dormant' end as sales_segment 
from ecom_temp1)

select sales_segment , Count(CustomerID) as Total_Customers
from DeclineSegment
group by sales_segment
order by field(sales_segment, 'High Value', 'Medium Value', 'Low Value', 'Dormant');
