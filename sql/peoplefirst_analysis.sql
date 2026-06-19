CREATE DATABASE IF NOT EXISTS peoplefirst;
USE peoplefirst;

DROP TABLE IF EXISTS hr_data;

CREATE TABLE hr_data (
    employee_id             VARCHAR(10)    PRIMARY KEY,
    age                     INT            NOT NULL,
    gender                  VARCHAR(10)    NOT NULL,
    marital_status          VARCHAR(15)    NOT NULL,
    department              VARCHAR(20)    NOT NULL,
    job_role                VARCHAR(60)    NOT NULL,
    education_level         VARCHAR(20)    NOT NULL,
    years_at_company        INT            NOT NULL,
    years_in_role           INT            NOT NULL,
    monthly_salary          DECIMAL(10,2)  NOT NULL,
    salary_hike_pct         INT            NOT NULL,
    job_satisfaction        INT            NOT NULL,
    work_life_balance       INT            NOT NULL,
    environment_satisfaction INT           NOT NULL,
    overtime                VARCHAR(5)     NOT NULL,
    business_travel         VARCHAR(20)    NOT NULL,
    num_companies_worked    INT            NOT NULL,
    distance_from_home_km   INT            NOT NULL,
    performance_rating      INT            NOT NULL,
    training_hours_last_year INT           NOT NULL,
    attrition               VARCHAR(5)     NOT NULL
);



SELECT
    COUNT(employee_id)                              AS total_employees,
    SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END)
                                                    AS total_attrition,
    SUM(CASE WHEN attrition = 'No'  THEN 1 ELSE 0 END)
                                                    AS active_employees,
    ROUND(
        SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END)
        / COUNT(employee_id) * 100, 2)              AS attrition_rate_pct,
    14.0                                            AS industry_benchmark_pct,
    ROUND(
        SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END)
        / COUNT(employee_id) * 100 - 14.0, 2)      AS benchmark_gap_pct
FROM hr_data;




SELECT
    SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END)
                                                    AS employees_lost,
    400000                                          AS replacement_cost_per_employee_inr,
    SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) * 400000
                                                    AS total_replacement_cost_inr,
    ROUND(
        SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END)
        * 400000 / 10000000, 2)                     AS total_cost_crore,
    ROUND(
        SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END)
        * 400000
        / (SUM(monthly_salary) * 12) * 100, 2)     AS cost_as_pct_of_annual_payroll
FROM hr_data;




SELECT
    department,
    COUNT(employee_id)                              AS total_headcount,
    SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END)
                                                    AS attrition_count,
    SUM(CASE WHEN attrition = 'No'  THEN 1 ELSE 0 END)
                                                    AS active_count,
    ROUND(
        SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END)
        / COUNT(employee_id) * 100, 2)              AS attrition_rate_pct,
    ROUND(
        SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END)
        / COUNT(employee_id) * 100 - 14.0, 2)      AS gap_vs_benchmark,
    ROUND(AVG(monthly_salary), 0)                   AS avg_monthly_salary
FROM hr_data
GROUP BY department
ORDER BY attrition_rate_pct DESC;




SELECT
    department,
    job_role,
    COUNT(employee_id)                              AS total_in_role,
    SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END)
                                                    AS attrition_count,
    ROUND(
        SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END)
        / COUNT(employee_id) * 100, 2)              AS attrition_rate_pct,
    ROUND(AVG(monthly_salary), 0)                   AS avg_salary
FROM hr_data
GROUP BY department, job_role
ORDER BY department, attrition_rate_pct DESC;




SELECT
    CASE
        WHEN age BETWEEN 22 AND 25 THEN '22–25'
        WHEN age BETWEEN 26 AND 30 THEN '26–30'
        WHEN age BETWEEN 31 AND 35 THEN '31–35'
        WHEN age BETWEEN 36 AND 40 THEN '36–40'
        WHEN age BETWEEN 41 AND 50 THEN '41–50'
        ELSE '51+'
    END                                             AS age_band,
    COUNT(employee_id)                              AS total_employees,
    SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END)
                                                    AS attrition_count,
    ROUND(
        SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END)
        / COUNT(employee_id) * 100, 2)              AS attrition_rate_pct,
    ROUND(AVG(monthly_salary), 0)                   AS avg_salary
FROM hr_data
GROUP BY age_band
ORDER BY MIN(age);




