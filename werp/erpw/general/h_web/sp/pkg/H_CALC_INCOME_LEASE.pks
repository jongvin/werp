CREATE OR REPLACE package h_calc_income_lease is
PROCEDURE y_sp_h_lease_calc(as_dept_code              IN   VARCHAR2,
															  as_sell_code              IN   VARCHAR2,
															  as_dongho                 IN   VARCHAR2,
															  as_seq                    IN   INTEGER,
                                               as_input_date             IN   DATE,
															  as_daily_seq              IN   INTEGER,
                                               as_input_amt              IN   NUMBER,
															  as_input_deposit          IN   VARCHAR2,
															  as_user                   IN   VARCHAR2 );
PROCEDURE y_sp_h_lease_cmpt(as_dept_code              IN   VARCHAR2,
															  as_sell_code              IN   VARCHAR2,
															  as_dongho                 IN   VARCHAR2,
															  as_seq                    IN   INTEGER,
                                               as_input_date             IN   DATE,
                                               as_input_amt              IN   NUMBER,
															  as_input_deposit          IN   VARCHAR2,
															  as_user                   IN   VARCHAR2);
PROCEDURE y_sp_h_delete_daily_lease(as_dept_code    IN   VARCHAR2,
	                                                    as_sell_code    IN   VARCHAR2,
	                                                    as_dongho       IN   VARCHAR2,
	                                                    as_seq          IN   INTEGER,
																		 as_receipt_date IN   DATE,
																		 as_daily_seq    IN   INTEGER,
																		 as_recalc_tag   IN   integer);
PROCEDURE y_sp_h_delay_recalc_lease(as_dept_code    IN   VARCHAR2,
                                                as_sell_code    IN   VARCHAR2,
                                                as_dongho       IN   VARCHAR2,
                                                as_seq          IN   INTEGER,
																as_degree_code  IN   VARCHAR2,
																as_degree_seq   IN   INTEGER,
																as_receipt_date IN   DATE,
																as_daily_seq    IN   INTEGER,
																as_delay_amt    IN   NUMBER,
																as_discount_amt IN   NUMBER);
end;
/

