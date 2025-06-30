SELECT * FROM employeeattrition;

-- Insight 1: Is one gender more likely to leave us at certain job levels?
-- What are there specific job levels where one gender is more likely to attrit, indicating potential career progression or fairness issues?

SELECT
    JobLevel,
    Gender,
    COUNT(CASE WHEN Attrition = 'Yes' THEN EmployeeNumber END) AS AttritedEmployees,
    COUNT(EmployeeNumber) AS TotalEmployees,
    (COUNT(CASE WHEN Attrition = 'Yes' THEN EmployeeNumber END) / COUNT(EmployeeNumber)) * 100 AS AttritionRate_100Percent
FROM
    employeeattrition
GROUP BY
    JobLevel,
    Gender
ORDER BY
    JobLevel,
    Gender;


-- Insight 2: Are employees who work a lot of overtime also more likely to leave, especially if they feel their work-life balance is poor?
-- It shows if overtime significantly increase attrition, especially for those with lower perceived work-life balance?
SELECT
    WorkLifeBalance,
    OverTime,
    COUNT(CASE WHEN Attrition = 'Yes' THEN EmployeeNumber END) AS AttritedEmployees,
    COUNT(EmployeeNumber) AS TotalEmployees,
    (COUNT(CASE WHEN Attrition = 'Yes' THEN EmployeeNumber END) / COUNT(EmployeeNumber)) * 100 AS AttritionRate
FROM
    employeeattrition
GROUP BY
    WorkLifeBalance,
    OverTime
ORDER BY
    WorkLifeBalance,
    OverTime;


-- Insight 3: How does the average monthly income differ between employees who stay and those who leave, across different fields of study?
SELECT
    EducationField,
    Attrition,
    AVG(MonthlyIncome) AS AverageMonthlyIncome,
    MIN(MonthlyIncome) AS MinMonthlyIncome,
    MAX(MonthlyIncome) AS MaxMonthlyIncome
FROM
    EmployeeAttrition
GROUP BY
    EducationField,
    Attrition
ORDER BY
    EducationField,
    Attrition;
    

-- Insight 4: Are our high-performing employees leaving if they're not happy with their job?
-- Are high performers with low job satisfaction still leaving, indicating a deeper issue than just performance?
SELECT
    PerformanceRating,
    JobSatisfaction,
    COUNT(CASE WHEN Attrition = 'Yes' THEN EmployeeNumber END) AS AttritedEmployees,
    COUNT(EmployeeNumber) AS TotalEmployees,
    (COUNT(CASE WHEN Attrition = 'Yes' THEN EmployeeNumber END) / COUNT(EmployeeNumber)) * 100 AS AttritionRate
FROM
    EmployeeAttrition
WHERE
    JobSatisfaction IN (1, 2) -- 'Low' or 'Medium' satisfaction
GROUP BY
    PerformanceRating,
    JobSatisfaction
ORDER BY
    PerformanceRating,
    JobSatisfaction;
    
    
-- Insight 5: Do employees who have worked for many companies, or those who are relatively new to the workforce, leave at different rates?
-- This helps us tailor our retention efforts based on an employee's professional history and overall experience level.
SELECT
    NumCompaniesWorked,
    CASE
        WHEN TotalWorkingYears <= 2 THEN '0-2 Years'
        WHEN TotalWorkingYears BETWEEN 3 AND 5 THEN '3-5 Years'
        WHEN TotalWorkingYears BETWEEN 6 AND 10 THEN '6-10 Years'
        WHEN TotalWorkingYears > 10 THEN '10+ Years'
        ELSE 'Unknown'
    END AS TotalWorkingYearsGroup,
    COUNT(CASE WHEN Attrition = 'Yes' THEN EmployeeNumber END) AS AttritedEmployees,
    COUNT(EmployeeNumber) AS TotalEmployees,
    (COUNT(CASE WHEN Attrition = 'Yes' THEN EmployeeNumber END) / COUNT(EmployeeNumber)) * 100 AS AttritionRate
