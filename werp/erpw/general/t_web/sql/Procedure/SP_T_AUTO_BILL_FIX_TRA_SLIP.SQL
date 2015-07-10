CREATE OR REPLACE PROCEDURE SP_T_AUTO_BILL_FIX_TRA_SLIP
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
	AR_CRTUSERNO              NUMBER,
	AR_WORK_CODE			  VARCHAR2,
	AR_FIX_ASSET_SEQ		  NUMBER
)
IS
lnSLIP_IDSEQ     	T_ACC_SLIP_BODY.SLIP_IDSEQ%TYPE;
lnMAKE_SLIPLINE  	T_ACC_SLIP_BODY.MAKE_SLIPLINE%TYPE;
lrWORK_SLIP_BODY    T_WORK_ACC_SLIP_BODY%ROWTYPE; 
		
ln_FIX_ASSET_SEQ				NUMBER;
ln_GET_AMT						NUMBER;
ln_SELL_AMT						NUMBER;
ln_SUM_AMT						NUMBER;
ln_DEPREC_SUM_AMT				NUMBER;
ln_ADD_LOSS_AMT					NUMBER;
ln_ADD_LOSS_AMT1				NUMBER;
ln_ADD_LOSS_AMT2				NUMBER;		   
ln_ADD_AMT						NUMBER;	
ln_INCREDU_SEQ					NUMBER; 
ls_SELL_ACC_CODE				T_ACC_CODE.ACC_CODE%TYPE;
ls_SUM_ACC_CODE					T_ACC_CODE.ACC_CODE%TYPE;
ls_TRA_ACC_CODE					T_ACC_CODE.ACC_CODE%TYPE;
ls_SELL_LOSS_ACC_CODE			T_ACC_CODE.ACC_CODE%TYPE;
ls_MNG_DEPT_CODE				T_ACC_CODE.ACC_CODE%TYPE;
ls_SELL_ADD_LOSS_ACC_CODE		T_ACC_CODE.ACC_CODE%TYPE;

