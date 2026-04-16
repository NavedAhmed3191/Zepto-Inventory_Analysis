
select * from zepto

--Data Exploration
select count(*) from zepto

--sample data
select * from zepto
limit 10;

-- check Null Values

Select * from zepto
where category is null
or 
name is null
or 
 mrp is null
or 
 discountpercent is null
or 
 availablequantity is null
or 
 discountedsellingprice is null
or 
 weightingms is null
or 
 outofstock is null
or 
quantity is null;

--product category

select distinct category from zepto
order by category;

--product is instock vs outofstock

select outofstock, count(sku_id)
from zepto
group by outofstock;

--product name present multiple times

select name, count(sku_id)
from zepto
group by name
having count(sku_id) > 1
order by count(sku_id) desc;

--data cleaning
--product with price = 0

select * from zepto
where mrp = 0 or discountedsellingprice = 0;

Delete from zepto
where mrp =0;

--convert price from paise to rupees

update zepto
set mrp = mrp/100,
discountedSellingprice = discountedSellingprice/100;

--1. find the top 10 best value products based on the discount percentage.

select distinct name, mrp, discountPercent from zepto
order by discountPercent desc
limit 10;


--2. What are the Products with high MRP but out of stock.

select distinct name, mrp
from zepto
where outOfstock = TRUE
and mrp > 300
order by mrp desc;

--3. Calculate Estimated Revenue for each category.

select category,
sum(discountedSellingprice * availableQuantity) as Total_Revenue
from zepto 
group by category
order by Total_Revenue desc;


--4. Find all products where MRP is greater than 500.00 and discount is less than 10%.

select distinct name, mrp, discountPercent 
from zepto
where mrp > 500 and discountPercent < 10
order by mrp desc, discountPercent desc;

--5. Identify the top 5 categories offering the highest average discount percentage.

select category,
Round(avg(discountPercent),2) as Average_Percent
from zepto
group by category
order by Average_Percent desc
limit 5;


--6. find the price per gram for products above 100g and sort by best value.

select distinct name, weightInGms, discountedSellingPrice,
ROUND(discountedSellingPrice/weightInGms,2) as price_per_gms
from zepto
where weightInGms >= 100
order by price_per_gms desc;

--7. group the products into categories like low, medium, high based on their weightingms.

select distinct name, weightInGms,
case 
When weightInGms < 1000 Then 'Low'
When weightInGms < 5000 Then 'Medium'
Else 'Bulk'
End as Weight_Category
from zepto;

--8. what is the total inventory weight per category.

select category,
sum(availableQuantity * weightInGms) as Total_Weight
from zepto
group by category
order by Total_Weight Desc;

