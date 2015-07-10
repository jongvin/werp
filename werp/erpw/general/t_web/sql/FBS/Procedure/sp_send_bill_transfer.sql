	/*************************************************************************/
	/*																		                                   */
	/*	1. ���ID	 : send_bill_transfer									                     */
	/*	2. ����̸�	 : ���ްǺ�	���ھ��� realtime �۽�						           */
	/*	3. �ý���	 : ȸ��ý���											                         */
	/*	4. ����ý���: FBS													                         */
	/*	5. �������	 :														                           */
	/*	6. �����	 : PL/SQL												                         */
	/*	7. ���ȯ��	 : Windows2003 Server+ Oracle 9.2.0						           */
	/*	8. ���DBMS	 : Oracle												                         */
	/*	9. ����� ���� �� �ֿ���											                     */
	/*																		                                   */
	/*		- Realtime���� ���ھ����� �����ϴ� ����� �����մϴ�.			         */
	/*																		                                   */
	/*		- ��ȯ��														                               */
	/*			����ó�� =>	���� ����ó�� �Ϸ� ��							                   */
	/*			���޽��� =>	���޽��� ����									                       */
	/*			��ǥ��� =>	��ǥ��ҵ� ���									                     */
	/*																		                                   */
	/* 10. �����ۼ���: LG CNS ����ö										                     */
	/* 11. �����ۼ���: 2005��12��21��										                     */
	/* 12. ����������:														                           */
	/* 13. ����������:														                           */
	/*************************************************************************/
	CREATE OR REPLACE Procedure
	sp_send_bill_transfer( p_pay_seq	         IN NUMBER ,		   -- �����Ϸù�ȣ
												 p_out_bank_code	   IN VARCHAR2 ,	   -- ��������ڵ�
												 p_out_acct_number	 IN VARCHAR2 ,	   -- ��ݰ��¹�ȣ
			 									 p_in_bank_code	     IN VARCHAR2 ,	   -- �Ա������ڵ�
												 p_in_acct_number	   IN VARCHAR2 ,	   -- �Աݰ��¹�ȣ
												 p_regist_number	   IN VARCHAR2 ,	   -- ����ڹ�ȣ
												 p_check_no	         IN VARCHAR2 ,	   -- ��ǥ/������ȣ
												 p_future_ymd	       IN VARCHAR2 ,	   -- ��������
												 p_pay_amt	         IN NUMBER   ,	   -- ��ü�ݾ�
												 p_franchise_no	     IN VARCHAR2 ,	   -- ��������ȣ
								         p_emp_no		         IN VARCHAR2 ) IS  -- ���

		-- >>>>>>>>>>>>>   ó������	   <<<<<<<<<<<<<<<<<<		
		lrSend						fbs_main_pkg.FB_VAN_SEND_RECORD;
		lrRecv						fbs_main_pkg.FB_VAN_RECV_RECORD;
		ltVars						fbs_main_pkg.T_Vars;
		ltNums						fbs_main_pkg.T_Nums;		
			
		lsRet						    Varchar2(4000);
		v_result_code				Varchar2(4000);
		v_result_msg				Varchar2(4000);		
		v_docu_code 				VARCHAR2(7);                -- �����ڵ�
		v_docu_numc 				VARCHAR2(6);                -- ������ȣ
		v_today             VARCHAR2(8); 
		v_trx_seq           NUMBER:=0; 
		v_send_date 				Varchar2(14);		
		v_recv_date 				Varchar2(14);		
		
		-- ���� ����
		errmsg           VARCHAR2(500);              -- Error Message Edit
		errflag          INTEGER        DEFAULT 0;   -- Process Error Code
		e_msg            VARCHAR2(100);
		i  		           INTEGER        DEFAULT 0;
		-- User Define Error
		Err         			EXCEPTION;                  -- Select Data Not Found 

    FB_DOCU_BILL_ISSUE_T    VARCHAR2(7) := '0100310'; /*  ��������        (��ü=>����)  */
    FB_DOCU_BILL_ISSUE_B    VARCHAR2(7) := '0110310'; /*  ��������        (����=>��ü)  */

		DEFAULT_TIMEOUT         NUMBER(10)   := 60;
		SUCCESS_CODE		Constant Varchar2(2) := 'OK';
		
	BEGIN

		v_docu_code := FB_DOCU_BILL_ISSUE_T ;
		v_today := TO_CHAR(SYSDATE,'YYYYMMDD');
		
		--.�⺻	�ʱ�ȭ
		fbs_main_pkg.init_van_send_record(p_out_bank_code,p_out_acct_number,v_docu_code,lrSend);

		-- ������ ����
		lrSend.gaeb_area :=		fbs_util_pkg.sprintf('%-8.8s'  , v_today) ||		                 --1.��������
													fbs_util_pkg.sprintf('%-1.1s'  , ''  )    ||		                 --2.���۱���
													fbs_util_pkg.sprintf('%-1.1s'  , ''  )    ||		                 --3.��������
													fbs_util_pkg.sprintf('%-10.10s', p_regist_number ) ||		         --4.����ڹ�ȣ
													fbs_util_pkg.sprintf('%-14.14s', p_check_no	)      ||				     --5.������ȣ
													fbs_util_pkg.sprintf('%-2.2s'  , SUBSTRB(p_check_no,1,2) )	||	 --6.�ŷ�����
													fbs_util_pkg.sprintf('%-8.8s'  , p_future_ymd	 )            ||	 --7.��������
													fbs_util_pkg.sprintf('%-2.2s'  , p_in_bank_code)            ||	 --8.�����ڵ�
													fbs_util_pkg.sprintf('%-15.15s', p_out_acct_number	)       ||	 --9.���¹�ȣ
													fbs_util_pkg.sprintf('%-15.15s', LPAD(TO_CHAR(p_pay_amt),15,'0') )||--10.ó���ݾ�
													fbs_util_pkg.sprintf('%-10.10s', p_franchise_no	) ||				     --11.�������ȣ
													fbs_util_pkg.sprintf('%-20.20s', '' )	||					               --12.��������
													fbs_util_pkg.sprintf('%-2.2s'  , '' )	||					               --13.�������
													fbs_util_pkg.sprintf('%-20.20s', '' )	||					               --14.ȸ����������																									
													fbs_util_pkg.sprintf('%-72.72s', ''	) ;				                   --15.����		    			

		lsRet := fbs_main_pkg.send_realtime_document(lrSend,DEFAULT_TIMEOUT,lrRecv,v_result_code,v_result_msg);

		If lsRet <>	SUCCESS_CODE Then
			 v_result_msg := lsRet;
       fbs_util_pkg.write_log('FBS' , v_result_msg);
	     RAISE_APPLICATION_ERROR(-20030,v_result_msg);
			 Return;
		End	If;

		ltNums(1)  :=   8;	--1.��������      
		ltNums(2)  :=   1;	--2.���۱���      
		ltNums(3)  :=   1;	--3.��������      
		ltNums(4)  :=  10;	--4.����ڹ�ȣ    
		ltNums(5)  :=  14;	--5.������ȣ      
		ltNums(6)  :=   2;	--6.�ŷ�����      
		ltNums(7)  :=   8;	--7.��������      
		ltNums(8)  :=   2;	--8.�����ڵ�      
		ltNums(9)  :=  15;	--9.���¹�ȣ      
		ltNums(10) :=  15;	--10.ó���ݾ�     
		ltNums(11) :=  10;	--11.�������ȣ 
		ltNums(12) :=  20;	--12.��������    
		ltNums(13) :=   2;	--13.�������    
		ltNums(12) :=  20;	--14.ȸ����������
		ltNums(13) :=  72;	--15.����		     

		ltVars := fbs_main_pkg.SplitDocu(lrRecv.gaeb_area,ltNums);

		v_send_date := lrSend.send_date||lrSend.send_time;
		v_recv_date := lrRecv.send_date||lrRecv.send_time;
		v_docu_numc := lrSend.docu_numc;

    --���������̷¿� �߰�
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
