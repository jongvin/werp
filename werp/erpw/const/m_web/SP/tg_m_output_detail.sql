/* ========================================================================= */
/* 시스템 : 자재관리                                                         */
/* 함수명 : tg_m_output_detail(자재출고세부입력,수정,삭제)                   */
/* 기  능 : 자재출고세부내역입력시 현장별재고테이블를 수정함                 */
/* ===========================[ 변   경   이   력 ]========================= */
/*      작 성 자    소     속             작 성 일      비         고        */
/*   ------------  -------------------  ------------  ---------------------- */
/*   1. 김동우                           2003.05.15       최초작성           */
/* ========================================================================= */

CREATE or REPLACE	TRIGGER tg_m_output_detail
	BEFORE INSERT OR UPDATE OR DELETE ON m_output_detail
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
		  from m_currstock
		 where dept_code = :new.dept_code
			and mtrcode   = :new.mtrcode
			and ditag     = :new.ditag;

		IF C_CNT > 0 THEN
			update m_currstock
				set qty = qty - :new.qty,
					 amt = amt - :new.amt
			 where dept_code = :new.dept_code
				and mtrcode   = :new.mtrcode
				and ditag     = :new.ditag;

			select nvl(qty,0),nvl(amt,0)
			  into C_QTY,C_AMT
			  from m_currstock
			 where dept_code = :new.dept_code
				and mtrcode   = :new.mtrcode
				and ditag     = :new.ditag;
	
			IF C_QTY = 0 THEN
				delete from m_currstock
						where dept_code = :new.dept_code
						  and mtrcode   = :new.mtrcode
						  and ditag     = :new.ditag;
			END IF;
		END IF;
	END IF;

	IF updating THEN
		select count(*)
		  into C_CNT
		  from m_currstock
		 where dept_code = :old.dept_code
			and mtrcode   = :old.mtrcode
			and ditag     = :old.ditag;
		IF C_CNT > 0 THEN
			update m_currstock
				set qty = qty + :old.qty - :new.qty,
					 amt = amt + :old.amt - :new.amt
			 where dept_code = :old.dept_code
				and mtrcode   = :old.mtrcode
				and ditag     = :old.ditag;
		ELSE
			insert into m_currstock
				  values (:new.dept_code,:new.mtrcode,:new.ditag,:new.name,:new.ssize,:new.unitcode,
							 :old.qty - :new.qty,:old.amt - :new.amt,0);
		END IF;

		select nvl(qty,0),nvl(amt,0)
		  into C_QTY,C_AMT
		  from m_currstock
		 where dept_code = :new.dept_code
			and mtrcode   = :new.mtrcode
			and ditag     = :new.ditag;

		IF C_QTY = 0 THEN
			delete from m_currstock
					where dept_code = :new.dept_code
					  and mtrcode   = :new.mtrcode
					  and ditag     = :new.ditag;
		END IF;
	END IF;
			
	IF deleting THEN
		IF :old.deliverytag = 1 THEN
			select count(*)
			  into C_CNT
			  from m_input_detail
			 where dept_code = :old.dept_code
				and input_unq_num = :old.input_unq_num;
			IF C_CNT > 0 THEN
				update m_input_detail
					set deliverytag = 0
				 where dept_code = :old.dept_code
					and input_unq_num = :old.input_unq_num;
			END IF;
		END IF;

		select count(*)
		  into C_CNT
		  from m_currstock
		 where dept_code = :old.dept_code
			and mtrcode   = :old.mtrcode
			and ditag     = :old.ditag;
		IF C_CNT > 0 THEN
			update m_currstock
				set qty = qty + :old.qty,
					 amt = amt + :old.amt
			 where dept_code = :old.dept_code
				and mtrcode   = :old.mtrcode
				and ditag     = :old.ditag;
		ELSE
			insert into m_currstock
				  values (:old.dept_code,:old.mtrcode,:old.ditag,:old.name,:old.ssize,:old.unitcode,
							 :old.qty,:old.amt,0);
		END IF;
	END IF;
             
END tg_m_output_detail ;
/
