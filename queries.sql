-- 1. List all applicants with their latest loan application and evaluation status
SELECT 
    a.business_name,
    l.application_date,
    l.loan_amount_requested,
    e.status AS evaluation_status,
    e.risk_score
FROM MSME_Applicants a
JOIN Loan_Applications l ON a.applicant_id = l.applicant_id
LEFT JOIN Loan_Evaluation e ON l.application_id = e.application_id
ORDER BY l.application_date DESC;

-- 2. Find the top 5 highest risk applicants (risk_score descending)
SELECT 
    a.business_name,
    e.risk_score,
    e.status
FROM Loan_Evaluation e
JOIN Loan_Applications l ON e.application_id = l.application_id
JOIN MSME_Applicants a ON l.applicant_id = a.applicant_id
ORDER BY e.risk_score DESC
LIMIT 5;

-- 3. Count of approved vs rejected vs under review applications
SELECT 
    status,
    COUNT(*) AS total
FROM Loan_Evaluation
GROUP BY status;

-- 4. Average net profit by industry type
SELECT 
    a.industry_type,
    AVG(f.net_profit) AS avg_net_profit
FROM MSME_Applicants a
JOIN Financial_Statements f ON a.applicant_id = f.applicant_id
GROUP BY a.industry_type;

-- 5. Applicants who previously defaulted on loans
SELECT 
    a.business_name,
    c.loan_amount,
    c.years_since_last_loan
FROM MSME_Applicants a
JOIN Credit_History c ON a.applicant_id = c.applicant_id
WHERE c.defaulted = TRUE;

-- 6. Applications currently under review
SELECT 
    a.business_name,
    l.application_date,
    e.risk_score
FROM MSME_Applicants a
JOIN Loan_Applications l ON a.applicant_id = l.applicant_id
JOIN Loan_Evaluation e ON l.application_id = e.application_id
WHERE e.status = 'Under Review';

-- 7. Show recent review logs with notes
SELECT 
    a.business_name,
    r.reviewed_by,
    r.review_date,
    r.decision_notes
FROM MSME_Applicants a
JOIN Loan_Applications l ON a.applicant_id = l.applicant_id
JOIN Review_Logs r ON l.application_id = r.application_id
ORDER BY r.review_date DESC;
