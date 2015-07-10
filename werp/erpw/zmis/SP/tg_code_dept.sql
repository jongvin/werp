/* ========================================================================= */
/* �ý��� : �������                                                         */
/* �Լ��� : tg_code_dept(�μ��ڵ��Է�,����,����)                             */
/* ��  �� : ERPC���� �μ��ڵ�(sm_code_dept) ��� �� ������                   */
/* 	    : erpw�� ������ڵ�(z_code_dept)�� �ݿ��Ѵ�                      */
/* ===========================[ ��   ��   ��   �� ]========================= */
/*      �� �� ��    ��     ��             �� �� ��      ��         ��        */
/*   ------------  -------------------  ------------  ---------------------- */
/*   1. �赿��                           2003.12.05       �����ۼ�           */
/* ========================================================================= */

CREATE or REPLACE	TRIGGER tg_code_dept
	BEFORE INSERT OR UPDATE OR DELETE ON erpc.sm_code_dept
		FOR EACH ROW

DECLARE
   C_CNT    NUMBER(20,5);
   C_QTY    NUMBER(20,5);
   C_AMT    NUMBER(20,5);
	errnum   CHAR(6):= '-20999';

BEGIN
	IF inserting THEN
		IF :new.dept_div_code <> '1' AND :new.dept_div_code IS NOT NULL THEN
			select count(*)
			  into C_CNT
			  from z_code_dept
			 where dept_code = :new.dept_code;
	
			IF C_CNT < 1 THEN
				insert into z_code_dept
					  values (substrb(:new.dept_code,1,7),substrb(:new.company_code,1,2),:new.dept_name,
								 substrb(:new.dept_name,1,20),'',1,'','','P','Y','31',:new.dept_name,'01','','','','','','',
								 '','',null,null,1,'','','','','1','1','1',100,100,0,0,0,0,0,null,null,0,null,null,0,
								 null,null,0,0,0,0,'');
			END IF;
		END IF;
	END IF;

	IF updating THEN
		IF :old.dept_div_code <> '1' AND :old.dept_div_code IS NOT NULL THEN
			IF :new.dept_div_code = '1' OR :new.dept_div_code = '' THEN
				delete from z_code_dept
						where dept_code = :old.dept_code;
			ELSE
				select count(*)
				  into C_CNT
				  from z_code_dept
				 where dept_code = :old.dept_code;
		
				IF C_CNT > 0 THEN
					update z_code_dept
						set dept_code = :new.dept_code,
							 long_name = :new.dept_name,
							 proj_name = :new.dept_name,
							 SHORT_name = substrb(:new.dept_name,1,20),
							 comp_code = substrb(:new.company_code,1,2),
							 use_tag   = :new.use_yn							 
					 where dept_code = :old.dept_code;
				END IF;
			END IF;
		ELSE
			IF :new.dept_div_code <> '1' AND :new.dept_div_code IS NOT NULL THEN
				select count(*)
				  into C_CNT
				  from z_code_dept
				 where dept_code = :new.dept_code;
		
				IF C_CNT < 1 THEN
					insert into z_code_dept
						  values (substrb(:new.dept_code,1,7),substrb(:new.company_code,1,2),:new.dept_name,
									 substrb(:new.dept_name,1,20),'',1,'','','P','Y','31',:new.dept_name,'01','','','','','','',
									 '','',null,null,1,'','','','','1','1','1',100,100,0,0,0,0,0,null,null,0,null,null,0,
									 null,null,0,0,0,0,'');
				END IF;
			END IF;
		END IF;
	END IF;
			
	IF deleting THEN
		select count(*)
		  into C_CNT
		  from z_code_dept
		 where dept_code = :old.dept_code;

		IF C_CNT > 0 THEN
			delete from z_code_dept
					where dept_code = :old.dept_code;
		END IF;
	END IF;
             
END tg_code_dept ;
/
