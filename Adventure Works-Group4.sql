use adventure_project;
show tables;
 
 ----------------------------------------------------------------------------------------------------------------------------
 -- 1) Write a Query to match the customer full name from dimcustomer and customer key and sales order number from Fact Internet Sales?
    SELECT
    fis.CustomerKey,
    CONCAT(firstname, ' ',middlename,' ', lastname) AS customer_full_name,
    fis.SalesOrderNumber
    
FROM
    FactInternetSales fis
JOIN
   dimCustomer c ON fis.CustomerKey = c.CustomerKey;
----------------------------------------------------------------------------------------------------------------------------


-- 2)  Write a query to get the customer full name along with yearlyincome which is above 5000?
select CONCAT(firstname, ' ',middlename,' ', lastname) AS customer_full_name,yearlyincome from dimcustomer where yearlyincome>5000;

--------------------------------------------------------------------------------------------------------------------------

-- 3) Write a query to get productkey, englishproductname along with customerkey and customer full name?
SELECT
    dp.ProductKey,
    dp.EnglishProductName,
    fis.CustomerKey,
    CONCAT(firstname, ' ',middlename,' ', lastname) AS customer_full_name
FROM
    DimProduct dp
JOIN
    FactInternetSales fis ON dp.ProductKey = fis.ProductKey
JOIN
    DimCustomer dc ON fis.CustomerKey = dc.CustomerKey;

---------------------------------------------------------------------------------------------------------------------------

-- 4) Write a query to get the product category key and categoryname along with productsubcategoryname and productsubcategorykey?
SELECT 
    dc.productcategorykey AS productcategorykey,
    dc.englishproductcategoryname AS englishproductcategoryname,
    dsc.productsubcategorykey AS productsubcategorykey,
    dsc.englishproductsubcategoryname AS englishproductsubcategoryname
    
FROM 
    dimproductcategory dc
JOIN 
    dimproductsubcategory dsc ON dc.productcategorykey = dsc.productcategorykey;
    -----------------------------------------------------------------------------------------------------------------------
   
   -- 5)Write a query to get the detailsi.e., customer key, productkey,salesterritorykey, customerfullname, englishproductname, salesterritorycountry and sales amount?
    
    SELECT
    fis.customerkey,
     fis.productkey,
     dst.salesterritorykey,
    CONCAT(firstname, ' ',middlename,' ', lastname) AS customer_full_name,
    dp.englishproductname,
    dst.salesterritorycountry,
    fis.salesamount
FROM
    factinternetsales fis
JOIN
    dimcustomer dc ON fis.customerkey = dc.customerkey
JOIN
    dimproduct dp ON fis.productkey = dp.productkey
JOIN
    dimsalesterritory dst ON fis.salesterritorykey = dst.salesterritorykey;
-------------------------------------------------------------------------------------------------------------------------

-- 6) Write a query to get the profit?
SELECT
    salesamount,
    productstandardcost,
  round ( (salesamount - productstandardcost),2) AS profit
FROM
    factinternetsales;

-------------------------------------------------------------------------------------------------------------------------

-- 7) Write a query to get the details which are connected with the salesterritorycountry called unitedstates?
   SELECT distinct
    dp.productkey,
    dp.englishproductname,
    fis.salesamount,
    CONCAT(firstname, ' ',middlename,' ', lastname) AS customer_full_name,
    dst.salesterritorycountry
FROM
    factinternetsales fis
    
    JOIN
    dimcustomer dc ON fis.customerkey = dc.customerkey
JOIN
    dimproduct dp ON fis.productkey = dp.productkey
    
JOIN
    dimsalesterritory dst ON fis.salesterritorykey = dst.salesterritorykey
WHERE
    dst.salesterritorycountry = 'United States';
    
   -----------------------------------------------------------------------------------------------------------------------
   
   -- 8) Write a query to get the distinct values in the following columns?
   SELECT DISTINCT
    dp.productkey,
    dp.englishproductname,
    dc.customerkey,
    CONCAT(dc.firstname, ' ',dc.middlename,' ', dc.lastname) AS customer_full_name
FROM
    dimproduct dp
JOIN
    factinternetsales fis ON dp.productkey = fis.productkey
JOIN
    dimcustomer dc ON fis.customerkey = dc.customerkey;

------------------------------------------------------------------------------------------------------------------------

-- 9) Write a query to get the details along with datekey and fulldatealternatekey?
SELECT
    dp.productkey,
    dp.englishproductname,
    CONCAT(dc.firstname, ' ', dc.lastname) AS customer_full_name,
    dd.datekey,
    dd.fulldatealternatekey
FROM
    dimproduct dp
    
JOIN
    factinternetsales fis ON dp.productkey = fis.productkey
JOIN
    dimcustomer dc ON fis.customerkey = dc.customerkey
JOIN
    dimdate dd ON fis.orderdatekey = dd.datekey;
---------------------------------------------------------------------------------------------------------------------------

-- 10) Write a query to get the details which the specific date?

SELECT
    ds.customerfullname,
    ds.productname,
    ds.productcatname,
    ds.productsubcatname
FROM
    dimsales ds
WHERE
    ds.date = '29-12-2010';
---------------------------------------------------------------------------------------------------------------------------
  -- 11) Write a query to show each customer with multiple productcatname?
  
  SELECT CustomerfullName, COUNT(DISTINCT ProductCatName) AS NumProductCategories
FROM DimSales
GROUP BY Customerfullname
HAVING NumProductCategories > 1;
 
---------------------------------------------------------------------------------------------------------------------------
-- 12) Write a query to get the entire details from different spreadsheets to analyze the data?

SELECT
    dst.salesterritorycountry,
    ds.date,
    dc.customerkey,
    CONCAT(dc.firstname, ' ',dc.middlename,' ', dc.lastname) AS customer_full_name,
    dp.productkey,
    dp.englishproductname,
    ds.salesamount,
    ds.productstandardcost,
   round( (ds.salesamount - ds.productstandardcost),2) AS profit,
    ds.productcatname
FROM
    dimsales ds
JOIN
    dimcustomer dc ON ds.customerkey = dc.customerkey
JOIN
    dimproduct dp ON ds.productkey = dp.productkey
JOIN
    dimsalesterritory dst ON ds.salesterritorykey = dst.salesterritorykey
WHERE
      dst.salesterritorycountry = 'Canada'
      
  and   ds.productcatname = 'Accessories';
 ---------------------------------------------------------------------------------------------------------------------------- 
 
