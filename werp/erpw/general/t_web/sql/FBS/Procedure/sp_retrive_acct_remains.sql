CREATE OR REPLACE Procedure
				sp_retrive_acct_remains( p_bank_code	   IN VARCHAR2 ,	   -- �����ڵ�
															   p_acct_number	 IN VARCHAR2 ,	   -- ���¹�ȣ
															   p_remain_amt	   OUT NUMBER  ,	   -- �ܾ�		
															   p_enable_amt    OUT NUMBER  ,     -- �����ڱ�
															   p_resp_code	   OUT VARCHAR2,     -- �����ڵ�
															   p_resp_msg		   OUT VARCHAR2) IS  -- �����ڵ��
		                									 	
		lrSend						  fbs_main_pkg.FB_VAN_SEND_RECORD;
		lrRecv						  fbs_main_pkg.FB_VAN_RECV_RECORD;
		ltVars						  fbs_main_pkg.T_Vars;
		ltNums						  fbs_main_pkg.T_Nums;

		lsRet						    Varchar2(4000);
		v_result_code				Varchar2(4000);
		v_result_msg				Varchar2(4000);		
		v_docu_num 					VARCHAR2(7);                -- ������ȣ
    v_acct_number       Varchar2(4000);
   
    FB_DOCU_REMAIN_T    VARCHAR2(7) := '0600300'; /*  �ܾ���ȸ        (��ü=>����)  */
    FB_DOCU_REMAIN_B    VARCHAR2(7) := '0610300'; /*  �ܾ���ȸ        (����=>��ü)  */
    
		DEFAULT_TIMEOUT     NUMBER(10)   := 60;
		SUCCESS_CODE		Constant Varchar2(2) := 'OK';
		
	BEGIN
		-- >>>>>>>>>>>>>   ó������	   <<<<<<<<<<<<<<<<<<
		
		--������ȣ 
	  v_docu_num := FB_DOCU_REMAIN_T ;
		v_acct_number := replace(p_acct_number ,'-','');
		
		--.�⺻	�ʱ�ȭ
		fbs_main_pkg.init_van_send_record(p_bank_code,v_acct_number,v_docu_num,lrSend);
		
		-- ������ ����
		lrSend.gaeb_area :=		fbs_util_pkg.sprintf('%-15.15s', v_acct_number) ||		  --1.���¹�ȣ
													fbs_util_pkg.sprintf('%-1.1s'  , ''  ) ||		            --2.��ȣ
													fbs_util_pkg.sprintf('%-13.13s', '0000000000000' ) ||		--3.�����ܾ�
													fbs_util_pkg.sprintf('%-13.13s', '0000000000000') ||		--4.���ް��ɾ�
													fbs_util_pkg.sprintf('%-158.158s', ''	);				        --5.����

		lsRet := fbs_main_pkg.send_realtime_document(lrSend,DEFAULT_TIMEOUT,lrRecv,v_result_code,v_result_msg);

		If lsRet <>	SUCCESS_CODE Then
			 p_resp_msg := lsRet;
			 Return;
		End	If;
		
		ltNums(1) :=  15;	 --1.���¹�ȣ            
		ltNums(2) :=   1;	 --2.��ȣ                
		ltNums(3) :=  13;	 --3.�����ܾ�             
		ltNums(4) :=  13;	 --4.���ް��ɾ�
		ltNums(5) := 158;	 --5.����                

		ltVars := fbs_main_pkg.SplitDocu(lrRecv.gaeb_area,ltNums);

		p_remain_amt	:= To_Number(ltVars(3)); --3.�����ܾ�  
	  p_enable_amt	:= To_Number(ltVars(4)); --4.���ް��ɾ� 
 		p_resp_code	  := v_result_code;
		p_resp_msg    := v_result_msg;
		
	END 	;
/
