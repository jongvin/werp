CREATE OR REPLACE FORCE VIEW VIEW_R_A_CASH_DEGREE
(PROJ_UNQ_KEY, CHG_NO_SEQ)
AS 
SELECT a.proj_unq_key,                   a.chg_no_seq            from (select proj_unq_key,chg_no_seq,                        RANK() OVER                       (PARTITION by a.proj_unq_key                       ORDER BY a.proj_unq_key desc, a.chg_no_seq desc ) rk_1                   from r_a_cash_degree a) a             where a.rk_1 = 1;



