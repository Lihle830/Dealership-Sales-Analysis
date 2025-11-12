CREATE OR REPLACE TABLE DEALERSHIP.CAR_SALES.INVENTORY AS
SELECT *
FROM DEALERSHIP.CAR_SALES.INVENTORY
AT (OFFSET => -3600);
-----------------------------------------------------------------------------------------------------------------------------

Undersating my data----------------------------------------------------

-----------checking duplicates
SELECT 
  vin,
  saledate,
  seller,
  COUNT(*) AS duplicate_count
FROM DEALERSHIP.CAR_SALES.INVENTORY
GROUP BY vin, saledate, seller
HAVING COUNT(*) > 1;

--------Checking row and my colums
SELECT
    (SELECT COUNT(*) 
     FROM DEALERSHIP.CAR_SALES.INVENTORY) AS total_rows,
    (SELECT COUNT(*) 
     FROM DEALERSHIP.INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'CAR_SALES'
    AND TABLE_NAME = 'INVENTORY') AS total_columns;

--------Checking the model year range
SELECT 
    min(year) AS min_year,
    max(year) AS max_year
FROM DEALERSHIP.CAR_SALES.INVENTORY;

SELECT 
    min(sellingprice) AS min_price,
    max(sellingprice) AS max_price
 FROM DEALERSHIP.CAR_SALES.INVENTORY;

-------Checking the unique values in the columns  
   SELECT DISTINCT
    year,
    make,
    model,
    trim,
    body,
    transmission,
    interior,
    seller,
    color,
    state
    FROM DEALERSHIP.CAR_SALES.INVENTORY;

-----Checkinh nulls on Interior
SELECT interior,
       COUNT(*) AS count_interior
FROM DEALERSHIP.CAR_SALES.INVENTORY
GROUP BY interior
ORDER BY count_interior DESC;


-------Repalcing found nulls on Interior
SELECT
  CASE 
  WHEN interior IS NULL THEN 'Unknown'
  WHEN TRIM(interior) IN ('-', '—', '–', 'â€”') THEN 'Unknown'
  ELSE interior
  END AS interior
  FROM DEALERSHIP.CAR_SALES.INVENTORY;

  ----Checking nulls in state
SELECT state,COUNT(*) AS state_count
FROM DEALERSHIP.CAR_SALES.INVENTORY
GROUP BY state
ORDER BY state_count DESC;


---checkinh nulls on Interior
SELECT interior,COUNT(*) AS count_interior
FROM DEALERSHIP.CAR_SALES.INVENTORY
GROUP BY interior
ORDER BY count_interior DESC;

------Repalcing found nulls on Interior
SELECT 
        CASE 
        WHEN interior IS NULL OR TRIM(interior) IN ('-', '—', '–', 'â€”') THEN 'Unknown'
        ELSE interior
        END AS interior_cleaned,
        COUNT(*) AS count_interior
        FROM DEALERSHIP.CAR_SALES.INVENTORY
        GROUP BY interior_cleaned
        ORDER BY count_interior DESC;

---------Checking nllus on Model
SELECT model, COUNT(*) AS count_per_model
FROM DEALERSHIP.CAR_SALES.INVENTORY
GROUP BY model;

--------Repalcing found nulls on Model
SELECT
    CASE 
      WHEN model IS NULL THEN 'Unknown'
      WHEN TRIM(model) IN ('-', '—', '–', 'â€”') THEN 'Unknown'
      ELSE model
      END AS model_cleaned
      FROM DEALERSHIP.CAR_SALES.INVENTORY

---------Checking nulls on Make
SELECT model, COUNT(*) AS count_per_make
FROM DEALERSHIP.CAR_SALES.INVENTORY
GROUP BY model;

--------Repalcing found nulls on Make
SELECT 
  CASE 
    WHEN make IS NULL THEN 'Unknown'
    WHEN TRIM(make) IN ('-', '—', '–', 'â€”') THEN 'Unknown'
    ELSE make
    END AS make_cleaned
    FROM DEALERSHIP.CAR_SALES.INVENTORY;

-----checking nulls on trimchecking nulls on trim
SELECT trim, COUNT(*) AS count_per_trim
FROM DEALERSHIP.CAR_SALES.INVENTORY
GROUP BY trim
ORDER BY count_per_trim DESC;

------Repalcing found nulls on Make
SELECT
    CASE 
        WHEN trim IS NULL OR TRIM(trim) IN ('-', '—', '–', 'â€”') THEN 'Unknown'
        ELSE trim
        END AS trim_cleaned,
        COUNT(*) AS count_per_trim
        FROM DEALERSHIP.CAR_SALES.INVENTORY
        GROUP BY trim_cleaned
        ORDER BY count_per_trim DESC;


----checking nulls on Body
SELECT body, COUNT(*) AS count_per_body
FROM DEALERSHIP.CAR_SALES.INVENTORY
GROUP BY body
ORDER BY count_per_body DESC;

---------Repalcing found nulls on Body
SELECT
    CASE 
        WHEN body IS NULL OR TRIM(body) IN ('-', '—', '–', 'â€”') THEN 'Unknown'
        ELSE body
        END AS body_cleaned,
        COUNT(*) AS count_per_body
        FROM DEALERSHIP.CAR_SALES.INVENTORY
        GROUP BY body_cleaned
        ORDER BY count_per_body DESC;

