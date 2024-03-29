CREATE OR REPLACE TRIGGER "ERPW".tg_h_sale_income
	BEFORE INSERT OR UPDATE OR DELETE ON h_sale_income
		FOR EACH ROW
DECLARE
	errnum   CHAR(6):= '-20999';
BEGIN
	IF inserting THEN
		insert into h_log_sale_income
			  values (:new.dept_code,:new.sell_code,:new.dongho,:new.seq,:new.degree_code,:new.degree_seq,
						 sysdate,h_spec_unq_no.nextval,'I',:new.receipt_date,:new.receipt_code,:new.deposit_no,:new.r_amt,:new.r_land_amt,
						 :new.r_build_amt,:new.r_vat_amt,:new.delay_days,:new.delay_amt,:new.discount_days,:new.discount_amt,
						 :new.input_id,:new.work_date,:new.work_no,:new.tax_date,:new.tax_no);
	END IF;
	IF updating THEN
		insert into h_log_sale_income
			  values (:new.dept_code,:new.sell_code,:new.dongho,:new.seq,:new.degree_code,:new.degree_seq,
						 sysdate,h_spec_unq_no.nextval,'U',:new.receipt_date,:new.receipt_code,:new.deposit_no,:new.r_amt,:new.r_land_amt,
						 :new.r_build_amt,:new.r_vat_amt,:new.delay_days,:new.delay_amt,:new.discount_days,:new.discount_amt,
						 :new.input_id,:new.work_date,:new.work_no,:new.tax_date,:new.tax_no);
	END IF;
	IF deleting THEN
		insert into h_log_sale_income
			  values (:old.dept_code,:old.sell_code,:old.dongho,:old.seq,:old.degree_code,:old.degree_seq,
						 sysdate,h_spec_unq_no.nextval,'D',:old.receipt_date,:old.receipt_code,:old.deposit_no,:old.r_amt,:old.r_land_amt,
						 :old.r_build_amt,:old.r_vat_amt,:old.delay_days,:old.delay_amt,:old.discount_days,:old.discount_amt,
						 :old.input_id,:old.work_date,:old.work_no,:old.tax_date,:old.tax_no);
	END IF;
END tg_h_sale_income ;
/

