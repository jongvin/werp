CREATE OR REPLACE Procedure SP_CASH_PAY_DATA_CREATE
(
	p_TRANSFER_SEQ     IN NUMBER   ,        -- ������ü�Ϸù�ȣ
	p_emp_no           IN VARCHAR2          -- ��� 
)
Is
    /*************************************************************************/
    /*                                                                       */
    /*  1. ���ID    : SP_CASH_PAY_DATA_CREATE                               */
    /*  2. ����̸�  : ����������ü����Ÿ ����                               */
    /*  3. �ý���    : ȸ��ý���                                            */
    /*  4. ����ý���: FBS                                                   */
    /*  5. �������  :                                                       */
    /*  6. �����  : PL/SQL                                                */
    /*  7. ���ȯ��  : Windows2003 Server+ Oracle 9.2.0                      */
    /*  8. ���DBMS  : Oracle                                                */
    /*  9. ����� ���� �� �ֿ���                                           */
    /* 10. �����ۼ���: �����                                                */
    /* 11. �����ۼ���: 2006��02��15��                                        */
    /* 12. ����������:                                                       */
    /* 13. ����������:                                                       */
    /*************************************************************************/    
-- ��������
        v_pay_seq        NUMBER         DEFAULT 0;   -- �����Ϸù�ȣ
-- ���� ����
				errmsg           VARCHAR2(500);              -- Error Message Edit
				errflag          INTEGER        DEFAULT 0;   -- Process Error Code
				e_msg            VARCHAR2(100);
				i  		           INTEGER        DEFAULT 0;
-- User Define Error
				Err         			EXCEPTION;                 -- Select Data Not Found        	
Begin

--�����Ϸù�ȣ �˻�
    SELECT T_FB_CASH_PAY_DATA_SEQ.NEXTVAL 
    INTO v_pay_seq
    FROM DUAL ;

--�������޵���Ÿ INSERT	
    INSERT INTO T_FB_CASH_PAY_DATA	
    ( PAY_SEQ ,
      PAY_KIND_GUBUN,
      COMP_CODE,
      PAY_AMT,
      PAY_DUE_YMD,
      IN_BANK_CODE,
      IN_ACCOUNT_NO,
      ACCT_HOLDER_NAME,
      OUT_BANK_CODE,
      OUT_ACCOUNT_NO,
      DESCRIPTION ,
      PAY_STATUS,
      EDI_CREATE_REQ_YN,
      SLIP_ID ,
      CREATION_DATE,
      CREATION_EMP_NO )
    SELECT v_pay_seq ,
           'TR',
           A.COMP_CODE,
           A.TRANSFER_AMT,
           A.REQUEST_YMD,
           A.IN_BANK_CODE,
           A.IN_ACCOUNT_NO,
           B.ACCT_NAME,
           A.OUT_BANK_CODE,
           A.OUT_ACCOUNT_NO,
           A.DESCRIPTION ,
           '0',
           'N',
           11 ,
           SYSDATE,
           p_emp_no
    FROM T_FB_CASH_TRANSFER_DATA A,
         T_ACCNO_CODE B 
    WHERE A.IN_ACCOUNT_NO = B.ACCNO
    AND A.TRANSFER_SEQ = p_TRANSFER_SEQ ;
    
--������ü����Ÿ UPDATE
		UPDATE T_FB_CASH_TRANSFER_DATA
		SET    PAY_SEQ            = v_pay_seq,
		       TRANSFER_YMD       = TO_CHAR(SYSDATE,'YYYYMMDD'),
		       SLIP_ID            = 11 ,
		       FUND_TRANSFER_STATUS = 'S',
		       LAST_MODIFY_DATE   = SYSDATE,
		       LAST_MODIFY_EMP_NO = p_emp_no
		WHERE  TRANSFER_SEQ = p_TRANSFER_SEQ	;		

EXCEPTION
	WHEN OTHERS THEN
		ROLLBACK;
		fbs_util_pkg.write_log('FBS', sqlerrm);
--������ü����Ÿ UPDATE
		UPDATE T_FB_CASH_TRANSFER_DATA
		SET    FUND_TRANSFER_STATUS = 'C',
		       LAST_MODIFY_DATE   = SYSDATE,
		       LAST_MODIFY_EMP_NO = p_emp_no
		WHERE  TRANSFER_SEQ = p_TRANSFER_SEQ	;				
		COMMIT;
		RAISE_APPLICATION_ERROR(-20010 ,sqlerrm);
End;
/
