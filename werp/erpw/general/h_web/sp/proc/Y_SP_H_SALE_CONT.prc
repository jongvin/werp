CREATE OR REPLACE PROCEDURE y_sp_h_sale_cont (
   as_dept_code   IN       VARCHAR2,
   as_sell_code   IN       VARCHAR2,
   as_workdate    IN       VARCHAR2,
   rec_master     OUT      H_SALE_MASTER%ROWTYPE
)
IS
BEGIN
   SELECT dongho, seq, pyong,
          cust_code, contract_code,
          contract_date, chg_div,
          last_contract_date
     INTO rec_master.dongho, rec_master.seq, rec_master.pyong,
          rec_master.cust_code, rec_master.contract_code,
          rec_master.contract_date, rec_master.chg_div,
          rec_master.last_contract_date
     FROM H_SALE_MASTER
    WHERE dept_code = as_dept_code
      AND sell_code = as_sell_code
      AND last_contract_date <= as_workdate
      AND chg_date > as_workdate;
EXCEPTION
   WHEN OTHERS
   THEN
      RAISE;
END y_sp_h_sale_cont;
/

