update y_chg_degree set approve_class = '1' 
    where dept_code = 'A05283'
      AND CHG_NO_SEQ = 1;
COMMIT;
UPDATE Y_CHG_BUDGET_DETAIL SET APPROVE_YN = 'N'
    where dept_code = 'A05283'
      AND CHG_NO_SEQ = 1;
COMMIT;