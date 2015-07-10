CREATE OR REPLACE TRIGGER "ERPW".tg_h_lease_cont_dongho
	BEFORE INSERT OR UPDATE OR DELETE ON h_lease_cont_dongho
		FOR EACH ROW
DECLARE
	errnum   CHAR(6):= '-20999';
BEGIN
	IF inserting THEN
	   update h_sale_master
		   set contract_yn = 'Y'
		 where dept_code = :new.dept_code
		   and sell_code = :new.sell_code
			and dongho    = :new.dongho
			and seq       = :new.seq;
	END IF;
	IF updating THEN
		update h_sale_master
		   set contract_yn = 'N'
		 where dept_code = :old.dept_code
		   and sell_code = :old.sell_code
			and dongho    = :old.dongho
			and seq       = :old.seq;
		update h_sale_master
		   set contract_yn = 'Y'
		 where dept_code = :new.dept_code
		   and sell_code = :new.sell_code
			and dongho    = :new.dongho
			and seq       = :new.seq;
	END IF;
	IF deleting THEN
		update h_sale_master
		   set contract_yn = 'N'
		 where dept_code = :old.dept_code
		   and sell_code = :old.sell_code
			and dongho    = :old.dongho
			and seq       = :old.seq;
	END IF;
END tg_h_lease_cont_dongho ;
/

