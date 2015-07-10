CREATE OR REPLACE PROCEDURE
		 sp_retrive_acct_holder_name( p_comp_code	   IN VARCHAR2 ,	   -- ������ڵ�
		                              p_bank_code	   IN VARCHAR2 ,	   -- �����ڵ�
															    p_acct_number	 IN VARCHAR2 ,	   -- ���¹�ȣ
															    p_biz_number	 IN VARCHAR2 ,     -- �ֹ�(�����)��ȣ
															    p_holder_name	 OUT VARCHAR2,     -- �����ָ�
															    p_result_msg	 OUT VARCHAR2)IS   -- ������
			
		lrSend						fbs_main_pkg.FB_VAN_SEND_RECORD;
		lrRecv						fbs_main_pkg.FB_VAN_RECV_RECORD;
		ltVars						fbs_main_pkg.T_Vars;
		ltNums						fbs_main_pkg.T_Nums;

		lsRet						  Varchar2(4000);
		v_result_code			Varchar2(4000);
		v_result_msg			Varchar2(4000);
		v_acct_number     Varchar2(4000);
		v_holder_name     Varchar2(15);

		v_docu_num 				VARCHAR2(7);                -- ������ȣ
   
    FB_DOCU_NAME_CHECK_T    VARCHAR2(7) := '0400400'; /*  ������ ������ȸ (��ü=>����)  */
    FB_DOCU_NAME_CHECK_B    VARCHAR2(7) := '0410400'; /*  ������ ������ȸ (����=>��ü)  */
    
		DEFAULT_TIMEOUT     NUMBER(10)   := 60;
		SUCCESS_CODE		Constant Varchar2(2) := 'OK';
		
	BEGIN
		-- >>>>>>>>>>>>>   ó������	   <<<<<<<<<<<<<<<<<<
		--������ȣ 
	  v_docu_num := FB_DOCU_NAME_CHECK_T ;
    v_acct_number := replace(p_acct_number ,'-','');		
		
		--.�⺻	�ʱ�ȭ
		Begin
			Select
				a.TRAN_CODE,
				a.ENTE_CODE
			Into
				lrSend.tran_code,
				lrSend.ente_code
			From	T_FB_ORG_BANK a
			Where	a.COMP_CODE      = p_comp_code
			And		a.BANK_MAIN_CODE = p_bank_code;
			
		Exception When No_Data_Found Then
			Raise_Application_Error(-20009,'����ŷ������� �����Ǿ�	���� �ʽ��ϴ�.');
		End;
		
		lrSend.bank_code :=	p_bank_code;
		lrSend.send_date :=	To_Char(SysDate,'YYYYMMDD');
		lrSend.send_time :=	To_Char(SysDate,'HH24MISS');
		lrSend.send_cont :=	'1';
		-- �����ڵ�	�� �����ڵ�	����
		lrSend.docu_code :=	substrb(v_docu_num ,1,4);
		lrSend.upmu_code :=	substrb(v_docu_num ,5,3);
		--���� ��ȣ	ä��
		lrSend.docu_numc :=	F_T_Gen_docu_numc(lrSend.bank_code,lrSend.docu_code,lrSend.upmu_code,lrSend.send_date);		

		-- ������ ����
		lrSend.gaeb_area :=		fbs_util_pkg.sprintf('%-2.2s'    , p_bank_code) ||		  --1.����
													fbs_util_pkg.sprintf('%-15.15s'  , v_acct_number  ) ||	--2.���¹�ȣ
													fbs_util_pkg.sprintf('%-14.14s'  , p_biz_number ) ||		--3.�ֹ�(�����)��ȣ
													fbs_util_pkg.sprintf('%-14.14s'  , '') ||		            --4.�����ָ�
													fbs_util_pkg.sprintf('%-155.155s', ''	);				        --5.����

		lsRet := fbs_main_pkg.send_realtime_document(lrSend,DEFAULT_TIMEOUT,lrRecv,v_result_code,v_result_msg);

		If lsRet <>	SUCCESS_CODE Then
			 fbs_util_pkg.write_log('FBS', lsRet||'(���¹�ȣ:'||p_acct_number||')');
			 RAISE_APPLICATION_ERROR(-20010 ,lsRet||'(���¹�ȣ:'||p_acct_number||')');	
			 Return ;
		End	If;
		
		ltNums(1) :=   2;	 --1.����       
		ltNums(2) :=  15;	 --2.���¹�ȣ                
		ltNums(3) :=  14;	 --3.�ֹ�(�����)��ȣ  
		ltNums(4) :=  14;	 --4.�����ָ�
		ltNums(5) := 155;	 --5.����                

		ltVars := fbs_main_pkg.SplitDocu(lrRecv.gaeb_area,ltNums);

	  v_holder_name	:= To_Number(ltVars(4)); --4.�����ָ�
	  
	  p_holder_name	:= v_holder_name;
	  p_result_msg	:= v_result_msg; 
		
	END 	;
/
