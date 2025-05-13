-- 1. MSME Applicants
CREATE TABLE MSME_Applicants (
    applicant_id INT PRIMARY KEY AUTO_INCREMENT,
    business_name VARCHAR(100),
    owner_name VARCHAR(100),
    registration_no VARCHAR(50) UNIQUE,
    industry_type VARCHAR(50),
    contact_email VARCHAR(100),
    contact_number VARCHAR(20),
    address TEXT
);

-- 2. Financial Statements
CREATE TABLE Financial_Statements (
    finance_id INT PRIMARY KEY AUTO_INCREMENT,
    applicant_id INT,
    year YEAR,
    annual_revenue DECIMAL(15, 2),
    annual_expenses DECIMAL(15, 2),
    net_profit DECIMAL(15, 2),
    FOREIGN KEY (applicant_id) REFERENCES MSME_Applicants(applicant_id)
);

-- 3. Credit History
CREATE TABLE Credit_History (
    credit_id INT PRIMARY KEY AUTO_INCREMENT,
    applicant_id INT,
    loan_amount DECIMAL(15, 2),
    defaulted BOOLEAN,
    years_since_last_loan INT,
    FOREIGN KEY (applicant_id) REFERENCES MSME_Applicants(applicant_id)
);

-- 4. Loan Applications
CREATE TABLE Loan_Applications (
    application_id INT PRIMARY KEY AUTO_INCREMENT,
    applicant_id INT,
    application_date DATE,
    loan_amount_requested DECIMAL(15, 2),
    loan_purpose VARCHAR(255),
    FOREIGN KEY (applicant_id) REFERENCES MSME_Applicants(applicant_id)
);

-- 5. Loan Evaluation
CREATE TABLE Loan_Evaluation (
    evaluation_id INT PRIMARY KEY AUTO_INCREMENT,
    application_id INT,
    risk_score INT CHECK (risk_score BETWEEN 0 AND 100),
    status ENUM('Approved', 'Rejected', 'Under Review'),
    remarks TEXT,
    FOREIGN KEY (application_id) REFERENCES Loan_Applications(application_id)
);

-- 6. Review Logs
CREATE TABLE Review_Logs (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    application_id INT,
    reviewed_by VARCHAR(100),
    review_date DATE,
    decision_notes TEXT,
    FOREIGN KEY (application_id) REFERENCES Loan_Applications(application_id)
);

-- Sample data (Optional for testing)

INSERT INTO MSME_Applicants (business_name, owner_name, registration_no, industry_type, contact_email, contact_number, address)
VALUES
('TechGrow Pvt Ltd', 'Ravi Kumar', 'MSME12345', 'IT Services', 'ravi@techgrow.com', '9876543210', 'Delhi, India'),
('GreenLeaf Organics', 'Anita Mehra', 'MSME67890', 'Agriculture', 'anita@greenleaf.com', '9123456789', 'Punjab, India');

INSERT INTO Financial_Statements (applicant_id, year, annual_revenue, annual_expenses, net_profit)
VALUES
(1, 2023, 12000000, 8000000, 4000000),
(2, 2023, 6000000, 4500000, 1500000);

INSERT INTO Credit_History (applicant_id, loan_amount, defaulted, years_since_last_loan)
VALUES
(1, 5000000, FALSE, 2),
(2, 3000000, TRUE, 3);

INSERT INTO Loan_Applications (applicant_id, application_date, loan_amount_requested, loan_purpose)
VALUES
(1, '2025-05-01', 7000000, 'Expansion of cloud infrastructure'),
(2, '2025-05-03', 4000000, 'New greenhouse facility');

INSERT INTO Loan_Evaluation (application_id, risk_score, status, remarks)
VALUES
(1, 25, 'Approved', 'Strong financials, low risk'),
(2, 70, 'Under Review', 'Previous default, moderate risk');

INSERT INTO Review_Logs (application_id, reviewed_by, review_date, decision_notes)
VALUES
(1, 'Credit Analyst - Neha Sharma', '2025-05-05', 'Approved with conditions'),
(2, 'Credit Analyst - Mohit Jain', '2025-05-06', 'Needs further assessment');
