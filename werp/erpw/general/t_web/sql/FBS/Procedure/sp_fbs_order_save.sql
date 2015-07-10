CREATE OR REPLACE Procedure SP_FBS_ORDER_SAVE
(
	p_ACCOUNT_NO       IN VARCHAR2 ,        -- ���¹�ȣ
	p_FBS_ORDER        IN NUMBER   ,        -- ����
	p_emp_no           IN VARCHAR2          -- ��� 
)
Is
    /*************************************************************************/
    /*                                                                       */
    /*  1. ���ID    : SP_FBS_ORDER_SAVE                                     */
    /*  2. ����̸�  : ���¹�ȣ ��ȸ��������                                 */
    /*  3. �ý���    : ȸ��ý���                                            */
    /*  4. ����ý���: FBS                                                   */
    /*  5. �������  :                                                       */
    /*  6. �����  : PL/SQL                                                */
    /*  7. ���ȯ��  : Windows2003 Server+ Oracle 9.2.0                      */
    /*  8. ���DBMS  : Oracle                                                */
    /*  9. ����� ���� �� �ֿ���                                           */
    /* 10. �����ۼ���: �����                                                */
    /* 11. �����ۼ���: 2006��02��20��                                        */
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

		UPDATE T_ACCNO_CODE
		SET    FBS_DISPLAY_ORDER  = p_FBS_ORDER ,
		       MODDATE   = SYSDATE,
		       MODUSERNO = p_emp_no
		WHERE  ACCNO = p_ACCOUNT_NO	;		

EXCEPTION
	WHEN OTHERS THEN		fbs_util_pkg.write_log('FBS', sqlerrm||'(���¹�ȣ:'||p_ACCOUNT_NO||')');
		RAISE_APPLICATION_ERROR(-20010 ,sqlerrm||'(���¹�ȣ:'||p_ACCOUNT_NO||')');

End;
/
