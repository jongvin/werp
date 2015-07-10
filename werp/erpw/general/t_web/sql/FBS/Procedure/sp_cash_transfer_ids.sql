CREATE OR REPLACE Procedure SP_CASH_TRANSFER_IDS
(
	p_job_gubun        IN VARCHAR2 ,        -- �۾�����(INSERT, UPDATE, DELETE)
	p_TRANSFER_SEQ     IN NUMBER   ,        -- ������ü�Ϸù�ȣ
	p_REQUEST_YMD      IN VARCHAR2 ,        -- ��ü��������
	p_OUTACCOUNT_CODE  IN VARCHAR2 ,        -- ��ݰ��¹�ȣ
	p_OUTBANK_CODE     IN VARCHAR2 ,        -- �������
	p_INACCOUNT_CODE   IN VARCHAR2 ,        -- �Աݰ��¹�ȣ
	p_INBANK_CODE      IN VARCHAR2 ,        -- �Ա�����
	p_TRANSFER_AMT     IN NUMBER   ,        -- ��ü�ݾ�
	p_COMP_CODE        IN VARCHAR2 ,        -- ������ڵ�
	p_DESCRIPTION      IN VARCHAR2 ,        -- ����
	p_emp_no           IN VARCHAR2          -- ��� 
)
Is
    /*************************************************************************/
    /*                                                                       */
    /*  1. ���ID    : SP_CASH_TRANSFER_IDS                                  */
    /*  2. ����̸�  : ����������ü����Ÿ ���� �� ���� ,����                 */
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
-- ���� ����
				errmsg           VARCHAR2(500);              -- Error Message Edit
				errflag          INTEGER        DEFAULT 0;   -- Process Error Code
				e_msg            VARCHAR2(100);
				i  		           INTEGER        DEFAULT 0;
-- User Define Error
				Err         			EXCEPTION;                  -- Select Data Not Found        	
Begin

 	IF p_job_gubun = 'INSERT' THEN 

--����������ü����Ÿ INSERT	
    INSERT INTO T_FB_CASH_TRANSFER_DATA	
    ( TRANSFER_SEQ ,
      FUND_TRANSFER_STATUS,
      REQUEST_YMD,
      TRANSFER_AMT,
      OUT_BANK_CODE,
      OUT_ACCOUNT_NO,
      IN_BANK_CODE,
      IN_ACCOUNT_NO,
      DESCRIPTION,
      COMP_CODE,
      CREATION_DATE,
      CREATION_EMP_NO,
      PAY_SEQ )
    VALUES  
    ( T_FB_CASH_TRANSFER_DATA_SEQ.NEXTVAL ,
      'I' ,
			p_REQUEST_YMD ,
			p_TRANSFER_AMT ,
			p_OUTBANK_CODE ,
			p_OUTACCOUNT_CODE,
			p_INBANK_CODE ,
			p_INACCOUNT_CODE ,
			p_DESCRIPTION ,
			p_COMP_CODE ,
			SYSDATE,
			p_emp_no ,
			0 ) ;

	ELSIF p_job_gubun = 'UPDATE' THEN 

		UPDATE T_FB_CASH_TRANSFER_DATA
		SET    REQUEST_YMD    = p_REQUEST_YMD,
		       TRANSFER_AMT   = p_TRANSFER_AMT,
		       OUT_BANK_CODE  = p_OUTBANK_CODE,
		       OUT_ACCOUNT_NO = p_OUTACCOUNT_CODE,
		       IN_BANK_CODE   = p_INBANK_CODE,
		       IN_ACCOUNT_NO  = p_INACCOUNT_CODE,
		       DESCRIPTION    = p_DESCRIPTION,
		       LAST_MODIFY_DATE   = SYSDATE,
		       LAST_MODIFY_EMP_NO = p_emp_no
		WHERE  TRANSFER_SEQ = p_transfer_seq	;		

	ELSIF p_job_gubun = 'DELETE' THEN 

		DELETE FROM T_FB_CASH_TRANSFER_DATA
		WHERE  TRANSFER_SEQ = p_transfer_seq	;		

	END IF;	  

EXCEPTION
	WHEN OTHERS THEN
		fbs_util_pkg.write_log('FBS', sqlerrm||'('||p_job_gubun||')');
		RAISE_APPLICATION_ERROR(-20010 ,sqlerrm||'('||p_job_gubun||')');
End;
/
