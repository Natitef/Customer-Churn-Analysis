-- Checking if our clean table loaded correctly

SELECT COUNT(*) as total_customers,
       SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) as churned,
       SUM(CASE WHEN Churn = 'No' THEN 1 ELSE 0 END) as retained,
       ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) as churn_rate_pct
FROM workspace.default.telco_churn_clean;

-- Query 1: Churn rate by Contract Type
SELECT Contract,
       COUNT(*) as total_customers,
       SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) as churned,
       ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) as churn_rate_pct
FROM workspace.default.telco_churn_clean
GROUP BY Contract
ORDER BY churn_rate_pct DESC;

-- Query 2: Churn Rate by Contract Type (Highest to Lowest)
SELECT Contract,
       ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) as churn_rate_pct
FROM workspace.default.telco_churn_clean
GROUP BY Contract
ORDER BY churn_rate_pct DESC;
-- Query 3: Churn Rate by Payment Method (Highest to Lowest)
SELECT PaymentMethod, 
       ROUND(sum(CASE WHEN Churn = 'Yes' then 1 else 0 end)*100.0/count(*),2) AS churn_rate_pct
FROM workspace.default.telco_churn_clean
GROUP BY PaymentMethod
ORDER BY churn_rate_pct DESC;

-- Query 4 What is the average tenure and monthly charges for churned vs non-churned customers?

SELECT Churn,
       ROUND(AVG(Tenure),2) as AVG_Tenure,
       ROUND(AVG(MonthlyCharges),2) as AVG_MonthlyCharges
FROM workspace.default.telco_churn_clean
GROUP BY Churn;

-- Query 5 What is the churn rate by Internate Service type
SELECT InternetService, 
       ROUND(SUM(CASE WHEN Churn = 'Yes' then 1 else 0 end)*100/count(*),2) as churn_rate_pct
FROM workspace.default.telco_churn_clean
GROUP BY InternetService;

-- QUERY 6 What is the churn rate by Senior Citizen status?

SELECT SeniorCitizen,
       ROUND(SUM(CASE WHEN Churn = 'Yes' then 1 else 0 end)*100/count(*),2) as churn_rate_pct
FROM workspace.default.telco_churn_clean
GROUP BY SeniorCitizen;

Select Contract from workspace.default.telco_churn_clean;

