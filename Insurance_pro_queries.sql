use insurance;  

#targets
#New_target
SELECT SUM(`New Budget`) AS NEW_TARGET
FROM `individual budgets1`;

#cross_sell
SELECT SUM(`Cross sell bugdet`) AS cross_TARGET
FROM `individual budgets1`;

#Renewal
SELECT SUM(`Renewal Budget`) AS RENEWAL_TARGET
FROM `individual budgets1`;


#placed Achievement
 FLUSH TABLES;
SELECT
    bf.`Account Exe ID`,  -- Removed the table name from SELECT field list
       SUM(CASE WHEN bf.income_class = 'New' THEN bf.Amount ELSE 0 END) AS 'New Target',sum(ib.`New Budget`)*100 as New_sell_achievement,
    SUM(CASE WHEN bf.income_class = 'Cross Sell' THEN bf.Amount ELSE 0 END) AS 'Cross Sell Target', SUM(ib.`Cross sell bugdet`) * 100 AS Cross_Sell_Achievement_Percentage,
    SUM(CASE WHEn bf.income_class = 'Renewal' THEN bf.Amount ELSE 0 END) AS 'Renewal Target', SUM(ib.`Renewal Budget`) * 100 AS Renewal_Achievement_Percentage
FROM 
    `brokerage+fees` bf -- Alias for brokerage+fees table
JOIN 
    `individual budgets1` ib -- Alias for individual budgets1 table
    ON bf.`Account Exe ID` = ib.`Account Exe ID`
GROUP BY 
    bf.`Account Exe ID`
LIMIT 0, 50000;


#invoice Achievement
SELECT 
  iv.`Account Exe ID`,
    SUM(CASE WHEN income_class = 'New' THEN Amount ELSE 0 END) AS 'New Target',sum(ib.`New Budget`)*100 as New_sell_achievement,
    SUM(CASE WHEN income_class = 'Cross Sell' THEN Amount ELSE 0 END) AS 'Cross Sell Target',SUM(ib.`Cross sell bugdet`) * 100 AS Cross_Sell_Achievement_Percentage,
    SUM(CASE WHEN income_class = 'Renewal' THEN Amount ELSE 0 END) AS 'Renewal Target',SUM(ib.`Renewal Budget`) * 100 AS Renewal_Achievement_Percentage
FROM 
   invoice1 iv
    -- Alias for invoice table
JOIN 
    `individual budgets1` ib -- Alias for individual budgets1 table
    ON iv.`Account Exe ID` = ib.`Account Exe ID`
GROUP BY 
   iv.`Account Exe ID`
LIMIT 0, 50000;

   FLUSH TABLES;
SELECT
   iv.`Account Exe ID`,  -- Removed the table name from SELECT field list
       SUM(CASE WHEN iv.income_class = 'New' THEN iv.Amount ELSE 0 END) AS'New Target',sum(ib.`New Budget`)*100 as New_sell_invoice_achievement,
    SUM(CASE WHEN iv.income_class = 'Cross Sell' THEN iv.Amount ELSE 0 END) AS 'Cross Sell Target', SUM(ib.`Cross sell bugdet`) * 100 AS Cross_Sell_invoice_Achievement_Percentage,
    SUM(CASE WHEN iv.income_class = 'Renewal' THEN iv.Amount ELSE 0 END) AS 'Renewal Target', SUM(ib.`Renewal Budget`) * 100 AS Renewal_invoice_Achievement_Percentage
FROM 
 invoice1 iv -- Alias for invoice table
JOIN 
    `individual budgets1` ib -- Alias for individual budgets1 table
    ON iv.`Account Exe ID` = ib.`Account Exe ID`
GROUP BY 
   iv.`Account Exe ID` 
LIMIT 0, 50000;

#cross_invoice_achievement
SELECT
   iv.`Account Exe ID`,  
       SUM(CASE WHEN iv.income_class = 'New' THEN iv.Amount ELSE 0 END) AS `New Target`,
       SUM(ib.`New Budget`) * 100 AS New_sell_invoice_achievement,
       SUM(CASE WHEN iv.income_class = 'Cross Sell' THEN iv.Amount ELSE 0 END) AS `Cross Sell Target`,
       SUM(ib.`Cross sell bugdet`) * 100 AS Cross_Sell_invoice_Achievement_Percentage,
       SUM(CASE WHEN iv.income_class = 'Renewal' THEN iv.Amount ELSE 0 END) AS `Renewal Target`,
       SUM(ib.`Renewal Budget`) * 100 AS Renewal_invoice_Achievement_Percentage
FROM 
    invoice1 iv
JOIN 
    `individual budgets1` ib 
    ON iv.`Account Exe ID` = ib.`Account Exe ID`
GROUP BY 
    iv.`Account Exe ID`
LIMIT 0, 50000;