SELECT
    gender,
    COUNT(employee_id)                              AS total_employees,
    SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END)
                                                    AS attrition_count,
    ROUND(
        SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END)
        / COUNT(employee_id) * 100, 2)              AS attrition_rate_pct,
    ROUND(AVG(monthly_salary), 0)                   AS avg_monthly_salary,
    ROUND(AVG(job_satisfaction), 2)                 AS avg_job_satisfaction
FROM hr_data
GROUP BY gender
ORDER BY attrition_rate_pct DESC;




SELECT
    marital_status,
    COUNT(employee_id)                              AS total_employees,
    SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END)
                                                    AS attrition_count,
    ROUND(
        SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END)
        / COUNT(employee_id) * 100, 2)              AS attrition_rate_pct,
    ROUND(AVG(monthly_salary), 0)                   AS avg_salary
FROM hr_data
GROUP BY marital_status
ORDER BY attrition_rate_pct DESC;




SELECT
    job_satisfaction,
    CASE job_satisfaction
        WHEN 1 THEN 'Low'
        WHEN 2 THEN 'Medium'
        WHEN 3 THEN 'High'
        WHEN 4 THEN 'Very High'
    END                                             AS satisfaction_label,
    COUNT(employee_id)                              AS total_employees,
    SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END)
                                                    AS attrition_count,
    ROUND(
        SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END)
        / COUNT(employee_id) * 100, 2)              AS attrition_rate_pct,
    ROUND(AVG(monthly_salary), 0)                   AS avg_salary
FROM hr_data
GROUP BY job_satisfaction, satisfaction_label
ORDER BY job_satisfaction;




SELECT
    CASE
        WHEN salary_hike_pct < 8   THEN 'Below 8%  (Low)'
        WHEN salary_hike_pct < 13  THEN '8–12%     (Average)'
        WHEN salary_hike_pct < 19  THEN '13–18%    (Good)'
        ELSE '19%+      (Excellent)'
    END                                             AS hike_band,
    COUNT(employee_id)                              AS total_employees,
    SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END)
                                                    AS attrition_count,
    ROUND(
        SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END)
        / COUNT(employee_id) * 100, 2)              AS attrition_rate_pct,
    ROUND(AVG(monthly_salary), 0)                   AS avg_monthly_salary
FROM hr_data
GROUP BY hike_band
ORDER BY MIN(salary_hike_pct);



SELECT
    department,
    ROUND(AVG(CASE WHEN attrition = 'Yes'
              THEN monthly_salary END), 0)          AS avg_salary_leavers,
    ROUND(AVG(CASE WHEN attrition = 'No'
              THEN monthly_salary END), 0)          AS avg_salary_stayers,
    ROUND(AVG(CASE WHEN attrition = 'No'
              THEN monthly_salary END)
        - AVG(CASE WHEN attrition = 'Yes'
              THEN monthly_salary END), 0)          AS salary_gap_inr,
    ROUND(
        (AVG(CASE WHEN attrition = 'No'  THEN monthly_salary END)
       - AVG(CASE WHEN attrition = 'Yes' THEN monthly_salary END))
        / AVG(CASE WHEN attrition = 'No' THEN monthly_salary END)
        * 100, 2)                                   AS gap_pct
FROM hr_data
GROUP BY department
ORDER BY gap_pct DESC;




SELECT
    CASE
        WHEN years_at_company <= 1  THEN '0–1 Year'
        WHEN years_at_company <= 2  THEN '1–2 Years'
        WHEN years_at_company <= 4  THEN '3–4 Years'
        WHEN years_at_company <= 7  THEN '5–7 Years'
        WHEN years_at_company <= 10 THEN '8–10 Years'
        ELSE '10+ Years'
    END                                             AS tenure_band,
    COUNT(employee_id)                              AS total_employees,
    SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END)
                                                    AS attrition_count,
    ROUND(
        SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END)
        / COUNT(employee_id) * 100, 2)              AS attrition_rate_pct,
    ROUND(AVG(monthly_salary), 0)                   AS avg_salary
FROM hr_data
GROUP BY tenure_band
ORDER BY MIN(years_at_company);



SELECT
    overtime,
    COUNT(employee_id)                              AS total_employees,
    SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END)
                                                    AS attrition_count,
    ROUND(
        SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END)
        / COUNT(employee_id) * 100, 2)              AS attrition_rate_pct,
    ROUND(AVG(job_satisfaction), 2)                 AS avg_job_satisfaction,
    ROUND(AVG(work_life_balance), 2)                AS avg_work_life_balance
