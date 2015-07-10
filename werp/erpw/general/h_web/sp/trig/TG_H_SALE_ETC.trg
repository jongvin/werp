CREATE OR REPLACE TRIGGER "ERPW".tg_h_sale_etc
	BEFORE INSERT OR UPDATE OR DELETE ON h_sale_etc
		FOR EACH ROW
DECLARE
	errnum   CHAR(6):= '-20999';
BEGIN
	IF inserting THEN
		insert into h_log_sale_etc
			  values (:new.dept_code,:new.sell_code,:new.dongho,:new.seq,:new.unique_div,:new.effect_no,
						 sysdate,h_spec_unq_no.nextval,'I',:new.delivery_date,:new.creditor,:new.bond_amt,:new.cancel_yn,:new.cancel_date,
						 :new.remark,:new.cancel_desc,:new.input_id);
	END IF;
	IF updating THEN
		insert into h_log_sale_etc
			  values (:new.dept_code,:new.sell_code,:new.dongho,:new.seq,:new.unique_div,:new.effect_no,
						 sysdate,h_spec_unq_no.nextval,'U',:new.delivery_date,:new.creditor,:new.bond_amt,:new.cancel_yn,:new.cancel_date,
						 :new.remark,:new.cancel_desc,:new.input_id);
	END IF;
	IF deleting THEN
		insert into h_log_sale_etc
			  values (:old.dept_code,:old.sell_code,:old.dongho,:old.seq,:old.unique_div,:old.effect_no,
						 sysdate,h_spec_unq_no.nextval,'D',:old.delivery_date,:old.creditor,:old.bond_amt,:old.cancel_yn,:old.cancel_date,
						 :old.remark,:old.cancel_desc,:old.input_id);
	END IF;
END tg_h_sale_etc ;
/

