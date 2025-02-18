create database health_care_analysis;
use health_care_analysis;

select count(*) from dialysis1;

select count(*) from dialysis2;

-- KPI 1 : Number of Patients across various summaries
SELECT
    SUM(coalesce(`Transfusion summary`,0)) AS TransfusionPatients,
    SUM(coalesce(`Hypercalcemia summary`,0)) AS HypercalcemiaPatients,
     SUM(coalesce(`M Hypercalcemia summary`,0)) AS MonthHypercalcemiaPatients,
    SUM(coalesce(`Serum phosphorus summary`,0)) AS SerumPhosphorusPatients,
    SUM(coalesce(`M Serum phosphorus summary`,0)) AS MonthSerumPhosphorusPatients,
    SUM(coalesce(`Hospitalization summary`,0)) AS HospitalizationPatients,
    SUM(coalesce(`Hospital readmission summary`,0)) AS HospitalReadmissionPatients,
    SUM(coalesce(`Survival summary`,0)) AS SurvivalPatients,
    SUM(coalesce(`Fistula summary`,0)) AS FistulaPatients,
    SUM(coalesce(`Long term catheter summary`,0)) AS LongCatheterPatients,
     SUM(coalesce(`M long term catheter summary`,0)) AS MonthLongCatheterPatients,
    SUM(coalesce(`nPCR summary`,0)) AS nPCRPatients,
     SUM(coalesce(`M nPCR summary`,0)) AS MonthnPCRPatients
    
FROM
    dialysis1;
    
    
    
    
    -- KPI : 2 Profit Vs Non-Profit Stats
 SELECT
    `Profit or Non-Profit`,
    COUNT(*) AS TotalCenters,
   round((COUNT(*) * 100.0 / (SELECT COUNT(*) FROM dialysis1)),2) AS percentage
    
FROM
    dialysis1
GROUP BY
    `Profit or Non-Profit`;
    
    -- KPI : 3 Chain Organizations w.r.t. Total Performance Score as No Score   

    
    SELECT 
    d1.`Chain Organization`, 
    COUNT(d2.`Total Performance Score`) AS 'No Score'
FROM 
    dialysis1 AS d1 
JOIN 
    dialysis2 AS d2 ON d1.`Facility Name` = d2.`Facility Name` 
WHERE 
    d2.`Total Performance Score` = "No Score" 
GROUP BY 
    d1.`Chain Organization`;
    
    
    -- KPI :  Dialysis Stations Stats 
    SELECT
    AVG(`# of Dialysis Stations`) AS AvgDialysisStations,
	sum(`# of Dialysis Stations`) AS SumDialysisStations,
    MAX(`# of Dialysis Stations`) AS MaxDialysisStations,
    stddev(`# of Dialysis Stations`) as StddevDialysisStations,
    MIN(`# of Dialysis Stations`) AS MinDialysisStations,
    COUNT(`# of Dialysis Stations`) AS CountDialysisStations
FROM
    dialysis1;
    
    -- by using State
SELECT
State,
    AVG(`# of Dialysis Stations`) AS AvgDialysisStations,
	sum(`# of Dialysis Stations`) AS SumDialysisStations,
    MAX(`# of Dialysis Stations`) AS MaxDialysisStations,
    stddev(`# of Dialysis Stations`) as StddevDialysisStations,
    MIN(`# of Dialysis Stations`) AS MinDialysisStations,
    COUNT(`# of Dialysis Stations`) AS CountDialysisStations
FROM
    dialysis1
    GROUP BY 
   State;
    
    
    -- by using City
    SELECT
    city,
    AVG(`# of Dialysis Stations`) AS AvgDialysisStations,
	sum(`# of Dialysis Stations`) AS SumDialysisStations,
    MAX(`# of Dialysis Stations`) AS MaxDialysisStations,
    stddev(`# of Dialysis Stations`) as StddevDialysisStations,
    MIN(`# of Dialysis Stations`) AS MinDialysisStations,
    COUNT(`# of Dialysis Stations`) AS CountDialysisStations
FROM
    dialysis1
    GROUP BY 
    city;
    
    
    -- KPI : 5 # of Category Text  - As Expected

 SELECT
    SUM(CASE WHEN `Patient Transfusion category text` = 'As Expected' THEN 1 ELSE 0 END) AS TransfusionAsExpected,
    SUM(CASE WHEN `Hospitalization category text`= 'As Expected' THEN 1 ELSE 0 END) AS HospitalizationAsExpected,
    SUM(CASE WHEN `Readmission Category` = 'As Expected' THEN 1 ELSE 0 END) AS HospitalReadmissionsAsExpected,
    SUM(CASE WHEN `Survival Category Text` = 'As Expected' THEN 1 ELSE 0 END) AS SurvivalAsExpected,
    SUM(CASE WHEN `Infection category text` = 'As Expected' THEN 1 ELSE 0 END) AS InfectionAsExpected,
    SUM(CASE WHEN `Fistula Category Text` = 'As Expected' THEN 1 ELSE 0 END) AS FistulaAsExpected,
    SUM(CASE WHEN `SWR category text` = 'As Expected' THEN 1 ELSE 0 END) AS SWRAsExpected,
    SUM(CASE WHEN `PPPW category text` = 'As Expected' THEN 1 ELSE 0 END) AS PPPWAsExpected
FROM
    dialysis1;
    
    
    -- KPI : 6  Sum and Average Payment Reduction Rate

    SELECT
round((sum(`PY2020 Payment Reduction Percentage`)),2)AS AveragePaymentReductionRate
FROM
    dialysis2;
    
    
SELECT
round((avg(`PY2020 Payment Reduction Percentage`)),2)AS AveragePaymentReductionRate
FROM
    dialysis2
    where 
    `PY2020 Payment Reduction Percentage`!='no reduction';
    
    SELECT
avg(cast(`PY2020 Payment Reduction Percentage`as decimal(18,10)))AS AveragePaymentReductionRate
FROM
    dialysis2
    where 
    `PY2020 Payment Reduction Percentage`!='no reduction';
    
    
    
    
    
    
