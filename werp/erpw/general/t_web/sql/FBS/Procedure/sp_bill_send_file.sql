    /*************************************************************************/
    /*                                                                       */
    /*  1. ���ID    : bill_send_file                                        */
    /*  2. ����̸�  : ���ھ��� Batch���� �۽�                               */
    /*  3. �ý���    : FBS                                                   */
    /*  4. ����ý���: EFT                                                   */
    /*  5. �������  :                                                       */
    /*  6. �����  : PL/SQL                                                */
    /*  7. ���ȯ��  : HP-UX + Oracle 9.2.0                                  */
    /*  8. ���DBMS  : Oracle                                                */
    /*  9. ����� ���� �� �ֿ���                                           */
    /*                                                                       */
    /*      -  DB �������� EFT�ý������� BATCH������ �۽��մϴ�.             */
    /*                                                                       */
    /*      - ����� : tcpsend                                             */
    /*                                                                       */
    /*                                                                       */
    /* 10. �����ۼ���: LG CNS ����ö                                         */
    /* 11. �����ۼ���: 2005��2��3��                                          */
    /* 12. ����������:                                                       */
    /* 13. ����������:                                                       */
    /*************************************************************************/
    CREATE OR REPLACE Procedure
    				  sp_bill_send_file ( p_file_name   IN VARCHAR2 ,                -- ������ ���ϸ�
                                  p_comp_code   IN VARCHAR2 ,                -- ����� �ڵ�
                                  p_bank_code   IN VARCHAR2 ,                -- �����ڵ�
                                  p_edi_seq     IN VARCHAR2 ,                -- edi�̷��Ϸù�ȣ
                                  p_std_ymd     IN VARCHAR2 )  IS            -- edi��������
        
        v_result                  VARCHAR2(100);             -- EFT���α׷� ȣ�� ����� 
        v_send_seq_no             NUMBER(10)   := 0;
        v_gubun                   VARCHAR2(100):= 'B';
				-- ���� ����
				errmsg           VARCHAR2(500);              -- Error Message Edit
				errflag          INTEGER        DEFAULT 0;   -- Process Error Code
				-- User Define Error
				Err         			EXCEPTION;                  -- Select Data Not Found  
                
        -- UPDATE�� ����� QUERY�մϴ�.
        CURSOR edi_data_cursor IS
            SELECT pay_seq 
            FROM T_FB_BILL_PAY_HISTORY
            WHERE EDI_HISTORY_SEQ = p_edi_seq             
            GROUP BY pay_seq ;
                
    BEGIN
					
	        -- MAX�۽��Ϸù�ȣ.
	        SELECT NVL( MAX(send_seq_no) , 0)+ 1
	        INTO   v_send_seq_no
	        FROM   T_FB_EDI_HISTORY
	        WHERE  std_ymd   = p_std_ymd
	        AND    comp_code = p_comp_code ;

        -- ���� ���� TABLE�� ���� UPDATE�� �����Ѵ�.
        -- ������ �� ���, �����޽����� LOG�� ���� ��, ROLLBACKó���ϸ�, 
        -- ������ ���, �۽Ÿ���� ���� BATCH���� �۽� �õ�

  	      BEGIN         
          UPDATE T_FB_EDI_HISTORY
             SET SEND_DATE    = SYSDATE ,
                 RESULT_TEXT  = 'EDI�۽ſϷ�' ,
                 SEND_SEQ_NO  = v_send_seq_no
           WHERE EDI_HISTORY_SEQ = p_edi_seq;
           
	        EXCEPTION
	            WHEN OTHERS THEN	
	            	  errmsg := sqlerrm;
	                RAISE Err ;
	        END;

          BEGIN 
          UPDATE T_FB_BILL_PAY_HISTORY
             SET TRANSFER_YN     = 'Y',
                 SEND_DATE       = SYSDATE,
                 RESULT_TEXT     = 'EDI�۽ſϷ�'
           WHERE EDI_HISTORY_SEQ = p_edi_seq;

	        EXCEPTION
	            WHEN OTHERS THEN
	            	  errmsg := sqlerrm;
	                RAISE Err ;
	        END;
            
          FOR edibill_rec IN edi_data_cursor LOOP

              BEGIN 
              UPDATE T_FB_BILL_PAY_DATA
                 SET RESULT_TEXT = 'EDI�۽ſϷ�'
               WHERE PAY_SEQ     =  edibill_rec.pay_seq ;

			        EXCEPTION
			            WHEN OTHERS THEN
			            	  errmsg := sqlerrm;
			                RAISE Err ;
			        END;

          END LOOP;

					v_result := f_send_file_to_van( p_file_name ,v_gubun,p_comp_code,p_bank_code );

	        IF v_result = 'OK' THEN
	            fbs_util_pkg.write_log('FBS','[INFO] ' || ' �۽��� ���������� ó���Ϸ�Ǿ����ϴ�.');
	        ELSE
	            fbs_util_pkg.write_log('FBS','[ERROR] '|| ' �۽� �� ������ �߻��Ͽ� �۾��� ��ҵǾ����ϴ�.');
	            errmsg := '�۽� �� ������ �߻�';
	            RAISE Err;
        	END IF;

    EXCEPTION
        WHEN Err THEN    
            fbs_util_pkg.write_log('FBS' , errmsg);
				    RAISE_APPLICATION_ERROR(-20010,errmsg);                 	
        WHEN OTHERS THEN
            fbs_util_pkg.write_log('FBS', sqlerrm);
            RAISE_APPLICATION_ERROR(-20020,sqlerrm);                  
    END ;