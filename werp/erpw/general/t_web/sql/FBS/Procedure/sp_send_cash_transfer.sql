	/*************************************************************************/
	/*																		                                   */
	/*	1. ���ID	 : send_cash_transfer									                     */
	/*	2. ����̸�	 : ���ްǺ�	������ü ����								                 */
	/*	3. �ý���	 : ȸ��ý���											                         */
	/*	4. ����ý���: FBS													                         */
	/*	5. �������	 :														                           */
	/*	6. �����	 : PL/SQL												                         */
	/*	7. ���ȯ��	 : Windows2003 Server+ Oracle 9.2.0						           */
	/*	8. ���DBMS	 : Oracle												                         */
	/*	9. ����� ���� �� �ֿ���											                     */
	/*																		                                   */
	/*		- ���ް�(T_FB_CASH_PAY_DATA) ������	ó���Ǹ�, ���� ����ڰ�	ȭ��   */
	/*		  �� ���ؼ�	ȣ��Ǵ� �����̸�, ���������� ���ҵ� ���� ������ ��	   */
	/*		  �Ͽ�,	DIV_SEQ�� �߰�PARAMETER�� �Ͽ�,	SEND_CASH_EACH_TRANSFER	   */
	/*		  �Լ��� ȣ���Ͽ� ó���Ѵ�.										                     */
	/*																		                                   */
	/*		- �Լ����������� DIVIDE�� �Ǽ��� üũ�ϰ�, ������ �ǿ� ���Ͽ�	     */
	/*		  ó���Ϸ� ��, �������ó���� ��� Ȥ��	�Ϻν���, ��ü���п� ��	   */
	/*		  �� �̷���	������ �ִٰ� ó������� RETURN�Ѵ�.				           */
	/*																		                                   */
	/*		- �����۽ÿ��� �� �Լ��� ����ϸ�, ���޽���/�Ϻ����޽����� ���	   */
	/*		  �ش� ���޽��а���	ã�Ƽ� SEND_CASH_EACH_TRANSFER�� ��ȣ���Ͽ�	   */
	/*		  ó���Ѵ�.														                             */
	/*																		                                   */
	/*		- �Լ����������� SEND_CASH_EACH_TRANSFER�� ȣ���Ͽ�	����		       */
	/*		  ó������� ���Ͽ�	PAY_STATUS�� UPDATE�Ѵ�.					             */
	/*			4: ���޿Ϸ�													                             */
	/*			5: ���޽���													                             */
	/*			6: �Ϻ����޽���	=> �������Ұ��϶�, �����Ϻΰ� ������ ���	       */
	/*			7: ��ǥ���													                             */
	/*																		                                   */
	/*		- ��ȯ��														                               */
	/*			����ó�� =>	���� ��üó�� �Ϸ� ��							                   */
	/*			�Ϻ����޽���:[�����޽���]									                       */
	/*					 =>	�������Ұ��� ���, �Ϻ�	���޽��н� ù��° ����	         */
	/*			���޽���:[�����޽���]										                         */
	/*					 =>	���Ұ���1���� ���,	���޽��н� ����				               */
	/*			��ǥ��� =>	��ǥ��ҵ� ���									                     */
	/*																		                                   */
	/* 10. �����ۼ���: LG CNS ����ö										                     */
	/* 11. �����ۼ���: 2005��12��21��										                     */
	/* 12. ����������: �����														                     */
	/* 13. ����������: 2006��02��07��														             */
	/*************************************************************************/
	CREATE OR REPLACE Procedure
	sp_send_cash_transfer( p_pay_seq	   IN NUMBER ,		  -- �����Ϸù�ȣ
								         p_emp_no		   IN VARCHAR2 ) IS -- ���
		
		-- >>>>>>>>>>>>>   ó������	   <<<<<<<<<<<<<<<<<<			
		v_pay_seq       NUMBER := 0;                -- �����Ϸù�ȣ			
		v_div_seq       NUMBER := 0;                -- �����Ϸù�ȣ			
		v_trx_seq       NUMBER := 0;                -- �����Ϸù�ȣ		
		v_commission    NUMBER := 0;                -- commission
		v_result_code		Varchar2(4000);
		v_result_msg		Varchar2(4000);
		v_success_cnt   NUMBER := 0;
		v_cnt           NUMBER := 0;
		v_success_amt   NUMBER := 0;
		v_amt           NUMBER := 0;		
		v_pay_status		Varchar2(10); 
		v_send_date			Varchar2(14);
		v_recv_date			Varchar2(14);
		v_docu_num 			VARCHAR2(7);               -- ������ȣ           
		-- ���� ����
		errmsg           VARCHAR2(500);              -- Error Message Edit
		errflag          INTEGER        DEFAULT 0;   -- Process Error Code
		e_msg            VARCHAR2(100);
		i  		           INTEGER        DEFAULT 0;
		-- User Define Error
		Err         			EXCEPTION;                  -- Select Data Not Found 
			
    -- ������ü data ���� CURSOR   
		CURSOR cash_pay_cursor IS        	
        SELECT a.pay_seq                         AS pay_seq,        -- �����Ϸù�ȣ
        			 b.div_seq                         AS div_seq,        -- �����Ϸù�ȣ
        			 a.out_bank_code                   AS out_bank_code,  -- �������	
        			 replace(a.out_account_no,'-','')  AS out_account_no, -- ��ݰ��¹�ȣ 	
        			 a.in_bank_code                    AS in_bank_code,   -- �Ա�����	
        			 replace(a.in_account_no,'-','')   AS in_account_no,  -- �Աݰ��¹�ȣ	        			         			         			 
        			 b.pay_amt                         AS pay_amt         -- �������ޱݾ�
        FROM  T_FB_CASH_PAY_DATA  a ,
              T_FB_CASH_PAY_DIVIDED_DATA b
        WHERE a.pay_seq  = b.pay_seq
        AND   a.pay_seq  = p_pay_seq
        AND   NVL(b.pay_success_yn ,'N') = 'N'
        ORDER BY a.pay_seq ,
                 b.div_seq ;			
	BEGIN
        -- DATA RECORDS �� �����մϴ�.
        -----------------------------------------
        FOR cash_rec IN cash_pay_cursor LOOP

        	  sp_send_cash_each_transfer ( cash_rec.out_bank_code ,cash_rec.out_account_no ,
        	                               cash_rec.in_bank_code  ,cash_rec.in_account_no  ,
        	                               cash_rec.pay_amt       ,v_commission ,
        	                               v_result_code          ,v_result_msg ,
        	                               v_docu_num             ,v_send_date  ,v_recv_date) ;

    	      BEGIN         
                UPDATE T_FB_CASH_PAY_DIVIDED_DATA
                   SET COMMISSION_AMT = v_commission,
                       PAY_YMD        = DECODE(v_result_code ,'0000',TO_CHAR(SYSDATE,'YYYYMMDD'),NULL),
                       RESULT_TEXT    = v_result_msg ,
                       PAY_SUCCESS_YN = DECODE(v_result_code ,'0000','Y','N')
                 WHERE PAY_SEQ        = cash_rec.PAY_SEQ
                 AND   DIV_SEQ        = cash_rec.DIV_SEQ;
             
		        EXCEPTION
		            WHEN OTHERS THEN
		                RAISE Err ;
		        END;
		        
		        --���������̷¿� �߰�
           	BEGIN	            		
          	SELECT NVL( MAX( TRX_SEQ ),0) + 1
          	INTO   v_trx_seq  
          	FROM   T_FB_CASH_PAY_HISTORY
          	WHERE  PAY_SEQ = cash_rec.pay_seq
          	AND    DIV_SEQ = cash_rec.div_seq ;
          	
		        EXCEPTION
		            WHEN OTHERS THEN
		                RAISE Err ;
		        END;
				        		        
          	BEGIN
            INSERT INTO T_FB_CASH_PAY_HISTORY 
             ( PAY_SEQ ,
               DIV_SEQ ,
               TRX_SEQ ,
               PAY_SUCCESS_YN ,
               DOCU_NUMC ,
               SEND_DATE,
               RECV_DATE,
               RESULT_CODE ,
               RESULT_TEXT )
      			 VALUES 
      			 ( cash_rec.pay_seq ,
               cash_rec.div_seq ,
               v_trx_seq ,
               DECODE(v_result_code ,'0000','Y','N'),
               v_docu_num,
               to_date(v_send_date,'YYYYMMDDHH24MISS') ,
               to_date(v_recv_date,'YYYYMMDDHH24MISS') ,
               v_result_code ,
               v_result_msg );
                                                       
            EXCEPTION
                WHEN OTHERS THEN
											RAISE Err ;
            END;
		        
		        v_cnt := v_cnt + 1 ;
		        v_amt := v_amt + 1 ;
		        IF v_result_code = '0000' THEN
		        	 v_success_cnt := v_success_cnt + 1 ;
		        	 v_success_amt := v_success_amt + cash_rec.pay_amt ;
						END IF;

				END LOOP;
				
				IF v_success_cnt > 0 THEN
					 IF v_cnt = v_success_cnt THEN
				      v_pay_status := '4' ;
				   ELSE 
					    v_pay_status := '6' ;
           END IF ;					    
				ELSE
					 v_pay_status := '5' ;
				END IF ;
					   
	      BEGIN         
            UPDATE T_FB_CASH_PAY_DATA
               SET PAY_METHOD_GUBUN   = 'R' ,
                   PAY_STATUS         = v_pay_status,
                   PAY_YMD            = TO_CHAR(SYSDATE,'YYYYMMDD'),
                   PAY_SUCCESS_AMT    = v_success_amt  ,
                   PAY_FAIL_AMT       = PAY_AMT - v_success_amt ,
                   RESULT_TEXT        = v_result_msg ,
                   LAST_MODIFY_DATE   = TO_CHAR(SYSDATE,'YYYYMMDD'),
                   LAST_MODIFY_EMP_NO = p_emp_no
             WHERE PAY_SEQ            = p_pay_seq ;
         
        EXCEPTION
            WHEN OTHERS THEN
                RAISE Err ;
        END;
		        				
  EXCEPTION
      WHEN Err THEN    
          fbs_util_pkg.write_log('FBS' , sqlerrm);
			    RAISE_APPLICATION_ERROR(-20010,sqlerrm);                 	
      WHEN OTHERS THEN
          fbs_util_pkg.write_log('FBS', sqlerrm);
          RAISE_APPLICATION_ERROR(-20020,sqlerrm);                  
  END	;