/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_AUTO_BILL_FIX_TRA_SLIP
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : 취득 자동전표 발행
/* 4. 변  경  이  력 : 홍길동 작성(2006-01-31)
/* 5. 관련  프로그램 :
/* 6. 특  기  사  항 :
/**************************************************************************/
BEGIN
	
	

	BEGIN
		
		select  b.fix_asset_seq,
				b.get_cost_amt,
				b.old_deprec_amt,
				nvl(b.get_cost_amt,0) - nvl(b.old_deprec_amt,0),
			    a.incredu_seq,
				c.tra_acc_code,
			    c.sum_acc_code,
				c.sell_loss_acc_code,
			    b.mng_dept_code
		into
			    ln_FIX_ASSET_SEQ,
				ln_GET_AMT,
			    ln_DEPREC_SUM_AMT,
			    ln_ADD_LOSS_AMT,
			    ln_INCREDU_SEQ,
				ls_TRA_ACC_CODE, --폐기계정
			    ls_SUM_ACC_CODE, --누계게정 
			    ls_SELL_LOSS_ACC_CODE, --처분손실
			    ls_MNG_DEPT_CODE
		from   t_fix_incredu a,
			   t_fix_sheet b,
			   t_fix_asset_cls_code c
		where a.fix_asset_seq  	   = b.fix_asset_seq
		and	  b.asset_cls_code 	   = c.asset_cls_code
		and   incredu_cls = 3
		and	  b.fix_asset_seq      = AR_FIX_ASSET_SEQ;
	
	EXCEPTION WHEN NO_DATA_FOUND THEN
		RAISE_APPLICATION_ERROR	(-20009, '전표발행대상이 없습니다.');
	END;
	
	--RAISE_APPLICATION_ERROR	(-20009, lt_T_FIX_ASSET_SEQ.Count);

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
		lrWORK_SLIP_BODY.WORK_CODE,--AR_WORK_CODE,
		--'30000101', --AR_CHARGE_PERS,
		AR_CHARGE_PERS,
		AR_SLIP_KIND_TAG,
		'F',--AR_TRANSFER_TAG,
		'F'--AR_IGNORE_SET_RESET_TAG
	);

	  lnMAKE_SLIPLINE := 0;

	--자동전표 대상
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
		    ls_TRA_ACC_CODE,
			0,--AR_DB_AMT ,
			ln_GET_AMT,--AR_CR_AMT ,
			NULL,--SUMMARY_CODE ,
			(select tax_comp_code from t_dept_code_org where dept_code = ls_MNG_DEPT_CODE) , 
			(select comp_code from t_dept_code_org where dept_code =  ls_MNG_DEPT_CODE) , 
			ls_MNG_DEPT_CODE,  -- 귀속부서-관리부서에서 가져온다.
			(select class_code from t_dept_class_code where dept_code =  ls_MNG_DEPT_CODE) , -- 부서코드별 부문코드에서 가져온다.
			null ,--AR_VAT_CODE
			null,--F_T_STRINGTODATE(AR_VAT_DT) ,
			0,--AR_SUPAMT ,
			0,--AR_VATAMT ,	
			null, --rFIX_SHEET.CUST_SEQ ,
			null, --lrFIX_SHEET.CUST_NAME ,
			null, --lrFIX_SHEET.BANK_CODE ,-- 화면에서 가져오던, 고정자산 테이블에서 가져오던지
			null, 
			NULL,
			NULL,
			'폐기 자동전표',--AR_SUMMARY1 ,
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
		
		If ln_DEPREC_SUM_AMT > 0 then
		--누계액 계정
		--자동전표 대상
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
		    ls_SUM_ACC_CODE,
			ln_DEPREC_SUM_AMT,--AR_DB_AMT ,
			0,--AR_CR_AMT ,
			NULL,--SUMMARY_CODE ,
			(select tax_comp_code from t_dept_code_org where dept_code = ls_MNG_DEPT_CODE) , 
			(select comp_code from t_dept_code_org where dept_code =  ls_MNG_DEPT_CODE) , 
			ls_MNG_DEPT_CODE,  -- 귀속부서-관리부서에서 가져온다.
			(select class_code from t_dept_class_code where dept_code =  ls_MNG_DEPT_CODE) , -- 부서코드별 부문코드에서 가져온다.
			null ,--AR_VAT_CODE
			null,--F_T_STRINGTODATE(AR_VAT_DT) ,
			0,--AR_SUPAMT ,
			0,--AR_VATAMT ,	
			null, --rFIX_SHEET.CUST_SEQ ,
			null, --lrFIX_SHEET.CUST_NAME ,
			null, --lrFIX_SHEET.BANK_CODE ,-- 화면에서 가져오던, 고정자산 테이블에서 가져오던지
			null, 
			NULL,
			NULL,
			'폐기 자동전표',--AR_SUMMARY1 ,
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
	
		End If;
		
		
		
		
		
		--자동전표 대상 유형자산 손실-이익
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
		    ls_SELL_LOSS_ACC_CODE,
			ln_ADD_LOSS_AMT,--AR_DB_AMT,
			0,--AR_CR_AMT,
			NULL,--SUMMARY_CODE ,
			(select tax_comp_code from t_dept_code_org where dept_code = ls_MNG_DEPT_CODE) , 
			(select comp_code from t_dept_code_org where dept_code =  ls_MNG_DEPT_CODE) , 
			ls_MNG_DEPT_CODE,  -- 귀속부서-관리부서에서 가져온다.
			(select class_code from t_dept_class_code where dept_code =  ls_MNG_DEPT_CODE) , -- 부서코드별 부문코드에서 가져온다.
			null ,--AR_VAT_CODE
			null,--F_T_STRINGTODATE(AR_VAT_DT) ,
			0,--AR_SUPAMT ,
			0,--AR_VATAMT ,	
			null, --rFIX_SHEET.CUST_SEQ ,
			null, --lrFIX_SHEET.CUST_NAME ,
			null, --lrFIX_SHEET.BANK_CODE ,-- 화면에서 가져오던, 고정자산 테이블에서 가져오던지
			null, 
			NULL,
			NULL,
			'폐기 자동전표',--AR_SUMMARY1 ,
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
	
	
		
		--고정자산 폐기
	UPDATE T_FIX_INCREDU
	SET
		MODUSERNO = AR_CRTUSERNO,
		SLIP_ID = AR_SLIP_ID,
		SLIP_IDSEQ = lnSLIP_IDSEQ
	WHERE	FIX_ASSET_SEQ = ln_FIX_ASSET_SEQ
	AND		INCREDU_SEQ = ln_INCREDU_SEQ;
	
	
	

	
	
		-- 가등록된 자동전표 상대계정 세부사항 전표번호 입력....
		--Sp_T_Work_Detail_To_Slip(
			--AR_WORK_SLIP_ID,
			--AR_WORK_SLIP_IDSEQ,
			--AR_CRTUSERNO,
			--AR_SLIP_ID,
			--lnSLIP_IDSEQ
		--);
		
	

END;
/