FROM hr_data
GROUP BY overtime
ORDER BY attrition_rate_pct DESC;




SELECT
    business_travel,
    COUNT(employee_id)                              AS total_employees,
    SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END)
                                                    AS attrition_count,
    ROUND(
        SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END)
        / COUNT(employee_id) * 100, 2)              AS attrition_rate_pct,
    ROUND(AVG(work_life_balance), 2)                AS avg_work_life_balance,
    ROUND(AVG(monthly_salary), 0)                   AS avg_salary
FROM hr_data
GROUP BY business_travel
ORDER BY attrition_rate_pct DESC;



SELECT
    department,
    COUNT(employee_id)                              AS total_employees,
    SUM(CASE WHEN overtime = 'Yes' THEN 1 ELSE 0 END)
                                                    AS overtime_count,
    ROUND(
        SUM(CASE WHEN overtime = 'Yes' THEN 1 ELSE 0 END)
        / COUNT(employee_id) * 100, 2)              AS overtime_rate_pct,
    ROUND(
        SUM(CASE WHEN overtime = 'Yes' AND attrition = 'Yes'
            THEN 1 ELSE 0 END)
        / NULLIF(SUM(CASE WHEN overtime = 'Yes'
            THEN 1 ELSE 0 END), 0) * 100, 2)       AS attrition_rate_with_overtime
FROM hr_data
GROUP BY department
ORDER BY attrition_rate_with_overtime DESC;




SELECT
    employee_id,
    department,
    job_role,
    age,
    years_at_company,
    monthly_salary,
    job_satisfaction,
    work_life_balance,
    overtime,
    business_travel,
    salary_hike_pct,
    -- Risk score: count of red flag conditions
    (
        CASE WHEN overtime = 'Yes'              THEN 1 ELSE 0 END +
        CASE WHEN job_satisfaction <= 2         THEN 1 ELSE 0 END +
        CASE WHEN work_life_balance <= 2        THEN 1 ELSE 0 END +
        CASE WHEN years_at_company <= 2         THEN 1 ELSE 0 END +
        CASE WHEN business_travel='Frequently'  THEN 1 ELSE 0 END +
        CASE WHEN salary_hike_pct < 8           THEN 1 ELSE 0 END +
        CASE WHEN age < 30                      THEN 1 ELSE 0 END +
        CASE WHEN environment_satisfaction <= 2 THEN 1 ELSE 0 END
    )                                           AS risk_score,
    CASE
        WHEN (
            CASE WHEN overtime = 'Yes'              THEN 1 ELSE 0 END +
            CASE WHEN job_satisfaction <= 2         THEN 1 ELSE 0 END +
            CASE WHEN work_life_balance <= 2        THEN 1 ELSE 0 END +
            CASE WHEN years_at_company <= 2         THEN 1 ELSE 0 END +
            CASE WHEN business_travel='Frequently'  THEN 1 ELSE 0 END +
            CASE WHEN salary_hike_pct < 8           THEN 1 ELSE 0 END +
            CASE WHEN age < 30                      THEN 1 ELSE 0 END +
            CASE WHEN environment_satisfaction <= 2 THEN 1 ELSE 0 END
        ) >= 5 THEN 'HIGH RISK'
        WHEN (
            CASE WHEN overtime = 'Yes'              THEN 1 ELSE 0 END +
            CASE WHEN job_satisfaction <= 2         THEN 1 ELSE 0 END +
            CASE WHEN work_life_balance <= 2        THEN 1 ELSE 0 END +
            CASE WHEN years_at_company <= 2         THEN 1 ELSE 0 END +
            CASE WHEN business_travel='Frequently'  THEN 1 ELSE 0 END +
            CASE WHEN salary_hike_pct < 8           THEN 1 ELSE 0 END +
            CASE WHEN age < 30                      THEN 1 ELSE 0 END +
            CASE WHEN environment_satisfaction <= 2 THEN 1 ELSE 0 END
        ) >= 3 THEN 'MEDIUM RISK'
        ELSE 'LOW RISK'
    END                                         AS risk_level
FROM hr_data
WHERE attrition = 'No'
ORDER BY risk_score DESC
LIMIT 30;


