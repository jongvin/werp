/* ========================================================================= */
/* 시스템 : 자재관리                                                         */
/* 함수명 : tg_m_input_detail(자재입고세부입력,수정,삭제)                    */
/* 기  능 : 자재입고세부내역입력시 품의세부의 미입고수량을 고침              */
/* 	    : 자재입고세부내역입력시 현장별재고테이블를 수정함                 */
/* ===========================[ 변   경   이   력 ]========================= */
/*      작 성 자    소     속             작 성 일      비         고        */
/*   ------------  -------------------  ------------  ---------------------- */
/*   1. 김동우                           2003.05.14       최초작성           */
/* ========================================================================= */

CREATE or REPLACE	TRIGGER tg_m_input_detail
	BEFORE INSERT OR UPDATE OR DELETE ON m_input_detail
		FOR EACH ROW

DECLARE
   C_CNT    NUMBER(20,5);
   C_QTY    NUMBER(20,5);
   C_AMT    NUMBER(20,5);
	errnum   CHAR(6):= '-20999';

BEGIN
	IF inserting THEN
		IF :new.approval_unq_num <> 0 THEN
			select count(*)
			  into C_CNT
			  from m_approval_detail
			 where dept_code = :new.dept_code
				and approval_unq_num = :new.approval_unq_num;

			IF C_CNT > 0 THEN
				update m_approval_detail
					set noinput_qty = noinput_qty - :new.qty
				 where dept_code = :new.dept_code
					and approval_unq_num = :new.approval_unq_num;
			END IF;
		END IF;			
			
		select count(*)
		  into C_CNT
		  from m_currstock
		 where dept_code = :new.dept_code
			and mtrcode   = :new.mtrcode
			and ditag     = :new.ditag;

		IF C_CNT > 0 THEN
			update m_currstock
				set qty = qty + :new.qty,
					 amt = amt + :new.amt
			 where dept_code = :new.dept_code
				and mtrcode   = :new.mtrcode
				and ditag     = :new.ditag;
		ELSE
			insert into m_currstock
				  values (:new.dept_code,:new.mtrcode,:new.ditag,:new.name,:new.ssize,:new.unitcode,
							 :new.qty,:new.amt,0);
		END IF;
	END IF;

	IF updating THEN
		IF :old.qty <> :new.qty OR :old.amt <> :new.amt THEN
			IF :new.approval_unq_num <> 0 THEN
				select count(*)
				  into C_CNT
				  from m_approval_detail
				 where dept_code = :new.dept_code
					and approval_unq_num = :new.approval_unq_num;
	
				IF C_CNT > 0 THEN
					update m_approval_detail
						set noinput_qty = noinput_qty + :old.qty - :new.qty
					 where dept_code = :new.dept_code
						and approval_unq_num = :new.approval_unq_num;
				END IF;
			END IF;			
				
			IF :old.ditag <> :new.ditag OR :old.mtrcode <> :new.mtrcode THEN
				update m_currstock
					set qty = qty - :old.qty,
						 amt = amt - :old.amt
				 where dept_code = :old.dept_code
					and mtrcode   = :old.mtrcode
					and ditag     = :old.ditag;
	
				select nvl(qty,0),nvl(amt,0)
				  into C_QTY,C_AMT
				  from m_currstock
				 where dept_code = :old.dept_code
					and mtrcode   = :old.mtrcode
					and ditag     = :old.ditag;
	
				IF C_QTY = 0 THEN
					delete from m_currstock
							where dept_code = :old.dept_code
							  and mtrcode   = :old.mtrcode
							  and ditag     = :old.ditag;
				END IF;
			
				select count(*)
				  into C_CNT
				  from m_currstock
				 where dept_code = :new.dept_code
					and mtrcode   = :new.mtrcode
					and ditag     = :new.ditag;
		
					IF C_CNT > 0 THEN
						update m_currstock
							set qty = qty + :new.qty,
								 amt = amt + :new.amt
						 where dept_code = :new.dept_code
							and mtrcode   = :new.mtrcode
							and ditag     = :new.ditag;
					ELSE
						insert into m_currstock
							  values (:new.dept_code,:new.mtrcode,:new.ditag,:new.name,:new.ssize,:new.unitcode,
										 :new.qty,:new.amt,0);
					END IF;
			ELSE
				select count(*)
				  into C_CNT
				  from m_currstock
				 where dept_code = :new.dept_code
					and mtrcode   = :new.mtrcode
					and ditag     = :new.ditag;

				IF C_CNT < 1 THEN
					insert into m_currstock
						  values (:new.dept_code,:new.mtrcode,:new.ditag,:new.name,:new.ssize,:new.unitcode,
									 0,0,0);
				END IF;

				update m_currstock
					set qty = qty - :old.qty + :new.qty,
						 amt = amt - :old.amt + :new.amt
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
	END IF;
			
	IF deleting THEN
		IF :old.approval_unq_num <> 0 THEN
			select count(*)
			  into C_CNT
			  from m_approval_detail
			 where dept_code = :old.dept_code
				and approval_unq_num = :old.approval_unq_num;

			IF C_CNT > 0 THEN
				update m_approval_detail
					set noinput_qty = noinput_qty + :old.qty
				 where dept_code = :old.dept_code
					and approval_unq_num = :old.approval_unq_num;
			END IF;
		END IF;			

		update m_currstock
			set qty = qty - :old.qty,
				 amt = amt - :old.amt
		 where dept_code = :old.dept_code
			and mtrcode   = :old.mtrcode
			and ditag     = :old.ditag;

		select nvl(qty,0),nvl(amt,0)
		  into C_QTY,C_AMT
		  from m_currstock
		 where dept_code = :old.dept_code
			and mtrcode   = :old.mtrcode
			and ditag     = :old.ditag;

		IF C_QTY = 0 THEN
			delete from m_currstock
					where dept_code = :old.dept_code
					  and mtrcode   = :old.mtrcode
					  and ditag     = :old.ditag;
		END IF;
	END IF;
             
END tg_m_input_detail ;
/