SELECT income_class, COUNT(*)
FROM invoice1
GROUP BY income_class;

SELECT iv.`Account Exe ID`
FROM invoice1 iv
LEFT JOIN `individual budgets1` ib ON iv.`Account Exe ID` = ib.`Account Exe ID`
WHERE ib.`Account Exe ID` IS NULL;

SELECT DISTINCT income_class
FROM invoice1;

DESCRIBE invoice1;

#new_invoice_achievement
SELECT iv.`Account Exe ID`, 
       SUM(CASE WHEN iv.income_class = 'New' THEN iv.Amount ELSE 0 END) AS new_invoice_achieve
FROM invoice1 iv
GROUP BY iv.`Account Exe ID`;

select*from invoice1;
#renewal Target_achievement
SELECT iv.`Account Exe ID`, 
       SUM(CASE WHEN iv.income_class = 'Renewal' THEN iv.Amount ELSE 0 END) AS `Renewal Target`
FROM 
    invoice1 iv
JOIN 
    `individual budgets1` ib 
    ON iv.`Account Exe ID` = ib.`Account Exe ID`
GROUP BY 
    iv.`Account Exe ID`
LIMIT 0, 50000;

SELECT iv.`Account Exe ID`, 
       SUM(CASE WHEN iv.income_class = 'Renewal' THEN iv.Amount ELSE 0 END) AS `renweal invoice achievement`
FROM invoice1 iv
GROUP BY iv.`Account Exe ID`;

select * from invoice1;


#yearly meeting count
SELECT meeting_date, COUNT(*) AS Yearly_Meeting_Count
FROM Meeting
GROUP BY meeting_date;

SELECT COUNT(*)
FROM Meeting
WHERE meeting_date IS NULL;

SELECT YEAR(meeting_date) AS Year, COUNT(*) AS Total_Meetings
FROM Meeting
GROUP BY YEAR(meeting_date);

DESCRIBE Meeting;

SELECT 
    YEAR(meeting_date) AS Year, 
    COUNT(*) AS Total_Meetings
FROM 
    Meeting
WHERE 
    YEAR(meeting_date) IN (2019, 2020)
GROUP BY 
    YEAR(meeting_date); 
   
SELECT COUNT(*) FROM Meeting;


 #no of meetings by account exe_id   
SELECT `ï»¿Account Exe ID` AS no_of_exe_id, sum(meeting_date ) AS Total_Meetings
FROM Meeting
GROUP BY `ï»¿Account Exe ID`;


#no.of invoices by account excutives
SHOW TABLES FROM insurance;

SELECT `Account Executive`, COUNT(*) AS No_of_Invoices
FROM Invoice1
GROUP BY `Account Executive`
order by no_of_Invoices desc;



#stages wise revenue amount
SELECT stage,
sum(revenue_amount)*100 AS Matches
FROM Opportunity
group by stage;

#top 10 products by revenue wise
SELECT product_group,
       SUM(revenue_amount) AS total_revenue
FROM Opportunity
GROUP BY product_group
ORDER BY total_revenue DESC
LIMIT 10;


#total_opportunity
SELECT COUNT(*) AS Total_Opportunities
FROM Opportunity;

SELECT COUNT(*) AS Total_Opportunities
FROM Opportunity
WHERE stage = 'Open';

#stages wise opportunities
SELECT stage, COUNT(*) AS Total_Opportunities
FROM Opportunity
GROUP BY stage;

#open opportuniity
SELECT stage, count(*) AS Total_Opportunities
FROM Opportunity
WHERE stage != 'Negotiate'
GROUP BY stage;

#closed_won query
SELECT 
    Opportunity_ID,         -- Replace 'C' with the actual column name representing Opportunity ID
     `Account Executive`,      -- Replace 'E' with the actual column name representing Account Executive
     product_group,          -- Replace 'F' with the actual column name representing Product Group
     Stage                   -- This is for the Stage, where the condition will limit it to 'Won'
FROM 
    Opportunity
WHERE 
    stage = 'Closed Won';

#covertion Ratio
use insurance;
SELECT 
    (SUM(CASE WHEN stage = 'Closed Won' THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS Conversion_Ratio
FROM 
    Opportunity;

#top 10 open opportunity query
SELECT 
    `Account Executive`, 
    Opportunity_ID, 
    Product_Group, 
    revenue_amount, 
    stage
FROM 
    Opportunity
WHERE 
    stage = 'Open'
ORDER BY 
    revenue_amount DESC
LIMIT 10;

#top 10 won opportunity
SELECT 
    `Account Executive`, 
    Opportunity_ID, 
    Product_Group, 
    revenue_amount, 
    stage
FROM 
    Opportunity
WHERE 
    stage = 'Closed Won'
ORDER BY 
    revenue_amount DESC
LIMIT 10;


