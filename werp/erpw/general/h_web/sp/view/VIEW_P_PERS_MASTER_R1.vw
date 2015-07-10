CREATE OR REPLACE FORCE VIEW VIEW_P_PERS_MASTER_R1
(EMP_NO, EMP_NAME)
AS 
SELECT p_pers_master.emp_no, p_pers_master.emp_name FROM p_pers_master;



