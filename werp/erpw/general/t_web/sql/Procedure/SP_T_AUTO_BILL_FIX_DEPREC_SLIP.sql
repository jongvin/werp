CREATE OR REPLACE PROCEDURE SP_T_AUTO_BILL_FIX_DEPREC_SLIP
(
	AR_SLIP_ID	  			  NUMBER,
	AR_MAKE_SLIP_NO           VARCHAR2,
	AR_MAKE_DT                VARCHAR2,
	AR_MAKE_SEQ               VARCHAR2,
	AR_SLIP_KIND_TAG          VARCHAR2,
	AR_MAKE_COMP_CODE         VARCHAR2,
	AR_MAKE_DEPT_CODE         VARCHAR2,
	AR_CHARGE_PERS            NUMBER,
	AR_INOUT_DEPT_CODE        VARCHAR2,
	AR_MAKE_PERS              NUMBER,
	AR_MAKE_NAME              VARCHAR2,
	AR_WORK_SLIP_ID           NUMBER,
	AR_WORK_SLIP_IDSEQ        NUMBER,
	AR_CRTUSERNO              NUMBER,
	AR_WORK_CODE			  VARCHAR2,
	AR_WORK_SEQ				  NUMBER,
	AR_COST_DEPT_KND_TAG	  VARCHAR2
)
IS
lnSLIP_IDSEQ     	T_ACC_SLIP_BODY.SLIP_IDSEQ%TYPE;
lnMAKE_SLIPLINE  	T_ACC_SLIP_BODY.MAKE_SLIPLINE%TYPE;


Type T_FIX_ASSET_SEQ	 Is	Table Of T_FIX_SHEET.GET_COST_AMT%Type
		Index By Binary_Integer;
Type T_GET_AMT	 Is	Table Of T_FIX_SHEET.GET_COST_AMT%Type
		Index By Binary_Integer;
Type T_ASSET_ACC_CODE	 Is	Table Of T_ACC_CODE.ACC_CODE%Type
		Index By Binary_Integer;
Type T_DEPT_CODE	 Is	Table Of T_FIX_SHEET.MNG_DEPT_CODE%Type
		Index By Binary_Integer;
Type T_SUM_DT_FROM	 Is	Table Of T_FIX_FURNI_SUM.SUM_DT_FROM%Type
		Index By Binary_Integer;
		
lt_T_FIX_ASSET_SEQ				T_FIX_ASSET_SEQ;
lt_T_DEPREC_AMT					T_GET_AMT;

lt_T_SUM_ACC_CODE				T_ASSET_ACC_CODE;			
lt_T_ACC_CODE				    T_ASSET_ACC_CODE;
		 
lt_T_DEPT_CODE					T_DEPT_CODE;
lt_T_SUM_DT_FROM				T_SUM_DT_FROM;


TYPE SLIP_DETAIL_TABLE IS TABLE OF T_WORK_ACC_SLIP_BODY%ROWTYPE
	INDEX BY BINARY_INTEGER;
ltWORK_SLIP_BODY				SLIP_DETAIL_TABLE;
lrWORK_SLIP_BODY				T_WORK_ACC_SLIP_BODY%ROWTYPE;