-----checking nulls on transmission
SELECT transmission, COUNT(*) AS count_per_transmission
FROM DEALERSHIP.CAR_SALES.INVENTORY
GROUP BY transmission
ORDER BY count_per_transmission DESC;

---------Repalcing found nulls on Transmission
SELECT
    CASE 
        WHEN transmission IS NULL OR TRIM(transmission) IN ('-', '—', '–', 'â€”') THEN 'Unknown'
        ELSE transmission
        END AS transmission_cleaned,
        COUNT(*) AS count_per_transmission
        FROM DEALERSHIP.CAR_SALES.INVENTORY
        GROUP BY transmission_cleaned
        ORDER BY count_per_transmission DESC;


-----checking nulls on Color
SELECT color, COUNT(*) AS count_per_color
FROM DEALERSHIP.CAR_SALES.INVENTORY
GROUP BY color
ORDER BY count_per_color DESC;

---------Repalcing found nulls on Color
SELECT
    CASE
        WHEN color IS NULL OR TRIM(color) IN ('-', '—', '–', 'â€”') THEN 'Unknown'
        ELSE color
        END AS color_cleaned,
        COUNT(*) AS count_per_color
        FROM DEALERSHIP.CAR_SALES.INVENTORY
        GROUP BY color_cleaned
        ORDER BY count_per_color DESC;


-----checking nulls on seller
SELECT seller, COUNT(*) AS count_per_seller
FROM DEALERSHIP.CAR_SALES.INVENTORY
GROUP BY seller
ORDER BY count_per_seller DESC;


-----Checking nulls on odometer
SELECT odometer, COUNT(*) AS count_per_odometer
FROM DEALERSHIP.CAR_SALES.INVENTORY
GROUP BY odometer
ORDER BY count_per_odometer DESC;

------Repalcing found nulls on Odometer
SELECT
    CASE
        WHEN odometer IS NULL THEN 'Unknown'
        ELSE TO_VARCHAR(odometer)
        END AS odometer_cleaned,
        COUNT(*) AS count_per_odometer
        FROM DEALERSHIP.CAR_SALES.INVENTORY
        GROUP BY odometer_cleaned
        ORDER BY count_per_odometer DESC;


-----Checking nulls on Condition
SELECT condition, COUNT(*) AS count_per_condition
FROM DEALERSHIP.CAR_SALES.INVENTORY
GROUP BY condition
ORDER BY count_per_condition DESC;

------Checking nulls on VIN
SELECT
    COUNT(*) AS total_records,
    COUNT(vin) AS non_null_vins,
    COUNT(*) - COUNT(vin) AS null_vin_count
FROM DEALERSHIP.CAR_SALES.INVENTORY;

-----Replace Null on VIN
SELECT
    CASE
        WHEN vin IS NULL OR REGEXP_LIKE(vin, '^3vwd17aj6f.*$') THEN 'Unknown'
        ELSE vin
        END AS vin_cleaned,
        COUNT(*) AS count_per_vin
        FROM DEALERSHIP.CAR_SALES.INVENTORY
        GROUP BY vin_cleaned
        ORDER BY count_per_vin DESC;



-------------------------------------------------------------------------------------------------------------------------------------------------------------

------------------------Cleaned Data SeT


WITH converted AS (
    SELECT
        CONVERT_TIMEZONE(
            'America/Los_Angeles',
            'Africa/Johannesburg',
            TRY_TO_TIMESTAMP_NTZ(
                REGEXP_REPLACE(saledate, ' GMT.*', ''), 
                'DY MON DD YYYY HH24:MI:SS'
            )
        ) AS sa_time,
        
        CASE 
            WHEN interior IS NULL THEN 'Unknown'
            WHEN TRIM(interior) IN ('-', '—', '–', 'â€”') THEN 'Unknown'
            ELSE interior
            END AS interior,

        CASE 
            WHEN model IS NULL THEN 'Unknown'
            WHEN TRIM(model) IN ('-', '—', '–', 'â€”') THEN 'Unknown'
            ELSE model
            END AS model_cleaned,

        CASE 
            WHEN make IS NULL THEN 'Unknown'
            WHEN TRIM(make) IN ('-', '—', '–', 'â€”') THEN 'Unknown'
            ELSE make
            END AS make_cleaned,

        CASE
            WHEN vin IS NULL THEN 'Unknown'
            WHEN REGEXP_LIKE(vin, '^3vwd17aj6f.*$', 'i') THEN 'Unknown'
            ELSE vin
            END AS vin_cleaned,

        CASE
            WHEN odometer IS NULL THEN 'Unknown'
            WHEN TRIM(TO_VARCHAR(odometer)) IN ('-', '—', '–', 'â€”') THEN 'Unknown'
            ELSE TO_VARCHAR(odometer)
            END AS odometer_cleaned,
        
        sellingprice,
        condition,
        year,
        state,
        seller
    FROM DEALERSHIP.CAR_SALES.INVENTORY
)
SELECT
    sa_time,
    DATE_PART(year, sa_time) AS sale_year,
    DATE_PART(month, sa_time) AS sale_month,
    DATE_PART(day, sa_time) AS sale_day,
    sellingprice,
    interior,
    model_cleaned,
    make_cleaned,
    vin_cleaned,
    odometer_cleaned,
    condition,
    year,
    state,
    seller
FROM converted;
