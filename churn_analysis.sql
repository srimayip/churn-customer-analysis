-- =====================================================
-- Customer Churn Analysis SQL Queries
-- Project: Customer Churn Dashboard
-- Tools Used: SQL, Power BI
-- Objective: Identify churn drivers and analyze customer behavior
-- =====================================================

-- 1. Total Customers (KPI)
SELECT COUNT(DISTINCT `Customer ID`) AS total_customers
FROM customer_churn;

-- 2. Total Churned Customers (KPI)
SELECT COUNT(`Customer ID`) AS churned_customers
FROM customer_churn
WHERE TRIM(`Churn Label`) = 'Yes';

-- 3. Churn Rate (KPI)
SELECT 
COUNT(CASE WHEN TRIM(`Churn Label`) = 'Yes' THEN 1 END) * 100.0 /
COUNT(`Customer ID`) AS churn_rate
FROM customer_churn;

-- 4. Average Monthly Charges (KPI)
SELECT AVG(`Monthly Charges`) AS avg_monthly_charges
FROM customer_churn;

-- 5. Churn Distribution (Donut Chart)
SELECT `Churn Label`, COUNT(`Customer ID`) AS customers
FROM customer_churn
GROUP BY `Churn Label`;

-- 6. Churn by Contract (Bar Chart)
SELECT `Contract`,
       COUNT(`Customer ID`) AS total_customers,
       SUM(`Churn Value`) AS churned_customers
FROM customer_churn
GROUP BY `Contract`
ORDER BY churned_customers DESC;

-- 7. Churn by Tenure Group (Tenure Months)
SELECT 
CASE 
    WHEN `Tenure Months` <= 20 THEN '0-20 Months'
    WHEN `Tenure Months` <= 40 THEN '20-40 Months'
    WHEN `Tenure Months` <= 60 THEN '40-60 Months'
    ELSE '60+ Months'
END AS tenure_group,
COUNT(`Customer ID`) AS total_customers,
SUM(`Churn Value`) AS churned_customers
FROM customer_churn
GROUP BY tenure_group
ORDER BY tenure_group;

-- 8. Top Churn Reasons (Excluding non-actionable reasons)
SELECT `Churn Reason`, COUNT(`Customer ID`) AS churn_count
FROM customer_churn
WHERE TRIM(`Churn Label`) = 'Yes'
  AND `Churn Reason` NOT IN ('Dont know','Deceased','Moved')
GROUP BY `Churn Reason`
ORDER BY churn_count DESC;