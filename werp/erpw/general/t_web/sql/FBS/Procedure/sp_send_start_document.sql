CREATE OR REPLACE Procedure
		sp_send_start_document( p_comp_code	 IN VARCHAR2 ,	   -- ������ڵ�
		                 				p_bank_code	 IN VARCHAR2 ) IS  -- �����ڵ�
		                									 	
		lrSend						fbs_main_pkg.FB_VAN_SEND_RECORD;
		lrRecv						fbs_main_pkg.FB_VAN_RECV_RECORD;

		lsRet						  Varchar2(4000);
		v_result_code			Varchar2(4000);
		v_result_msg			Varchar2(4000);		
		v_docu_num 				VARCHAR2(7);                -- ������ȣ

    FB_DOCU_OPEN_T    VARCHAR2(7) := '0800100'; /*  ��������        (��ü=>����)  */
    FB_DOCU_OPEN_B    VARCHAR2(7) := '0810100'; /*  ��������        (����=>��ü)  */

		DEFAULT_TIMEOUT   NUMBER(10)   := 60;
		SUCCESS_CODE		  Constant Varchar2(2) := 'OK';
		
	BEGIN
		-- >>>>>>>>>>>>>   ó������	   <<<<<<<<<<<<<<<<<<
		--������ȣ 
	  v_docu_num := FB_DOCU_OPEN_T ;

		--.�⺻	�ʱ�ȭ
    BEGIN
		Select
				a.TRAN_CODE,
				a.ENTE_CODE
			Into
				lrSend.tran_code,
				lrSend.ente_code
			From	T_FB_ORG_BANK a
			Where	a.COMP_CODE = p_comp_code
			And		a.BANK_MAIN_CODE = p_bank_code ;
		
		Exception When No_Data_Found Then
			Raise_Application_Error(-20009,'����ŷ������� �����Ǿ�	���� �ʽ��ϴ�.');
		End;
		
		lrSend.bank_code :=	p_bank_code;
		lrSend.send_date :=	To_Char(SysDate,'YYYYMMDD');
		lrSend.send_time :=	To_Char(SysDate,'HH24MISS');
		lrSend.send_cont :=	'1';
		-- �����ڵ�	�� �����ڵ�	����
		lrSend.docu_code :=	SubStrb(v_docu_num,1,4); 
		lrSend.upmu_code :=	SubStrb(v_docu_num,5,3);
		--���� ��ȣ	ä��
		lrSend.docu_numc :=	F_T_Gen_docu_numc(lrSend.bank_code,lrSend.docu_code,lrSend.upmu_code,lrSend.send_date);
		
		-- ������ ����		
		lrSend.gaeb_area :=		fbs_util_pkg.sprintf( '%-200s'  , '' );

		lsRet := fbs_main_pkg.send_realtime_document(lrSend,DEFAULT_TIMEOUT,lrRecv,v_result_code,v_result_msg);

		If lsRet <>	SUCCESS_CODE Then
				fbs_util_pkg.write_log('FBS', sqlerrm||'(����:'||p_bank_code||')');
				RAISE_APPLICATION_ERROR(-20010 ,sqlerrm||'(����:'||p_bank_code||')');
		End	If;

EXCEPTION
	WHEN OTHERS THEN		
			fbs_util_pkg.write_log('FBS', sqlerrm||'(����:'||p_bank_code||')');
			RAISE_APPLICATION_ERROR(-20010 ,sqlerrm||'(����:'||p_bank_code||')');
END 	;
/
