-- Check top 100 Rows
SELECT TOP(100) *
FROM supermarket_sales


-- Check if there are duplicates (based on invoice ID)
SELECT Invoice_ID, COUNT(*) AS count
FROM supermarket_sales
GROUP BY Invoice_ID
HAVING COUNT(*) > 1;



-- Total Sales
SELECT SUM(Total) as 'Total Sales'
FROM supermarket_sales


-- Top selling product line(category) based on Total Sales
SELECT Product_line as Category, SUM(Total) as Total_Sales
FROM supermarket_sales
GROUP BY Product_line
ORDER BY Total_Sales DESC


-- Top City based on Total Sales
SELECT City, SUM(Total) as Total_Sales
FROM supermarket_sales
GROUP BY City
ORDER BY Total_Sales DESC


-- Top Branch based on Total Sales
SELECT Branch, SUM(Total) as Total_Sales
FROM supermarket_sales
GROUP BY Branch
ORDER BY Total_Sales DESC


--  Compare genders in the dataset
SELECT Gender, COUNT(Gender) as '# of Transactions'
FROM supermarket_sales
GROUP BY Gender


-- Total amount spent based on gender
SELECT Gender, SUM(Total) as 'Total Sales'
FROM supermarket_sales
GROUP BY Gender
ORDER BY SUM(Total)  DESC




-- Categories purchased by memebers the most
SELECT Product_Line as Category, COUNT(Product_line) as '# of Products Purchased by Members'
FROM supermarket_sales
WHERE Customer_type = 'Member'
GROUP BY Product_line
ORDER BY COUNT(Product_line) DESC


-- Category purchased by normal customers the most
SELECT Product_Line as Category, COUNT(Product_line) as '# of Products Purchased by Normal Customers'
FROM supermarket_sales
WHERE Customer_type != 'Member'
GROUP BY Product_line
ORDER BY COUNT(Product_line) DESC


-- Top 10 unit prices based on product line
SELECT TOP(10) Product_line as Category,Unit_price
FROM supermarket_sales
ORDER BY Unit_price DESC 


-- Average Total price and Average unit price in general
SELECT AVG(Unit_price) as 'Average Unit Price', AVG(Total)  as 'Average Total Price'
FROM supermarket_sales


-- Average Total price and Average unit price based on product category
SELECT Product_line as Category,AVG(Unit_price) as 'Average Unit Price', AVG(Total)  as 'Average Total Price'
FROM supermarket_sales
GROUP BY Product_line
ORDER BY AVG(Unit_price) DESC


-- Average Total price and Average unit price based on City
SELECT City,AVG(Unit_price) as 'Average Unit Price', AVG(Total)  as 'Average Total Price'
FROM supermarket_sales
GROUP BY City
ORDER BY AVG(Unit_price) DESC


-- Average Rating in general
SELECT AVG(Rating) as 'Average Customer Rating'
FROM supermarket_sales


-- Count of different payment methods
SELECT payment,COUNT(Payment) as '# of transactions'
FROM supermarket_sales
GROUP BY Payment
ORDER BY COUNT(Payment) DESC


-- Top dates with the most transactions
SELECT Date, count(Date) as '# of transactions'
FROM supermarket_sales
GROUP BY Date
ORDER BY count(Date) DESC, Date DESC


-- Top dates with the most total sales
SELECT Date, SUM(Total) as 'Total Sales'
FROM supermarket_sales
GROUP BY Date
ORDER BY [Total Sales]  DESC

-- Top MONTHS with the most total transactions
SELECT COUNT(MONTH(Date))  as  '# of transactions', MONTH(date) as 'Month'
FROM supermarket_sales
GROUP BY Month(date)
ORDER BY COUNT(MONTH(Date)) 


-------------------------------- rounding the time to the nearest hour for simplicity
--ALTER TABLE supermarket_sales
--ADD RoundedTime TIME;

---- Update the 'RoundedTime' column with the rounded values
--UPDATE supermarket_sales
--SET RoundedTime = TIMEFROMPARTS(DATEPART(HOUR, Time) + 
--                                CASE WHEN DATEPART(MINUTE, Time) >= 30 THEN 1 ELSE 0 END, 
--                                0, 0, 0, 0);
---- Verify the result
--SELECT Time, RoundedTime
--FROM supermarket_sales;

-----------------------------------------------------------------------------------------------

-- Hours that had the most sales
SELECT RoundedTime, SUM(Total) as 'Total Sales'
FROM supermarket_sales
GROUP BY RoundedTime
ORDER BY [Total Sales] DESC

------------------------------------------ Here we want to analyze the date based on the day of the week
-- add the column weekday_name
--ALTER TABLE supermarket_sales
--ADD Weekday_Name varchar(25);

--UPDATE supermarket_sales
--SET Weekday_Name = DATENAME(dw, Date);

---- Verify the result
--SELECT Date, Weekday_Name
--FROM supermarket_sales;

-----------------------------------------------------------------------

--  total sales based on weekday
SELECT Weekday_Name, SUM(Total) as 'Total Sales'
FROM supermarket_sales
GROUP BY Weekday_Name
ORDER BY [Total Sales] DESC



-- Cumulative Total Sales vs. Date & Branch

SELECT
	DISTINCT
    Date,
    Branch,
    SUM(Total) OVER (ORDER BY Date) AS Total_Cumulative_Sales,
    SUM(CASE WHEN Branch = 'A' THEN Total ELSE 0 END) OVER (ORDER BY Date) AS Cumulative_Sales_Branch_A,
    SUM(CASE WHEN Branch = 'B' THEN Total ELSE 0 END) OVER (ORDER BY Date) AS Cumulative_Sales_Branch_B,
    SUM(CASE WHEN Branch = 'C' THEN Total ELSE 0 END) OVER (ORDER BY Date) AS Cumulative_Sales_Branch_C
FROM
    supermarket_sales
ORDER BY
    Date;


