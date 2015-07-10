CREATE OR REPLACE Procedure SP_DELETE_BILL_EDI_FILE
(
	p_edi_seq     IN NUMBER ,        -- edi�̷��Ϸù�ȣ
	p_emp_no      IN VARCHAR2        -- ���                                       
)
Is
    /*************************************************************************/
    /*                                                                       */
    /*  1. ���ID    : SP_DELETE_BILL_EDI_FILE                               */
    /*  2. ����̸�  : ��ü���ϻ���                                          */
    /*  3. �ý���    : ȸ��ý���                                            */
    /*  4. ����ý���: FBS                                                   */
    /*  5. �������  :                                                       */
    /*  6. �����  : PL/SQL                                                */
    /*  7. ���ȯ��  : Windows2003 Server+ Oracle 9.2.0                      */
    /*  8. ���DBMS  : Oracle                                                */
    /*  9. ����� ���� �� �ֿ���                                           */
    /*                                                                       */
    /* 10. �����ۼ���: �����                                                */
    /* 11. �����ۼ���: 2006��02��09��                                        */
    /* 12. ����������:                                                       */
    /* 13. ����������:                                                       */
    /*************************************************************************/    
-- ��������
				v_dummy_return		 VARCHAR2(100); 
				v_bill_send_dir    VARCHAR2(200);             -- BATCH �۽� DIRECTORY 
				v_send_date		     VARCHAR2(100); 
				v_sned_file_name	 VARCHAR2(100); 
-- ���� ����
				errmsg           VARCHAR2(500);              -- Error Message Edit
				errflag          INTEGER        DEFAULT 0;   -- Process Error Code
-- User Define Error
				Err         			EXCEPTION;                  -- Select Data Not Found  

  CURSOR edi_data_cursor IS
      SELECT pay_seq 
        FROM T_FB_BILL_PAY_HISTORY
       WHERE EDI_HISTORY_SEQ = p_edi_seq
    GROUP BY pay_seq ; 
					      	
Begin

 	SELECT NVL(to_char(SEND_DATE ,'yyyymmdd') ,'N') ,
 	       SEND_FILE_NAME
	INTO   v_send_date,
	       v_sned_file_name 	        
 	FROM T_FB_EDI_HISTORY
 	WHERE EDI_HISTORY_SEQ = p_edi_seq ;
 	
 	IF v_send_date <> 'N' THEN 
	     errmsg  := '���ϻ����Ұ�!';
	     errflag := -20021;
	     RAISE Err;
	ELSE
      -- �������� OS���� directory�� �����ɴϴ�.(from DBA_DIRECTORIES )
      BEGIN
          SELECT DIRECTORY_PATH || '\'
          INTO v_bill_send_dir
          FROM DBA_DIRECTORIES
          WHERE DIRECTORY_NAME = 'FBS_BILL_SEND_DIR';
      
      EXCEPTION
          WHEN NO_DATA_FOUND THEN
					     errmsg  := '����DIR�˻� ����!';
					     errflag := -20022;
					     RAISE Err;
      END;

      BEGIN
					UPDATE T_FB_EDI_HISTORY
          SET    RESULT_TEXT     = 'EDI���ϻ���'
          WHERE  EDI_HISTORY_SEQ = p_edi_seq;
          	
          FOR bill_seq_rec IN edi_data_cursor LOOP
               
              UPDATE T_FB_BILL_PAY_DATA
                 SET PAY_STATUS  = '2' ,
                     RESULT_TEXT = 'EDI���ϻ���'
               WHERE PAY_SEQ     =  bill_seq_rec.PAY_SEQ ;
               
          END LOOP;
      
      		DELETE FROM T_FB_BILL_PAY_HISTORY
          WHERE  EDI_HISTORY_SEQ = p_edi_seq
          AND    SEND_DATE IS NULL;
          	
      EXCEPTION
          WHEN NO_DATA_FOUND THEN
					     errmsg  := '�����̷¼��� ����!';
					     errflag := -20022;
					     RAISE Err;
      END; 
           
      BEGIN
          v_dummy_return := fbs_util_pkg.exec_os_command(	'del ' || v_bill_send_dir || v_sned_file_name );
      EXCEPTION
          WHEN OTHERS THEN
              fbs_util_pkg.write_log('FBS',sqlerrm);
					    errmsg  := '���ϻ��� ����!';
					    errflag := -20023;
					    RAISE Err;              
      END;

	END IF;	  

EXCEPTION
	WHEN Err THEN
		RAISE_APPLICATION_ERROR(errflag ,errmsg);
End;
/
