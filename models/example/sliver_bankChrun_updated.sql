{{ config(materialized='table', schema= 'BANKINGDATA_SLIVER_LAYER') }}

WITH bank_churn_updated AS (
    SELECT 
        RowNumber,
        CustomerId,
        CreditScore,
        GeographyID,
        GenderID,
        Age,
        Tenure,
        Balance,
        NumOfProducts,
        HasCrCard,
        IsActiveMember,
        EstimatedSalary,
        Exited,
        Bank_DOJ,
        EXTRACT(DAY FROM TO_DATE(Bank_DOJ, 'DD-MM-YYYY')) AS Bank_DOJ_Day,
        EXTRACT(MONTH FROM TO_DATE(Bank_DOJ, 'DD-MM-YYYY')) AS Bank_DOJ_Month,
        EXTRACT(YEAR FROM TO_DATE(Bank_DOJ, 'DD-MM-YYYY')) AS Bank_DOJ_Year,
        CASE 
            WHEN CreditScore BETWEEN 800 AND 850 THEN 'Excellent'
            WHEN CreditScore BETWEEN 740 AND 799 THEN 'Very Good'
            WHEN CreditScore BETWEEN 670 AND 739 THEN 'Good'
            WHEN CreditScore BETWEEN 580 AND 669 THEN 'Fair'
            WHEN CreditScore BETWEEN 300 AND 579 THEN 'Poor'
            ELSE 'Unknown'
        END AS CreditScoreCategory
    FROM {{ source('Bankingdata', 'BANK_CHURN') }}
)

SELECT * 
FROM bank_churn_updated