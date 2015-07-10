CREATE OR REPLACE Procedure
				sp_depo_miss_req( p_comp_code	   IN VARCHAR2 ,	   -- ������ڵ�
				                  p_bank_code	   IN VARCHAR2 ,	   -- �����ڵ�
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

    FB_DOCU_DEPO_TR_B   VARCHAR2(7) := '0200300'; /*  ���ݰŷ�������(����=>��ü)  */
    FB_DOCU_DEPO_MISS_T VARCHAR2(7) := '0200600'; /*  ���ݰŷ����    (��ü=>����)  */
    FB_DOCU_DEPO_MISS_B VARCHAR2(7) := '0210600'; /*  ���ݰŷ����    (����=>��ü)  */    
        
		DEFAULT_TIMEOUT     NUMBER(10)   := 60;
		SUCCESS_CODE		Constant Varchar2(2) := 'OK';
		
	BEGIN
		-- >>>>>>>>>>>>>   ó������	   <<<<<<<<<<<<<<<<<<
		--������ȣ 
	  v_docu_num := FB_DOCU_DEPO_MISS_T ;

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
    AND DOCU_CODE = SUBSTRB(FB_DOCU_DEPO_TR_B,1,4) 
    AND UPMU_CODE = SUBSTRB(FB_DOCU_DEPO_TR_B,5,3) 
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
    AND ( (  DOCU_CODE = SUBSTRB( FB_DOCU_DEPO_TR_B , 1 , 4 )
             AND UPMU_CODE = SUBSTRB( FB_DOCU_DEPO_TR_B , 5 , 3 )
             AND DOCU_NUMC = p_miss_num )
         OR( DOCU_CODE = SUBSTRB( FB_DOCU_DEPO_MISS_B , 1 , 4 )
             AND UPMU_CODE = SUBSTRB( FB_DOCU_DEPO_MISS_B , 5 , 3 )   
             AND DOCU_NUMC = p_miss_num  )
    );
       
    IF v_cnt > 0 THEN
       Raise_Application_Error(-20009,'ó���� �Ϸ�� ��ȣ�Դϴ�.');
    END IF;
		
		-- ������ ����		
		lrSend.gaeb_area :=		fbs_util_pkg.sprintf( '%-15s' , '' ) ||
													fbs_util_pkg.sprintf( '%-2s'  , '' ) ||
													fbs_util_pkg.sprintf( '%-2s'  , '' ) ||
													fbs_util_pkg.sprintf( '%-13s' , '' ) ||
													fbs_util_pkg.sprintf( '%-13s' , '' ) ||
                          fbs_util_pkg.sprintf( '%-22s' , '' ) ||
                          fbs_util_pkg.sprintf( '%-10s' , '' ) ||
                          fbs_util_pkg.sprintf( '%-16s' , '' ) ||
                          fbs_util_pkg.sprintf( '%-8s'  , p_trade_ymd ) || -- ���õǴ� ��
                          fbs_util_pkg.sprintf( '%-6s'  , '' ) ||
                          fbs_util_pkg.sprintf( '%-13s' , '' ) ||
                          fbs_util_pkg.sprintf( '%-13s' , '' ) ||
                          fbs_util_pkg.sprintf( '%-13s' , '' ) ||
                          fbs_util_pkg.sprintf( '%-6s'  , p_miss_num ) ||  -- ���õǴ� ��
                          fbs_util_pkg.sprintf( '%-6s'  , '' ) ||
                          fbs_util_pkg.sprintf( '%-6s'  , '' ) ||
                          fbs_util_pkg.sprintf( '%-8s'  , '' ) ||
                          fbs_util_pkg.sprintf( '%-28s' , '' );  

		lsRet := fbs_main_pkg.send_realtime_document(lrSend,DEFAULT_TIMEOUT,lrRecv,v_result_code,v_result_msg);

		If lsRet <>	SUCCESS_CODE Then
				fbs_util_pkg.write_log('FBS', sqlerrm||'(���:'||p_miss_num||')');
				RAISE_APPLICATION_ERROR(-20010 ,sqlerrm||'(���:'||p_miss_num||')');
		End	If;
		
		ltNums(1) :=  15;	 --1.���¹�ȣ            
		ltNums(2) :=   2;	 --2.�ŷ�����               
		ltNums(3) :=   2;	 --3.�ŷ��߻�����            
		ltNums(4) :=  13;	 --4.�ŷ��ݾ�
		ltNums(5) :=  13;	 --5.�ŷ����ܾ�              
		ltNums(6) :=   6;	 --6.�����ڵ�          
		ltNums(7) :=  16;	 --7.�Ա��μ���               
		ltNums(8) :=  10;	 --8.�����׼�ǥ��ȣ             
		ltNums(9) :=  16;	 --9.CMS�ڵ�
		ltNums(10):=   8;	 --10.�ŷ�����               
		ltNums(11):=   6;	 --11.�ŷ��ð�          
		ltNums(12):=  13;	 --12.����                
		ltNums(13):=  13;	 --13.�����ǥ             
		ltNums(14):=  13;	 --14.Ÿ����
		ltNums(15):=   6;	 --15.���ŷ�������ȣ               				
		ltNums(16):=   6;	 --16.�Ϸù�ȣ              				
		ltNums(17):=   6;	 --17.��ҽ��Ϸù�ȣ                				
		ltNums(18):=   8;	 --18.��ҽðŷ�����               				
		ltNums(19):=   1;	 --19.����(�ܾ׺�ȣ) 
		ltNums(20):=  27;	 --20.����                				               				

		ltVars := fbs_main_pkg.SplitDocu(lrRecv.gaeb_area,ltNums);
		
		--���ݰŷ��� INSERT	
    INSERT INTO T_FB_CASH_TRX_DATA	
    ( BANK_CODE , --�ŷ��߻����� 
      ACCOUNT_NO, --���¹�ȣ
      TRADE_YMD,  --�ŷ�����
      DOCU_NUMC,  --���ŷ�������ȣ
      TRX_GUBUN,  --�ŷ�����
      TRADE_TIME, --�ŷ��ð�
      RECV_AMT,   --�ŷ��ݾ�(�Աݽ�)
      PAY_AMT,    --�ŷ��ݾ�(���޽�)
      REMAIN_AMT, --�ŷ����ܾ�   
      ENABLE_AMT, --���� 
      IN_OUT_NAME,--�Ա��μ��� 
      CMS_CODE,   --CMS�ڵ�
      COMP_CODE ) --�����
    VALUES  
    ( ltVars(3) ,
      ltVars(1) ,
			ltVars(10),
			ltVars(15),
			ltVars(2) ,
			ltVars(11),
			ltVars(4) ,
			ltVars(4) ,
			ltVars(5) ,
			ltVars(12),
			ltVars(7) ,
			ltVars(9) ,
			p_comp_code ) ;		

EXCEPTION
	WHEN OTHERS THEN		
			fbs_util_pkg.write_log('FBS', sqlerrm||'(���:'||p_miss_num||')');
			RAISE_APPLICATION_ERROR(-20010 ,sqlerrm||'(���:'||p_miss_num||')');
END 	;
/
