create database Northwind_traders;
use Northwind_traders
select * from [dbo].[categories];
select * from [dbo].[customers]
select * from orders
select * from [dbo].[order_details]
select * from products
select * from employees
select * from shippers

use Northwind_traders;

-- customers_analysis
update customers 
set customerID = replace(customerID, substring(customerID, Patindex('%[^a-zA-zo-9 ]%', customerID), 1),'')
where Patindex('%[^a-zA-zo-9 ]%', customerID) > 0;

--number of customer 

select Count(distinct companyName) as Total_customers from customers

-- Identifying countries with the highest number of companies
select country,count(distinct companyName) no_company 
from customers
group by country
order by no_company desc 

-- Identify the role of the people North-wind communication with for business

select contactTitle, count(distinct companyName) no_contactTitle
from customers
group by contactTitle
order by no_contactTitle desc; 

-- creating a new column for the revenue 
alter table order_details add Revenue float;
update order_details set Revenue = (unitPrice * quantity)- discount

-- Revenue by company
select distinct C.companyName, round(sum(D.Revenue),0) as Revenue
from customers C
join orders O on O.customerID = C.customerID
join order_details D on D.orderID = O.orderID
group by C.companyName
order by Revenue desc

--Order Analysis 

select round(sum(Revenue),0) as revenue
from order_details

select count(orderID) from orders

select YEAR(O.orderDate) as year, round(sum(OD.Revenue),0) as revenue
from orders O
join order_details OD on OD.orderID = O.orderID
group by YEAR (O.orderDate)
order by Revenue desc


-- Number of days products are shipped

select DATEDIFF(day, orderDate, shippedDate) as date_difference 
from orders
order by date_difference  desc;

select C.companyName, DATEDIFF(day, O.orderDate, O.shippedDate) as date_difference 
from orders O
join customers C on C.customerID = O.customerID
order by date_difference  desc

--Avgerage delivery days 

select AVG(DATEDIFF(day, orderDate, shippedDate)) as date_difference 
from orders;

select country,DATEDIFF(day, O.orderDate, O.shippedDate) as date_difference 
from orders O
join customers C on C.customerID = O.customerID
order by date_difference  desc

select P.productName,country,DATEDIFF(day, O.orderDate, O.shippedDate) as date_difference 
from products P
join order_details R on R.productID = P.productID
join orders O on O.orderID = R.orderID
join customers C on C.customerID = O.customerID
order by date_difference desc

select P.productName, round(sum(O.Revenue),0) as revenue
from Products P
join order_details O on O.productID = P.productID
where P.productName like 'Sir%'
group by P.productName

select C.country,p.productName, sum(D.quantity) as quantity
from customers C
join orders O on O.customerID = C.customerID
join order_details D on D.orderID = O.orderID
join products p on p.productID = D.productID
group by C.country,p.productName
order by quantity desc

select C.country, sum(D.quantity) as quantity
from customers C
join orders O on O.customerID = C.customerID
join order_details D on D.orderID = O.orderID
group by C.country
order by quantity desc

select C.country, year(O.orderDate)as Year, round(sum(D.Revenue),0) as revenue
from customers C
join orders O on O.customerID = C.customerID
join order_details D on D.orderID = O.orderID
where C.country like 'USA'
group by C.country,year(O.orderDate)


select round(SUM(freight),0) as freight_cost 
from orders 


select C.companyName, ROUND(sum(O.freight),0) as freight_no
from orders O
join customers C on C.customerID = O.customerID
group by C.companyName
order by freight_no desc;

-- product_analysis 
select P.productName, round(sum(O.Revenue),0) as Revenue
from products P
join order_details O on O.productID = P.productID
group by P.productName
order by Revenue desc

-- calculating the freight_cost and quantity per products 

select P.productName,sum(O.quantity) as Total_quantity ,round(sum(R.freight),0) as freight_amount
from products P
join order_details O on O.productID = P.productID
join orders R on R.orderID = O.orderID
group by P.productName
order by freight_amount desc

-- category Analysis 
select C.categoryName, round(sum(O.Revenue),0) as Revenue
from categories C
join products P on P.categoryID = C.categoryID
join order_details O on O.productID = P.productID
group by categoryName

select YEAR(R.orderDate) as year, round(sum(O.Revenue),0) as Revenue, C.categoryName
from categories C
join products P on P.categoryID = C.categoryID
join order_details O on O.productID = P.productID
join orders R on R.orderID = O.orderID
where YEAR(R.orderDate) = '2015'
group by C.categoryName, YEAR(R.orderDate)

-- shippers Analysis
select companyName, round(sum(O.freight),0) as freight_cost
from shippers S
join orders O on O.shipperID = S.shipperID
group by S.companyName
order by freight_cost desc

-- Employees Analysis

select E.employeeName, round(sum(D.Revenue),0) as revenue 
from employees E
join orders O on O.employeeID = E.employeeID
join order_details D on D.orderID = O.orderID
group by E.employeeName
order by revenue desc













