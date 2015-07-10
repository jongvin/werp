CREATE OR REPLACE Procedure
				sp_send_cash_each_transfer( p_out_bank_code	   IN VARCHAR2 ,	   -- ��������ڵ�
																	  p_out_acct_number	 IN VARCHAR2 ,	   -- ��ݰ��¹�ȣ
								 									  p_in_bank_code	   IN VARCHAR2 ,	   -- �Ա������ڵ�
																	  p_in_acct_number	 IN VARCHAR2 ,	   -- �Աݰ��¹�ȣ
																	  p_pay_amt	         IN NUMBER   ,	   -- ��ü�ݾ�									 
																	  p_commission       OUT NUMBER  ,     -- ������
																	  p_resp_code	       OUT VARCHAR2,     -- �����ڵ�
																	  p_resp_msg		     OUT VARCHAR2,     -- �����ڵ��
																	  p_docu_numc		     OUT VARCHAR2,     -- ������ȣ
																	  p_send_date		     OUT VARCHAR2,     -- ���۽ð�
																	  p_recv_date		     OUT VARCHAR2 ) IS -- ����ð�
		                									 	
		lrSend						fbs_main_pkg.FB_VAN_SEND_RECORD;
		lrRecv						fbs_main_pkg.FB_VAN_RECV_RECORD;
		ltVars						fbs_main_pkg.T_Vars;
		ltNums						fbs_main_pkg.T_Nums;

		lsRet						    Varchar2(4000);
		v_result_code				Varchar2(4000);
		v_result_msg				Varchar2(4000);		
		v_account_pass			VARCHAR2(8);                -- ��й�ȣ
		v_docu_num 					VARCHAR2(7);                -- ������ȣ
		v_real_sign_no 			VARCHAR2(6);                -- �����ȣ
   
    FB_DOCU_DATR_T      VARCHAR2(7) := '0100100'; /*  ������ü        (��ü=>����)  */
    FB_DOCU_DATR_B      VARCHAR2(7) := '0110100'; /*  ������ü        (����=>��ü)  */
    FB_DOCU_TATR_T      VARCHAR2(7) := '0100200'; /*  Ÿ����ü        (��ü=>����)  */
    FB_DOCU_TATR_B      VARCHAR2(7) := '0110200'; /*  Ÿ����ü        (����=>��ü)  */
    
		DEFAULT_TIMEOUT     NUMBER(10)   := 60;
		SUCCESS_CODE		Constant Varchar2(2) := 'OK';
		
	BEGIN
		-- >>>>>>>>>>>>>   ó������	   <<<<<<<<<<<<<<<<<<
							
    -- ������������� �����ɴϴ�.(�����й�ȣ,��ü��й�ȣ)
    SELECT fbs_util_pkg.pw_decode( NEW_PASSWORD , 4 )||
    			 fbs_util_pkg.pw_decode( NEW_PASSWORD , 4 )
    INTO   v_account_pass 
    FROM   T_FB_ACCOUNTS_PWD
    WHERE  ACCOUNT_NO = p_out_acct_number ;

		--������ȣ 
		IF p_out_bank_code = p_in_bank_code  THEN
			 v_docu_num := FB_DOCU_DATR_T ;
		ELSE	
			 v_docu_num := FB_DOCU_TATR_T ;
		END IF;			 

    -- �����ȣ
    SELECT fbs_util_pkg.get_real_sign_no (p_out_bank_code ,p_out_acct_number ,
                             p_in_bank_code  ,p_in_acct_number  ,p_pay_amt,v_docu_num )
    INTO   v_real_sign_no
    FROM   dual ;    

		--.�⺻	�ʱ�ȭ
		fbs_main_pkg.init_van_send_record(p_out_bank_code,p_out_acct_number,v_docu_num,lrSend);
		
		-- ������ ����
		lrSend.gaeb_area :=		fbs_util_pkg.sprintf('%-15.15s', p_in_acct_number) ||		--1.��ݰ��¹�ȣ
													fbs_util_pkg.sprintf('%-8.8s'  , v_account_pass  ) ||		--2.��й�ȣ(8)
													fbs_util_pkg.sprintf('%-6.6s'  , v_real_sign_no  ) ||		--3.�����ȣ
													fbs_util_pkg.sprintf('%-13.13s', LPAD(TO_CHAR(p_pay_amt),13,'0')) ||		--4.��ݱݾ�
													fbs_util_pkg.sprintf('%-1.1s'  , ''	) ||				        --5.������ܾ׺�ȣ
													fbs_util_pkg.sprintf('%-13.13s', '' )	||					      --6.������ܾ�
													fbs_util_pkg.sprintf('%-2.2s'  , p_in_bank_code	 ) ||		--7.�Ա������ڵ�
													fbs_util_pkg.sprintf('%-15.15s', p_in_acct_number) ||		--8.�Աݰ��¹�ȣ
													fbs_util_pkg.sprintf('%-13.13s', ''	) ||				        --9.������
													fbs_util_pkg.sprintf('%-6.6s'  , '' )	||					      --10.CMS�ڵ�
													fbs_util_pkg.sprintf('%-22.22s', ''	) ||				        --11.�Ա��� ����(������)
													fbs_util_pkg.sprintf('%-14.14s', '' )	||					      --12.�Ա�����������
													fbs_util_pkg.sprintf('%-72.72s', ''	) ;				          --13.����

		lsRet := fbs_main_pkg.send_realtime_document(lrSend,DEFAULT_TIMEOUT,lrRecv,v_result_code,v_result_msg);

		If lsRet <>	SUCCESS_CODE Then
			 p_resp_msg := lsRet;
       fbs_util_pkg.write_log('FBS' , p_resp_msg);
	     RAISE_APPLICATION_ERROR(-20030,p_resp_msg);
			 Return;
		End	If;
		
		ltNums(1) :=  15;	--1.��ݰ��¹�ȣ           
		ltNums(2) :=   8;	--2.��й�ȣ(8)            
		ltNums(3) :=   6;	--3.�����ȣ               
		ltNums(4) :=  13;	--4.��ݱݾ�               
		ltNums(5) :=   1;	--5.������ܾ׺�ȣ         
		ltNums(6) :=  13;	--6.������ܾ�             
		ltNums(7) :=   2;	--7.8            
		ltNums(8) :=  15;	--8.�Աݰ��¹�ȣ           
		ltNums(9) :=  13;	--9.������                 
		ltNums(10) :=  6;	--10.CMS�ڵ�               
		ltNums(11) := 22;	--11.�Ա��� ����(������) 
		ltNums(12) := 14;	--12.�Ա�����������        
		ltNums(13) :=  7;	--13.����                  


		ltVars := fbs_main_pkg.SplitDocu(lrRecv.gaeb_area,ltNums);

		p_commission	:= To_Number(ltVars(9)); --9.������  
 		p_resp_code	:= v_result_code;
		p_resp_msg := v_result_msg;
		p_send_date := lrSend.send_date||lrSend.send_time;
		p_recv_date := lrRecv.send_date||lrRecv.send_time;
		p_docu_numc := lrSend.docu_numc;
		
	END 	;
