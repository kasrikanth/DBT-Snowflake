-- This is a dbt model file named Gold_Dim_table.sql

{{ config(materialized='table', schema='BANKINGDATA_GOLD_LAYER') }}

/*
WITH Dim_table AS (
    SELECT
        b.CustomerId,
        ci.Surname,
        g.GenderCategory AS Gender,
        geo.GeographyLocation AS Geography,
        cc.Category AS CreditCard,
        a.ActiveCategory AS ActiveStatus,
        e.ExitCategory AS ExitStatus,
        b.CreditScoreCategory  -- Ensure this column exists in SLIVER_BANKCHRUN_UPDATED
    FROM DBT_DATABASE.DBT_FILES_BANKINGDATA_SLIVER_LAYER.SLIVER_BANKCHRUN_UPDATED b
    JOIN DBT_DATABASE.BANKINGDATA_BRONZE_LAYER.CustomerInfo ci ON b.CustomerId = ci.CustomerId
    JOIN DBT_DATABASE.BANKINGDATA_BRONZE_LAYER.Gender g ON b.GenderID = g.GenderID
    JOIN DBT_DATABASE.BANKINGDATA_BRONZE_LAYER.Geography geo ON b.GeographyID = geo.GeographyID
    JOIN DBT_DATABASE.BANKINGDATA_BRONZE_LAYER.CreditCard cc ON b.HasCrCard = cc.CreditID
    JOIN DBT_DATABASE.BANKINGDATA_BRONZE_LAYER.ActiveCustomer a ON b.IsActiveMember = a.ActiveID
    JOIN DBT_DATABASE.BANKINGDATA_BRONZE_LAYER.ExitCustomer e ON b.Exited = e.ExitID
)

SELECT * 
FROM Dim_table
*/


WITH Dim_table AS (
    SELECT
        b.CustomerId,
        ci.Surname,
        g.GenderCategory AS Gender,
        geo.GeographyLocation AS Geography,
        cc.Category AS CreditCard,
        a.ActiveCategory AS ActiveStatus,
        e.ExitCategory AS ExitStatus,
        b.CreditScoreCategory
    FROM {{ source('sliver_Bankingdata', 'SLIVER_BANKCHRUN_UPDATED') }} b
    JOIN {{ source('Bankingdata', 'CUSTOMERINFO') }} ci ON b.CustomerId = ci.CustomerId
    JOIN {{ source('Bankingdata', 'GENDER') }} g ON b.GenderID = g.GenderID
    JOIN {{ source('Bankingdata', 'GEOGRAPHY') }} geo ON b.GeographyID = geo.GeographyID
    JOIN {{ source('Bankingdata', 'CREDITCARD') }} cc ON b.HasCrCard = cc.CreditID
    JOIN {{ source('Bankingdata', 'ACTIVECUSTOMER') }} a ON b.IsActiveMember = a.ActiveID
    JOIN {{ source('Bankingdata', 'EXITCUSTOMER') }} e ON b.Exited = e.ExitID
)

SELECT * 
FROM Dim_table




