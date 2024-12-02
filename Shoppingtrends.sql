

-- INFORMATION ABOUT SUBJECTS

-- Total number of people represented in the data set.
SELECT COUNT(*) from shopping_trends;

-- Min and Max age in data set
SELECT MIN("Age"), MAX("Age") FROM shopping_trends;

-- Male and Female shopper amount.
SELECT "Gender", COUNT("Gender") AS Total from shopping_trends GROUP BY "Gender";

-- Average age of Male and Female shopper.
SELECT AVG("Age") FROM shopping_trends WHERE "Gender" = 'Male';
SELECT AVG("Age") FROM shopping_trends WHERE "Gender" = 'Female';

-- Amount of subjects that are teenagers
SELECT SUM("Age") FROM shopping_trends WHERE "Age" < 20;

-- Percentage of people who are over 45.
SELECT COUNT(CASE WHEN "Age" > 45 THEN 1 END) * 1.0/ COUNT(*) AS middle_age_ratio from shopping_trends;

-- 



-- PRODUCT INFORMATION ANALYSIS

-- Categories and their revenue.
SELECT "Category", SUM("Purchase Amount (USD)") AS Revenue FROM shopping_trends GROUP BY "Category"
ORDER BY Revenue;

-- Top 5 products that brought in the most revenue
SELECT "Item Purchased", SUM("Purchase Amount (USD)") AS Total FROM shopping_trends GROUP BY "Item Purchased"
ORDER BY Total DESC LIMIT 5;

-- What is the least and most popular sizes for clothing 
SELECT "Size", COUNT("Size") AS Total FROM shopping_trends WHERE "Category" = 'Clothing' 
GROUP BY "Size" ORDER BY Total ASC LIMIT 1;
SELECT "Size", COUNT("Size") AS Total FROM shopping_trends WHERE "Category" = 'Clothing' 
GROUP BY "Size" ORDER BY Total DESC LIMIT 1;


-- Most popular color among female and male shoppers
SELECT "Color", COUNT("Color") AS most_popular FROM shopping_trends WHERE "Gender" = 'Male'
GROUP BY "Color" ORDER BY most_popular DESC LIMIT 1;
SELECT "Color", COUNT("Color") AS most_popular FROM shopping_trends WHERE "Gender" = 'Male'
GROUP BY "Color" ORDER BY most_popular DESC LIMIT 1;

-- What percentage of products being sold are not clothes
SELECT COUNT(CASE WHEN "Category" != 'Clothing' THEN 1 END) * 1.0/COUNT("Customer ID") AS cat_ratio FROM
shopping_trends;

-- Least likely color/category combination
SELECT "Category", "Color", COUNT(*) AS Total FROM shopping_trends WHERE "Category" = 'Clothing'
GROUP BY "Category", "Color" ORDER BY Total LIMIT 5;
SELECT "Category", "Color", COUNT(*) AS Total FROM shopping_trends WHERE "Category" = 'Accessories'
GROUP BY "Category", "Color" ORDER BY Total LIMIT 5;
SELECT "Category", "Color", COUNT(*) AS Total FROM shopping_trends WHERE "Category" = 'Footwear'
GROUP BY "Category", "Color" ORDER BY Total LIMIT 5;
SELECT "Category", "Color", COUNT(*) AS Total FROM shopping_trends WHERE "Category" = 'Outerwear'
GROUP BY "Category", "Color" ORDER BY Total LIMIT 5;

-- Top 3 categories for men.
SELECT "Category", COUNT("Category") AS Total_category_num from shopping_trends WHERE "Gender" = 'Male' 
GROUP BY "Category" ORDER BY Total_category_num DESC LIMIT 3;

-- Top 3 categories for women.
SELECT "Category", COUNT("Category") AS Total_category_num from shopping_trends WHERE "Gender" = 'Female' 
GROUP BY "Category" ORDER BY Total_category_num DESC LIMIT 3;

-- Accessories purchased over 80 dollars
SELECT "Item Purchased", "Purchase Amount (USD)" FROM shopping_trends WHERE "Category" = 'Accessories'
AND "Purchase Amount (USD)" > 80;




-- LOCATION/SEASONAL AND SALES INFORMATION

-- Top 10 states where shopping is highest in the summer
SELECT "Location", SUM("Purchase Amount (USD)") AS Total_revenue from shopping_trends WHERE "Season" = 'Summer'
GROUP BY "Location" ORDER BY Total_revenue DESC LIMIT 10;

