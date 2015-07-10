CREATE OR REPLACE Procedure SP_BILL_PAY_WINDOW_CHECK
(
	p_pay_seq     IN NUMBER ,          -- �����Ϸù�ȣ
	p_level_gubun IN VARCHAR2 ,        -- ���ޱ��� [ CASHIER:�ⳳ , MANAGER:����]
	p_job_gubun   IN VARCHAR2 ,        -- ó������ [ CHECK:Ȯ�� , CANCEL:Ȯ����� ]
	p_emp_no      IN VARCHAR2          -- ���                                       
)
Is
    /*************************************************************************/
    /*                                                                       */
    /*  1. ���ID    : cash_pay_window_check                                 */
    /*  2. ����̸�  : ������ü ����� ȹ�� �� ���ó�� ����                 */
    /*  3. �ý���    : ȸ��ý���                                            */
    /*  4. ����ý���: FBS                                                   */
    /*  5. �������  :                                                       */
    /*  6. �����  : PL/SQL                                                */
    /*  7. ���ȯ��  : Windows2003 Server+ Oracle 9.2.0                      */
    /*  8. ���DBMS  : Oracle                                                */
    /*  9. ����� ���� �� �ֿ���                                           */
    /*                                                                       */
    /* 10. �����ۼ���: LG CNS ����ö                                         */
    /* 11. �����ۼ���: 2005��12��21��                                        */
    /* 12. ����������:                                                       */
    /* 13. ����������:                                                       */
    /*************************************************************************/    
-- ��������
				C_PAY_SEQ					t_fb_cash_pay_data.PAY_SEQ%TYPE;
-- ���� ����
				errmsg           VARCHAR2(500);              -- Error Message Edit
				errflag          INTEGER        DEFAULT 0;   -- Process Error Code
				e_msg            VARCHAR2(100);
				i  		           INTEGER        DEFAULT 0;
-- User Define Error
				Err         			EXCEPTION;                  -- Select Data Not Found        	
Begin

	C_PAY_SEQ := p_pay_seq ;

 	IF p_level_gubun = 'CASHIER' THEN --����� ó����
	 	IF p_job_gubun = 'CHECK' THEN --Ȯ��ó����
	
	--���ھ������޵���Ÿ UPDATE			
			UPDATE T_FB_BILL_PAY_DATA
			SET    PAY_STATUS ='1',
			       CASHIER_CONFIRM_DATE = SYSDATE
			WHERE  PAY_SEQ = C_PAY_SEQ		    ;		
			
		  IF SQL%NOTFOUND THEN
		     errmsg  := '���޵���Ÿ ���� ����!';
		     errflag := -20023;
		     RAISE Err;
		  END IF;
	
		ELSIF p_job_gubun = 'CANCEL' THEN --����� Ȯ����ҽ�
			
	--���ھ������޵���Ÿ UPDATE			
			UPDATE T_FB_BILL_PAY_DATA
			SET    PAY_STATUS ='0',
			       CASHIER_CONFIRM_DATE = NULL
			WHERE  PAY_SEQ = C_PAY_SEQ		    ;
			
		  IF SQL%NOTFOUND THEN
		     errmsg  := '���޵���Ÿ ���� ����!';
		     errflag := -20025;
		     RAISE Err;
		  END IF;
		END IF;
	ELSIF	p_level_gubun = 'MANAGER' THEN --���� ó����
		
	 	IF p_job_gubun = 'CHECK' THEN --Ȯ��ó����
	
	--���ھ������޵���Ÿ UPDATE			
			UPDATE T_FB_BILL_PAY_DATA
			SET    PAY_STATUS ='2',
			       MANAGER_CONFIRM_DATE = SYSDATE
			WHERE  PAY_SEQ = C_PAY_SEQ		    ;		
			
		  IF SQL%NOTFOUND THEN
		     errmsg  := '���޵���Ÿ ���� ����!';
		     errflag := -20023;
		     RAISE Err;
		  END IF;
	
		ELSIF p_job_gubun = 'CANCEL' THEN --Ȯ����ҽ�
			
	--���ھ������޵���Ÿ UPDATE			
			UPDATE T_FB_BILL_PAY_DATA
			SET    PAY_STATUS ='1',
			       MANAGER_CONFIRM_DATE = NULL
			WHERE  PAY_SEQ = C_PAY_SEQ		    ;
			
		  IF SQL%NOTFOUND THEN
		     errmsg  := '���޵���Ÿ ���� ����!';
		     errflag := -20025;
		     RAISE Err;
		  END IF;
		END IF;		
	END IF;		

EXCEPTION
	WHEN Err THEN
		RAISE_APPLICATION_ERROR(errflag ,errmsg);
End;
/
