CREATE OR REPLACE PROCEDURE SP_T_AUTO_BILL_FIX_SELL_SLIP
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
	AR_AUTO_BILL_FIX_SELL_SEQ  NUMBER,
	AR_WORK_SLIP_ID           NUMBER,
	AR_WORK_SLIP_IDSEQ        NUMBER,
	AR_CRTUSERNO              NUMBER,
	AR_WORK_CODE			  VARCHAR2
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
ls_SELL_PORF_ACC_CODE			T_ACC_CODE.ACC_CODE%TYPE;
ls_SELL_LOSS_ACC_CODE			T_ACC_CODE.ACC_CODE%TYPE;
ls_MNG_DEPT_CODE				T_ACC_CODE.ACC_CODE%TYPE;
ls_SELL_ADD_LOSS_ACC_CODE		T_ACC_CODE.ACC_CODE%TYPE;

/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_AUTO_BILL_FIX_GET_SLIP
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : 취득 자동전표 발행
/* 4. 변  경  이  력 : 홍길동 작성(2006-01-31)
/* 5. 관련  프로그램 :
/* 6. 특  기  사  항 :
/**************************************************************************/
BEGIN
	
	BEGIN
		SELECT *
		INTO lrWORK_SLIP_BODY
		FROM T_WORK_ACC_SLIP_BODY
		WHERE SLIP_ID = AR_WORK_SLIP_ID
		AND     SLIP_IDSEQ = AR_WORK_SLIP_IDSEQ;
	EXCEPTION WHEN NO_DATA_FOUND THEN
		RAISE_APPLICATION_ERROR	(-20009, '상대계정을 찾을 수 없습니다.');
	END;

	BEGIN
		
		select  a.fix_asset_seq,
				b.get_cost_amt,
				b.old_deprec_amt,
				nvl(b.get_cost_amt,0) - (nvl(b.old_deprec_amt,0) + nvl(a.sell_amt,0)),
				abs(nvl(b.get_cost_amt,0) - (nvl(b.old_deprec_amt,0) + nvl(a.sell_amt,0))),
				a.sell_amt,
			    a.incredu_seq,
				c.sell_acc_code,
			    c.sum_acc_code,
				c.sell_porf_acc_code,
				c.sell_loss_acc_code,
			    b.mng_dept_code
		into
			    ln_FIX_ASSET_SEQ,
				ln_GET_AMT,
			    ln_DEPREC_SUM_AMT,
			    ln_ADD_LOSS_AMT,
				ln_ADD_LOSS_AMT1,
				ln_SELL_AMT,
			    ln_INCREDU_SEQ,
				ls_SELL_ACC_CODE,
			    ls_SUM_ACC_CODE,
				ls_SELL_PORF_ACC_CODE,
			    ls_SELL_LOSS_ACC_CODE,
			    ls_MNG_DEPT_CODE
		from   t_auto_bill_fix_sell a,
			   t_fix_sheet b,
			   t_fix_asset_cls_code c
		where a.fix_asset_seq  	   = b.fix_asset_seq
		and	  b.asset_cls_code 	   = c.asset_cls_code
		and	  a.auto_b_f_sell_seq  = AR_AUTO_BILL_FIX_SELL_SEQ;
	
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
		    ls_SELL_ACC_CODE,
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
			'매각 자동전표',--AR_SUMMARY1 ,
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
			'매각 자동전표',--AR_SUMMARY1 ,
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
		
		If  ln_ADD_LOSS_AMT > 0 then
		
		    ln_ADD_LOSS_AMT2 := ln_ADD_LOSS_AMT1;
		    ln_ADD_AMT := 0;
		    ls_SELL_ADD_LOSS_ACC_CODE := ls_SELL_LOSS_ACC_CODE;
		End if;
		
		if ln_ADD_LOSS_AMT < 0 then
			ln_ADD_LOSS_AMT2 := 0;
			ln_ADD_AMT  := ln_ADD_LOSS_AMT1;
			ls_SELL_ADD_LOSS_ACC_CODE := ls_SELL_PORF_ACC_CODE;
		End if;
		
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
			MNG_ITEM_DT4
		)
		VALUES
		(
			AR_SLIP_ID ,
			lnSLIP_IDSEQ ,
			AR_CRTUSERNO,
			SYSDATE,
			LNMAKE_SLIPLINE ,
		    ls_SELL_ADD_LOSS_ACC_CODE,
			ln_ADD_LOSS_AMT2,--AR_DB_AMT,
			ln_ADD_AMT,--AR_CR_AMT,
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
			'매각 자동전표',--AR_SUMMARY1 ,
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
	
	
		
		--고정자산 매각 
	UPDATE T_FIX_INCREDU
	SET
		MODUSERNO = AR_CRTUSERNO,
		SLIP_ID = AR_SLIP_ID,
		SLIP_IDSEQ = lnSLIP_IDSEQ
	WHERE	FIX_ASSET_SEQ = ln_FIX_ASSET_SEQ
	AND		INCREDU_SEQ = ln_INCREDU_SEQ;
	
	
	
	If ln_SELL_AMT <> 0 Then
	
		-- 상대계정
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
			AR_SLIP_ID,
			lnSLIP_IDSEQ ,
			AR_CRTUSERNO,
			SYSDATE,
			lnMAKE_SLIPLINE ,
			lrWORK_SLIP_BODY.ACC_CODE ,
			lrWORK_SLIP_BODY.DB_AMT,--AR_DB_AMT ,
			lrWORK_SLIP_BODY.CR_AMT,--AR_CR_AMT ,
			lrWORK_SLIP_BODY.SUMMARY_CODE,--SUMMARY_CODE ,
			lrWORK_SLIP_BODY.TAX_COMP_CODE ,
			lrWORK_SLIP_BODY.COMP_CODE ,
			lrWORK_SLIP_BODY.DEPT_CODE ,
			lrWORK_SLIP_BODY.CLASS_CODE ,
			lrWORK_SLIP_BODY.VAT_CODE ,
			lrWORK_SLIP_BODY.VAT_DT ,
			lrWORK_SLIP_BODY.SUPAMT ,
			lrWORK_SLIP_BODY.VATAMT ,
			lrWORK_SLIP_BODY.CUST_SEQ ,
			lrWORK_SLIP_BODY.CUST_NAME ,
			lrWORK_SLIP_BODY.BANK_CODE ,
			lrWORK_SLIP_BODY.ACCNO ,
			--lrWORK_SLIP_BODY.RESET_SLIP_ID,
	      	--lrWORK_SLIP_BODY.RESET_SLIP_IDSEQ,
			DECODE(lrWORK_SLIP_BODY.RESET_SLIP_ID,	     lrWORK_SLIP_BODY.SLIP_ID, 			 AR_SLIP_ID,	lrWORK_SLIP_BODY.RESET_SLIP_ID),
			DECODE(lrWORK_SLIP_BODY.RESET_SLIP_IDSEQ,	 lrWORK_SLIP_BODY.SLIP_IDSEQ,	  lnSLIP_IDSEQ, lrWORK_SLIP_BODY.RESET_SLIP_IDSEQ),
	 		lrWORK_SLIP_BODY.SUMMARY1 ,
	 		lrWORK_SLIP_BODY.SUMMARY2 ,
	 		lrWORK_SLIP_BODY.CHK_NO ,
	 		lrWORK_SLIP_BODY.BILL_NO ,
	 		lrWORK_SLIP_BODY.REC_BILL_NO ,
	 		lrWORK_SLIP_BODY.CP_NO ,
	 		lrWORK_SLIP_BODY.SECU_NO ,
	 		lrWORK_SLIP_BODY.LOAN_NO ,
	 		lrWORK_SLIP_BODY.LOAN_REFUND_NO ,
	 		lrWORK_SLIP_BODY.LOAN_REFUND_SEQ ,
	 		lrWORK_SLIP_BODY.DEPOSIT_ACCNO ,
	 		lrWORK_SLIP_BODY.PAYMENT_SEQ ,
	 		lrWORK_SLIP_BODY.PAY_CON_CASH ,
	 		lrWORK_SLIP_BODY.PAY_CON_BILL ,
	 		lrWORK_SLIP_BODY.PAY_CON_BILL_DT ,
	 		lrWORK_SLIP_BODY.PAY_CON_BILL_DAYS,
	 		lrWORK_SLIP_BODY.EMP_NO ,
	 		lrWORK_SLIP_BODY.ANTICIPATION_DT ,
	 		lrWORK_SLIP_BODY.MNG_ITEM_CHAR1 ,
	 		lrWORK_SLIP_BODY.MNG_ITEM_CHAR2 ,
	 		lrWORK_SLIP_BODY.MNG_ITEM_CHAR3 ,
	 		lrWORK_SLIP_BODY.MNG_ITEM_CHAR4 ,
	 		lrWORK_SLIP_BODY.MNG_ITEM_NUM1 ,
	 		lrWORK_SLIP_BODY.MNG_ITEM_NUM2 ,
			lrWORK_SLIP_BODY.MNG_ITEM_NUM3 ,
			lrWORK_SLIP_BODY.MNG_ITEM_NUM4 ,
			lrWORK_SLIP_BODY.MNG_ITEM_DT1 ,
			lrWORK_SLIP_BODY.MNG_ITEM_DT2 ,
			lrWORK_SLIP_BODY.MNG_ITEM_DT3 ,
			lrWORK_SLIP_BODY.MNG_ITEM_DT4,
			lrWORK_SLIP_BODY.FIX_ASSET_SEQ,
      		lrWORK_SLIP_BODY.CARD_SEQ
		);
		--RAISE_APPLICATION_ERROR	(-20009, ''||lrWORK_SLIP_BODY.DB_AMT);
	
	
		-- 가등록된 자동전표 상대계정 세부사항 전표번호 입력....
		Sp_T_Work_Detail_To_Slip(
			AR_WORK_SLIP_ID,
			AR_WORK_SLIP_IDSEQ,
			AR_CRTUSERNO,
			AR_SLIP_ID,
			lnSLIP_IDSEQ
		);
		
	End If;

END;
/
