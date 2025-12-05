-- Preview all records in the table
SELECT *
FROM ibrd_statement_of_loans_and_guarantees_3;

-- Identify duplicate records using key loan fields
SELECT id, row_num
FROM(
SELECT id, ROW_NUMBER() OVER(PARTITION BY Loan_Number, Region, `Country/Economy`, Loan_Type, Interest_Rate, Project_ID, 
Project_Name, First_Repayment_Date,Last_Repayment_Date) as row_num
FROM ibrd_statement_of_loans_and_guarantees.ibrd_statement_of_loans_and_guarantees_3
) as rownum
WHERE row_num > 1;

-- Check unique region values
SELECT DISTINCT REGION
FROM ibrd_statement_of_loans_and_guarantees.ibrd_statement_of_loans_and_guarantees_3;

-- Check unique country codes
SELECT DISTINCT `Country/Economy_Code`
FROM ibrd_statement_of_loans_and_guarantees.ibrd_statement_of_loans_and_guarantees_3;

-- Rename country code column
ALTER TABLE ibrd_statement_of_loans_and_guarantees.ibrd_statement_of_loans_and_guarantees_3
RENAME COLUMN `Country/Economy_Code` TO Country_Code;

-- Preview table after renaming column
SELECT * 
FROM ibrd_statement_of_loans_and_guarantees.ibrd_statement_of_loans_and_guarantees_3;

-- Check unique country names
SELECT DISTINCT `Country/Economy`
FROM ibrd_statement_of_loans_and_guarantees.ibrd_statement_of_loans_and_guarantees_3;

-- Rename country column
ALTER TABLE ibrd_statement_of_loans_and_guarantees.ibrd_statement_of_loans_and_guarantees_3
RENAME COLUMN `Country/Economy` TO Country;

-- Preview updated country column
SELECT *FROM ibrd_statement_of_loans_and_guarantees.ibrd_statement_of_loans_and_guarantees_3;

-- Check borrower names
SELECT DISTINCT `Borrower` 
FROM ibrd_statement_of_loans_and_guarantees.ibrd_statement_of_loans_and_guarantees_3;

-- Preview all records again
SELECT *
FROM ibrd_statement_of_loans_and_guarantees.ibrd_statement_of_loans_and_guarantees_3;

-- Check guarantor country codes
SELECT DISTINCT `Guarantor_Country/Economy_Code`
FROM ibrd_statement_of_loans_and_guarantees.ibrd_statement_of_loans_and_guarantees_3;

-- Rename guarantor country code column
ALTER TABLE ibrd_statement_of_loans_and_guarantees.ibrd_statement_of_loans_and_guarantees_3
RENAME COLUMN `Guarantor_Country/Economy_Code` TO Guarantor_Country_Code;

-- Preview table after renaming guarantor code
SELECT * FROM ibrd_statement_of_loans_and_guarantees.ibrd_statement_of_loans_and_guarantees_3;

-- Check guarantor names
SELECT DISTINCT `Guarantor`
FROM ibrd_statement_of_loans_and_guarantees.ibrd_statement_of_loans_and_guarantees_3;

-- Recheck country values
SELECT DISTINCT `Country`
FROM ibrd_statement_of_loans_and_guarantees.ibrd_statement_of_loans_and_guarantees_3;

-- Standardize Egypt country name
Update ibrd_statement_of_loans_and_guarantees.ibrd_statement_of_loans_and_guarantees_3
SET Country = 'Egypt' WHERE country = 'Egypt, Arab Republic of';

-- Verify updated country values
SELECT DISTINCT `Country` 
FROM ibrd_statement_of_loans_and_guarantees.ibrd_statement_of_loans_and_guarantees_3;

-- Standardize Egypt guarantor name
Update ibrd_statement_of_loans_and_guarantees.ibrd_statement_of_loans_and_guarantees_3
SET Guarantor = 'Egypt' WHERE Guarantor = 'Egypt, Arab Republic of';

-- Preview records after guarantor update
SELECT * 
FROM ibrd_statement_of_loans_and_guarantees.ibrd_statement_of_loans_and_guarantees_3;

-- Check loan type values
SELECT DISTINCT `Loan_Type`
FROM ibrd_statement_of_loans_and_guarantees.ibrd_statement_of_loans_and_guarantees_3;

-- Check loan status values
SELECT DISTINCT `Loan_Status`
FROM ibrd_statement_of_loans_and_guarantees.ibrd_statement_of_loans_and_guarantees_3;

-- Fix inconsistent loan status formatting
Update ibrd_statement_of_loans_and_guarantees.ibrd_statement_of_loans_and_guarantees_3
set Loan_Status = 'Disbursing & Repaying' WHERE Loan_Status = 'Disbursing&Repaying';

-- Verify updated loan status values
SELECT DISTINCT `Loan_Status`
FROM ibrd_statement_of_loans_and_guarantees.ibrd_statement_of_loans_and_guarantees_3;

-- Check undisbursed amount values
SELECT DISTINCT `Undisbursed_Amount_`
FROM ibrd_statement_of_loans_and_guarantees.ibrd_statement_of_loans_and_guarantees_3;

-- Check Due to IBRD values
SELECT DISTINCT `Due_to_IBRD_`
FROM ibrd_statement_of_loans_and_guarantees.ibrd_statement_of_loans_and_guarantees_3;

-- Validate key date columns
SELECT DISTINCT `Due_to_IBRD_` First_Repayment_Date, Last_Repayment_Date,
 Agreement_Signing_Date, Board_Approval_Date,Closed_Date_(Most_Recent), Last_Disbursement_Date
 FROM ibrd_statement_of_loans_and_guarantees.ibrd_statement_of_loans_and_guarantees_3;

-- Recheck date columns with cleaner syntax
SELECT DISTINCT `Due_to_IBRD_`First_Repayment_Date, Last_Repayment_Date, Agreement_Signing_Date, 
Board_Approval_Date, `Closed_Date_(Most_Recent)`, Last_Disbursement_Date
FROM ibrd_statement_of_loans_and_guarantees.ibrd_statement_of_loans_and_guarantees_3;

-- Check currency column for missing data
SELECT Currency_of_Commitment
FROM ibrd_statement_of_loans_and_guarantees.ibrd_statement_of_loans_and_guarantees_3;

-- Drop empty currency column
ALTER TABLE ibrd_statement_of_loans_and_guarantees_3
DROP COLUMN Currency_of_Commitment;

-- Drop unnecessary ID column
ALTER TABLE ibrd_statement_of_loans_and_guarantees_3
DROP COLUMN id;

-- Check for missing project IDs
SELECT id, Project_ID
FROM ibrd_statement_of_loans_and_guarantees.ibrd_statement_of_loans_and_guarantees_3
WHERE Project_ID = '';

-- Check for missing last disbursement dates
SELECT Project_ID, Last_Disbursement_Date
FROM ibrd_statement_of_loans_and_guarantees.ibrd_statement_of_loans_and_guarantees_3
WHERE Last_Disbursement_Date = '';

-- Final review of cleaned dataset
SELECT *
FROM ibrd_statement_of_loans_and_guarantees_3;

