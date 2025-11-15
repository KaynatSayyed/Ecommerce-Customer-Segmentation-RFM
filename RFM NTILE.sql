With RecencyCTE as
(select CustomerID,
datediff(current_date(), max(str_to_date(invoicedate, '%m/%d/%Y'))) as Recency
from ecom_temp1
group by CustomerID),

FrequencyCTE as
(select CustomerID, count(*) as Frequency
from ecom_temp1
group by CustomerID),

MonetaryCTE as
(select CustomerID, sum(TotalSales) as Monetary from ecom_temp1
group by CustomerID),

RFMscoreCTE as
(select R.CustomerID,
ntile(5) over(order by R.Recency asc) as Recency_score,
ntile(5) over(order by F.Frequency desc) as Frequency_score,
ntile(5) over(order by M.Monetary desc) as Monetary_score
from RecencyCTE R join FrequencyCTE F on R.CustomerID = F.CustomerID
join MonetaryCTE M on R.CustomerID = M.CustomerID)

select CustomerID, Recency_score, Frequency_score, Monetary_score,
(Recency_score + Frequency_score + Monetary_score) as RFM_score
from RFMscoreCTE
order by RFM_score desc