-- Categories and their revenue according to season.
SELECT "Category", "Season", SUM("Purchase Amount (USD)") AS Revenue FROM shopping_trends 
GROUP BY "Category", "Season" ORDER BY "Category";

-- Which season do shoppers shop the most in
SELECT "Season", COUNT("Season") AS Total from shopping_trends GROUP BY "Season" ORDER BY Total DESC;

-- Each of the 50 States and their total revenue
SELECT "Location", SUM("Purchase Amount (USD)") AS total_revenue FROM shopping_trends GROUP BY "Location"
ORDER BY total_revenue;

-- Percent of clothing sold in each state
SELECT "Location", COUNT(CASE WHEN "Category" = 'Clothing' THEN 1 END) * 100.0/COUNT(*) AS percent_of_clothing
FROM shopping_trends GROUP BY "Location" ORDER BY "Location";

-- Which states sell the most gloves in the winter season
SELECT "Location", SUM("Purchase Amount (USD)") AS total FROM shopping_trends WHERE "Item Purchased"
= 'Gloves' AND "Season" = 'Winter' GROUP BY "Location" ORDER BY total DESC LIMIT 10;

-- States and their revenue each season
SELECT DISTINCT "Location", "Season", SUM("Purchase Amount (USD)") AS total FROM shopping_trends
GROUP BY "Location", "Season" ORDER BY "Location";






-- Shopping Experience/Customer Decision

-- Average rating given by men purchasing clothing 
SELECT AVG("Review Rating") AS avg_clothing_rating_men from shopping_trends WHERE "Gender" = 'Male'
AND "Category" = 'Clothing';

-- Average age where frequency of purchases is weekly
SELECT AVG("Age") AS avg_age_weekly from shopping_trends WHERE "Frequency of Purchases" = 'Weekly';

-- Ratio of people using cash vs other methods
SELECT COUNT(CASE WHEN "Payment Method" = 'Cash' THEN 1 END) * 1.0/COUNT(CASE WHEN "Payment Method" != 'Cash' THEN 1 END)
AS cash_to_alt_ratio FROM shopping_trends; 

-- What is the maximum age that a shopper uses vemmo for payment.
SELECT MAX("Age") FROM shopping_trends WHERE "Payment Method" = 'Venmo';

-- Purchases where express shipping was included for an item under 30 dollars
SELECT "Customer ID", "Item Purchased" FROM shopping_trends WHERE "Purchase Amount (USD)" < 30
AND "Shipping Type" = 'Express';

-- Standard shipping vs Other methods of shipping
SELECT COUNT(CASE WHEN "Shipping Type" = 'Standard' THEN 1 END) AS standard,
COUNT (CASE WHEN "Shipping Type" != 'Standard' THEN 1 END) AS other FROM shopping_trends;

-- States with the lowest average shopping ratings
SELECT "Location", AVG("Review Rating") AS avg_rating FROM shopping_trends GROUP BY "Location"
ORDER BY avg_rating LIMIT 10;

-- Amount of regular shoppers per state (Over 40 previous purchases and weekly purchases)
SELECT "Location", SUM(CASE WHEN "Frequency of Purchases" = 'Weekly' AND "Previous Purchases " > 40 THEN 1 END)
AS Regular_shoppers FROM shopping_trends GROUP BY "Location" ORDER BY "Location";

-- Shoppers that have subscriptions versus those who don't
SELECT COUNT(CASE WHEN "Subscription Status" = 'Yes' THEN 1 END) AS Sub, 
COUNT(CASE WHEN "Subscription Status" = 'No' THEN 1 END) AS No_sub FROM shopping_trends;

--How many purchases got a discount by applying promo code
SELECT COUNT(CASE WHEN "Discount Applied " = 'Yes' AND "Promo Code Used " = 'Yes' THEN 1 END) AS discount,
COUNT(*) AS total FROM shopping_trends;

-- Percentage of people using discounts under the age of 50 vs percentage 50 and over
SELECT COUNT(CASE WHEN "Discount Applied " = 'Yes' AND "Age" < 50 THEN 1 END)*100.0/COUNT(CASE WHEN "Age"<50 THEN 1 END) AS Young,
COUNT(CASE WHEN "Discount Applied " = 'Yes' AND "Age" >= 50 THEN 1 END)*100.0/COUNT(CASE WHEN "Age" >= 50 THEN 1 END) AS Not_young 
FROM shopping_trends;
