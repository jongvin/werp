	/*************************************************************************/
	/*																		                                   */
	/*	1. 모듈ID	 : send_bill_transfer									                     */
	/*	2. 모듈이름	 : 지급건별	전자어음 realtime 송신						           */
	/*	3. 시스템	 : 회계시스템											                         */
	/*	4. 서브시스템: FBS													                         */
	/*	5. 모듈유형	 :														                           */
	/*	6. 모듈언어	 : PL/SQL												                         */
	/*	7. 모듈환경	 : Windows2003 Server+ Oracle 9.2.0						           */
	/*	8. 모듈DBMS	 : Oracle												                         */
	/*	9. 모듈의 목적 및 주요기능											                     */
	/*																		                                   */
	/*		- Realtime으로 전자어음을 발행하는 기능을 수행합니다.			         */
	/*																		                                   */
	/*		- 반환값														                               */
	/*			정상처리 =>	정상 발행처리 완료 시							                   */
	/*			지급실패 =>	지급실패 오류									                       */
	/*			전표취소 =>	전표취소된 경우									                     */
	/*																		                                   */
	/* 10. 최초작성자: LG CNS 신인철										                     */
	/* 11. 최초작성일: 2005년12월21일										                     */
	/* 12. 최종수정자:														                           */
	/* 13. 최종수정일:														                           */
	/*************************************************************************/
	CREATE OR REPLACE Procedure
	sp_send_bill_transfer( p_pay_seq	         IN NUMBER ,		   -- 지급일련번호
												 p_out_bank_code	   IN VARCHAR2 ,	   -- 출금은행코드
												 p_out_acct_number	 IN VARCHAR2 ,	   -- 출금계좌번호
			 									 p_in_bank_code	     IN VARCHAR2 ,	   -- 입금은행코드
												 p_in_acct_number	   IN VARCHAR2 ,	   -- 입금계좌번호
												 p_regist_number	   IN VARCHAR2 ,	   -- 사업자번호
												 p_check_no	         IN VARCHAR2 ,	   -- 수표/어음번호
												 p_future_ymd	       IN VARCHAR2 ,	   -- 만기일자
												 p_pay_amt	         IN NUMBER   ,	   -- 이체금액
												 p_franchise_no	     IN VARCHAR2 ,	   -- 가맹점번호
								         p_emp_no		         IN VARCHAR2 ) IS  -- 사번

		-- >>>>>>>>>>>>>   처리로직	   <<<<<<<<<<<<<<<<<<		
		lrSend						fbs_main_pkg.FB_VAN_SEND_RECORD;
		lrRecv						fbs_main_pkg.FB_VAN_RECV_RECORD;
		ltVars						fbs_main_pkg.T_Vars;
		ltNums						fbs_main_pkg.T_Nums;		
			
		lsRet						    Varchar2(4000);
		v_result_code				Varchar2(4000);
		v_result_msg				Varchar2(4000);		
		v_docu_code 				VARCHAR2(7);                -- 전문코드
		v_docu_numc 				VARCHAR2(6);                -- 전문번호
		v_today             VARCHAR2(8); 
		v_trx_seq           NUMBER:=0; 
		v_send_date 				Varchar2(14);		
		v_recv_date 				Varchar2(14);		
		
		-- 공통 변수
		errmsg           VARCHAR2(500);              -- Error Message Edit
		errflag          INTEGER        DEFAULT 0;   -- Process Error Code
		e_msg            VARCHAR2(100);
		i  		           INTEGER        DEFAULT 0;
		-- User Define Error
		Err         			EXCEPTION;                  -- Select Data Not Found 

    FB_DOCU_BILL_ISSUE_T    VARCHAR2(7) := '0100310'; /*  어음지불        (업체=>은행)  */
    FB_DOCU_BILL_ISSUE_B    VARCHAR2(7) := '0110310'; /*  어음지불        (은행=>업체)  */

		DEFAULT_TIMEOUT         NUMBER(10)   := 60;
		SUCCESS_CODE		Constant Varchar2(2) := 'OK';
		
	BEGIN

		v_docu_code := FB_DOCU_BILL_ISSUE_T ;
		v_today := TO_CHAR(SYSDATE,'YYYYMMDD');
		
		--.기본	초기화
		fbs_main_pkg.init_van_send_record(p_out_bank_code,p_out_acct_number,v_docu_code,lrSend);

		-- 개별부 설정
		lrSend.gaeb_area :=		fbs_util_pkg.sprintf('%-8.8s'  , v_today) ||		                 --1.전송일자
													fbs_util_pkg.sprintf('%-1.1s'  , ''  )    ||		                 --2.전송구분
													fbs_util_pkg.sprintf('%-1.1s'  , ''  )    ||		                 --3.결제구분
													fbs_util_pkg.sprintf('%-10.10s', p_regist_number ) ||		         --4.사업자번호
													fbs_util_pkg.sprintf('%-14.14s', p_check_no	)      ||				     --5.문서번호
													fbs_util_pkg.sprintf('%-2.2s'  , SUBSTRB(p_check_no,1,2) )	||	 --6.거래구분
													fbs_util_pkg.sprintf('%-8.8s'  , p_future_ymd	 )            ||	 --7.만기일자
													fbs_util_pkg.sprintf('%-2.2s'  , p_in_bank_code)            ||	 --8.은행코드
													fbs_util_pkg.sprintf('%-15.15s', p_out_acct_number	)       ||	 --9.계좌번호
													fbs_util_pkg.sprintf('%-15.15s', LPAD(TO_CHAR(p_pay_amt),15,'0') )||--10.처리금액
													fbs_util_pkg.sprintf('%-10.10s', p_franchise_no	) ||				     --11.은행고객번호
													fbs_util_pkg.sprintf('%-20.20s', '' )	||					               --12.지급지명
													fbs_util_pkg.sprintf('%-2.2s'  , '' )	||					               --13.결과구분
													fbs_util_pkg.sprintf('%-20.20s', '' )	||					               --14.회사임의정보																									
													fbs_util_pkg.sprintf('%-72.72s', ''	) ;				                   --15.예비		    			

		lsRet := fbs_main_pkg.send_realtime_document(lrSend,DEFAULT_TIMEOUT,lrRecv,v_result_code,v_result_msg);

		If lsRet <>	SUCCESS_CODE Then
			 v_result_msg := lsRet;
       fbs_util_pkg.write_log('FBS' , v_result_msg);
	     RAISE_APPLICATION_ERROR(-20030,v_result_msg);
			 Return;
		End	If;

		ltNums(1)  :=   8;	--1.전송일자      
		ltNums(2)  :=   1;	--2.전송구분      
		ltNums(3)  :=   1;	--3.결제구분      
		ltNums(4)  :=  10;	--4.사업자번호    
		ltNums(5)  :=  14;	--5.문서번호      
		ltNums(6)  :=   2;	--6.거래구분      
		ltNums(7)  :=   8;	--7.만기일자      
		ltNums(8)  :=   2;	--8.은행코드      
		ltNums(9)  :=  15;	--9.계좌번호      
		ltNums(10) :=  15;	--10.처리금액     
		ltNums(11) :=  10;	--11.은행고객번호 
		ltNums(12) :=  20;	--12.지급지명    
		ltNums(13) :=   2;	--13.결과구분    
		ltNums(12) :=  20;	--14.회사임의정보
		ltNums(13) :=  72;	--15.예비		     

		ltVars := fbs_main_pkg.SplitDocu(lrRecv.gaeb_area,ltNums);

		v_send_date := lrSend.send_date||lrSend.send_time;
		v_recv_date := lrRecv.send_date||lrRecv.send_time;
		v_docu_numc := lrSend.docu_numc;

    --현금지급이력에 추가
   	BEGIN	            		
  	SELECT NVL( MAX( TRX_SEQ ),0) + 1
  	INTO   v_trx_seq  
  	FROM   T_FB_BILL_PAY_HISTORY
  	WHERE  PAY_SEQ = p_pay_seq ;
  	
    EXCEPTION
        WHEN OTHERS THEN
            RAISE Err ;
    END;
				        		        
  	BEGIN
    INSERT INTO T_FB_BILL_PAY_HISTORY 
     ( PAY_SEQ ,
       TRX_SEQ ,
       PAY_SUCCESS_YN ,
       DOCU_NUMC ,
       SEND_DATE,
       RECV_DATE,
       RESULT_CODE ,
       RESULT_TEXT )
		 VALUES 
		 ( p_pay_seq ,
       v_trx_seq ,
       DECODE(v_result_code ,'0000','Y','N'),
       v_docu_numc,
       to_date(v_send_date,'YYYYMMDDHH24MISS') ,
       to_date(v_recv_date,'YYYYMMDDHH24MISS') ,
       v_result_code ,
       v_result_msg );
                                               
    EXCEPTION
        WHEN OTHERS THEN
							RAISE Err ;
    END;
					   
    BEGIN         
        UPDATE T_FB_BILL_PAY_DATA
           SET PAY_METHOD_GUBUN = 'R' ,
               PAY_STATUS       = DECODE(v_result_code ,'0000','4','5'),
               PAY_YMD          = TO_CHAR(SYSDATE,'YYYYMMDD'),
               RESULT_TEXT      = v_result_msg 
         WHERE PAY_SEQ          = p_pay_seq ;
     
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
