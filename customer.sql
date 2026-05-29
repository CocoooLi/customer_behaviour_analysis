CREATE DATABASE customer_behavior;
USE customer_behavior;

-- Q1. What is the overall churn rate of customers?
SELECT 
    COUNT(*) AS total_customers,
    SUM(churn = 'Yes') AS churned_customers,
    ROUND(
        AVG(churn = 'Yes') * 100,
        2
    ) AS churn_rate_percentage
FROM customer;

-- Q2. Which contract type has the highest churn rate?
SELECT 
    contract,
    COUNT(*) AS total_customers,
    SUM(churn = 'Yes') AS churned_customers,
    ROUND(
        AVG(churn = 'Yes') * 100,
        2
    ) AS churn_rate_percentage
FROM customer
GROUP BY contract
ORDER BY churn_rate_percentage DESC;

-- Q3. What is the churn rate for each tenure group: New, Early, 
-- Established, and Loyal?
SELECT
    tenure_group,
    COUNT(*) AS total_customers,
    SUM(churn = 'Yes') AS churned_customers,
    ROUND(
        AVG(churn = 'Yes') * 100,
        2
    ) AS churn_rate_percentage
FROM customer
GROUP BY tenure_group
ORDER BY churn_rate_percentage DESC;

-- Q4. Do customers with automatic payment methods have lower churn rates than 
-- those with manual payment methods?
SELECT 
    CASE
        WHEN auto_payment = 1 THEN 'Automatic Payment'
        ELSE 'Manual Payment'
    END AS payment_type,
    COUNT(*) AS total_customers,
    SUM(churn = 'Yes') AS churned_customers,
    ROUND(
        AVG(churn = 'Yes') * 100,
        2
    ) AS churn_rate_percentage
FROM customer
GROUP BY auto_payment
ORDER BY churn_rate_percentage DESC;

-- Q5. Which payment method is associated with the highest churn rate?
SELECT
    payment_method,
    COUNT(*) AS total_customers,
    SUM(churn = 'Yes') AS churned_customers,
    ROUND(
        AVG(churn = 'Yes') * 100,
        2
    ) AS churn_rate_percentage
FROM customer
GROUP BY payment_method
ORDER BY churn_rate_percentage DESC;

-- Q6. How does churn rate differ across internet service types: DSL, Fiber optic, 
-- and No internet service?
SELECT
    internet_service,
    COUNT(*) AS total_customers,
    SUM(churn = 'Yes') AS churned_customers,
    ROUND(
        AVG(churn = 'Yes') * 100,
        2
    ) AS churn_rate_percentage
FROM customer
GROUP BY internet_service
ORDER BY churn_rate_percentage DESC;

-- Q7. What is the average monthly charge for churned customers compared
-- with non-churned customers?
SELECT 
    churn,
    COUNT(*) AS total_customers,
    ROUND(
        AVG(monthly_charges),
        2
    ) AS average_monthly_charge
FROM customer
GROUP BY churn;

-- Q8. Which customer segment contributes the most total revenue based on contract type?
SELECT 
    contract,
    COUNT(*) AS total_customers,
    ROUND(
        SUM(total_charges),
        2
    ) AS total_revenue,
    ROUND(
        AVG(total_charges),
        2
    ) AS average_revenue_per_customer
FROM customer
GROUP BY contract
ORDER BY total_revenue DESC;

-- Q9. Which tenure group generates the highest average monthly charges?
SELECT 
    tenure_group,
    COUNT(*) AS total_customers,
    ROUND(
        AVG(monthly_charges),
        2
    ) AS average_monthly_charge
FROM customer
GROUP BY tenure_group
ORDER BY average_monthly_charge DESC;

-- Q10. Are senior citizens more likely to churn than non-senior customers?
SELECT
    CASE
        WHEN senior_citizen = 1 THEN 'Senior Citizen'
        ELSE 'Non-Senior Citizen'
    END AS customer_group,
    COUNT(*) AS total_customers,
    SUM(churn = 'Yes') AS churned_customers,
    ROUND(
        AVG(churn = 'Yes') * 100,
        2
    ) AS churn_rate_percentage
FROM customer
GROUP BY senior_citizen
ORDER BY churn_rate_percentage DESC;

-- Q11. Do customers with partners or dependents have lower churn rates?
SELECT 
    'Partner' AS customer_attribute,
    partner AS status,
    COUNT(*) AS total_customers,
    SUM(churn = 'Yes') AS churned_customers,
    ROUND(AVG(churn = 'Yes') * 100, 2) AS churn_rate_percentage
FROM customer
GROUP BY partner

UNION ALL

SELECT 
    'Dependents' AS customer_attribute,
    dependents AS status,
    COUNT(*) AS total_customers,
    SUM(churn = 'Yes') AS churned_customers,
    ROUND(AVG(churn = 'Yes') * 100, 2) AS churn_rate_percentage
FROM customer
GROUP BY dependents
ORDER BY customer_attribute, churn_rate_percentage DESC;

-- Q12. Which group has the highest churn rate based on the number of 
-- additional services subscribed?
SELECT 
    num_additional_services,
    COUNT(*) AS total_customers,
    SUM(churn = 'Yes') AS churned_customers,
    ROUND(AVG(churn = 'Yes') * 100, 2) AS churn_rate_percentage
FROM customer
GROUP BY num_additional_services
ORDER BY num_additional_services ASC;

-- Q13. What are the top 5 customer segments with the highest churn rate, 
-- grouped by contract type, internet service, and payment method?
SELECT 
    contract,
    internet_service,
    payment_method,
    COUNT(*) AS total_customers,
    SUM(churn = 'Yes') AS churned_customers,
    ROUND(AVG(churn = 'Yes') * 100, 2) AS churn_rate_percentage
FROM customer
GROUP BY contract, internet_service, payment_method
HAVING COUNT(*) >= 30
ORDER BY churn_rate_percentage DESC
LIMIT 5;

-- Q14. Among churned customers, which service combinations are most common?
SELECT 
    internet_service,
    online_security,
    tech_support,
    streaming_tv,
    streaming_movies,
    COUNT(*) AS churned_customers
FROM customer
WHERE churn = 'Yes'
GROUP BY 
    internet_service,
    online_security,
    tech_support,
    streaming_tv,
    streaming_movies
ORDER BY churned_customers DESC
LIMIT 5;