CREATE OR REPLACE Procedure SP_CASH_PAY_WINDOW_CHECK2
(
	p_pay_seq     IN NUMBER ,          -- �����Ϸù�ȣ
	p_job_gubun   IN VARCHAR2 ,        -- ó������ [ CHECK:Ȯ�� , CANCEL:Ȯ����� ]
	p_emp_no      IN VARCHAR2          -- ���                                       
)
Is
    /*************************************************************************/
    /*                                                                       */
    /*  1. ���ID    : cash_pay_window_check2                                */
    /*  2. ����̸�  : ������ü �繫���� ȹ�� �� ���ó�� ����               */
    /*  3. �ý���    : ȸ��ý���                                            */
    /*  4. ����ý���: FBS                                                   */
    /*  5. �������  :                                                       */
    /*  6. �����  : PL/SQL                                                */
    /*  7. ���ȯ��  : Windows2003 Server+ Oracle 9.2.0                      */
    /*  8. ���DBMS  : Oracle                                                */
    /* 10. �����ۼ���: LG CNS ����ö                                         */
    /* 11. �����ۼ���: 2005��12��21��                                        */
    /* 12. ����������:                                                       */
    /* 13. ����������:                                                       */
    /*************************************************************************/    
-- ��������
-- ���� ����
				errmsg           VARCHAR2(500);              -- Error Message Edit
				errflag          INTEGER        DEFAULT 0;   -- Process Error Code
				e_msg            VARCHAR2(100);
				i  		           INTEGER        DEFAULT 0;
-- User Define Error
				Err         			EXCEPTION;                  -- Select Data Not Found        	
Begin

 	IF p_job_gubun = 'CHECK' THEN --�繫���� Ȯ��ó����

--�������޵���Ÿ UPDATE			
		UPDATE T_FB_CASH_PAY_DATA
		SET    PAY_STATUS ='2',
		       MANAGER_CONFIRM_DATE = SYSDATE
		WHERE  PAY_SEQ    = p_pay_seq	
		AND    PAY_STATUS ='1'	    ;		
		
	  IF SQL%NOTFOUND THEN
	     errmsg  := '���޵���Ÿ ���� ����!';
	     errflag := -20020;
	     RAISE Err;
	  END IF;

	ELSIF p_job_gubun = 'CANCEL' THEN --�繫���� Ȯ����ҽ�
--�������޵���Ÿ UPDATE			
		UPDATE T_FB_CASH_PAY_DATA
		SET    PAY_STATUS ='1',
		       MANAGER_CONFIRM_DATE = NULL
		WHERE  PAY_SEQ = p_pay_seq
		AND    PAY_STATUS ='2'		    ;
		
	  IF SQL%NOTFOUND THEN
	     errmsg  := '���޵���Ÿ ���� ����!';
	     errflag := -20021;
	     RAISE Err;
	  END IF;
	END IF;

EXCEPTION
	WHEN Err THEN
		RAISE_APPLICATION_ERROR(errflag ,errmsg);
End;
/
