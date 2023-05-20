# Northwind-Business-Analysis-

## Introduction
This is my Maven Analytics Project submission. The task was to conduct a  vigorous analysis on the Sales & order data for Northwind Traders, a fictitious gourmet food supplier, including information on customers, products, orders, shippers, and employees and  build a top-level KPI dashboard to help Northwind Traders' executives quickly understand the company's performance in key areas.

The data contain sales activites from  July 2013 to May 2015, consist of seven tables.

## Business Question
The task an informative dashboard to help executives quaickly undersatnd the company's perfoemance. These are the most metrics to analyse to sucessfully achieve the task. The business questions are :
* What is the Month over Month of sales ?
* What are the best perfoeming produts?
* Which countries do we genearate the highest revenue?
* Who are the companys's Top customers ?
* Identify the average shipping days?

## Skills Demonstrated:
Data Cleansing and Transformation In SQL Server and Excel
Data Modelling in PowerBi 
Dax For My analysis in PowerBi

## Data Analysis
I Created a new column to get the company revenue
``` SQL
alter table order_details add Revenue float;
update order_details set Revenue = (unitPrice * quantity)- discount
```
``` SQL
select round(sum(Revenue),0) as revenue
from order_details
```
|  revenue             | 
|------------------------------|
|    1354338                   |
This query calculates the Total revenue generated in three years

2) What are the best perfoeming produts?
``` SQL
select top 5 P.productName, round(sum(O.Revenue),0) as Revenue
from products P
join order_details O on O.productID = P.productID
group by P.productName
order by Revenue desc
```
|  productName              |  Revenue  |
|---------------------------|-----------|
  C�te de Blaye            |     149983
  Th�ringer Rostbratwurst  |     87734
  Raclette Courdavault     |     76293
  Camembert Pierrot        |      50283
Tarte au sucre             |      49825


3) Which countries do we genearate the highest revenue?

``` SQL
select top 5 C.country, round(sum(D.Revenue),0) as revenue
from customers C
join orders O on O.customerID = C.customerID
join order_details D on D.orderID = O.orderID
group by C.country
order by revenue desc
```
| country          |  Revenue  |
|------------------|-----------|
 USA               |  263546
Germany            |  244620
Austria            |  139488
Brazil             | 114955
France             |  85489

 The findings shed light on the spending patterns of the United States and Germany.
 The United States has emerged as the highest paying country, demonstrating a significant commitment to their business operations. Within the United States, several companies have made noteworthy expenditures on specific products, indicating their interest and investment in these items.
Rattlesnake Canyon Grocery, a company operating within the United States, stands out by dedicating a substantial sum of 16,864 to the purchase of Côte de Blaye. This expenditure underscores their strong interest in this particular product and their willingness to make a significant investment in it.
Save-a-lot Markets, another company from the United States, has also made a substantial investment of 14,259 in Thüringer Rostbratwurst. This expenditure highlights their preference for this product and their commitment to acquiring a significant quantity of it.
Great Lakes Food Market, operating within the United States, has spent a notable amount of 11,857 on Côte de Blaye. This expenditure demonstrates their interest in this specific product and their dedication to procuring a substantial quantity of it.
Germany follows the United States in terms of expenditures. Within Germany, QUICK-Stop emerges as a company that has made a significant investment in Côte de Blaye, spending a substantial sum of 23,715. This expenditure reflects their strong interest and commitment to this product.
Additionally, Königlich Essen, also based in Germany, has invested 7,905 in Côte de Blaye. This expenditure indicates their preference for this product and their willingness to make a notable financial commitment to it.
In conclusion, the United States and Germany have emerged as the highest paying countries, with companies such as Rattlesnake Canyon Grocery, Save-a-lot Markets, Great Lakes Food Market, QUICK-Stop, and Königlich Essen making substantial investments in specific products. The United States companies have shown a particular interest in Côte de Blaye and Thüringer Rostbratwurst, while the German companies have focused their expenditures on Côte de Blaye. These findings provide valuable insights into the expenditure patterns and product preferences of these companies within the respective countries.

4) Who are the companys's Top customers ?
``` Sql
select distinct C.companyName, round(sum(D.Revenue),0) as Revenue
from customers C
join orders O on O.customerID = C.customerID
join order_details D on D.orderID = O.orderID
group by C.companyName
order by Revenue desc
```
| Companies                     |  Revenue  |
|-------------------------------|-----------|
  QUICK-Stop                    |  117477
Save-a-lot Markets              |  115664
Ernst Handel                    |  113230
Hungry Owl All-Night Grocers    |  57311
Rattlesnake Canyon Grocery      |  52243

The findings reveal interesting insights into the spending patterns and preferences of these companies.

Quick Stop emerges as the highest paying company, investing a significant amount in their business operations. Notably, they have spent a substantial sum of 23,715 on the Côte de Blaye product. This expenditure indicates their strong interest and commitment towards this particular product.

Regarding the quantity of products purchased, Quick Stop has shown a notable preference for Camembert Pierrot. They have acquired a substantial quantity of 243 units, demonstrating a significant demand for this item. Another product that has garnered their attention is Singaporean Hokkien Fried Mee, with a purchase of 191 units, reflecting their interest in diverse culinary offerings.

Save-a-Lot company follows closely in terms of expenditure. They have dedicated a considerable amount, 14,259, towards the procurement of Thüringer Rostbratwurst, indicating a significant investment in this product. Additionally, Save-a-Lot has acquired an impressive quantity of 220 units of Scottish Longbreads and 204 units of Alice Mutton, highlighting their interest in these specific items.

Lastly, Ernst has made a substantial expenditure of 9,130 on Raclette Courdavault, signifying their inclination towards this product. While their spending may not be as high as Quick Stop or Save-a-Lot, it is still a significant investment.

In conclusion, Quick Stop emerges as the highest paying company, with a substantial investment in the Côte de Blaye product. They have shown a strong preference for Camembert Pierrot and Singaporean Hokkien Fried Mee. Save-a-Lot follows closely, focusing their spending on Thüringer Rostbratwurst, Scottish Longbreads, and Alice Mutton. Lastly, Ernst has made a significant expenditure on Raclette Courdavault. These findings provide valuable insights into the expenditure patterns and product preferences of these companies.


``` DAX
Total_revenue = ROUND(SUM(order_details[Revenue]),0)
pm revenue = CALCULATE([Total_revenue],DATEADD('Calendar'[Date],-1,MONTH))
MOM revenue growth% = 
var PYrevenue =
CALCULATE([Total_revenue],DATEADD('Calendar'[Date],-1,MONTH))
return 
     DIVIDE(([Total_revenue]-[pm revenue]), [pm revenue])
```



|  ContactTitle                |  NoContact_Title  |
|------------------------------|-------------------|
| Owner                        |  17               |
|  Sales Representative        |  17               |
| Marketing Manager            |  12               |
| Sales Manager
 Accounting Manager
 Sales Associate
 Marketing Assistant
 Sales Agent
 Assistant Sales Agent
 Order Administrator
 Assistant Sales Representative
 Owner/Marketing Assistant



