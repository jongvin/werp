CREATE OR REPLACE package h_calc_income_grt is
PROCEDURE y_sp_h_grt_calc(as_dept_code              IN   VARCHAR2,
															  as_sell_code              IN   VARCHAR2,
															  as_cont_date                 IN   date,
															  as_cont_seq                    IN   INTEGER,
                                               as_input_date             IN   DATE,
															  as_daily_seq              IN   INTEGER,
                                               as_input_amt              IN   NUMBER,
															  as_input_deposit          IN   VARCHAR2,
															  as_user                   IN   VARCHAR2 );
PROCEDURE y_sp_h_grt_cmpt(as_dept_code              IN   VARCHAR2,
															  as_sell_code              IN   VARCHAR2,
															  as_cont_date                 IN   date,
															  as_cont_seq                    IN   INTEGER,
                                               as_input_date             IN   DATE,
                                               as_input_amt              IN   NUMBER,
															  as_input_deposit          IN   VARCHAR2,
															  as_user                   IN   VARCHAR2);
PROCEDURE y_sp_h_delete_daily_grt(as_dept_code    IN   VARCHAR2,
	                                                    as_sell_code    IN   VARCHAR2,
	                                                    as_cont_date       IN   date,
	                                                    as_cont_seq          IN   INTEGER,
																		 as_receipt_date IN   DATE,
																		 as_daily_seq    IN   INTEGER,
																		 as_recalc_tag   IN   integer);
PROCEDURE y_sp_h_delay_recalc_grt(as_dept_code    IN   VARCHAR2,
                                                as_sell_code    IN   VARCHAR2,
                                                as_cont_date       IN   date,
                                                as_cont_seq          IN   INTEGER,
																as_degree_code  IN   VARCHAR2,
																as_degree_seq   IN   INTEGER,
																as_receipt_date IN   DATE,
																as_daily_seq    IN   INTEGER,
																as_delay_amt    IN   NUMBER,
																as_discount_amt IN   NUMBER);
end;
/

