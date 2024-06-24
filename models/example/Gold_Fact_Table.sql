{{ config(materialized='table', schema= 'BANKINGDATA_GOLD_LAYER') }}


with Fact_table as(
    SELECT
        CustomerId,
        Age,
        CreditScore,
        Tenure,
        EstimatedSalary,
        Balance,
        NumOfProducts
    from {{ source('Bankingdata', 'BANK_CHURN') }}
)

SELECT * FROM Fact_table