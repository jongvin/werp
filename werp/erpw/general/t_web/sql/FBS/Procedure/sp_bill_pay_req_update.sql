CREATE OR REPLACE Procedure SP_BILL_PAY_REQ_UPDATE
(
	p_job_gubun   IN VARCHAR2 ,        -- �۾�����(CREATE:��ü���ϻ������� FINISH:�����ۼ��Ϸ�)
	p_pay_seq     IN NUMBER ,          -- �����Ϸù�ȣ
	p_emp_no      IN VARCHAR2          -- ���                                       
)
Is
    /*************************************************************************/
    /*                                                                       */
    /*  1. ���ID    : SP_BILL_PAY_REQ_UPDATE                                */
    /*  2. ����̸�  : ���ھ������޵���Ÿ�� EDI������û���� ����             */
    /*  3. �ý���    : ȸ��ý���                                            */
    /*  4. ����ý���: FBS                                                   */
    /*  5. �������  :                                                       */
    /*  6. �����  : PL/SQL                                                */
    /*  7. ���ȯ��  : Windows2003 Server+ Oracle 9.2.0                      */
    /*  8. ���DBMS  : Oracle                                                */
    /*  9. ����� ���� �� �ֿ���                                           */
    /*                                                                       */
    /*      - EDI ��ġ ������ ������� ��� ��ġ�� FLAG UPDATE               */
    /*        ('Y' :���� �ۼ��� 'N': )                                       */
    /*                                                                       */
    /*                                                                       */
    /* 10. �����ۼ���: �����                                                */
    /* 11. �����ۼ���: 2006��02��7��                                         */
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

 	IF p_job_gubun = 'CREATE' THEN --���ϻ������۽�

--�������޵���Ÿ UPDATE			
		UPDATE T_FB_BILL_PAY_DATA
		SET    PAY_METHOD_GUBUN   = 'B',
		       EDI_CREATE_REQ_YN  = 'Y',
		       LAST_MODIFY_DATE   = SYSDATE,
		       LAST_MODIFY_EMP_NO = p_emp_no
		WHERE  PAY_SEQ = p_pay_seq	;		
		
	  IF SQL%NOTFOUND THEN
	  	 ROLLBACK;	
	     errmsg  := '���޵���Ÿ ���� ����!';
	     errflag := -20020;
	     RAISE Err;
	  END IF;

	ELSIF p_job_gubun = 'FINISH' THEN --���ϿϷ��
--�������޵���Ÿ UPDATE	
		UPDATE T_FB_BILL_PAY_DATA
		SET    PAY_STATUS  = '3',
		       EDI_CREATE_REQ_YN  = 'N',
		       LAST_MODIFY_DATE   = SYSDATE,
		       LAST_MODIFY_EMP_NO = p_emp_no
		WHERE  PAY_SEQ = p_pay_seq	;		

	  IF SQL%NOTFOUND THEN
	  	 ROLLBACK;
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
