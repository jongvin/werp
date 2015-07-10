CREATE OR REPLACE Procedure SP_CASH_PAY_WINDOW_CHECK
(
	p_pay_seq     IN NUMBER ,          -- �����Ϸù�ȣ
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
    /*      - ������ü�� ����� Ȯ��/Ȯ����ҿ� ���Ͽ� ������ ó����ƾ       */
    /*        Ȯ������, Ȯ�����ó�������� GUBUN�ڵ�� �����Ѵ�.             */
    /*                                                                       */
    /*        (1) Ȯ��ó�� ��                                                */
    /*          : T_FB_CASH_PAY_DATA�� ��� �ش� ����RECORD�� ���Ͽ� Ÿ��    */
    /*            ��ü���θ� Ȯ���Ͽ�, T_FB_LOOKUP_VALUES���̺��� ���ະ     */
    /*            ��ü�ѵ��ݾ��� Ȯ���Ͽ�, T_FB_CASH_PAY_DIVIDED_DATA��      */
    /*            �������ްǿ� ���Ͽ� RECORD�� ������Ų��.                   */
    /*            ��ü�ѵ��� �Ȱɸ��� ���� 1���� ��������RECORD������        */
    /*            ������Ų ��, PAY_STATUS�� ����� Ȯ�λ��·� UPDATE�Ѵ�.    */
    /*                                                                       */
    /*        (2) Ȯ����� ó�� ��                                           */ 
    /*          : �� Ȯ�� �� ���̾����Ƿ�, �����������̺� ������ RECORD��  */
    /*            DELETE�ϰ�, PAY_STATUS�� ����� ��Ȯ�� ���·� �����Ų��.  */
    /*                                                                       */
    /*      - �����Ȯ��/Ȯ�����ó���� �������/���޿Ϸ�/����/��ǥ��� �ø� */
    /*         ������ ���¿����� ó���� ������                               */
    /*                                                                       */
    /*      - ���޵���Ÿ�� ��ó�� "������ü"�� ���� Ȯ��/Ȯ����ҿ� ���� */
    /*        STATUS�� ��������ش�. T_FB_CASH_TRANSFER_DATA��               */
    /*        FUND_TRANSFER_STATUS�� Ȯ�νô� '1'�� �����ϸ�, ��ҽô� '0'�� */
    /*        ���� UPDATE�Ѵ�.                                               */
    /*                                                                       */    
    /*      - ��ȯ��                                                         */
    /*          OK : ���� ó�� ��                                            */
    /*          �����޽��� : ��Ÿ ���� �߻��� (DEFAULT��:ERROR)              */
    /*                                                                       */
    /* 10. �����ۼ���: LG CNS ����ö                                         */
    /* 11. �����ۼ���: 2005��12��21��                                        */
    /* 12. ����������:                                                       */
    /* 13. ����������:                                                       */
    /*************************************************************************/    
-- ��������
				C_PAY_SEQ					t_fb_cash_pay_data.PAY_SEQ%TYPE;
				C_PAY_AMT					t_fb_cash_pay_data.PAY_AMT%TYPE;
				C_OUT_BANK_CODE		t_fb_cash_pay_data.OUT_BANK_CODE%TYPE;
				C_IN_BANK_CODE		t_fb_cash_pay_data.IN_BANK_CODE%TYPE;
				C_LIMIT_AMT		    NUMBER(20,5);
				C_DIVIDED_AMT		  NUMBER(20,5);
				C_CNT		          INTEGER        DEFAULT 0;
-- ���� ����
				errmsg           VARCHAR2(500);              -- Error Message Edit
				errflag          INTEGER        DEFAULT 0;   -- Process Error Code
				e_msg            VARCHAR2(100);
				i  		           INTEGER        DEFAULT 0;
-- User Define Error
				Err         			EXCEPTION;                  -- Select Data Not Found        	
Begin
	SELECT PAY_SEQ,				--�����Ϸù�ȣ
	       PAY_AMT,       --���ޱݾ�
	       OUT_BANK_CODE, --�������
	       IN_BANK_CODE   --�Ա�����
	INTO 	 C_PAY_SEQ,
				 C_PAY_AMT,
				 C_OUT_BANK_CODE,
				 C_IN_BANK_CODE
	FROM   T_FB_CASH_PAY_DATA
	WHERE  PAY_SEQ = p_pay_seq ;
	
  IF SQL%NOTFOUND THEN
     errmsg  := '�������޵���Ÿ ���� ����!';
     errflag := -20020;
     RAISE Err;
  END IF;   	

 	IF p_job_gubun = 'CHECK' THEN --����� Ȯ��ó����
 				 	
		IF C_OUT_BANK_CODE <> C_IN_BANK_CODE THEN  --Ÿ����ü��
			
		 	  SELECT TRUNC( (C_PAY_AMT/ TO_NUMBER(LOOKUP_VALUE)) ,0)+
		 	         DECODE(GREATEST(MOD(C_PAY_AMT, TO_NUMBER(LOOKUP_VALUE)),0),0,0,1), --��ü�Ǽ�
		 	         TO_NUMBER(LOOKUP_VALUE)                                            --��ü�ѵ�
		 	  INTO   C_CNT ,
		 	  			 C_LIMIT_AMT	
		 	  FROM   T_FB_LOOKUP_VALUES
		 	  WHERE  LOOKUP_TYPE = 'TA_TRAN_LIMIT'
		 	  AND    LOOKUP_CODE = C_OUT_BANK_CODE
		 	  AND    USE_YN      = 'Y' ;
		 	  
			  IF SQL%NOTFOUND THEN
			     errmsg  := '���ʵ���Ÿ ���� ����!';
			     errflag := -20021;
			     RAISE Err;
			  END IF;   			 	  
					 	  
		ELSE
				C_CNT := 1;
		END IF	;	  
  				
		For i In 1..C_CNT Loop -- �������ޱݾ�
			 	
			IF C_CNT = 1 THEN
				 C_DIVIDED_AMT := C_PAY_AMT;
			ELSE
				 IF i < C_CNT THEN
				 		C_DIVIDED_AMT := C_LIMIT_AMT;
				 ELSE
				 		C_DIVIDED_AMT := C_PAY_AMT - (C_LIMIT_AMT*(i-1));		
				 END IF;
			END IF	; 		
			 		 		
			BEGIN
--�������޺��ҵ���Ÿ ����
			INSERT INTO T_FB_CASH_PAY_DIVIDED_DATA
			(
				PAY_SEQ,
				DIV_SEQ,
				PAY_AMT
			)
			VALUES
			(
				C_PAY_SEQ,
				i,
				C_DIVIDED_AMT
			) ;

			EXCEPTION
			WHEN OTHERS THEN
				  errmsg := 'INSERT ó�� ����!' ;
				  errflag := -20022 ;
				  RAISE Err;
					EXIT;
			END;				    		  
 	
		End Loop;
--�������޵���Ÿ UPDATE			
		UPDATE T_FB_CASH_PAY_DATA
		SET    PAY_STATUS ='1',
		       CASHIER_CONFIRM_DATE = SYSDATE
		WHERE  PAY_SEQ = C_PAY_SEQ		    ;		
		
	  IF SQL%NOTFOUND THEN
	     errmsg  := '���޵���Ÿ ���� ����!';
	     errflag := -20023;
	     RAISE Err;
	  END IF;

	ELSIF p_job_gubun = 'CANCEL' THEN --����� Ȯ����ҽ�
--�������޺��ҵ���Ÿ����		
		DELETE FROM T_FB_CASH_PAY_DIVIDED_DATA
		WHERE PAY_SEQ = C_PAY_SEQ		    ;

	  IF SQL%NOTFOUND THEN
	     errmsg  := '���ҵ���Ÿ ���� ����!';
	     errflag := -20024;
	     RAISE Err;
	  END IF;

		
--�������޵���Ÿ UPDATE			
		UPDATE T_FB_CASH_PAY_DATA
		SET    PAY_STATUS ='0',
		       CASHIER_CONFIRM_DATE = NULL
		WHERE  PAY_SEQ = C_PAY_SEQ		    ;
		
	  IF SQL%NOTFOUND THEN
	     errmsg  := '���޵���Ÿ ���� ����!';
	     errflag := -20025;
	     RAISE Err;
	  END IF;
	END IF;

EXCEPTION
	WHEN Err THEN
		RAISE_APPLICATION_ERROR(errflag ,errmsg);
End;
/
