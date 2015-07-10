	/*************************************************************************/
	/*																		                                   */
	/*	1. 모듈ID	 : send_cash_transfer									                     */
	/*	2. 모듈이름	 : 지급건별	현금이체 지급								                 */
	/*	3. 시스템	 : 회계시스템											                         */
	/*	4. 서브시스템: FBS													                         */
	/*	5. 모듈유형	 :														                           */
	/*	6. 모듈언어	 : PL/SQL												                         */
	/*	7. 모듈환경	 : Windows2003 Server+ Oracle 9.2.0						           */
	/*	8. 모듈DBMS	 : Oracle												                         */
	/*	9. 모듈의 목적 및 주요기능											                     */
	/*																		                                   */
	/*		- 지급건(T_FB_CASH_PAY_DATA) 단위로	처리되며, 실제 사용자가	화면   */
	/*		  을 통해서	호출되는 단위이며, 내부적으로 분할된 내역 각각에 대	   */
	/*		  하여,	DIV_SEQ를 추가PARAMETER로 하여,	SEND_CASH_EACH_TRANSFER	   */
	/*		  함수를 호출하여 처리한다.										                     */
	/*																		                                   */
	/*		- 함수내부적으로 DIVIDE된 건수를 체크하고, 각각의 건에 대하여	     */
	/*		  처리완료 후, 모두정상처리된 경우 혹은	일부실패, 전체실패에 대	   */
	/*		  한 이력을	가지고 있다가 처리결과를 RETURN한다.				           */
	/*																		                                   */
	/*		- 재전송시에도 본 함수를 사용하며, 지급실패/일부지급실패인 경우	   */
	/*		  해당 지급실패건을	찾아서 SEND_CASH_EACH_TRANSFER를 재호출하여	   */
	/*		  처리한다.														                             */
	/*																		                                   */
	/*		- 함수내부적으로 SEND_CASH_EACH_TRANSFER를 호출하여	받은		       */
	/*		  처리결과에 대하여	PAY_STATUS를 UPDATE한다.					             */
	/*			4: 지급완료													                             */
	/*			5: 지급실패													                             */
	/*			6: 일부지급실패	=> 여러분할건일때, 그중일부가 실패한 경우	       */
	/*			7: 전표취소													                             */
	/*																		                                   */
	/*		- 반환값														                               */
	/*			정상처리 =>	정상 이체처리 완료 시							                   */
	/*			일부지급실패:[오류메시지]									                       */
	/*					 =>	여러분할것인 경우, 일부	지급실패시 첫번째 오류	         */
	/*			지급실패:[오류메시지]										                         */
	/*					 =>	분할건이1건인 경우,	지급실패시 오류				               */
	/*			전표취소 =>	전표취소된 경우									                     */
	/*																		                                   */
	/* 10. 최초작성자: LG CNS 신인철										                     */
	/* 11. 최초작성일: 2005년12월21일										                     */
	/* 12. 최종수정자: 배민정														                     */
	/* 13. 최종수정일: 2006년02월07일														             */
	/*************************************************************************/
	CREATE OR REPLACE Procedure
	sp_send_cash_transfer( p_pay_seq	   IN NUMBER ,		  -- 지급일련번호
								         p_emp_no		   IN VARCHAR2 ) IS -- 사번
		
		-- >>>>>>>>>>>>>   처리로직	   <<<<<<<<<<<<<<<<<<			
		v_pay_seq       NUMBER := 0;                -- 지급일련번호			
		v_div_seq       NUMBER := 0;                -- 지급일련번호			
		v_trx_seq       NUMBER := 0;                -- 지급일련번호		
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
		v_docu_num 			VARCHAR2(7);               -- 전문번호           
		-- 공통 변수
		errmsg           VARCHAR2(500);              -- Error Message Edit
		errflag          INTEGER        DEFAULT 0;   -- Process Error Code
		e_msg            VARCHAR2(100);
		i  		           INTEGER        DEFAULT 0;
		-- User Define Error
		Err         			EXCEPTION;                  -- Select Data Not Found 
			
    -- 현금이체 data 추출 CURSOR   
		CURSOR cash_pay_cursor IS        	
        SELECT a.pay_seq                         AS pay_seq,        -- 지급일련번호
        			 b.div_seq                         AS div_seq,        -- 분할일련번호
        			 a.out_bank_code                   AS out_bank_code,  -- 출금은행	
        			 replace(a.out_account_no,'-','')  AS out_account_no, -- 출금계좌번호 	
        			 a.in_bank_code                    AS in_bank_code,   -- 입금은행	
        			 replace(a.in_account_no,'-','')   AS in_account_no,  -- 입금계좌번호	        			         			         			 
        			 b.pay_amt                         AS pay_amt         -- 분할지급금액
        FROM  T_FB_CASH_PAY_DATA  a ,
              T_FB_CASH_PAY_DIVIDED_DATA b
        WHERE a.pay_seq  = b.pay_seq
        AND   a.pay_seq  = p_pay_seq
        AND   NVL(b.pay_success_yn ,'N') = 'N'
        ORDER BY a.pay_seq ,
                 b.div_seq ;			
	BEGIN
        -- DATA RECORDS 를 생성합니다.
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
		        
		        --현금지급이력에 추가
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