FROM
    EmployeeAttrition
GROUP BY
    NumCompaniesWorked,
    TotalWorkingYearsGroup
ORDER BY
    NumCompaniesWorked,
    TotalWorkingYearsGroup;


-- Insight 6: Are employees in certain job roles leaving because they haven't been promoted in a long time?
-- This insight helps us identify if a lack of career progression opportunities in specific roles is a significant factor in employee departures.
SELECT
    JobRole,
    Attrition,
    AVG(YearsSinceLastPromotion) AS AverageYearsSinceLastPromotion
FROM
    EmployeeAttrition
GROUP BY
    JobRole,
    Attrition
ORDER BY
    JobRole,
    Attrition;


-- Insight 7: Are employees from specific age groups or marital statuses more likely to leave the company?
-- This helps us understand if demographic factors influence attrition, which can inform targeted HR policies and benefits.
SELECT
    CASE
        WHEN Age <= 25 THEN '18-25'
        WHEN Age BETWEEN 26 AND 35 THEN '26-35'
        WHEN Age BETWEEN 36 AND 45 THEN '36-45'
        WHEN Age > 45 THEN '45+'
        ELSE 'Unknown'
    END AS AgeGroup,
    MaritalStatus,
    COUNT(CASE WHEN Attrition = 'Yes' THEN EmployeeNumber END) AS AttritedEmployees,
    COUNT(EmployeeNumber) AS TotalEmployees,
    (COUNT(CASE WHEN Attrition = 'Yes' THEN EmployeeNumber END) / COUNT(EmployeeNumber)) * 100 AS AttritionRate
FROM
    employeeattrition
GROUP BY
    AgeGroup,
    MaritalStatus
ORDER BY
    AgeGroup,
    MaritalStatus;
    
    
-- Insight 8: Does the work environment impact whether employees leave, especially for those who travel a lot for business?
-- This explores if the combination of business travel and satisfaction with the work environment influences attrition.
SELECT
    BusinessTravel,
    EnvironmentSatisfaction,
    COUNT(CASE WHEN Attrition = 'Yes' THEN EmployeeNumber END) AS AttritedEmployees,
    COUNT(EmployeeNumber) AS TotalEmployees,
    (COUNT(CASE WHEN Attrition = 'Yes' THEN EmployeeNumber END) / COUNT(EmployeeNumber)) * 100 AS AttritionRate
FROM
    EmployeeAttrition
GROUP BY
    BusinessTravel,
    EnvironmentSatisfaction
ORDER BY
    BusinessTravel,
    EnvironmentSatisfaction;
    
    
-- Inssight 9: Are employees who are highly involved in their jobs still leaving, even if they received a small salary increase?
-- This helps us understand if high commitment isn't being sufficiently rewarded, leading highly engaged employees to leave.
SELECT
    PercentSalaryHike,
    JobInvolvement,
    COUNT(CASE WHEN Attrition = 'Yes' THEN EmployeeNumber END) AS AttritedEmployees,
    COUNT(EmployeeNumber) AS TotalEmployees,
    (COUNT(CASE WHEN Attrition = 'Yes' THEN EmployeeNumber END) / COUNT(EmployeeNumber)) * 100 AS AttritionRate
FROM
    EmployeeAttrition
GROUP BY
    PercentSalaryHike,
    JobInvolvement
ORDER BY
    PercentSalaryHike,
    JobInvolvement;
    

-- Insight 10. Are employees with fewer long-term incentives (like stock options) and a higher "per-day" cost more likely to leave?
SELECT
    Attrition,
    COUNT(EmployeeNumber) AS TotalEmployees,
    (COUNT(CASE WHEN Attrition = 'Yes' THEN EmployeeNumber END) / COUNT(EmployeeNumber)) * 100 AS AttritionRate
FROM
    EmployeeAttrition
WHERE
    StockOptionLevel = 0 -- Assuming 0 means no stock options
    AND MonthlyRate > (SELECT AVG(MonthlyRate) FROM EmployeeAttrition) -- Employees with above-average monthly rate
