{{ config(materialized='table', schema= 'BANKINGDATA_GOLD_LAYER') }}

/*
with high_creditscore as(
    SELECT
        b.CustomerId,
        b.CreditScore,
        b.Tenure,
        b.EstimatedSalary,
        sb.CreditScoreCategory
    from {{ source('Bankingdata', 'BANK_CHURN') }} b
    join {{ source('sliver_Bankingdata', 'SLIVER_BANKCHRUN_UPDATED') }} sb
    WHERE CreditScore >= 800
)

SELECT * FROM high_creditscore
*/

WITH high_creditscore AS (
    SELECT
        b.CustomerId,
        b.CreditScore,
        b.Tenure,
        b.EstimatedSalary,
        sb.CreditScoreCategory
    FROM {{ source('Bankingdata', 'BANK_CHURN') }} b
    JOIN {{ source('sliver_Bankingdata', 'SLIVER_BANKCHRUN_UPDATED') }} sb
    ON b.CustomerId = sb.CustomerId
    WHERE b.CreditScore >= 800
)

SELECT * FROM high_creditscore
