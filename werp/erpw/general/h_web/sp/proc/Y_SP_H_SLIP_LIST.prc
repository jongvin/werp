CREATE OR REPLACE PROCEDURE Y_Sp_H_Slip_List(as_tag          IN   VARCHAR2,
                                             as_save_num     IN   NUMBER,
                                             as_approval_num IN   VARCHAR2,
                                             as_approval_name IN  VARCHAR2,
                                             as_dept_code    IN   VARCHAR2,
                                        		as_sell_code    IN   VARCHAR2,
                                        		adt_from_date   IN   DATE,
															adt_to_date     IN   DATE
															) IS
-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------
-- 공통 변수
   v_dept              VARCHAR2(10);               -- 발의부서
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
   UserErr         EXCEPTION;                  -- Select Data Not Found
BEGIN
   BEGIN
      /*IF as_tag = 'su_01' THEN
			e_msg := '청약입금 전표 처리 error su01';
         Y_Sp_H_Slip_Subs(as_save_num, as_approval_num, as_approval_name,
                           as_dept_code, as_sell_code, adt_from_date, adt_to_date);
		END IF;
      IF as_tag = 'su_02' THEN
			e_msg := '청약환출 전표 처리 error su02';
			Y_Sp_H_Subs_Cancel(as_save_num, as_approval_num, as_approval_name,
                           as_dept_code, as_sell_code, adt_from_date, adt_to_date);
		END IF;*/
      IF as_tag = 'sa_01' THEN
			e_msg := '분양 미수금 전표 처리 error sa01'||SQLERRM ;
			Y_Sp_H_Slip_Agree(as_save_num, as_approval_num, as_approval_name,
                           as_dept_code, as_sell_code, adt_from_date, adt_to_date);
		END IF;
		/*IF as_tag = 'sa_02' THEN
			e_msg := '분양 수입금 전표 처리 error sa02';
			Y_Sp_H_Slip_Income(as_save_num, as_approval_num, as_approval_name,
                           as_dept_code, as_sell_code, adt_from_date, adt_to_date);
		END IF;
      IF as_tag = 'sa_03' THEN
			e_msg := '분양 해약 전표 처리 error sa03';
			Y_Sp_H_Slip_Cancel(as_save_num, as_approval_num, as_approval_name,
                           as_dept_code, as_sell_code, adt_from_date, adt_to_date);
		END IF;
      IF as_tag = 'sa_04' THEN
			e_msg := '분양 매출 전표 처리 error sa03';
			Y_Sp_H_Slip_Sale(as_save_num, as_approval_num, as_approval_name,
                           as_dept_code, as_sell_code, adt_from_date, adt_to_date);
		END IF;
      IF as_tag = 'in_01' THEN
			e_msg := '분양 대출이자대납(무이자) 전표 처리 error in01';
			Y_Sp_H_Slip_Loan_Noint(as_save_num, as_approval_num, as_approval_name,
                           as_dept_code, as_sell_code, adt_from_date, adt_to_date);
		END IF;
      IF as_tag = 'in_02' THEN
			e_msg := '분양 대출이자대납(유이자) 전표 처리 error in02';
			Y_Sp_H_Slip_Loan_Int(as_save_num, as_approval_num, as_approval_name,
                           as_dept_code, as_sell_code, adt_from_date, adt_to_date);
		END IF;
      IF as_tag = 'in_03' THEN
			e_msg := '분양 대출이자정산 전표 처리 error in03';
			Y_Sp_H_Slip_Loan_Fin(as_save_num, as_approval_num, as_approval_name,
                           as_dept_code, as_sell_code, adt_from_date, adt_to_date);
		END IF;
      IF as_tag = 're_01' THEN
			e_msg := '임대계약(임대보증금) 전표 처리 error re01';
			Y_Sp_H_Slip_Lease_Grt_Income(as_save_num, as_approval_num, as_approval_name,
                           as_dept_code, as_sell_code, adt_from_date, adt_to_date);
		END IF;
      IF as_tag = 're_02' THEN
			e_msg := '임대환출(임대보증금) 전표 처리 error re02';
			Y_Sp_H_Slip_Lease_Grt_Cancel(as_save_num, as_approval_num, as_approval_name,
                           as_dept_code, as_sell_code, adt_from_date, adt_to_date);
		END IF;
      IF as_tag = 're_03' THEN
			e_msg := '월임대료(청구시) 전표 처리 error re03';
			Y_Sp_H_Slip_Lease_Rent_Agree(as_save_num, as_approval_num, as_approval_name,
                           as_dept_code, as_sell_code, adt_from_date, adt_to_date);
		END IF;
      IF as_tag = 're_04' THEN
			e_msg := '월임대료(입금시) 전표 처리 error re04';
			Y_Sp_H_Slip_Lease_Rent_Income(as_save_num, as_approval_num, as_approval_name,
                           as_dept_code, as_sell_code, adt_from_date, adt_to_date);
		END IF;*/
		
      EXCEPTION
      WHEN OTHERS THEN
         IF SQL%NOTFOUND THEN
              Wk_errflag := -20020;
              GOTO EXIT_ROUTINE;
           END IF;
   END;
   -- *****************************************************************************
   -- PROCESS ENDDING ... !
   -- *****************************************************************************
   <<EXIT_ROUTINE>>
   -- ENDING...[0.1] CURSOR CLOSE 재 확인 처리 !
   IF Wk_errflag = 0 THEN
      Wk_errmsg  := '';                        -- 사용자 정의 Error Message
      Wk_errflag := 0;                         -- 사용자 정의 Error Code
   ELSE
      Wk_errmsg := RTRIM(e_msg) || '/>'||SQLERRM;
      RAISE UserErr;
   END IF;
EXCEPTION
    WHEN UserErr       THEN
       RAISE_APPLICATION_ERROR(Wk_errflag, Wk_errmsg);
END Y_Sp_H_Slip_List;
/

