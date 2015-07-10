/* ========================================================================= */
/* �ý��� : �������                                                         */
/* �Լ��� : tg_m_est_detail(���������Է�,����,����)                          */
/* ��  �� : �������γ����Է½� û�������� ��ǰ�Ǽ����� ��ħ                  */
/* ===========================[ ��   ��   ��   �� ]========================= */
/*      �� �� ��    ��     ��             �� �� ��      ��         ��        */
/*   ------------  -------------------  ------------  ---------------------- */
/*   1. �赿��                           2003.05.02       �����ۼ�           */
/* ========================================================================= */

CREATE or REPLACE	TRIGGER tg_m_est_detail
	BEFORE INSERT OR UPDATE OR DELETE ON m_est_detail
		FOR EACH ROW

DECLARE
   C_CNT    NUMBER(20,5);
	errnum   CHAR(6):= '-20999';

BEGIN
	IF inserting THEN
		select count(*)
		  into C_CNT
		  from m_request_detail
		 where dept_code = :new.dept_code
			and request_unq_num = :new.request_unq_num;

		IF C_CNT > 0 THEN
			update m_request_detail
				set nappr_qty = nappr_qty - :new.qty
			 where dept_code = :new.dept_code
				and request_unq_num = :new.request_unq_num;
		END IF;
		select count(*)
		  into C_CNT
		  from m_vender_est
		 where dept_code = :new.dept_code
			and estimateyymm = :new.estimateyymm
			and estimateseq = :new.estimateseq;

		IF C_CNT > 0 THEN
			insert into m_vender_est_detail
			select :new.dept_code,:new.estimateyymm,:new.estimateseq,sbcr_code,:new.est_unq_num,0,0
			  from m_vender_est 
			 where dept_code = :new.dept_code
				and estimateyymm = :new.estimateyymm
				and estimateseq  =:new.estimateseq;

			insert into m_vender_est_detail_web
			select :new.dept_code,:new.estimateyymm,:new.estimateseq,sbcr_code,:new.est_unq_num,0,0
			  from m_vender_est 
			 where dept_code = :new.dept_code
				and estimateyymm = :new.estimateyymm
				and estimateseq  =:new.estimateseq;
		END IF;
	END IF;

	IF updating THEN
		select count(*)
		  into C_CNT
		  from m_request_detail
		 where dept_code = :new.dept_code
			and request_unq_num = :new.request_unq_num;

		IF C_CNT > 0 THEN
			update m_request_detail
				set nappr_qty = nappr_qty + :old.qty - :new.qty
			 where dept_code = :new.dept_code
				and request_unq_num = :new.request_unq_num;
		END IF;
	END IF;
			
	IF deleting THEN
		select count(*)
		  into C_CNT
		  from m_request_detail
		 where dept_code = :old.dept_code
			and request_unq_num = :old.request_unq_num;

		IF C_CNT > 0 THEN
			update m_request_detail
				set nappr_qty = nappr_qty + :old.qty
			 where dept_code = :old.dept_code
				and request_unq_num = :old.request_unq_num;
		END IF;
		select count(*)
		  into C_CNT
		  from m_vender_est_detail
		 where dept_code = :old.dept_code
			and estimateyymm = :old.estimateyymm
			and estimateseq  = :old.estimateseq
			and est_unq_num  = :old.est_unq_num;

		IF C_CNT > 0 THEN
			delete from m_vender_est_detail
				   where dept_code    = :old.dept_code
					  and estimateyymm = :old.estimateyymm
					  and estimateseq  = :old.estimateseq
					  and est_unq_num  = :old.est_unq_num;

			delete from m_vender_est_detail_web
				   where dept_code    = :old.dept_code
					  and estimateyymm = :old.estimateyymm
					  and estimateseq  = :old.estimateseq
					  and est_unq_num  = :old.est_unq_num;
		END IF;
	END IF;
             
END tg_m_est_detail ;
/