SELECT
    risk_level,
    COUNT(*)                                        AS employee_count,
    ROUND(COUNT(*) / SUM(COUNT(*)) OVER () * 100, 2)
                                                    AS pct_of_active,
    ROUND(COUNT(*) * 400000 / 10000000, 2)         AS potential_cost_if_all_leave_cr
FROM (
    SELECT
        CASE
            WHEN (
                CASE WHEN overtime = 'Yes'              THEN 1 ELSE 0 END +
                CASE WHEN job_satisfaction <= 2         THEN 1 ELSE 0 END +
                CASE WHEN work_life_balance <= 2        THEN 1 ELSE 0 END +
                CASE WHEN years_at_company <= 2         THEN 1 ELSE 0 END +
                CASE WHEN business_travel='Frequently'  THEN 1 ELSE 0 END +
                CASE WHEN salary_hike_pct < 8           THEN 1 ELSE 0 END +
                CASE WHEN age < 30                      THEN 1 ELSE 0 END +
                CASE WHEN environment_satisfaction <= 2 THEN 1 ELSE 0 END
            ) >= 5 THEN 'HIGH RISK'
            WHEN (
                CASE WHEN overtime = 'Yes'              THEN 1 ELSE 0 END +
                CASE WHEN job_satisfaction <= 2         THEN 1 ELSE 0 END +
                CASE WHEN work_life_balance <= 2        THEN 1 ELSE 0 END +
                CASE WHEN years_at_company <= 2         THEN 1 ELSE 0 END +
                CASE WHEN business_travel='Frequently'  THEN 1 ELSE 0 END +
                CASE WHEN salary_hike_pct < 8           THEN 1 ELSE 0 END +
                CASE WHEN age < 30                      THEN 1 ELSE 0 END +
                CASE WHEN environment_satisfaction <= 2 THEN 1 ELSE 0 END
            ) >= 3 THEN 'MEDIUM RISK'
            ELSE 'LOW RISK'
        END AS risk_level
    FROM hr_data
    WHERE attrition = 'No'
) risk_table
GROUP BY risk_level
ORDER BY
    CASE risk_level
        WHEN 'HIGH RISK'   THEN 1
        WHEN 'MEDIUM RISK' THEN 2
        ELSE 3
    END;



SELECT
    -- Overall
    COUNT(employee_id)                              AS total_employees,
    ROUND(
        SUM(CASE WHEN attrition='Yes' THEN 1 ELSE 0 END)
        / COUNT(employee_id) * 100, 2)              AS overall_attrition_pct,

    -- Financial
    ROUND(
        SUM(CASE WHEN attrition='Yes' THEN 1 ELSE 0 END)
        * 400000 / 10000000, 2)                     AS replacement_cost_crore,

    -- Overtime impact
    ROUND(
        SUM(CASE WHEN overtime='Yes' AND attrition='Yes' THEN 1 ELSE 0 END)
        / NULLIF(SUM(CASE WHEN overtime='Yes' THEN 1 ELSE 0 END),0)
        * 100, 2)                                   AS attrition_rate_overtime_employees,

    ROUND(
        SUM(CASE WHEN overtime='No' AND attrition='Yes' THEN 1 ELSE 0 END)
        / NULLIF(SUM(CASE WHEN overtime='No' THEN 1 ELSE 0 END),0)
        * 100, 2)                                   AS attrition_rate_no_overtime,

    -- Satisfaction impact
    ROUND(
        SUM(CASE WHEN job_satisfaction<=2 AND attrition='Yes' THEN 1 ELSE 0 END)
        / NULLIF(SUM(CASE WHEN job_satisfaction<=2 THEN 1 ELSE 0 END),0)
        * 100, 2)                                   AS attrition_low_satisfaction,

    ROUND(
        SUM(CASE WHEN job_satisfaction>=3 AND attrition='Yes' THEN 1 ELSE 0 END)
        / NULLIF(SUM(CASE WHEN job_satisfaction>=3 THEN 1 ELSE 0 END),0)
        * 100, 2)                                   AS attrition_high_satisfaction,

    -- Tenure danger zone
    ROUND(
        SUM(CASE WHEN years_at_company<=2 AND attrition='Yes' THEN 1 ELSE 0 END)
        / NULLIF(SUM(CASE WHEN years_at_company<=2 THEN 1 ELSE 0 END),0)
        * 100, 2)                                   AS attrition_rate_0_to_2_years

FROM hr_data;
