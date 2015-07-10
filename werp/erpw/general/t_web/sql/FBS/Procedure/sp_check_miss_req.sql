CREATE OR REPLACE Procedure
				sp_check_miss_req( p_comp_code	 IN VARCHAR2 ,	   -- ������ڵ�
				                   p_bank_code	 IN VARCHAR2 ,	   -- �����ڵ�
													 p_trade_ymd 	 IN VARCHAR2 ,	   -- �ŷ�����
													 p_miss_num	   IN VARCHAR2  ) IS -- ���		
		                									 	
		lrSend						fbs_main_pkg.FB_VAN_SEND_RECORD;
		lrRecv						fbs_main_pkg.FB_VAN_RECV_RECORD;
		ltVars						fbs_main_pkg.T_Vars;
		ltNums						fbs_main_pkg.T_Nums;

		lsRet						  Varchar2(4000);
		v_result_code			Varchar2(4000);
		v_result_msg			Varchar2(4000);		
		v_docu_num 				VARCHAR2(7);                -- ������ȣ
		v_docu_numc       NUMBER;
		v_max_docu_numc   NUMBER;
		v_cnt             NUMBER;

    FB_DOCU_BILL_TRX_B   VARCHAR2(7) := '0200400'; /*  �����ŷ���     (����=>��ü) */  
    FB_DOCU_BILL_MISS_T  VARCHAR2(7) := '0200500'; /*  �����������û (��ü=>����) */
    FB_DOCU_BILL_MISS_B  VARCHAR2(7) := '0210500'; /*  �����������û (����=>��ü) */

		DEFAULT_TIMEOUT     NUMBER(10)   := 60;
		SUCCESS_CODE		Constant Varchar2(2) := 'OK';
		
	BEGIN
		-- >>>>>>>>>>>>>   ó������	   <<<<<<<<<<<<<<<<<<
		--������ȣ 
	  v_docu_num := FB_DOCU_BILL_MISS_T ;

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
		lrSend.docu_numc :=	p_miss_num ;
		
    SELECT NVL(TO_NUMBER(MAX(DOCU_NUMC)),0) ,TO_NUMBER(p_miss_num)
    INTO v_max_docu_numc ,v_docu_numc
    FROM T_FB_VAN_RECV
    WHERE SEND_DATE = p_trade_ymd
    AND DOCU_CODE = SUBSTRB(FB_DOCU_BILL_TRX_B,1,4) 
    AND UPMU_CODE = SUBSTRB(FB_DOCU_BILL_TRX_B,5,3) 
    AND ENTE_CODE = lrSend.ente_code
    AND BANK_CODE = lrSend.bank_code ;	
    
    IF v_max_docu_numc < v_docu_numc THEN
       Raise_Application_Error(-20009,'����� �ٽ� Ȯ���ϼ���.');
    END IF; 
                
    -- ���ݰŷ��� Ȥ�� �����û�� �Ͽ�, �̹� �°��� ������ ����ó���մϴ�. 
    SELECT COUNT(*) 
    INTO v_cnt
    FROM T_FB_VAN_RECV
    WHERE ENTE_CODE = lrSend.ente_code
    AND BANK_CODE = lrSend.bank_code
    AND SEND_DATE = p_trade_ymd
    AND ( (  DOCU_CODE = SUBSTRB( FB_DOCU_BILL_TRX_B , 1 , 4 )
             AND UPMU_CODE = SUBSTRB( FB_DOCU_BILL_TRX_B , 5 , 3 )
             AND DOCU_NUMC = p_miss_num )
         OR( DOCU_CODE = SUBSTRB( FB_DOCU_BILL_MISS_B , 1 , 4 )
             AND UPMU_CODE = SUBSTRB( FB_DOCU_BILL_MISS_B , 5 , 3 )   
             AND DOCU_NUMC = p_miss_num  )
    );
       
    IF v_cnt > 0 THEN
       Raise_Application_Error(-20009,'ó���� �Ϸ�� ��ȣ�Դϴ�.');
    END IF;
		
		-- ������ ����		
		lrSend.gaeb_area :=		fbs_util_pkg.sprintf( '%-2s'  , '' ) ||
		                      fbs_util_pkg.sprintf( '%-15s' , '' ) ||													
													fbs_util_pkg.sprintf( '%-8s'  , p_trade_ymd ) ||-- ���õǴ� ��(�ŷ�����)
													fbs_util_pkg.sprintf( '%-6s'  , '' ) ||
													fbs_util_pkg.sprintf( '%-10s' , '' ) ||
                          fbs_util_pkg.sprintf( '%-13s' , '' ) ||
                          fbs_util_pkg.sprintf( '%-14s' , '' ) ||
                          fbs_util_pkg.sprintf( '%-8s'  , '' ) ||
                          fbs_util_pkg.sprintf( '%-16s' , '' ) || 
                          fbs_util_pkg.sprintf( '%-16s' , '' ) ||
                          fbs_util_pkg.sprintf( '%-3s'  , '' ) ||
                          fbs_util_pkg.sprintf( '%-13s' , '' ) ||
                          fbs_util_pkg.sprintf( '%-6s'  , '' ) ||
                          fbs_util_pkg.sprintf( '%-6s'  , p_miss_num ) ||  -- ���õǴ� ��
                          fbs_util_pkg.sprintf( '%-6s'  , '' ) ||
                          fbs_util_pkg.sprintf( '%-6s'  , '' ) ||
                          fbs_util_pkg.sprintf( '%-8s'  , '' ) ||
                          fbs_util_pkg.sprintf( '%-44s' , '' );  

		lsRet := fbs_main_pkg.send_realtime_document(lrSend,DEFAULT_TIMEOUT,lrRecv,v_result_code,v_result_msg);

		If lsRet <>	SUCCESS_CODE Then
				fbs_util_pkg.write_log('FBS', sqlerrm||'(���:'||p_miss_num||')');
				RAISE_APPLICATION_ERROR(-20010 ,sqlerrm||'(���:'||p_miss_num||')');
		End	If;
		
		ltNums(1) :=   2;	 --1.�ŷ�����
		ltNums(2) :=  15;	 --2.���¹�ȣ
		ltNums(3) :=   8;	 --3.�ŷ�����
		ltNums(4) :=   6;	 --4.�ŷ��ð�
		ltNums(5) :=  10;	 --5.������ȣ
		ltNums(6) :=  13;	 --6.�ݾ�
		ltNums(7) :=  14;	 --7.������
		ltNums(8) :=   8;	 --8.������
		ltNums(9) :=  16;	 --9.�������������
		ltNums(10):=  16;	 --10.CMS�ڵ�
		ltNums(11):=   3;	 --11.�׸񺯰��ڵ�
		ltNums(12):=  13;	 --12.�ܾ�
		ltNums(13):=   6;	 --13.�����ڵ�
		ltNums(14):=   6;	 --14.���ŷ�������ȣ
		ltNums(15):=   6;	 --15.�Ϸù�ȣ
		ltNums(16):=   6;	 --16.��ҽ��Ϸù�ȣ
		ltNums(17):=   8;	 --17.��ҽðŷ�����
		ltNums(18):=  44;	 --18.����

		ltVars := fbs_main_pkg.SplitDocu(lrRecv.gaeb_area,ltNums);
		
		--���ݰŷ��� INSERT	
    INSERT INTO T_FB_BILL_TRX_DATA	
    ( BANK_CODE ,          --�ŷ��߻����� 
      ACCOUNT_NO,          --���¹�ȣ
      TRADE_YMD,           --�ŷ�����
      DOCU_NUMC,           --���ŷ�������ȣ
      TRX_GUBUN,           --�ŷ�����
      TRADE_TIME,          --�ŷ��ð�
      BILL_NO,             --������ȣ
      ISSUE_NAME,          --������ 
      FUTURE_PAY_DUE_YMD,  --������
      FUTURE_PAY_BANK_CODE,--�������������
      AMOUNT,              --�ݾ� 
      REMAIN_AMT,          --�ŷ����ܾ�   
      CMS_CODE,            --CMS�ڵ�
      GIRO_CODE,           --�����ڵ�
      COMP_CODE )          --�����
    VALUES  
    ( p_bank_code ,
      ltVars(2) ,
			ltVars(3) ,
			ltVars(14),
			ltVars(1) ,
			ltVars(4) ,
			ltVars(5) ,
			ltVars(7) ,
			ltVars(8) ,
			ltVars(9) ,
			ltVars(6) ,
			ltVars(12),
			ltVars(10),
			ltVars(13),
			p_comp_code ) ;		

EXCEPTION
	WHEN OTHERS THEN		
			fbs_util_pkg.write_log('FBS', sqlerrm||'(���:'||p_miss_num||')');
			RAISE_APPLICATION_ERROR(-20010 ,sqlerrm||'(���:'||p_miss_num||')');
END 	;
/
