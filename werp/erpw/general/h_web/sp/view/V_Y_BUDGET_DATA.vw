CREATE OR REPLACE FORCE VIEW V_Y_BUDGET_DATA
(DEPT_CODE, AMT_APT, AMT_ETC)
AS 
SELECT MAX(dept_code) dept_code,SUM(DECODE(division,'01',amt,0))amt_apt,SUM(DECODE(division,'04',amt,0))amt_etc
FROM Y_BUDGET_PARENT
WHERE invest_class = 'Y'
GROUP BY dept_code;



