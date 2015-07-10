CREATE OR REPLACE PROCEDURE Sp_T_Acc_Slip_Body_U
(
	AR_SLIP_ID                                             NUMBER,
	AR_SLIP_IDSEQ                                          NUMBER,
	AR_MODUSERNO                                           VARCHAR2,
	AR_MAKE_SLIPLINE                                       NUMBER,
	AR_ACC_CODE                                            VARCHAR2,
	AR_ACC_NAME                                            VARCHAR2,
	AR_ACC_REMAIN_POSITION                                 VARCHAR2,
	AR_DB_AMT                                              NUMBER,
	AR_DB_AMT_D                                            VARCHAR2,
	AR_CR_AMT                                              NUMBER,
	AR_CR_AMT_D                                            VARCHAR2,
	AR_SUMMARY_CLS                                         VARCHAR2,
	AR_SUMMARY_CODE                                        VARCHAR2,
	AR_SUMMARY1                                            VARCHAR2,
	AR_SUMMARY2                                            VARCHAR2,
	AR_TAX_COMP_CODE                                       VARCHAR2,
	AR_COMP_CODE                                           VARCHAR2,
	AR_DEPT_CODE                                           VARCHAR2,
	AR_DEPT_NAME                                           VARCHAR2,
	AR_CLASS_CODE                                          VARCHAR2,
	AR_CLASS_CODE_NAME                                     VARCHAR2,
	AR_VAT_CODE                                            VARCHAR2,
	AR_VAT_NAME                                            VARCHAR2,
	AR_VAT_DT                                              VARCHAR2,
	AR_SUPAMT                                              NUMBER,
	AR_VATAMT                                              NUMBER,
	AR_RCPTBILL_CLS                                        VARCHAR2,
	AR_SUBTR_CLS                                           VARCHAR2,
	AR_SALEBUY_CLS                                         VARCHAR2,
	AR_VATOCCUR_CLS                                        VARCHAR2,
	AR_SLIP_DETAIL_LIST                                    VARCHAR2,
	AR_VAT_ACC_CODE                                        VARCHAR2,
	AR_BUDG_MNG                                            VARCHAR2,
	AR_BUDG_EXEC_CLS                                       VARCHAR2,
	AR_CUST_CODE_MNG                                       VARCHAR2,
	AR_CUST_CODE_MNG_TG                                    VARCHAR2,
	AR_CUST_SEQ                                            VARCHAR2,
	AR_CUST_CODE                                           VARCHAR2,
	AR_CUST_NAME_MNG                                       VARCHAR2,
	AR_CUST_NAME_MNG_TG                                    VARCHAR2,
	AR_CUST_NAME                                           VARCHAR2,
	AR_BANK_MNG                                            VARCHAR2,
	AR_BANK_MNG_TG                                         VARCHAR2,
	AR_BANK_CODE                                           VARCHAR2,
	AR_BANK_NAME                                           VARCHAR2,
	AR_ACCNO_MNG                                           VARCHAR2,
	AR_ACCNO_MNG_TG                                        VARCHAR2,
	AR_ACCNO                                               VARCHAR2,
	AR_ACC_REMAIN_MNG                                      VARCHAR2,
	AR_RESET_SLIP_ID                                       NUMBER,
	AR_RESET_SLIP_IDSEQ                                    NUMBER,
	AR_BRAIN_GRP_SEQ                                    NUMBER,
	AR_BRAIN_SLIP_SEQ1                                    NUMBER,
	AR_BRAIN_SLIP_SEQ2                                    NUMBER,
	AR_BRAIN_SLIP_LINE                                    NUMBER,
	AR_BRAIN_SORT_SEQ                                     NUMBER,
	AR_BRAIN_ACC_POSITION                                 VARCHAR2,
	AR_CARD_NO_MNG                                          VARCHAR2,
	AR_CARD_NO_MNG_TG                                       VARCHAR2,
	AR_CARD_SEQ_B                                            NUMBER,
	AR_CHK_NO_MNG                                          VARCHAR2,
	AR_CHK_NO_MNG_TG                                       VARCHAR2,
	AR_CHK_NO                                              VARCHAR2,
	AR_CHK_PUBL_DT                                         VARCHAR2,
	AR_CHK_COLL_DT                                         VARCHAR2,
	AR_BILL_NO_MNG                                         VARCHAR2,
	AR_BILL_NO_MNG_TG                                      VARCHAR2,
	AR_BILL_NO                                             VARCHAR2,
	AR_BILL_NO_S                                           VARCHAR2,
	AR_BILL_PUBL_DT                                        VARCHAR2,
	AR_BILL_EXPR_DT                                        VARCHAR2,
	AR_BILL_NO_R                                           VARCHAR2,
	AR_BILL_PUBL_DT_R                                      VARCHAR2,
	AR_BILL_EXPR_DT_R                                      VARCHAR2,
	AR_BILL_CHG_EXPR_DT_R                                  VARCHAR2,
	AR_BILL_COLL_DT_R                                  VARCHAR2,
	AR_REC_BILL_NO_MNG                                     VARCHAR2,
	AR_REC_BILL_NO_MNG_TG                                  VARCHAR2,
	AR_REC_BILL_NO                                         VARCHAR2,
	AR_REC_BILL_NO_S                                       VARCHAR2,
	AR_REC_BILL_PUBL_DT                                    VARCHAR2,
	AR_REC_BILL_EXPR_DT                                    VARCHAR2,
	AR_REC_BILL_NO_R                                       VARCHAR2,
	AR_REC_BILL_PUBL_DT_R                                  VARCHAR2,
	AR_REC_BILL_EXPR_DT_R                                  VARCHAR2,
	AR_REC_BILL_PUBL_AMT_R                                 NUMBER,
	AR_REC_BILL_DISH_DT_R         VARCHAR2,
	AR_REC_BILL_TRUST_DT_R        VARCHAR2,
	AR_REC_BILL_TRUST_BANK_CODE_R VARCHAR2,
	AR_REC_BILL_DISC_DT_R         VARCHAR2,
	AR_REC_BILL_DISC_BANK_CODE_R  VARCHAR2,
	AR_REC_BILL_DISC_RAT_R        NUMBER,
	AR_REC_BILL_DISC_AMT_R        NUMBER,

	AR_CP_NO_MNG                                           VARCHAR2,
	AR_CP_NO_MNG_TG                                        VARCHAR2,
	AR_CP_NO                                               VARCHAR2,
	AR_CP_NO_S                                             VARCHAR2,
	AR_CP_BUY_PUBL_DT                                         VARCHAR2,
	AR_CP_BUY_EXPR_DT                                         VARCHAR2,
	AR_CP_BUY_DUSE_DT                                         VARCHAR2,
	AR_CP_BUY_PUBL_AMT                                        NUMBER,
	AR_CP_BUY_INCOME_AMT                                      NUMBER,
	AR_CP_BUY_PUBL_PLACE                                      VARCHAR2,
	AR_CP_BUY_PUBL_NAME                                       VARCHAR2,
	AR_CP_BUY_INTR_RAT                                        NUMBER,
	AR_CP_BUY_CUST_SEQ                                        NUMBER,
	AR_CP_NO_R                                             VARCHAR2,
	AR_CP_BUY_PUBL_DT_R                                       VARCHAR2,
	AR_CP_BUY_EXPR_DT_R                                       VARCHAR2,
	AR_CP_BUY_DUSE_DT_R                                       VARCHAR2,
	AR_CP_BUY_PUBL_AMT_R                                      NUMBER,
	AR_CP_BUY_INCOME_AMT_R                                    NUMBER,
	AR_CP_BUY_PUBL_PLACE_R                                    VARCHAR2,
	AR_CP_BUY_PUBL_NAME_R                                     VARCHAR2,
	AR_CP_BUY_INTR_RAT_R                                      NUMBER,
	AR_CP_BUY_CUST_SEQ_R                                      NUMBER,
	AR_CP_BUY_RESET_AMT_R                                     NUMBER,

	AR_SECU_MNG                                            VARCHAR2,
	AR_SECU_MNG_TG                                         VARCHAR2,
	AR_SECU_NO                                             NUMBER,
	AR_SECU_REAL_SECU_NO                                   VARCHAR2,
	AR_SECU_NO_S                                           NUMBER,
	AR_SECU_REAL_SECU_NO_S                                 VARCHAR2,
	AR_SECU_SEC_KIND_CODE                                  VARCHAR2,
	AR_SECU_GET_DT                                         VARCHAR2,
	AR_SECU_GET_PLACE                                      VARCHAR2,
	AR_SECU_PERSTOCK_AMT                                   NUMBER,
	AR_SECU_INCOME_AMT                                     NUMBER,
	AR_SECU_BF_GET_ITR_AMT                                 NUMBER,
	AR_SECU_GET_ITR_AMT                                    NUMBER,
	AR_SECU_PUBL_DT                                        VARCHAR2,
	AR_SECU_ITR_TAG                                        VARCHAR2,
	AR_SECU_EXPR_DT                                        VARCHAR2,
	AR_SECU_INTR_RATE                                      NUMBER,

	AR_SECU_NO_R                                           NUMBER,
	AR_SECU_REAL_SECU_NO_R                                 VARCHAR2,
	AR_SECU_PERSTOCK_AMT_R                                 NUMBER,
	AR_SECU_PUBL_DT_R                                      VARCHAR2,
	AR_SECU_EXPR_DT_R                                      VARCHAR2,
	AR_SECU_INTR_RATE_R                                    NUMBER,
	AR_SECU_SALE_AMT_R                                     NUMBER,
	AR_SECU_SALE_DT_R                                      VARCHAR2,
	AR_SECU_RETURN_DT_R                                    VARCHAR2,
	AR_SECU_CONSIGN_BANK_R                                 VARCHAR2,
	AR_SECU_SALE_ITR_AMT_R                                 NUMBER,
	AR_SECU_SALE_TAX_R                                     NUMBER,
	AR_SECU_SALE_LOSS_R                                    NUMBER,
	AR_SECU_SALE_NP_ITR_AMT_R                              NUMBER,

	AR_LOAN_NO_MNG                                         VARCHAR2,
	AR_LOAN_NO_MNG_TG                                      VARCHAR2,
	AR_LOAN_REFUND_NO                                      VARCHAR2,
	AR_LOAN_REFUND_SEQ                                     NUMBER,

	AR_LOAN_REFUND_NO_S                                    VARCHAR2,

	AR_LOAN_REFUND_NO_R                                    VARCHAR2,

	AR_LOAN_REFUND_NO_I                                    VARCHAR2,

	AR_FIXED_MNG                                           VARCHAR2,
	AR_FIXED_MNG_TG                                        VARCHAR2,
	AR_FIX_ASSET_SEQ				       NUMBER,

	AR_DEPOSIT_PAY_MNG                                     VARCHAR2,
	AR_DEPOSIT_PAY_MNG_TG                                  VARCHAR2,
	AR_DEPOSIT_ACCNO                                       VARCHAR2,
	AR_PAYMENT_SEQ                                         NUMBER,
	AR_PAYMENT_SCH_DT                                      VARCHAR2,
	AR_PAYMENT_SCH_AMT                                     NUMBER,
	AR_PAYMENT_DT                                          VARCHAR2,
	AR_PAYMENT_AMT                                         NUMBER,
	AR_PAY_CON_MNG                                         VARCHAR2,
	AR_PAY_CON_MNG_TG                                      VARCHAR2,
	AR_PAY_CON_CASH                                        NUMBER,
	AR_PAY_CON_BILL                                        NUMBER,
	AR_BILL_EXPR_MNG                                       VARCHAR2,
	AR_BILL_EXPR_MNG_TG                                    VARCHAR2,
	AR_PAY_CON_BILL_DT                                     VARCHAR2,
	AR_PAY_CON_BILL_DAYS                                   NUMBER,
	AR_EMP_NO_MNG                                          VARCHAR2,
	AR_EMP_NO_MNG_TG                                       VARCHAR2,
	AR_EMP_NO                                              VARCHAR2,
	AR_EMP_NAME                                            VARCHAR2,
	AR_ANTICIPATION_DT_MNG                                 VARCHAR2,
	AR_ANTICIPATION_DT_MNG_TG                              VARCHAR2,
	AR_ANTICIPATION_DT                                     VARCHAR2,
	-- 현금영수증
	AR_CASH_MNG                                     VARCHAR2,
	AR_CASH_SEQ                                     NUMBER,
	AR_CASH_CASHNO                                  VARCHAR2,
	AR_CASH_USE_DT                                  VARCHAR2,
	AR_CASH_TRADE_AMT                               NUMBER,
	AR_CASH_REQ_TG                                  VARCHAR2,
	-- 신용카드
	AR_CARD_MNG                                     VARCHAR2,
	AR_CARD_SEQ                                     NUMBER,
	AR_CARD_CARDNO                                  VARCHAR2,
	AR_CARD_USE_DT                                  VARCHAR2,
	AR_CARD_HAVE_PERS                               VARCHAR2,
	AR_CARD_TRADE_AMT                               NUMBER,
	AR_CARD_REQ_TG                                  VARCHAR2,
	AR_MNG_NAME_CHAR1                                      VARCHAR2,
	AR_MNG_TG_CHAR1                                        VARCHAR2,
	AR_MNG_ITEM_CHAR1                                      VARCHAR2,
	AR_MNG_NAME_CHAR2                                      VARCHAR2,
	AR_MNG_TG_CHAR2                                        VARCHAR2,
	AR_MNG_ITEM_CHAR2                                      VARCHAR2,
	AR_MNG_NAME_CHAR3                                      VARCHAR2,
	AR_MNG_TG_CHAR3                                        VARCHAR2,
	AR_MNG_ITEM_CHAR3                                      VARCHAR2,
	AR_MNG_NAME_CHAR4                                      VARCHAR2,
	AR_MNG_TG_CHAR4                                        VARCHAR2,
	AR_MNG_ITEM_CHAR4                                      VARCHAR2,
	AR_MNG_NAME_NUM1                                       VARCHAR2,
	AR_MNG_TG_NUM1                                         VARCHAR2,
	AR_MNG_ITEM_NUM1                                       NUMBER,
	AR_MNG_NAME_NUM2                                       VARCHAR2,
	AR_MNG_TG_NUM2                                         VARCHAR2,
	AR_MNG_ITEM_NUM2                                       NUMBER,
	AR_MNG_NAME_NUM3                                       VARCHAR2,
	AR_MNG_TG_NUM3                                         VARCHAR2,
	AR_MNG_ITEM_NUM3                                       NUMBER,
	AR_MNG_NAME_NUM4                                       VARCHAR2,
	AR_MNG_TG_NUM4                                         VARCHAR2,
	AR_MNG_ITEM_NUM4                                       NUMBER,
	AR_MNG_NAME_DT1                                        VARCHAR2,
	AR_MNG_TG_DT1                                          VARCHAR2,
	AR_MNG_ITEM_DT1                                        VARCHAR2,
	AR_MNG_NAME_DT2                                        VARCHAR2,
	AR_MNG_TG_DT2                                          VARCHAR2,
	AR_MNG_ITEM_DT2                                        VARCHAR2,
	AR_MNG_NAME_DT3                                        VARCHAR2,
	AR_MNG_TG_DT3                                          VARCHAR2,
	AR_MNG_ITEM_DT3                                        VARCHAR2,
	AR_MNG_NAME_DT4                                        VARCHAR2,
	AR_MNG_TG_DT4                                          VARCHAR2,
	AR_MNG_ITEM_DT4                                        VARCHAR2,
	AR_RESET_SLIPNO                                        VARCHAR2
)
IS
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_ACC_SLIP_BODY_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_ACC_SLIP_BODY 테이블 Update
/* 4. 변  경  이  력 : 최언회 작성(2005-12-07)
/* 5. 관련  프로그램 :
/* 6. 특  기  사  항 :
/**************************************************************************/
lrT_ACC_CODE	T_ACC_CODE_VIEW%ROWTYPE;
lsCUST_SEQ		T_ACC_SLIP_BODY1.CUST_NAME%TYPE;
lsCUST_NAME	   T_ACC_SLIP_BODY1.CUST_NAME%TYPE;
BEGIN
	BEGIN
		SELECT
			*
		INTO
			lrT_ACC_CODE
		FROM	T_ACC_CODE_VIEW
		WHERE	ACC_CODE = AR_ACC_CODE;
	EXCEPTION WHEN NO_DATA_FOUND THEN
		RAISE_APPLICATION_ERROR	(-20009, '계정과목이 존재하지 않습니다.');
	END;
	
	lsCUST_SEQ		:= AR_CUST_SEQ;
	lsCUST_NAME	   := AR_CUST_NAME;
	--거래처코드검증
	IF NVL(lrT_ACC_CODE.CUST_CODE_MNG,'F') = 'T' THEN
		IF NVL(lrT_ACC_CODE.CUST_CODE_MNG_TG,'F') = 'F' AND lsCUST_SEQ IS NULL THEN
			lsCUST_SEQ		:= '26371';
			lsCUST_NAME	   := '임의거래처';
		END IF;
	END IF;
	
	UPDATE T_ACC_SLIP_BODY_INS
	SET
	SLIP_ID = AR_SLIP_ID ,
      	SLIP_IDSEQ = AR_SLIP_IDSEQ ,
      	MODUSERNO = AR_MODUSERNO ,
      	MODDATE = SYSDATE ,
      	MAKE_SLIPLINE = AR_MAKE_SLIPLINE ,
      	ACC_CODE = AR_ACC_CODE ,
      	DB_AMT = AR_DB_AMT ,
      	CR_AMT = AR_CR_AMT ,
      	SUMMARY_CODE = AR_SUMMARY_CODE ,
      	TAX_COMP_CODE = AR_TAX_COMP_CODE ,
      	COMP_CODE = AR_COMP_CODE ,
      	DEPT_CODE = AR_DEPT_CODE ,
      	CLASS_CODE = AR_CLASS_CODE ,
      	VAT_CODE = AR_VAT_CODE ,
      	VAT_DT = F_T_Stringtodate(AR_VAT_DT) ,
      	SUPAMT = AR_SUPAMT ,
      	VATAMT = AR_VATAMT ,
      	CUST_SEQ = lsCUST_SEQ, --AR_CUST_SEQ ,
      	CUST_NAME = lsCUST_NAME, --AR_CUST_NAME ,
      	BANK_CODE = AR_BANK_CODE ,
      	ACCNO = AR_ACCNO ,
      	RESET_SLIP_ID = DECODE(AR_RESET_SLIP_ID, 0, NULL, AR_RESET_SLIP_ID) ,
      	RESET_SLIP_IDSEQ = DECODE(AR_RESET_SLIP_IDSEQ, 0, NULL, AR_RESET_SLIP_IDSEQ) ,
      	SUMMARY1 = AR_SUMMARY1 ,
      	SUMMARY2 = AR_SUMMARY2 ,
	BRAIN_GRP_SEQ = AR_BRAIN_GRP_SEQ ,
	BRAIN_SLIP_SEQ1 = AR_BRAIN_SLIP_SEQ1 ,
	BRAIN_SLIP_SEQ2 = AR_BRAIN_SLIP_SEQ2 ,
	BRAIN_SLIP_LINE = AR_BRAIN_SLIP_LINE,
	BRAIN_SORT_SEQ = AR_BRAIN_SORT_SEQ,
	BRAIN_ACC_POSITION = AR_BRAIN_ACC_POSITION,
	CARD_SEQ = DECODE(AR_CARD_SEQ_B,0,NULL,AR_CARD_SEQ_B),
      	CHK_NO = AR_CHK_NO ,
      	BILL_NO = AR_BILL_NO ,
      	REC_BILL_NO = AR_REC_BILL_NO ,
      	CP_NO = AR_CP_NO ,
      	SECU_NO = AR_SECU_NO ,
      	--LOAN_NO = AR_LOAN_NO ,
      	LOAN_REFUND_NO = AR_LOAN_REFUND_NO ,
      	LOAN_REFUND_SEQ = AR_LOAN_REFUND_SEQ ,
	FIX_ASSET_SEQ = AR_FIX_ASSET_SEQ,
      	DEPOSIT_ACCNO = AR_DEPOSIT_ACCNO ,
      	PAYMENT_SEQ = AR_PAYMENT_SEQ ,
      	PAY_CON_CASH = AR_PAY_CON_CASH ,
      	PAY_CON_BILL = AR_PAY_CON_BILL ,
      	PAY_CON_BILL_DT = F_T_Stringtodate(AR_PAY_CON_BILL_DT) ,
      	PAY_CON_BILL_DAYS = AR_PAY_CON_BILL_DAYS,
      	EMP_NO = AR_EMP_NO ,
      	ANTICIPATION_DT = F_T_Stringtodate(AR_ANTICIPATION_DT) ,
      	MNG_ITEM_CHAR1 = AR_MNG_ITEM_CHAR1 ,
      	MNG_ITEM_CHAR2 = AR_MNG_ITEM_CHAR2 ,
      	MNG_ITEM_CHAR3 = AR_MNG_ITEM_CHAR3 ,
      	MNG_ITEM_CHAR4 = AR_MNG_ITEM_CHAR4 ,
      	MNG_ITEM_NUM1 = AR_MNG_ITEM_NUM1 ,
      	MNG_ITEM_NUM2 = AR_MNG_ITEM_NUM2 ,
      	MNG_ITEM_NUM3 = AR_MNG_ITEM_NUM3 ,
      	MNG_ITEM_NUM4 = AR_MNG_ITEM_NUM4 ,
      	MNG_ITEM_DT1 = F_T_Stringtodate(AR_MNG_ITEM_DT1) ,
      	MNG_ITEM_DT2 = F_T_Stringtodate(AR_MNG_ITEM_DT2) ,
      	MNG_ITEM_DT3 = F_T_Stringtodate(AR_MNG_ITEM_DT3) ,
      	MNG_ITEM_DT4 = F_T_Stringtodate(AR_MNG_ITEM_DT4)
	WHERE	SLIP_ID = AR_SLIP_ID
	AND	SLIP_IDSEQ = AR_SLIP_IDSEQ;

	--당좌수표
	Sp_T_Fin_Pay_Chk_Slip_U(AR_SLIP_ID,
							AR_SLIP_IDSEQ,
							AR_MODUSERNO,
							AR_ACC_REMAIN_POSITION,
							AR_DB_AMT,
							AR_CR_AMT,
							AR_CUST_SEQ,
							AR_CHK_NO_MNG,
							AR_CHK_NO_MNG_TG,
							AR_CHK_NO,
							AR_CHK_PUBL_DT,
							AR_CHK_COLL_DT,
							AR_SUMMARY1);

	--지급어음
	Sp_T_Fin_Pay_Bill_Slip_U(AR_SLIP_ID,
							AR_SLIP_IDSEQ,
							AR_MODUSERNO,
							AR_ACC_REMAIN_POSITION,
							AR_DB_AMT,
							AR_CR_AMT,
							AR_CUST_SEQ,
							AR_BILL_NO_MNG,
							AR_BILL_NO_MNG_TG,
							AR_BILL_NO_S,
							AR_BILL_PUBL_DT,
							AR_BILL_EXPR_DT,
							AR_BILL_NO_R,
							AR_BILL_PUBL_DT_R,
							AR_BILL_EXPR_DT_R,
							AR_BILL_CHG_EXPR_DT_R,
							AR_BILL_COLL_DT_R,
							AR_SUMMARY1);
	--받을어음
	Sp_T_Fin_Receive_Bill_Slip_Iu
	(
		AR_SLIP_ID,
		AR_SLIP_IDSEQ,
		AR_MODUSERNO,
		AR_ACC_REMAIN_POSITION,
		AR_COMP_CODE,
		AR_DB_AMT,
		AR_CR_AMT,
		--받을어음
		AR_REC_BILL_NO_MNG,
		AR_REC_BILL_NO_MNG_TG,
		--받을어음 설정
		AR_REC_BILL_NO_S,
		AR_REC_BILL_PUBL_DT,
		AR_REC_BILL_EXPR_DT,
		--받을어음 반제
		AR_REC_BILL_NO_R,
		AR_REC_BILL_PUBL_DT_R,
		AR_REC_BILL_EXPR_DT_R,
		AR_REC_BILL_DISH_DT_R,
		AR_REC_BILL_TRUST_DT_R,
		AR_REC_BILL_TRUST_BANK_CODE_R,
		AR_REC_BILL_DISC_DT_R,
		AR_REC_BILL_DISC_BANK_CODE_R,
		AR_REC_BILL_DISC_RAT_R,
		AR_REC_BILL_DISC_AMT_R
	);

	--유가증권
	Sp_T_Fin_Securty_Slip_Iu
	(
		AR_SLIP_ID,
		AR_SLIP_IDSEQ,
		AR_MODUSERNO,
		AR_ACC_REMAIN_POSITION,
		AR_COMP_CODE,
		AR_DB_AMT,
		AR_CR_AMT,
		--유가증권
		AR_SECU_MNG,
		AR_SECU_MNG_TG,
		--유가증권 설정
		AR_SECU_NO_S,
		AR_SECU_REAL_SECU_NO_S,
		AR_SECU_SEC_KIND_CODE,
		AR_SECU_GET_DT,
		AR_SECU_GET_PLACE,
		AR_SECU_PERSTOCK_AMT,
		AR_SECU_INCOME_AMT,
		AR_SECU_BF_GET_ITR_AMT,
		AR_SECU_GET_ITR_AMT,
		AR_SECU_PUBL_DT,
		AR_SECU_ITR_TAG,
		AR_SECU_EXPR_DT,
		AR_SECU_INTR_RATE,
		--유가증권 반제
		AR_SECU_NO_R,
		AR_SECU_REAL_SECU_NO_R,
		AR_SECU_PERSTOCK_AMT_R,
		AR_SECU_PUBL_DT_R,
		AR_SECU_EXPR_DT_R,
		AR_SECU_INTR_RATE_R,
		AR_SECU_SALE_AMT_R,
		AR_SECU_SALE_DT_R,
		AR_SECU_RETURN_DT_R,
		AR_SECU_CONSIGN_BANK_R,
		AR_SECU_SALE_ITR_AMT_R,
		AR_SECU_SALE_TAX_R,
		AR_SECU_SALE_LOSS_R,
		AR_SECU_SALE_NP_ITR_AMT_R
	);

	/*
	--차입
	Sp_T_Fin_Loan_Slip_Iu
	(
		AR_SLIP_ID,
		AR_SLIP_IDSEQ,
		AR_MODUSERNO,
		AR_ACC_REMAIN_POSITION,
		AR_COMP_CODE,
		AR_DB_AMT,
		AR_CR_AMT,
		--차입
		AR_LOAN_NO_MNG,
		AR_LOAN_NO_MNG_TG,
		--차입 설정
		AR_LOAN_REFUND_NO_S,
		AR_LOAN_REFUND_SEQ_S,
		AR_LOAN_TRANS_DT,
		AR_LOAN_FDT,
		AR_LOAN_EXPR_DT,
		AR_LOAN_REAL_INTR_RATE,
		AR_LOAN_TITLE_INTR_RATE,
		--차입 반제
		AR_LOAN_REFUND_NO_R,
		AR_LOAN_REFUND_SEQ_R,
		AR_LOAN_TRANS_DT_R,
		AR_LOAN_REFUND_SCH_DT_R,
		AR_LOAN_REFUND_SCH_ORG_AMT_R,
		AR_LOAN_REFUND_SCH_INTR_AMT_R,
		AR_LOAN_REFUND_DT_R
	);
	*/

	--예적금
	Sp_T_Deposit_Payment_Slip_U
	(
		AR_SLIP_ID,
		AR_SLIP_IDSEQ,
		AR_MODUSERNO,
		AR_ACC_REMAIN_POSITION,
		AR_DB_AMT,
		AR_CR_AMT,
		--적금
		AR_DEPOSIT_PAY_MNG,
		AR_DEPOSIT_PAY_MNG_TG,
		--적금
		AR_DEPOSIT_ACCNO,
		AR_PAYMENT_SEQ,
		AR_PAYMENT_SCH_DT,
		AR_PAYMENT_SCH_AMT,
		AR_PAYMENT_DT,
		AR_PAYMENT_AMT
	);

	--기업어음
	Sp_T_Fin_Cp_Buy_Slip_Iu
	(
		AR_SLIP_ID,
		AR_SLIP_IDSEQ,
		AR_MODUSERNO,
		AR_ACC_REMAIN_POSITION,
		AR_COMP_CODE,
		AR_DB_AMT,
		AR_CR_AMT,
		--CP매입
		AR_CP_NO_MNG,
		AR_CP_NO_MNG_TG,
		--CP매입 설정
		AR_CP_NO_S,
		AR_CP_BUY_PUBL_DT,
		AR_CP_BUY_EXPR_DT,
		AR_CP_BUY_DUSE_DT,
		AR_CP_BUY_PUBL_AMT,
		AR_CP_BUY_INCOME_AMT,
		AR_CP_BUY_PUBL_PLACE,
		AR_CP_BUY_PUBL_NAME,
		AR_CP_BUY_INTR_RAT,
		AR_CP_BUY_CUST_SEQ,
		AR_SUMMARY1,
		--CP매입 반제
		AR_CP_NO_R,
		AR_CP_BUY_PUBL_DT_R,
		AR_CP_BUY_EXPR_DT_R,
		AR_CP_BUY_DUSE_DT_R,
		AR_CP_BUY_PUBL_AMT_R,
		AR_CP_BUY_INCOME_AMT_R,
		AR_CP_BUY_PUBL_PLACE_R,
		AR_CP_BUY_PUBL_NAME_R,
		AR_CP_BUY_INTR_RAT_R,
		AR_CP_BUY_CUST_SEQ_R,
		AR_CP_BUY_RESET_AMT_R,
		AR_SUMMARY1
	);
	--현금영수증
	Sp_T_Expense_Cash_Slip_Iu
	(
		AR_SLIP_ID,
		AR_SLIP_IDSEQ,
		AR_MODUSERNO,
		AR_ACC_REMAIN_POSITION,
		AR_DB_AMT,
		AR_CR_AMT,
		--현금영수증
		AR_CASH_MNG,
		--현금영수증 설정
		AR_CASH_CASHNO,
		AR_CASH_USE_DT,
		AR_EMP_NO,
		AR_EMP_NAME,--AR_CASH_HAVE_PERS,
		AR_CUST_CODE,
		AR_CUST_NAME,
		AR_CASH_TRADE_AMT,
		AR_CASH_REQ_TG
	);

	--카드영수증
	Sp_T_Expense_Card_Slip_Iu
	(
		AR_SLIP_ID,
		AR_SLIP_IDSEQ,
		AR_MODUSERNO,
		AR_ACC_REMAIN_POSITION,
		AR_DB_AMT,
		AR_CR_AMT,
		--카드영수증
		AR_CARD_MNG,
		--카드영수증 설정
		AR_CARD_SEQ,
		AR_CARD_CARDNO,
		AR_CARD_USE_DT,
		AR_CARD_HAVE_PERS,
		AR_CUST_CODE,
		AR_CUST_NAME,
		AR_CARD_TRADE_AMT,
		AR_CARD_REQ_TG
	);
END;
/