lsMNG_DEPT_CODE					VARCHAR2(10);
lsACC_CODE						VARCHAR2(10);
lnSLIP_ID 						Number;
lnSLID_IDSEQ 					Number;
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_AUTO_BILL_FIX_GET_SLIP
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : 감가상각 자동전표 발행
/* 4. 변  경  이  력 : 홍길동 작성(2006-01-31)
/* 5. 관련  프로그램 :
/* 6. 특  기  사  항 :
/**************************************************************************/
BEGIN
	--RAISE_APPLICATION_ERROR	(-20009, 'test');
	BEGIN
		
		select  a.fix_asset_seq,
				b.deprec_amt,
				d.sum_acc_code,
				c.acc_code,
			    b.dept_code,
				b.sum_dt_from
		BULK COLLECT INTO
			    lt_T_FIX_ASSET_SEQ,
			    lt_T_DEPREC_AMT,
				lt_T_SUM_ACC_CODE,
				lt_T_ACC_CODE,
			    lt_T_DEPT_CODE,
				lt_T_SUM_DT_FROM
		from  t_fix_sheet a,
	  		  t_fix_furni_sum b,
	  		  t_fix_deprec_acc_code c,
	  		  t_fix_asset_cls_code d
		where a.fix_asset_seq  = b.fix_asset_seq
		and	  a.asset_cls_code = c.asset_cls_code
		and	  a.asset_cls_code = d.asset_cls_code
		and	  cost_dept_knd_tag= AR_COST_DEPT_KND_TAG
		and	  b.work_seq  = AR_WORK_SEQ;
	
	EXCEPTION WHEN NO_DATA_FOUND THEN
		RAISE_APPLICATION_ERROR	(-20009, '전표발행대상이 없습니다.');
	END;
	
	--RAISE_APPLICATION_ERROR	(-20009, lt_T_FIX_ASSET_SEQ.Count);
	
	lnSLID_IDSEQ :=0;
	
	
	
	INSERT INTO T_ACC_SLIP_HEAD
	(
		SLIP_ID,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		MAKE_SLIPCLS,
		MAKE_SLIPNO,
		MAKE_COMP_CODE,
		MAKE_DEPT_CODE,
		MAKE_DT,
		MAKE_DT_TRANS,
		MAKE_SEQ,
		INOUT_DEPT_CODE,
		MAKE_PERS,
		MAKE_NAME,
		GROUPWARE_SLIPSTATUS,
		KEEP_SLIPNO,
		KEEP_DT,
		KEEP_DT_TRANS,
		KEEP_SEQ,
		KEEP_DEPT_CODE,
		KEEP_KEEPER,
		WORK_CODE,
		CHARGE_PERS,
		SLIP_KIND_TAG,
		TRANSFER_TAG,
		IGNORE_SET_RESET_TAG
	)
	VALUES
	(
		AR_SLIP_ID,--AR_SLIP_ID,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		'3',--AR_MAKE_SLIPCLS,
		AR_MAKE_SLIP_NO,
		AR_MAKE_COMP_CODE,
		AR_MAKE_DEPT_CODE,
		F_T_Stringtodate(AR_MAKE_DT),
		AR_MAKE_DT,--AR_MAKE_DT_TRANS,
		AR_MAKE_SEQ,
		AR_INOUT_DEPT_CODE,
		AR_MAKE_PERS,
		AR_MAKE_NAME,
		NULL,--AR_GROUPWARE_SLIPSTATUS,
		NULL,--AR_KEEP_SLIPNO,
		NULL,--AR_KEEP_DT,
		NULL,--AR_KEEP_DT_TRANS,
		NULL,--AR_KEEP_SEQ,
		NULL,--AR_KEEP_DEPT_CODE,
		NULL,--AR_KEEP_KEEPER,
		AR_WORK_CODE,
		AR_CHARGE_PERS,
		AR_SLIP_KIND_TAG,
		'F',--AR_TRANSFER_TAG,
		'F'--AR_IGNORE_SET_RESET_TAG
	);

	lnMAKE_SLIPLINE := 0;

	
	--자동전표 대상
	FOR liI IN lt_T_FIX_ASSET_SEQ.First..lt_T_FIX_ASSET_SEQ.Last LOOP
		
		
		--감가상각비 계정
		SELECT F_T_Get_Newslip_Idseq()
		INTO lnSLIP_IDSEQ
		FROM DUAL;
			
		lnMAKE_SLIPLINE := lnMAKE_SLIPLINE + 1;
	
		INSERT INTO T_ACC_SLIP_BODY
		(
			   	SLIP_ID ,
				SLIP_IDSEQ ,
				CRTUSERNO ,
				CRTDATE ,
				MAKE_SLIPLINE ,
				ACC_CODE ,
				DB_AMT ,
				CR_AMT ,
				SUMMARY_CODE ,
				TAX_COMP_CODE ,
				COMP_CODE ,
				DEPT_CODE ,
				CLASS_CODE ,
				VAT_CODE ,
				VAT_DT ,
				SUPAMT ,
				VATAMT ,
				CUST_SEQ ,
				CUST_NAME ,
				BANK_CODE ,
				ACCNO ,
				RESET_SLIP_ID ,
				RESET_SLIP_IDSEQ ,
				SUMMARY1 ,
				SUMMARY2 ,
				CHK_NO ,
				BILL_NO ,
				REC_BILL_NO ,
				CP_NO ,
				SECU_NO ,
				LOAN_NO ,
				LOAN_REFUND_NO ,
				LOAN_REFUND_SEQ ,
				DEPOSIT_ACCNO ,
				PAYMENT_SEQ ,
				PAY_CON_CASH ,
				PAY_CON_BILL ,
				PAY_CON_BILL_DT ,
				PAY_CON_BILL_DAYS,
				EMP_NO ,
				ANTICIPATION_DT ,
				MNG_ITEM_CHAR1 ,
				MNG_ITEM_CHAR2 ,
				MNG_ITEM_CHAR3 ,
				MNG_ITEM_CHAR4 ,
				MNG_ITEM_NUM1 ,
				MNG_ITEM_NUM2 ,
				MNG_ITEM_NUM3 ,
				MNG_ITEM_NUM4 ,
				MNG_ITEM_DT1 ,
				MNG_ITEM_DT2 ,
				MNG_ITEM_DT3 ,
				MNG_ITEM_DT4
		)
		VALUES
		(
				AR_SLIP_ID ,
				lnSLIP_IDSEQ ,
				AR_CRTUSERNO,
				SYSDATE,
				LNMAKE_SLIPLINE ,
			    lt_T_ACC_CODE(liI) ,
				lt_T_DEPREC_AMT(liI),--AR_DB_AMT ,
				0,--AR_CR_AMT ,
				NULL,--SUMMARY_CODE ,
				(select tax_comp_code from t_dept_code_org where dept_code = lt_T_DEPT_CODE(liI)) , 
				(select comp_code from t_dept_code_org where dept_code =  lt_T_DEPT_CODE(liI)) , 
				lt_T_DEPT_CODE(liI),  -- 귀속부서-관리부서에서 가져온다.
				(select class_code from t_dept_class_code where dept_code =  lt_T_DEPT_CODE(liI)) , -- 부서코드별 부문코드에서 가져온다.
				null ,--AR_VAT_CODE
				null, --AR_VAT_DT
				0,--AR_SUPAMT ,
				0,--AR_VATAMT ,	
				null, --rFIX_SHEET.CUST_SEQ ,
				null, --lrFIX_SHEET.CUST_NAME ,
				null, --lrFIX_SHEET.BANK_CODE ,-- 화면에서 가져오던, 고정자산 테이블에서 가져오던지
				null, 
				NULL,
				NULL,
				'고정자산감가상각 자동전표',--AR_SUMMARY1 ,
				NULL,--AR_SUMMARY2 ,
				NULL,--AR_CHK_NO ,
				NULL,--BILL_NO ,
				NULL,--.REC_BILL_NO ,
				NULL,--AR_CP_NO ,
				NULL,--AR_SECU_NO ,
				NULL,--AR_LOAN_NO ,
				NULL,--AR_LOAN_REFUND_NO ,
				NULL,--AR_LOAN_REFUND_SEQ ,
				NULL,--AR_DEPOSIT_ACCNO ,
				NULL,--AR_PAYMENT_SEQ ,
				NULL,--AR_PAY_CON_CASH ,
				NULL,--AR_PAY_CON_BILL ,
				NULL,--F_T_STRINGTODATE(AR_PAY_CON_BILL_DT) ,
				NULL,--AR_PAY_CON_BILL_DAYS,
				NULL,--AR_EMP_NO ,
				NULL,--F_T_STRINGTODATE(AR_ANTICIPATION_DT) ,
				NULL,--AR_MNG_ITEM_CHAR1 ,
				NULL,--AR_MNG_ITEM_CHAR2 ,
				NULL,--AR_MNG_ITEM_CHAR3 ,
				NULL,--AR_MNG_ITEM_CHAR4 ,
				NULL,--AR_MNG_ITEM_NUM1 ,
				NULL,--AR_MNG_ITEM_NUM2 ,
				NULL,--AR_MNG_ITEM_NUM3 ,
				NULL,--AR_MNG_ITEM_NUM4 ,
				NULL,--F_T_STRINGTODATE(AR_MNG_ITEM_DT1) ,
				NULL,--F_T_STRINGTODATE(AR_MNG_ITEM_DT2) ,
				NULL,--F_T_STRINGTODATE(AR_MNG_ITEM_DT3) ,
				NULL--F_T_STRINGTODATE(AR_MNG_ITEM_DT4)
	
		);
		
		
		--상대계정 감가상각 누계액
		SELECT F_T_Get_Newslip_Idseq()
		INTO lnSLIP_IDSEQ
		FROM DUAL;
		
		lnMAKE_SLIPLINE := lnMAKE_SLIPLINE + 1;

		INSERT INTO T_ACC_SLIP_BODY
		(
			SLIP_ID ,
			SLIP_IDSEQ ,
			CRTUSERNO ,
			CRTDATE ,
			MAKE_SLIPLINE ,
			ACC_CODE ,
			DB_AMT ,
			CR_AMT ,
			SUMMARY_CODE ,
			TAX_COMP_CODE ,
			COMP_CODE ,
			DEPT_CODE ,
			CLASS_CODE ,
			VAT_CODE ,
			VAT_DT ,
			SUPAMT ,
			VATAMT ,
			CUST_SEQ ,
			CUST_NAME ,
			BANK_CODE ,
			ACCNO ,
			RESET_SLIP_ID ,
			RESET_SLIP_IDSEQ ,
			SUMMARY1 ,
			SUMMARY2 ,
			CHK_NO ,
			BILL_NO ,
			REC_BILL_NO ,
			CP_NO ,
			SECU_NO ,
			LOAN_NO ,
			LOAN_REFUND_NO ,
			LOAN_REFUND_SEQ ,
			DEPOSIT_ACCNO ,
			PAYMENT_SEQ ,
			PAY_CON_CASH ,
			PAY_CON_BILL ,
			PAY_CON_BILL_DT ,
			PAY_CON_BILL_DAYS,
			EMP_NO ,
			ANTICIPATION_DT ,
			MNG_ITEM_CHAR1 ,
			MNG_ITEM_CHAR2 ,
			MNG_ITEM_CHAR3 ,
			MNG_ITEM_CHAR4 ,
			MNG_ITEM_NUM1 ,
			MNG_ITEM_NUM2 ,
			MNG_ITEM_NUM3 ,
			MNG_ITEM_NUM4 ,
			MNG_ITEM_DT1 ,
			MNG_ITEM_DT2 ,
			MNG_ITEM_DT3 ,
			MNG_ITEM_DT4,
			FIX_ASSET_SEQ,
      		CARD_SEQ 
		)
		VALUES
		(
			AR_SLIP_ID ,
			lnSLIP_IDSEQ ,
			AR_CRTUSERNO,
			SYSDATE,
			LNMAKE_SLIPLINE ,
		    lt_T_SUM_ACC_CODE(liI) ,
			0,--AR_DB_AMT ,
			lt_T_DEPREC_AMT(liI),--AR_CR_AMT ,
			NULL,--SUMMARY_CODE ,
			(select tax_comp_code from t_dept_code_org where dept_code = lt_T_DEPT_CODE(liI)) , 
			(select comp_code from t_dept_code_org where dept_code     =  lt_T_DEPT_CODE(liI)) , 
			lt_T_DEPT_CODE(liI),  -- 귀속부서-관리부서에서 가져온다.
			(select class_code from t_dept_class_code where dept_code  =  lt_T_DEPT_CODE(liI)) , -- 부서코드별 부문코드에서 가져온다.
			null ,--AR_VAT_CODE
			null, --AR_VAT_DT
			0,--AR_SUPAMT ,
			0,--AR_VATAMT ,	
			null, --rFIX_SHEET.CUST_SEQ ,
			null, --lrFIX_SHEET.CUST_NAME ,
			null, --lrFIX_SHEET.BANK_CODE ,-- 화면에서 가져오던, 고정자산 테이블에서 가져오던지
			null, 
			NULL,
			NULL,
			'고정자산감가상상각누계액 자동전표',--AR_SUMMARY1 ,
			NULL,--AR_SUMMARY2 ,
			NULL,--AR_CHK_NO ,
			NULL,--BILL_NO ,
			NULL,--.REC_BILL_NO ,
			NULL,--AR_CP_NO ,
			NULL,--AR_SECU_NO ,
			NULL,--AR_LOAN_NO ,
			NULL,--AR_LOAN_REFUND_NO ,
			NULL,--AR_LOAN_REFUND_SEQ ,
			NULL,--AR_DEPOSIT_ACCNO ,
			NULL,--AR_PAYMENT_SEQ ,
			NULL,--AR_PAY_CON_CASH ,
			NULL,--AR_PAY_CON_BILL ,
			NULL,--F_T_STRINGTODATE(AR_PAY_CON_BILL_DT) ,
			NULL,--AR_PAY_CON_BILL_DAYS,
			NULL,--AR_EMP_NO ,
			NULL,--F_T_STRINGTODATE(AR_ANTICIPATION_DT) ,
			NULL,--AR_MNG_ITEM_CHAR1 ,
			NULL,--AR_MNG_ITEM_CHAR2 ,
			NULL,--AR_MNG_ITEM_CHAR3 ,
			NULL,--AR_MNG_ITEM_CHAR4 ,
			NULL,--AR_MNG_ITEM_NUM1 ,
			NULL,--AR_MNG_ITEM_NUM2 ,
			NULL,--AR_MNG_ITEM_NUM3 ,
			NULL,--AR_MNG_ITEM_NUM4 ,
			NULL,--F_T_STRINGTODATE(AR_MNG_ITEM_DT1) ,
			NULL,--F_T_STRINGTODATE(AR_MNG_ITEM_DT2) ,
			NULL,--F_T_STRINGTODATE(AR_MNG_ITEM_DT3) ,
			NULL,--F_T_STRINGTODATE(AR_MNG_ITEM_DT4)
			NULL,
			NULL

		);
		
		
		
		--고정자산 부서별감가상각  
		UPDATE T_FIX_FURNI_SUM
		SET
				MODUSERNO  = AR_CRTUSERNO,
				SLIP_ID    = AR_SLIP_ID,
				SLIP_IDSEQ = lnSLIP_IDSEQ
		WHERE	FIX_ASSET_SEQ = lt_T_FIX_ASSET_SEQ(liI)
		AND		WORK_SEQ   	  = AR_WORK_SEQ
		AND		DEPT_CODE     = lt_T_DEPT_CODE(liI)
		AND		SUM_DT_FROM   = lt_T_SUM_DT_FROM(liI);
	END LOOP;
	

	
END;
/
