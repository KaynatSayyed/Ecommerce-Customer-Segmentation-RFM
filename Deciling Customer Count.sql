With Sales_total as
(select CustomerID, sum(TotalSales) as TotalSales
from ecom_temp1
group by CustomerID),

Ranking as
(select CustomerID, TotalSales,
ntile(10) over(order by TotalSales Desc) as Decile
from Sales_total)

select Decile, 
count(CustomerID) as CustomerCount,
round(avg(TotalSales),2) as avg_sales 
from Ranking
group by Decile
order by Decile