GROUP BY
    Attrition;
    

-- Insight 11: How does the average daily pay of employees who leave compare to their time at the company, across different departments?
SELECT
    Department,
    CASE
        WHEN YearsAtCompany <= 2 THEN '0-2 Years'
        WHEN YearsAtCompany BETWEEN 3 AND 5 THEN '3-5 Years'
        WHEN YearsAtCompany BETWEEN 6 AND 10 THEN '6-10 Years'
        WHEN YearsAtCompany > 10 THEN '10+ Years'
        ELSE 'Unknown'
    END AS YearsAtCompanyGroup,
    Attrition,
    AVG(DailyRate) AS AverageDailyRate
FROM
    EmployeeAttrition
GROUP BY
    Department,
    YearsAtCompanyGroup,
    Attrition
ORDER BY
    Department,
    YearsAtCompanyGroup,
    Attrition;


-- Insight 12: Does a combination of a long commute and poor workplace relationships make employees more likely to leave?
SELECT
    RelationshipSatisfaction,
    CASE
        WHEN DistanceFromHome <= 5 THEN 'Close (0-5)'
        WHEN DistanceFromHome BETWEEN 6 AND 15 THEN 'Medium (6-15)'
        WHEN DistanceFromHome > 15 THEN 'Far (15+)'
        ELSE 'Unknown'
    END AS DistanceGroup,
    COUNT(CASE WHEN Attrition = 'Yes' THEN EmployeeNumber END) AS AttritedEmployees,
    COUNT(EmployeeNumber) AS TotalEmployees,
    (COUNT(CASE WHEN Attrition = 'Yes' THEN EmployeeNumber END) / COUNT(EmployeeNumber)) * 100 AS AttritionRate
FROM
    employeeattrition
WHERE
    RelationshipSatisfaction IN (1, 2) -- Employees who reported 'Low' or 'Medium' relationship satisfaction
GROUP BY
    RelationshipSatisfaction,
    DistanceGroup
ORDER BY
    RelationshipSatisfaction,
    DistanceGroup;


-- Insight 13: What is the attrition rate for our experienced employees who have not received a promotion in their current role for over three years?
SELECT
    COUNT(CASE WHEN Attrition = 'Yes' THEN EmployeeNumber END) AS AttritedEmployees,
    COUNT(EmployeeNumber) AS TotalEmployees,
    (COUNT(CASE WHEN Attrition = 'Yes' THEN EmployeeNumber END) / COUNT(EmployeeNumber)) * 100 AS AttritionRate
FROM
    EmployeeAttrition
WHERE
    YearsInCurrentRole > 3
    AND YearsSinceLastPromotion > 3 -- More than 3 years since last promotion in current role
    AND TotalWorkingYears > 5;


-- Insight 14: How does average monthly income and the average time spent with their current manager compare between attrited and non-attrited employees in each department?
SELECT
    Department,
    Attrition,
    AVG(MonthlyIncome) AS AverageMonthlyIncome,
    AVG(YearsWithCurrManager) AS AverageYearsWithManager,
    COUNT(CASE WHEN Attrition = 'Yes' THEN EmployeeNumber END) / COUNT(EmployeeNumber) * 100 AS DepartmentAttritionRate
FROM
    employeeattrition
GROUP BY
    Department,
    Attrition
ORDER BY
    Department,
    Attrition;


-- Insight 15: Which job roles and departments are experiencing the most employee departures, and what was their average monthly income?
SELECT
    JobRole,
    Department,
    COUNT(CASE WHEN Attrition = 'Yes' THEN EmployeeNumber END) AS AttritedEmployeesCount,
    AVG(MonthlyIncome) AS AverageMonthlyIncomeOfAttrited
FROM
    EmployeeAttrition
WHERE
    Attrition = 'Yes'
GROUP BY
    JobRole,
    Department
ORDER BY
    AttritedEmployeesCount DESC
LIMIT 5;

