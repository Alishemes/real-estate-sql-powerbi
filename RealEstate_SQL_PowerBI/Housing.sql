--Explore Data
SELECT TOP 15 *
FROM housing;


--Check NULL Values
SELECT * 
FROM housing
WHERE RM IS NULL
OR MEDV IS NULL;


--Create Clean View
GO

CREATE VIEW vw_housing_clean AS
SELECT *
FROM housing
WHERE RM IS NOT NULL 
AND MEDV IS NOT NULL;

GO

--Use Clean Data
SELECT *
FROM vw_housing_clean;


--Duplicate Check
SELECT *,
COUNT(*) AS duplicate_count
FROM housing
GROUP BY
CRIM, ZN, INDUS, CHAS, NOX, RM,
AGE, DIS, RAD, TAX, PTRATIO,
B, LSTAT, MEDV
HAVING COUNT(*) > 1;



-- Average Price
SELECT ROUND(AVG(MEDV),2) AS avg_price
FROM housing;

-- Max & Min Price
SELECT 
MAX(MEDV) AS max_price,
MIN(MEDV) AS min_price
FROM housing;


--Rooms vs Price Analysis
SELECT 
ROUND(RM, 0) AS rooms,
ROUND(AVG(MEDV),2) AS avg_price
FROM housing
GROUP BY ROUND(RM, 0)
ORDER BY rooms;


--Crime vs Price (Raw View)
SELECT 
ROUND(CRIM,0) AS crime,
ROUND(MEDV,0) AS price
FROM housing
ORDER BY CRIM DESC;


--Crime Level Segmentation (Insight)
SELECT 
CASE 
WHEN CRIM < 1 THEN 'Low Crime'
WHEN CRIM BETWEEN 1 AND 5 THEN 'Medium Crime'
ELSE 'High Crime'
END AS crime_level,
ROUND(AVG(MEDV),2) AS avg_price
FROM housing
GROUP BY 
CASE 
WHEN CRIM < 1 THEN 'Low Crime'
WHEN CRIM BETWEEN 1 AND 5 THEN 'Medium Crime'
ELSE 'High Crime'
END;



--River Effect (CHAS)
SELECT 
CHAS,
ROUND(AVG(MEDV),2) AS avg_price
FROM housing
GROUP BY CHAS;


--Pollution Impact (NOX)
SELECT 
NOX,
ROUND(MEDV,2) AS price
FROM housing
ORDER BY NOX DESC;

SELECT 
    CHAS,
    COUNT(*) AS house_count
FROM housing
GROUP BY CHAS;