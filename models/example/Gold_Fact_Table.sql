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
    FROM DBT_DATABASE.BANKINGDATA_BRONZE_LAYER.Bank_churn
)

SELECT * FROM Fact_table