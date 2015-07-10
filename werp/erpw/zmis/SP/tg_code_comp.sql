/* ========================================================================= */
/* 시스템 : 공통관리                                                         */
/* 함수명 : tg_code_comp(사업장코드입력,수정,삭제)                           */
/* 기  능 : ERPC에서 사업장코드(sm_code_company) 등록 및 수정시              */
/* 	    : erpw의 사업장코드(z_code_comp)로 반영한다                      */
/* ===========================[ 변   경   이   력 ]========================= */
/*      작 성 자    소     속             작 성 일      비         고        */
/*   ------------  -------------------  ------------  ---------------------- */
/*   1. 김동우                           2003.12.05       최초작성           */
/* ========================================================================= */

CREATE or REPLACE	TRIGGER tg_code_comp
	BEFORE INSERT OR UPDATE OR DELETE ON erpc.sm_code_company
		FOR EACH ROW

DECLARE
   C_CNT    NUMBER(20,5);
   C_QTY    NUMBER(20,5);
   C_AMT    NUMBER(20,5);
	errnum   CHAR(6):= '-20999';

BEGIN
	IF inserting THEN
		select count(*)
		  into C_CNT
		  from z_code_comp
		 where comp_code = :new.company_code;

		IF C_CNT < 1 THEN
			insert into z_code_comp
				  values (substrb(:new.company_code,1,2),:new.company_name,'');
		END IF;
	END IF;

	IF updating THEN
		IF :old.company_code <> :new.company_code OR :old.company_name <> :new.company_name THEN
			select count(*)
			  into C_CNT
			  from z_code_comp
			 where comp_code = :old.company_code;

			IF C_CNT > 0 THEN
				update z_code_comp
					set comp_code = :new.company_code,
						 comp_name = :new.company_name
				 where comp_code = :old.company_code;
			END IF;
		END IF;
	END IF;
			
	IF deleting THEN
		select count(*)
		  into C_CNT
		  from z_code_comp
		 where comp_code = :old.company_code;

		IF C_CNT > 0 THEN
			delete from z_code_comp
			 	   where comp_code = :old.company_code;
		END IF;
	END IF;
             
END tg_code_comp ;
/
