# Customer Churn Analysis

## Project Overview
Customer churn is one of the most costly challenges facing subscription 
businesses. This project builds a complete end-to-end churn analysis 
solution using real IBM Telco customer data to answer three core 
business questions:

- **Who is churning?** — SQL analysis identifying high risk segments
- **When do they churn?** — Cohort analysis tracking retention over time
- **Who will churn next?** — Machine learning model predicting at-risk customers

## Tools & Technologies
- **Databricks** — Cloud platform for ETL, SQL analysis, and ML model
- **Python & Pandas** — Data cleaning, transformation, and cohort analysis
- **SQL** — Business question analysis on Delta tables
- **Scikit-learn** — Random Forest Classifier for churn prediction
- **Matplotlib & Seaborn** — Exploratory data visualizations
- **Tableau Public** — Interactive business dashboard

## Project Structure
- `01_ETL_Pipeline.ipynb` — Data ingestion, cleaning, and transformation
- `02_SQL_Analysis.sql` — Business questions answered with SQL queries
- `03_Churn_Model.ipynb` — Cohort analysis, ML model, and risk segmentation

## Dataset
IBM Telco Customer Churn dataset — 7,043 customers with 21 features 
including demographics, services subscribed, contract type, payment 
method, and churn status.

Source: [Kaggle — Telco Customer Churn](https://www.kaggle.com/datasets/blastchar/telco-customer-churn)

## ETL Pipeline
Raw data required significant cleaning before analysis:

- Converted TotalCharges from string to numeric — 11 null values 
  identified and filled with 0 (customers with tenure = 0 who had 
  not yet been billed)
- Fixed SeniorCitizen column from 0/1 integer to Yes/No for 
  consistency with other binary columns
- Dropped customerID — not needed for analysis or modeling
- Removed 26 duplicate rows
- Standardized text columns by stripping whitespace
- Final clean dataset: 7,017 rows x 20 columns
- Saved as Delta table in Databricks Unity Catalog

## SQL Analysis — Key Findings

| Metric | Finding |
|--------|---------|
| Overall churn rate | 26.42% |
| Month-to-month contracts | 42.61% churn — highest risk |
| Two year contracts | 2.83% churn — most loyal |
| Electronic check payment | 45.10% churn — riskiest payment method |
| Auto payment methods | ~15-16% churn — most stable |
| Churned avg tenure | 18 months |
| Retained avg tenure | 38 months |
| Fiber optic churn rate | 41.74% |
| Senior citizen churn rate | 41.62% |

## Cohort Analysis
Customers grouped into tenure cohorts to track churn over time:

| Cohort | Customers | Churn Rate |
|--------|-----------|------------|
| 0-12 months | 2,175 | 47.68% |
| 13-24 months | 1,024 | 28.71% |
| 25-48 months | 1,594 | 20.39% |
| 49-72 months | 2,239 | 9.51% |

New customers churn at nearly 5x the rate of long term customers, 
confirming tenure as a critical retention factor.

## Machine Learning Model
Built a Random Forest Classifier to predict which customers will churn:

- 100 decision trees, 80/20 train/test split
- Overall accuracy: 77.42%
- Recall for churned customers: 50% (class imbalance challenge)
- 187 false negatives — customers predicted safe who actually churned

**Top predictive features:**
1. TotalCharges — lifetime revenue most predictive of churn risk
2. Tenure — how long a customer has been with the company
3. MonthlyCharges — higher bills correlate with higher churn
4. PaymentMethod_Electronic check — confirms SQL finding
5. InternetService_Fiber optic — confirms SQL finding

**Customer Risk Segmentation:**
- High Risk (70%+ churn probability) — 1,406 customers
- Medium Risk (40-70%) — 529 customers
- Low Risk (under 40%) — 5,082 customers

## Key Business Insights
The highest risk customer profile is:
**New customer + Fiber optic internet + Month-to-month contract + 
Electronic check payment**

**Business recommendations:**
- Incentivize new customers to sign longer contracts immediately
- Offer automatic payment discounts to reduce electronic check usage
- Investigate fiber optic service quality — 42% churn suggests 
  price or quality issues
- Focus retention campaigns on the 1,406 high risk customers 
  rather than the full customer base

## Dashboard
Interactive Tableau dashboard visualizing churn rates by contract 
type, payment method, internet service, and tenure cohort.

**Tableau Dashboard:** https://public.tableau.com/app/profile/nathan.tefera/viz/CustomerChurnAnalysisDashboard_17780901561540/Dashboard1
**PowerBI Dashboard:** Customer Churn Analysis Dashboard.pbix

## Model Limitations & Future Improvements
- Class imbalance caused low recall for churned customers — 
  future improvement would apply SMOTE oversampling or adjust 
  class weights
- Dataset does not include signup dates — true time-based cohort 
  analysis would require this data
- Model could be improved with XGBoost and hyperparameter tuning
