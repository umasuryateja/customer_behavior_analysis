select * from customer limit 20

--- total revenue by gender
select gender, SUM(purchase_amount) as revenue
from customer
group by gender

--- customers used a discount but still spent more than the average purchase amount
SELECT customer_id,purchase_amount from customer
where discount_applied ='Yes' and purchase_amount >= (SELECT AVG(purchase_amount) from customer)


--- top 5 products with the highest average review rating
SELECT item_purchased ,ROUND(AVG(review_rating:: NUMERIC),2) as "Average Product_rating" from customer
group by item_purchased
order by avg(review_rating) desc
limit 5;


--- Comapare the avearge purchase amounts btw standarad and express shipping
select shipping_type,
round(AVG(purchase_amount),2)
from customer
where shipping_type in ('Standard','Express')
group by shipping_type


---do subscribed customers spend more? comapre avg spend and total revenue btw subscriber and non subscriber
select subscription_status,
count (customer_id) as total_customers,
Round(avg(purchase_amount),2) as avg_spend,
round(sum(purchase_amount),2) as total_revenue
from customer
group by subscription_status
order by total_revenue, avg_spend desc;

---which 5 products have highest % of purchase with discounts applied
select item_purchased,
round(100 * sum(case when discount_applied = 'Yes' then 1 else 0 end)/count(*),2) as discount_rate
from customer
group by item_purchased
order by discount_rate desc
limit 5;


---what is the revenue contributed of each age group
select age_group,
sum(purchase_amount) as total_revenue
from customer
group by age_group
order by total_revenue desc; 