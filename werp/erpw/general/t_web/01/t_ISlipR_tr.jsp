<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : t_WSlipR_tr.jsp(발의전표등록)
/* 2. 유형(시나리오) : Update Page
/* 3. 기  능  정  의 :
/* 4. 변  경  이  력 : 최언회 작성(2005-12-07)
/* 5. 관련  프로그램 :
/* 6. 특  기  사  항 :
/**************************************************************************/
	CITGauceInfo GauceInfo = null;

	GauceDataSet dsSLIP_D = null;

	GauceDataRow[] rows_SLIP_D = null;

	String	strSql = "";
	String	strAct = "";
	String	strUserNo = "";
	String	strSLIP_ID = "";
	Connection conn = null;

	try
	{
		GauceInfo = CITCommon.initServerPage(request, response, session);
		/* 세션정보 */
		strUserNo = CITCommon.toKOR((String)session.getAttribute("emp_no"));
		conn = CITConnectionManager.getConnection(false);

		strAct = GauceInfo.request.getParameter("ACT");

		if (CITCommon.isNull(strAct))
		{
			//전표 Detail
			dsSLIP_D = GauceInfo.request.getGauceDataSet("dsSLIP_D");

			if (dsSLIP_D == null) throw new Exception("dsSLIP_D이(가) 널(Null)입니다.");

			rows_SLIP_D = dsSLIP_D.getDataRows();

			try
			{
				for	(int i = 0;	i <	rows_SLIP_D.length; i++)
				{
					CITData lrArgData = new CITData();

					if (rows_SLIP_D[i].getJobType() == GauceDataRow.TB_JOB_INSERT)
					{
						strSql = "{call SP_T_WORK_ACC_SLIP_BODY_I("
															+"?,?,?,?,?,?,?,?,?,?,"
															+"?,?,?,?,?,?,?,?,?,?,"
															+"?,?,?,?,?,?,?,?,?,?,"
															+"?,?,?,?,?,?,?,?,?,?,"
															+"?,?,?,?,?,?,?,?,?,?,"
															+"?,?,?,?,?,?,?,?,?,?,"
															+"?,?,?,?,?,?,?,?,?,?,"
															+"?,?,?,?,?,?,?,?,?,?,"
															+"?,?,?,?,?,?,?,?,?,?,"
															+"?,?,?,?,?,?,?,?,?,?,"
															+"?,?,?,?,?,?,?,?,?,?,"
															+"?,?,?,?,?,?,?,?,?,?,"
															+"?,?,?,?,?,?,?,?,?,?,"
															+"?,?,?,?,?,?,?,?,?,?,"
															+"?,?,?,?,?,?,?,?,?,?,"
															+"?,?,?,?,?,?,?,?,?,?,"
															+"?,?,?,?,?,?,?,?,?,?,"
															+"?,?,?,?,?,?,?,?,?,?,"
															+"?,?,?,?,?,?,?,?,?,?,"
															+"?,?,?,?,?,?,?,?,?,?,"
															+"?,?,?,?,?,?,?,?,?,?,"
															+"?,?,?,?,?,?,?,?,?,?,"
															+"?,?,?,?,?,?,?,?,?,?,"
															+"?,?,?,?,?,?)}";

						lrArgData.addColumn("SLIP_ID",CITData.NUMBER);
						lrArgData.addColumn("SLIP_IDSEQ",CITData.NUMBER);
						lrArgData.addColumn("MODUSERNO",CITData.VARCHAR2);
						lrArgData.addColumn("MAKE_SLIPLINE",CITData.NUMBER);
						lrArgData.addColumn("ACC_CODE",CITData.VARCHAR2);
						lrArgData.addColumn("ACC_NAME",CITData.VARCHAR2);
						lrArgData.addColumn("ACC_REMAIN_POSITION",CITData.VARCHAR2);
						lrArgData.addColumn("DB_AMT",CITData.NUMBER);
						lrArgData.addColumn("DB_AMT_D",CITData.VARCHAR2);
						lrArgData.addColumn("CR_AMT",CITData.NUMBER);
						lrArgData.addColumn("CR_AMT_D",CITData.VARCHAR2);
						lrArgData.addColumn("SUMMARY_CLS",CITData.VARCHAR2);
						lrArgData.addColumn("SUMMARY_CODE",CITData.VARCHAR2);
						lrArgData.addColumn("SUMMARY1",CITData.VARCHAR2);
						lrArgData.addColumn("SUMMARY2",CITData.VARCHAR2);
						lrArgData.addColumn("TAX_COMP_CODE",CITData.VARCHAR2);
						lrArgData.addColumn("COMP_CODE",CITData.VARCHAR2);
						lrArgData.addColumn("DEPT_CODE",CITData.VARCHAR2);
						lrArgData.addColumn("DEPT_NAME",CITData.VARCHAR2);
						lrArgData.addColumn("CLASS_CODE",CITData.VARCHAR2);
						lrArgData.addColumn("CLASS_CODE_NAME",CITData.VARCHAR2);
						lrArgData.addColumn("VAT_CODE",CITData.VARCHAR2);
						lrArgData.addColumn("VAT_NAME",CITData.VARCHAR2);
						lrArgData.addColumn("VAT_DT",CITData.VARCHAR2);
						lrArgData.addColumn("SUPAMT",CITData.NUMBER);
						lrArgData.addColumn("VATAMT",CITData.NUMBER);
						lrArgData.addColumn("RCPTBILL_CLS",CITData.VARCHAR2);
						lrArgData.addColumn("SUBTR_CLS",CITData.VARCHAR2);
						lrArgData.addColumn("SALEBUY_CLS",CITData.VARCHAR2);
						lrArgData.addColumn("VATOCCUR_CLS",CITData.VARCHAR2);
						lrArgData.addColumn("SLIP_DETAIL_LIST",CITData.VARCHAR2);
						lrArgData.addColumn("VAT_ACC_CODE",CITData.VARCHAR2);
						lrArgData.addColumn("BUDG_MNG",CITData.VARCHAR2);
						lrArgData.addColumn("BUDG_EXEC_CLS",CITData.VARCHAR2);
						lrArgData.addColumn("CUST_CODE_MNG",CITData.VARCHAR2);
						lrArgData.addColumn("CUST_CODE_MNG_TG",CITData.VARCHAR2);
						lrArgData.addColumn("CUST_SEQ",CITData.VARCHAR2);
						lrArgData.addColumn("CUST_CODE",CITData.VARCHAR2);
						lrArgData.addColumn("CUST_NAME_MNG",CITData.VARCHAR2);
						lrArgData.addColumn("CUST_NAME_MNG_TG",CITData.VARCHAR2);
						lrArgData.addColumn("CUST_NAME",CITData.VARCHAR2);
						lrArgData.addColumn("BANK_MNG",CITData.VARCHAR2);
						lrArgData.addColumn("BANK_MNG_TG",CITData.VARCHAR2);
						lrArgData.addColumn("BANK_CODE",CITData.VARCHAR2);
						lrArgData.addColumn("BANK_NAME",CITData.VARCHAR2);
						lrArgData.addColumn("ACCNO_MNG",CITData.VARCHAR2);
						lrArgData.addColumn("ACCNO_MNG_TG",CITData.VARCHAR2);
						lrArgData.addColumn("ACCNO",CITData.VARCHAR2);
						lrArgData.addColumn("ACC_REMAIN_MNG",CITData.VARCHAR2);
						lrArgData.addColumn("RESET_SLIP_ID",CITData.NUMBER);
						lrArgData.addColumn("RESET_SLIP_IDSEQ",CITData.NUMBER);
						lrArgData.addColumn("CHK_NO_MNG",CITData.VARCHAR2);
						lrArgData.addColumn("CHK_NO_MNG_TG",CITData.VARCHAR2);
						lrArgData.addColumn("CHK_NO",CITData.VARCHAR2);
						lrArgData.addColumn("CHK_PUBL_DT",CITData.VARCHAR2);
						lrArgData.addColumn("BILL_NO_MNG",CITData.VARCHAR2);
						lrArgData.addColumn("BILL_NO_MNG_TG",CITData.VARCHAR2);
						lrArgData.addColumn("BILL_NO",CITData.VARCHAR2);
						lrArgData.addColumn("BILL_NO_S",CITData.VARCHAR2);
						lrArgData.addColumn("BILL_PUBL_DT",CITData.VARCHAR2);
						lrArgData.addColumn("BILL_EXPR_DT",CITData.VARCHAR2);
						lrArgData.addColumn("BILL_NO_R",CITData.VARCHAR2);
						lrArgData.addColumn("BILL_PUBL_DT_R",CITData.VARCHAR2);
						lrArgData.addColumn("BILL_EXPR_DT_R",CITData.VARCHAR2);
						lrArgData.addColumn("BILL_CHG_EXPR_DT_R",CITData.VARCHAR2);
						lrArgData.addColumn("REC_BILL_NO_MNG",CITData.VARCHAR2);
						lrArgData.addColumn("REC_BILL_NO_MNG_TG",CITData.VARCHAR2);
						lrArgData.addColumn("REC_BILL_NO",CITData.VARCHAR2);
						lrArgData.addColumn("REC_BILL_NO_S",CITData.VARCHAR2);
						lrArgData.addColumn("REC_BILL_PUBL_DT",CITData.VARCHAR2);
						lrArgData.addColumn("REC_BILL_EXPR_DT",CITData.VARCHAR2);
						lrArgData.addColumn("REC_BILL_NO_R",CITData.VARCHAR2);
						lrArgData.addColumn("REC_BILL_PUBL_DT_R",CITData.VARCHAR2);
						lrArgData.addColumn("REC_BILL_EXPR_DT_R",CITData.VARCHAR2);
						lrArgData.addColumn("REC_BILL_PUBL_AMT_R",CITData.NUMBER);
						
						lrArgData.addColumn("REC_BILL_DISH_DT_R",CITData.VARCHAR2);
						lrArgData.addColumn("REC_BILL_TRUST_DT_R",CITData.VARCHAR2);
						lrArgData.addColumn("REC_BILL_TRUST_BANK_CODE_R",CITData.VARCHAR2);
						lrArgData.addColumn("REC_BILL_DISC_DT_R",CITData.VARCHAR2);
						lrArgData.addColumn("REC_BILL_DISC_BANK_CODE_R",CITData.VARCHAR2);
						lrArgData.addColumn("REC_BILL_DISC_RAT_R",CITData.NUMBER);
						lrArgData.addColumn("REC_BILL_DISC_AMT_R",CITData.NUMBER);
						lrArgData.addColumn("CP_NO_MNG",CITData.VARCHAR2);
						lrArgData.addColumn("CP_NO_MNG_TG",CITData.VARCHAR2);
						lrArgData.addColumn("CP_NO",CITData.VARCHAR2);
						
						lrArgData.addColumn("CP_NO_S",CITData.VARCHAR2);
						lrArgData.addColumn("CP_BUY_PUBL_DT",CITData.VARCHAR2);
						lrArgData.addColumn("CP_BUY_EXPR_DT",CITData.VARCHAR2);
						lrArgData.addColumn("CP_BUY_DUSE_DT",CITData.VARCHAR2);
						lrArgData.addColumn("CP_BUY_PUBL_AMT",CITData.NUMBER);
						lrArgData.addColumn("CP_BUY_INCOME_AMT",CITData.NUMBER);
						lrArgData.addColumn("CP_BUY_PUBL_PLACE",CITData.VARCHAR2);
						lrArgData.addColumn("CP_BUY_PUBL_NAME",CITData.VARCHAR2);
						lrArgData.addColumn("CP_BUY_INTR_RAT",CITData.NUMBER);
						lrArgData.addColumn("CP_BUY_CUST_SEQ",CITData.NUMBER);
						
						lrArgData.addColumn("CP_NO_R",CITData.VARCHAR2);
						lrArgData.addColumn("CP_BUY_PUBL_DT_R",CITData.VARCHAR2);
						lrArgData.addColumn("CP_BUY_EXPR_DT_R",CITData.VARCHAR2);
						lrArgData.addColumn("CP_BUY_DUSE_DT_R",CITData.VARCHAR2);
						lrArgData.addColumn("CP_BUY_PUBL_AMT_R",CITData.NUMBER);
						lrArgData.addColumn("CP_BUY_INCOME_AMT_R",CITData.NUMBER);
						lrArgData.addColumn("CP_BUY_PUBL_PLACE_R",CITData.VARCHAR2);
						lrArgData.addColumn("CP_BUY_PUBL_NAME_R",CITData.VARCHAR2);
						lrArgData.addColumn("CP_BUY_INTR_RAT_R",CITData.NUMBER);
						lrArgData.addColumn("CP_BUY_CUST_SEQ_R",CITData.NUMBER);
						lrArgData.addColumn("CP_BUY_RESET_AMT_R",CITData.NUMBER);
						
						lrArgData.addColumn("SECU_MNG",CITData.VARCHAR2);
						lrArgData.addColumn("SECU_MNG_TG",CITData.VARCHAR2);
						lrArgData.addColumn("SECU_NO",CITData.NUMBER);
						lrArgData.addColumn("SECU_REAL_SECU_NO",CITData.VARCHAR2);
						lrArgData.addColumn("SECU_NO_S",CITData.NUMBER);
						lrArgData.addColumn("SECU_REAL_SECU_NO_S",CITData.VARCHAR2);
						lrArgData.addColumn("SECU_SEC_KIND_CODE",CITData.VARCHAR2);
						lrArgData.addColumn("SECU_GET_DT",CITData.VARCHAR2);
						lrArgData.addColumn("SECU_GET_PLACE",CITData.VARCHAR2);
						lrArgData.addColumn("SECU_PERSTOCK_AMT",CITData.NUMBER);
						lrArgData.addColumn("SECU_INCOME_AMT",CITData.NUMBER);
						lrArgData.addColumn("SECU_BF_GET_ITR_AMT",CITData.NUMBER);
						lrArgData.addColumn("SECU_GET_ITR_AMT",CITData.NUMBER);
						lrArgData.addColumn("SECU_PUBL_DT",CITData.VARCHAR2);
						lrArgData.addColumn("SECU_ITR_TAG",CITData.VARCHAR2);
						lrArgData.addColumn("SECU_EXPR_DT",CITData.VARCHAR2);
						lrArgData.addColumn("SECU_INTR_RATE",CITData.NUMBER);
						
						lrArgData.addColumn("SECU_NO_R",CITData.NUMBER);
						lrArgData.addColumn("SECU_REAL_SECU_NO_R",CITData.VARCHAR2);
						lrArgData.addColumn("SECU_PERSTOCK_AMT_R",CITData.NUMBER);
						lrArgData.addColumn("SECU_PUBL_DT_R",CITData.VARCHAR2);
						lrArgData.addColumn("SECU_EXPR_DT_R",CITData.VARCHAR2);
						lrArgData.addColumn("SECU_INTR_RATE_R",CITData.NUMBER);
						lrArgData.addColumn("SECU_SALE_AMT_R",CITData.NUMBER);
						lrArgData.addColumn("SECU_SALE_DT_R",CITData.VARCHAR2);
						lrArgData.addColumn("SECU_RETURN_DT_R",CITData.VARCHAR2);
						lrArgData.addColumn("SECU_CONSIGN_BANK_R",CITData.VARCHAR2);
						lrArgData.addColumn("SECU_SALE_ITR_AMT_R",CITData.NUMBER);
						lrArgData.addColumn("SECU_SALE_TAX_R",CITData.NUMBER);
						lrArgData.addColumn("SECU_SALE_LOSS_R",CITData.NUMBER);
						lrArgData.addColumn("SECU_SALE_NP_ITR_AMT_R",CITData.NUMBER);
						
						lrArgData.addColumn("LOAN_NO_MNG",CITData.VARCHAR2);
						lrArgData.addColumn("LOAN_NO_MNG_TG",CITData.VARCHAR2);
						lrArgData.addColumn("LOAN_REFUND_NO",CITData.VARCHAR2);
						lrArgData.addColumn("LOAN_REFUND_SEQ",CITData.NUMBER);
						
						lrArgData.addColumn("LOAN_REFUND_NO_S",CITData.VARCHAR2);
						lrArgData.addColumn("LOAN_REFUND_SEQ_S",CITData.NUMBER);
						lrArgData.addColumn("LOAN_TRANS_DT",CITData.VARCHAR2);
						lrArgData.addColumn("LOAN_FDT",CITData.VARCHAR2);
						lrArgData.addColumn("LOAN_EXPR_DT",CITData.VARCHAR2);
						lrArgData.addColumn("LOAN_REAL_INTR_RATE",CITData.NUMBER);
						lrArgData.addColumn("LOAN_TITLE_INTR_RATE",CITData.NUMBER);
						
						lrArgData.addColumn("LOAN_REFUND_NO_R",CITData.VARCHAR2);
						lrArgData.addColumn("LOAN_REFUND_SEQ_R",CITData.NUMBER);
						lrArgData.addColumn("LOAN_TRANS_DT_R",CITData.VARCHAR2);
						lrArgData.addColumn("LOAN_REFUND_SCH_DT_R",CITData.VARCHAR2);
						lrArgData.addColumn("LOAN_REFUND_SCH_ORG_AMT_R",CITData.NUMBER);
						lrArgData.addColumn("LOAN_REFUND_SCH_INTR_AMT_R",CITData.NUMBER);
						lrArgData.addColumn("LOAN_REFUND_DT_R",CITData.VARCHAR2);
						lrArgData.addColumn("LOAN_REFUND_NO_I",CITData.VARCHAR2);
						lrArgData.addColumn("LOAN_REFUND_SEQ_I",CITData.NUMBER);
						lrArgData.addColumn("LOAN_REFUND_SCH_DT_I",CITData.VARCHAR2);
						lrArgData.addColumn("LOAN_REFUND_SCH_ORG_AMT_I",CITData.NUMBER);
						lrArgData.addColumn("LOAN_INTR_DT_I",CITData.VARCHAR2);
						lrArgData.addColumn("FIXED_MNG",CITData.VARCHAR2);
						lrArgData.addColumn("FIXED_MNG_TG",CITData.VARCHAR2);
						lrArgData.addColumn("FIX_ASSET_SEQ",CITData.VARCHAR2);

						lrArgData.addColumn("DEPOSIT_PAY_MNG",CITData.VARCHAR2);
						lrArgData.addColumn("DEPOSIT_PAY_MNG_TG",CITData.VARCHAR2);
						lrArgData.addColumn("DEPOSIT_ACCNO",CITData.VARCHAR2);
						lrArgData.addColumn("PAYMENT_SEQ",CITData.NUMBER);
						lrArgData.addColumn("PAYMENT_SCH_DT",CITData.VARCHAR2);
						lrArgData.addColumn("PAYMENT_SCH_AMT",CITData.NUMBER);
						lrArgData.addColumn("PAYMENT_DT",CITData.VARCHAR2);
						lrArgData.addColumn("PAYMENT_AMT",CITData.NUMBER);
						lrArgData.addColumn("PAY_CON_MNG",CITData.VARCHAR2);
						lrArgData.addColumn("PAY_CON_MNG_TG",CITData.VARCHAR2);
						lrArgData.addColumn("PAY_CON_CASH",CITData.NUMBER);
						lrArgData.addColumn("PAY_CON_BILL",CITData.NUMBER);
						lrArgData.addColumn("BILL_EXPR_MNG",CITData.VARCHAR2);
						lrArgData.addColumn("BILL_EXPR_MNG_TG",CITData.VARCHAR2);
						lrArgData.addColumn("PAY_CON_BILL_DT",CITData.VARCHAR2);
						lrArgData.addColumn("PAY_CON_BILL_DAYS",CITData.NUMBER);
						lrArgData.addColumn("EMP_NO_MNG",CITData.VARCHAR2);
						lrArgData.addColumn("EMP_NO_MNG_TG",CITData.VARCHAR2);
						lrArgData.addColumn("EMP_NO",CITData.VARCHAR2);
						lrArgData.addColumn("EMP_NAME",CITData.VARCHAR2);
						lrArgData.addColumn("ANTICIPATION_DT_MNG",CITData.VARCHAR2);
						lrArgData.addColumn("ANTICIPATION_DT_MNG_TG",CITData.VARCHAR2);
						lrArgData.addColumn("ANTICIPATION_DT",CITData.VARCHAR2);
						
						// 현금영수증
						lrArgData.addColumn("CASH_MNG",CITData.VARCHAR2);
						lrArgData.addColumn("CASH_SEQ",CITData.NUMBER);
						lrArgData.addColumn("CASH_CASHNO",CITData.VARCHAR2);
						lrArgData.addColumn("CASH_USE_DT",CITData.VARCHAR2);
						lrArgData.addColumn("CASH_TRADE_AMT",CITData.NUMBER);
						lrArgData.addColumn("CASH_REQ_TG",CITData.VARCHAR2);
						// 신용카드                             
						lrArgData.addColumn("CARD_MNG",CITData.VARCHAR2);
						lrArgData.addColumn("CARD_SEQ",CITData.NUMBER);
						lrArgData.addColumn("CARD_CARDNO",CITData.VARCHAR2);
						lrArgData.addColumn("CARD_USE_DT",CITData.VARCHAR2);
						lrArgData.addColumn("CARD_HAVE_PERS",CITData.VARCHAR2);
						lrArgData.addColumn("CARD_TRADE_AMT",CITData.NUMBER);
						lrArgData.addColumn("CARD_REQ_TG",CITData.VARCHAR2);
						
						lrArgData.addColumn("MNG_NAME_CHAR1",CITData.VARCHAR2);
						lrArgData.addColumn("MNG_TG_CHAR1",CITData.VARCHAR2);
						lrArgData.addColumn("MNG_ITEM_CHAR1",CITData.VARCHAR2);
						lrArgData.addColumn("MNG_NAME_CHAR2",CITData.VARCHAR2);
						lrArgData.addColumn("MNG_TG_CHAR2",CITData.VARCHAR2);
						lrArgData.addColumn("MNG_ITEM_CHAR2",CITData.VARCHAR2);
						lrArgData.addColumn("MNG_NAME_CHAR3",CITData.VARCHAR2);
						lrArgData.addColumn("MNG_TG_CHAR3",CITData.VARCHAR2);
						lrArgData.addColumn("MNG_ITEM_CHAR3",CITData.VARCHAR2);
						lrArgData.addColumn("MNG_NAME_CHAR4",CITData.VARCHAR2);
						lrArgData.addColumn("MNG_TG_CHAR4",CITData.VARCHAR2);
						lrArgData.addColumn("MNG_ITEM_CHAR4",CITData.VARCHAR2);
						lrArgData.addColumn("MNG_NAME_NUM1",CITData.VARCHAR2);
						lrArgData.addColumn("MNG_TG_NUM1",CITData.VARCHAR2);
						lrArgData.addColumn("MNG_ITEM_NUM1",CITData.NUMBER);
						lrArgData.addColumn("MNG_NAME_NUM2",CITData.VARCHAR2);
						lrArgData.addColumn("MNG_TG_NUM2",CITData.VARCHAR2);
						lrArgData.addColumn("MNG_ITEM_NUM2",CITData.NUMBER);
						lrArgData.addColumn("MNG_NAME_NUM3",CITData.VARCHAR2);
						lrArgData.addColumn("MNG_TG_NUM3",CITData.VARCHAR2);
						lrArgData.addColumn("MNG_ITEM_NUM3",CITData.NUMBER);
						lrArgData.addColumn("MNG_NAME_NUM4",CITData.VARCHAR2);
						lrArgData.addColumn("MNG_TG_NUM4",CITData.VARCHAR2);
						lrArgData.addColumn("MNG_ITEM_NUM4",CITData.NUMBER);
						lrArgData.addColumn("MNG_NAME_DT1",CITData.VARCHAR2);
						lrArgData.addColumn("MNG_TG_DT1",CITData.VARCHAR2);
						lrArgData.addColumn("MNG_ITEM_DT1",CITData.VARCHAR2);
						lrArgData.addColumn("MNG_NAME_DT2",CITData.VARCHAR2);
						lrArgData.addColumn("MNG_TG_DT2",CITData.VARCHAR2);
						lrArgData.addColumn("MNG_ITEM_DT2",CITData.VARCHAR2);
						lrArgData.addColumn("MNG_NAME_DT3",CITData.VARCHAR2);
						lrArgData.addColumn("MNG_TG_DT3",CITData.VARCHAR2);
						lrArgData.addColumn("MNG_ITEM_DT3",CITData.VARCHAR2);
						lrArgData.addColumn("MNG_NAME_DT4",CITData.VARCHAR2);
						lrArgData.addColumn("MNG_TG_DT4",CITData.VARCHAR2);
						lrArgData.addColumn("MNG_ITEM_DT4",CITData.VARCHAR2);
						lrArgData.addColumn("RESET_SLIPNO",CITData.VARCHAR2);
						
						lrArgData.addRow();
						
						strSLIP_ID = rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("SLIP_ID"));
						lrArgData.setValue("SLIP_ID", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("SLIP_ID")));
						lrArgData.setValue("SLIP_IDSEQ", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("SLIP_IDSEQ")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("MAKE_SLIPLINE", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("MAKE_SLIPLINE")));
						lrArgData.setValue("ACC_CODE", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("ACC_CODE")));
						lrArgData.setValue("ACC_NAME", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("ACC_NAME")));
						lrArgData.setValue("ACC_REMAIN_POSITION", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("ACC_REMAIN_POSITION")));
						lrArgData.setValue("DB_AMT", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("DB_AMT")));
						lrArgData.setValue("DB_AMT_D", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("DB_AMT_D")));
						lrArgData.setValue("CR_AMT", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CR_AMT")));
						lrArgData.setValue("CR_AMT_D", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CR_AMT_D")));
						lrArgData.setValue("SUMMARY_CLS", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("SUMMARY_CLS")));
						lrArgData.setValue("SUMMARY_CODE", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("SUMMARY_CODE")));
						lrArgData.setValue("SUMMARY1", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("SUMMARY1")));
						lrArgData.setValue("SUMMARY2", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("SUMMARY2")));
						lrArgData.setValue("TAX_COMP_CODE", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("TAX_COMP_CODE")));
						lrArgData.setValue("COMP_CODE", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("DEPT_CODE", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("DEPT_CODE")));
						lrArgData.setValue("DEPT_NAME", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("DEPT_NAME")));
						lrArgData.setValue("CLASS_CODE", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CLASS_CODE")));
						lrArgData.setValue("CLASS_CODE_NAME", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CLASS_CODE_NAME")));
						lrArgData.setValue("VAT_CODE", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("VAT_CODE")));
						lrArgData.setValue("VAT_NAME", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("VAT_NAME")));
						lrArgData.setValue("VAT_DT", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("VAT_DT")));
						lrArgData.setValue("SUPAMT", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("SUPAMT")));
						lrArgData.setValue("VATAMT", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("VATAMT")));
						lrArgData.setValue("RCPTBILL_CLS", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("RCPTBILL_CLS")));
						lrArgData.setValue("SUBTR_CLS", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("SUBTR_CLS")));
						lrArgData.setValue("SALEBUY_CLS", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("SALEBUY_CLS")));
						lrArgData.setValue("VATOCCUR_CLS", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("VATOCCUR_CLS")));
						lrArgData.setValue("SLIP_DETAIL_LIST", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("SLIP_DETAIL_LIST")));
						lrArgData.setValue("VAT_ACC_CODE", "");
						lrArgData.setValue("BUDG_MNG", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("BUDG_MNG")));
						lrArgData.setValue("BUDG_EXEC_CLS", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("BUDG_EXEC_CLS")));
						lrArgData.setValue("CUST_CODE_MNG", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CUST_CODE_MNG")));
						lrArgData.setValue("CUST_CODE_MNG_TG", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CUST_CODE_MNG_TG")));
						lrArgData.setValue("CUST_SEQ", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CUST_SEQ")));
						lrArgData.setValue("CUST_CODE", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CUST_CODE")));
						lrArgData.setValue("CUST_NAME_MNG", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CUST_NAME_MNG")));
						lrArgData.setValue("CUST_NAME_MNG_TG", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CUST_NAME_MNG_TG")));
						lrArgData.setValue("CUST_NAME", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CUST_NAME")));
						lrArgData.setValue("BANK_MNG", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("BANK_MNG")));
						lrArgData.setValue("BANK_MNG_TG", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("BANK_MNG_TG")));
						lrArgData.setValue("BANK_CODE", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("BANK_CODE")));
						lrArgData.setValue("BANK_NAME", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("BANK_NAME")));
						lrArgData.setValue("ACCNO_MNG", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("ACCNO_MNG")));
						lrArgData.setValue("ACCNO_MNG_TG", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("ACCNO_MNG_TG")));
						lrArgData.setValue("ACCNO", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("ACCNO")));
						lrArgData.setValue("ACC_REMAIN_MNG", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("ACC_REMAIN_MNG")));
						lrArgData.setValue("RESET_SLIP_ID", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("RESET_SLIP_ID")));
						lrArgData.setValue("RESET_SLIP_IDSEQ", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("RESET_SLIP_IDSEQ")));
						lrArgData.setValue("CHK_NO_MNG", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CHK_NO_MNG")));
						lrArgData.setValue("CHK_NO_MNG_TG", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CHK_NO_MNG_TG")));
						lrArgData.setValue("CHK_NO", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CHK_NO")));
						lrArgData.setValue("CHK_PUBL_DT", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CHK_PUBL_DT")));
						lrArgData.setValue("BILL_NO_MNG", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("BILL_NO_MNG")));
						lrArgData.setValue("BILL_NO_MNG_TG", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("BILL_NO_MNG_TG")));
						lrArgData.setValue("BILL_NO", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("BILL_NO")));
						lrArgData.setValue("BILL_NO_S", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("BILL_NO_S")));
						lrArgData.setValue("BILL_PUBL_DT", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("BILL_PUBL_DT")));
						lrArgData.setValue("BILL_EXPR_DT", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("BILL_EXPR_DT")));
						lrArgData.setValue("BILL_NO_R", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("BILL_NO_R")));
						lrArgData.setValue("BILL_PUBL_DT_R", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("BILL_PUBL_DT_R")));
						lrArgData.setValue("BILL_EXPR_DT_R", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("BILL_EXPR_DT_R")));
						lrArgData.setValue("BILL_CHG_EXPR_DT_R", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("BILL_CHG_EXPR_DT_R")));
						lrArgData.setValue("REC_BILL_NO_MNG", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("REC_BILL_NO_MNG")));
						lrArgData.setValue("REC_BILL_NO_MNG_TG", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("REC_BILL_NO_MNG_TG")));
						lrArgData.setValue("REC_BILL_NO", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("REC_BILL_NO")));
						lrArgData.setValue("REC_BILL_NO_S", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("REC_BILL_NO_S")));
						lrArgData.setValue("REC_BILL_PUBL_DT", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("REC_BILL_PUBL_DT")));
						lrArgData.setValue("REC_BILL_EXPR_DT", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("REC_BILL_EXPR_DT")));
						lrArgData.setValue("REC_BILL_NO_R", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("REC_BILL_NO_R")));
						lrArgData.setValue("REC_BILL_PUBL_DT_R", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("REC_BILL_PUBL_DT_R")));
						lrArgData.setValue("REC_BILL_EXPR_DT_R", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("REC_BILL_EXPR_DT_R")));
						lrArgData.setValue("REC_BILL_PUBL_AMT_R", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("REC_BILL_PUBL_AMT_R")));
						
						lrArgData.setValue("REC_BILL_DISH_DT_R", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("REC_BILL_DISH_DT_R")));
						lrArgData.setValue("REC_BILL_TRUST_DT_R", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("REC_BILL_TRUST_DT_R")));
						lrArgData.setValue("REC_BILL_TRUST_BANK_CODE_R", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("REC_BILL_TRUST_BANK_CODE_R")));
						lrArgData.setValue("REC_BILL_DISC_DT_R", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("REC_BILL_DISC_DT_R")));
						lrArgData.setValue("REC_BILL_DISC_BANK_CODE_R", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("REC_BILL_DISC_BANK_CODE_R")));
						lrArgData.setValue("REC_BILL_DISC_RAT_R", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("REC_BILL_DISC_RAT_R")));
						lrArgData.setValue("REC_BILL_DISC_AMT_R", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("REC_BILL_DISC_AMT_R")));
						
						
						lrArgData.setValue("CP_NO_MNG", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CP_NO_MNG")));
						lrArgData.setValue("CP_NO_MNG_TG", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CP_NO_MNG_TG")));
						lrArgData.setValue("CP_NO", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CP_NO")));
						
						lrArgData.setValue("CP_NO_S", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CP_NO_S")));
						lrArgData.setValue("CP_BUY_PUBL_DT", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CP_BUY_PUBL_DT")));
						lrArgData.setValue("CP_BUY_EXPR_DT", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CP_BUY_EXPR_DT")));
						lrArgData.setValue("CP_BUY_DUSE_DT", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CP_BUY_DUSE_DT")));
						lrArgData.setValue("CP_BUY_PUBL_AMT", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CP_BUY_PUBL_AMT")));
						lrArgData.setValue("CP_BUY_INCOME_AMT", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CP_BUY_INCOME_AMT")));
						lrArgData.setValue("CP_BUY_PUBL_PLACE", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CP_BUY_PUBL_PLACE")));
						lrArgData.setValue("CP_BUY_PUBL_NAME", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CP_BUY_PUBL_NAME")));
						lrArgData.setValue("CP_BUY_INTR_RAT", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CP_BUY_INTR_RAT")));
						lrArgData.setValue("CP_BUY_CUST_SEQ", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CP_BUY_CUST_SEQ")));

						lrArgData.setValue("CP_NO_R", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CP_NO_R")));
						lrArgData.setValue("CP_BUY_PUBL_DT_R", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CP_BUY_PUBL_DT_R")));
						lrArgData.setValue("CP_BUY_EXPR_DT_R", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CP_BUY_EXPR_DT_R")));
						lrArgData.setValue("CP_BUY_DUSE_DT_R", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CP_BUY_DUSE_DT_R")));
						lrArgData.setValue("CP_BUY_PUBL_AMT_R", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CP_BUY_PUBL_AMT_R")));
						lrArgData.setValue("CP_BUY_INCOME_AMT_R", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CP_BUY_INCOME_AMT_R")));
						lrArgData.setValue("CP_BUY_PUBL_PLACE_R", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CP_BUY_PUBL_PLACE_R")));
						lrArgData.setValue("CP_BUY_PUBL_NAME_R", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CP_BUY_PUBL_NAME_R")));
						lrArgData.setValue("CP_BUY_INTR_RAT_R", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CP_BUY_INTR_RAT_R")));
						lrArgData.setValue("CP_BUY_CUST_SEQ_R", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CP_BUY_CUST_SEQ_R")));
						lrArgData.setValue("CP_BUY_RESET_AMT_R", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CP_BUY_RESET_AMT_R")));
						

						lrArgData.setValue("SECU_MNG", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("SECU_MNG")));
						lrArgData.setValue("SECU_MNG_TG", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("SECU_MNG_TG")));
						lrArgData.setValue("SECU_NO", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("SECU_NO")));
						lrArgData.setValue("SECU_REAL_SECU_NO", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("SECU_NO")));
						lrArgData.setValue("SECU_NO_S", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("SECU_NO_S")));
						lrArgData.setValue("SECU_REAL_SECU_NO_S", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("SECU_REAL_SECU_NO_S")));
						lrArgData.setValue("SECU_SEC_KIND_CODE", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("SECU_SEC_KIND_CODE")));
						lrArgData.setValue("SECU_GET_DT", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("SECU_GET_DT")));
						lrArgData.setValue("SECU_GET_PLACE", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("SECU_GET_PLACE")));
						lrArgData.setValue("SECU_PERSTOCK_AMT", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("SECU_PERSTOCK_AMT")));
						lrArgData.setValue("SECU_INCOME_AMT", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("SECU_INCOME_AMT")));
						lrArgData.setValue("SECU_BF_GET_ITR_AMT", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("SECU_BF_GET_ITR_AMT")));
						lrArgData.setValue("SECU_GET_ITR_AMT", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("SECU_GET_ITR_AMT")));
						lrArgData.setValue("SECU_PUBL_DT", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("SECU_PUBL_DT")));
						lrArgData.setValue("SECU_ITR_TAG", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("SECU_ITR_TAG")));
						lrArgData.setValue("SECU_EXPR_DT", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("SECU_EXPR_DT")));
						lrArgData.setValue("SECU_INTR_RATE", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("SECU_INTR_RATE")));
						
						lrArgData.setValue("SECU_NO_R", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("SECU_NO_R")));
						lrArgData.setValue("SECU_REAL_SECU_NO_R", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("SECU_REAL_SECU_NO_R")));
						lrArgData.setValue("SECU_PERSTOCK_AMT_R", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("SECU_PERSTOCK_AMT_R")));
						lrArgData.setValue("SECU_PUBL_DT_R", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("SECU_PUBL_DT_R")));
						lrArgData.setValue("SECU_EXPR_DT_R", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("SECU_EXPR_DT_R")));
						lrArgData.setValue("SECU_INTR_RATE_R", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("SECU_INTR_RATE_R")));
						lrArgData.setValue("SECU_SALE_AMT_R", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("SECU_SALE_AMT_R")));
						lrArgData.setValue("SECU_SALE_DT_R", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("SECU_SALE_DT_R")));
						lrArgData.setValue("SECU_RETURN_DT_R", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("SECU_RETURN_DT_R")));
						lrArgData.setValue("SECU_CONSIGN_BANK_R", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("SECU_CONSIGN_BANK_R")));
						lrArgData.setValue("SECU_SALE_ITR_AMT_R", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("SECU_SALE_ITR_AMT_R")));
						lrArgData.setValue("SECU_SALE_TAX_R", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("SECU_SALE_TAX_R")));
						lrArgData.setValue("SECU_SALE_LOSS_R", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("SECU_SALE_LOSS_R")));
						lrArgData.setValue("SECU_SALE_NP_ITR_AMT_R", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("SECU_SALE_NP_ITR_AMT_R")));

						lrArgData.setValue("LOAN_NO_MNG", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("LOAN_NO_MNG")));
						lrArgData.setValue("LOAN_NO_MNG_TG", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("LOAN_NO_MNG_TG")));
						lrArgData.setValue("LOAN_REFUND_NO", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("LOAN_REFUND_NO")));
						lrArgData.setValue("LOAN_REFUND_SEQ", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("LOAN_REFUND_SEQ")));
						
						lrArgData.setValue("LOAN_REFUND_NO_S", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("LOAN_REFUND_NO_S")));
						lrArgData.setValue("LOAN_REFUND_SEQ_S", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("LOAN_REFUND_SEQ_S")));
						lrArgData.setValue("LOAN_TRANS_DT", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("LOAN_TRANS_DT")));
						lrArgData.setValue("LOAN_FDT", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("LOAN_FDT")));
						lrArgData.setValue("LOAN_EXPR_DT", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("LOAN_EXPR_DT")));
						lrArgData.setValue("LOAN_REAL_INTR_RATE", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("LOAN_REAL_INTR_RATE")));
						lrArgData.setValue("LOAN_TITLE_INTR_RATE", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("LOAN_TITLE_INTR_RATE")));
						
						lrArgData.setValue("LOAN_REFUND_NO_R", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("LOAN_REFUND_NO_R")));
						lrArgData.setValue("LOAN_REFUND_SEQ_R", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("LOAN_REFUND_SEQ_R")));
						lrArgData.setValue("LOAN_TRANS_DT_R", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("LOAN_TRANS_DT_R")));
						lrArgData.setValue("LOAN_REFUND_SCH_DT_R", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("LOAN_REFUND_SCH_DT_R")));
						lrArgData.setValue("LOAN_REFUND_SCH_ORG_AMT_R", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("LOAN_REFUND_SCH_ORG_AMT_R")));
						lrArgData.setValue("LOAN_REFUND_SCH_INTR_AMT_R", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("LOAN_REFUND_SCH_INTR_AMT_R")));
						lrArgData.setValue("LOAN_REFUND_DT_R", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("LOAN_REFUND_DT_R")));
						lrArgData.setValue("LOAN_REFUND_NO_I", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("LOAN_REFUND_NO_I")));
						lrArgData.setValue("LOAN_REFUND_SEQ_I", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("LOAN_REFUND_SEQ_I")));
						lrArgData.setValue("LOAN_REFUND_SCH_DT_I", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("LOAN_REFUND_SCH_DT_I")));
						lrArgData.setValue("LOAN_REFUND_SCH_ORG_AMT_I", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("LOAN_REFUND_SCH_ORG_AMT_I")));
						lrArgData.setValue("LOAN_INTR_DT_I", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("LOAN_INTR_DT_I")));
						lrArgData.setValue("FIXED_MNG", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("FIXED_MNG")));
						lrArgData.setValue("FIXED_MNG_TG", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("FIXED_MNG_TG")));
						lrArgData.setValue("FIX_ASSET_SEQ", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("FIX_ASSET_SEQ")));
						
						lrArgData.setValue("DEPOSIT_PAY_MNG", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("DEPOSIT_PAY_MNG")));
						lrArgData.setValue("DEPOSIT_PAY_MNG_TG", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("DEPOSIT_PAY_MNG_TG")));
						lrArgData.setValue("DEPOSIT_ACCNO", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("DEPOSIT_ACCNO")));
						lrArgData.setValue("PAYMENT_SEQ", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("PAYMENT_SEQ")));
						lrArgData.setValue("PAYMENT_SCH_DT", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("PAYMENT_SCH_DT")));
						lrArgData.setValue("PAYMENT_SCH_AMT", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("PAYMENT_SCH_AMT")));
						lrArgData.setValue("PAYMENT_DT", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("PAYMENT_DT")));
						lrArgData.setValue("PAYMENT_AMT", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("PAYMENT_AMT")));
						lrArgData.setValue("PAY_CON_MNG", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("PAY_CON_MNG")));
						lrArgData.setValue("PAY_CON_MNG_TG", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("PAY_CON_MNG_TG")));
						lrArgData.setValue("PAY_CON_CASH", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("PAY_CON_CASH")));
						lrArgData.setValue("PAY_CON_BILL", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("PAY_CON_BILL")));
						lrArgData.setValue("BILL_EXPR_MNG", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("BILL_EXPR_MNG")));
						lrArgData.setValue("BILL_EXPR_MNG_TG", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("BILL_EXPR_MNG_TG")));
						lrArgData.setValue("PAY_CON_BILL_DT", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("PAY_CON_BILL_DT")));
						lrArgData.setValue("PAY_CON_BILL_DAYS", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("PAY_CON_BILL_DAYS")));
						lrArgData.setValue("EMP_NO_MNG", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("EMP_NO_MNG")));
						lrArgData.setValue("EMP_NO_MNG_TG", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("EMP_NO_MNG_TG")));
						lrArgData.setValue("EMP_NO", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("EMP_NO")));
						lrArgData.setValue("EMP_NAME", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("EMP_NAME")));
						lrArgData.setValue("ANTICIPATION_DT_MNG", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("ANTICIPATION_DT_MNG")));
						lrArgData.setValue("ANTICIPATION_DT_MNG_TG", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("ANTICIPATION_DT_MNG_TG")));
						lrArgData.setValue("ANTICIPATION_DT", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("ANTICIPATION_DT")));
						
						lrArgData.setValue("CASH_MNG",       rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CASH_MNG")));      
						lrArgData.setValue("CASH_SEQ",       rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CASH_SEQ")));
						lrArgData.setValue("CASH_CASHNO",    rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CASH_CASHNO")));
						lrArgData.setValue("CASH_USE_DT",    rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CASH_USE_DT")));
						lrArgData.setValue("CASH_TRADE_AMT", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CASH_TRADE_AMT")));
						lrArgData.setValue("CASH_REQ_TG",    rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CASH_REQ_TG")));

						lrArgData.setValue("CARD_MNG",       rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CARD_MNG")));
						lrArgData.setValue("CARD_SEQ",       rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CARD_SEQ")));
						lrArgData.setValue("CARD_CARDNO",    rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CARD_CARDNO")));
						lrArgData.setValue("CARD_USE_DT",    rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CARD_USE_DT")));
						lrArgData.setValue("CARD_HAVE_PERS", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CARD_HAVE_PERS")));
						lrArgData.setValue("CARD_TRADE_AMT", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CARD_TRADE_AMT")));
						lrArgData.setValue("CARD_REQ_TG",    rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CARD_REQ_TG")));
						
						lrArgData.setValue("MNG_NAME_CHAR1", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("MNG_NAME_CHAR1")));
						lrArgData.setValue("MNG_TG_CHAR1", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("MNG_TG_CHAR1")));
						lrArgData.setValue("MNG_ITEM_CHAR1", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("MNG_ITEM_CHAR1")));
						lrArgData.setValue("MNG_NAME_CHAR2", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("MNG_NAME_CHAR2")));
						lrArgData.setValue("MNG_TG_CHAR2", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("MNG_TG_CHAR2")));
						lrArgData.setValue("MNG_ITEM_CHAR2", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("MNG_ITEM_CHAR2")));
						lrArgData.setValue("MNG_NAME_CHAR3", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("MNG_NAME_CHAR3")));
						lrArgData.setValue("MNG_TG_CHAR3", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("MNG_TG_CHAR3")));
						lrArgData.setValue("MNG_ITEM_CHAR3", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("MNG_ITEM_CHAR3")));
						lrArgData.setValue("MNG_NAME_CHAR4", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("MNG_NAME_CHAR4")));
						lrArgData.setValue("MNG_TG_CHAR4", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("MNG_TG_CHAR4")));
						lrArgData.setValue("MNG_ITEM_CHAR4", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("MNG_ITEM_CHAR4")));
						lrArgData.setValue("MNG_NAME_NUM1", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("MNG_NAME_NUM1")));
						lrArgData.setValue("MNG_TG_NUM1", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("MNG_TG_NUM1")));
						lrArgData.setValue("MNG_ITEM_NUM1", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("MNG_ITEM_NUM1")));
						lrArgData.setValue("MNG_NAME_NUM2", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("MNG_NAME_NUM2")));
						lrArgData.setValue("MNG_TG_NUM2", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("MNG_TG_NUM2")));
						lrArgData.setValue("MNG_ITEM_NUM2", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("MNG_ITEM_NUM2")));
						lrArgData.setValue("MNG_NAME_NUM3", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("MNG_NAME_NUM3")));
						lrArgData.setValue("MNG_TG_NUM3", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("MNG_TG_NUM3")));
						lrArgData.setValue("MNG_ITEM_NUM3", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("MNG_ITEM_NUM3")));
						lrArgData.setValue("MNG_NAME_NUM4", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("MNG_NAME_NUM4")));
						lrArgData.setValue("MNG_TG_NUM4", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("MNG_TG_NUM4")));
						lrArgData.setValue("MNG_ITEM_NUM4", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("MNG_ITEM_NUM4")));
						lrArgData.setValue("MNG_NAME_DT1", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("MNG_NAME_DT1")));
						lrArgData.setValue("MNG_TG_DT1", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("MNG_TG_DT1")));
						lrArgData.setValue("MNG_ITEM_DT1", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("MNG_ITEM_DT1")));
						lrArgData.setValue("MNG_NAME_DT2", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("MNG_NAME_DT2")));
						lrArgData.setValue("MNG_TG_DT2", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("MNG_TG_DT2")));
						lrArgData.setValue("MNG_ITEM_DT2", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("MNG_ITEM_DT2")));
						lrArgData.setValue("MNG_NAME_DT3", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("MNG_NAME_DT3")));
						lrArgData.setValue("MNG_TG_DT3", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("MNG_TG_DT3")));
						lrArgData.setValue("MNG_ITEM_DT3", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("MNG_ITEM_DT3")));
						lrArgData.setValue("MNG_NAME_DT4", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("MNG_NAME_DT4")));
						lrArgData.setValue("MNG_TG_DT4", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("MNG_TG_DT4")));
						lrArgData.setValue("MNG_ITEM_DT4", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("MNG_ITEM_DT4")));
						lrArgData.setValue("RESET_SLIPNO", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("RESET_SLIPNO")));
					}
					else if (rows_SLIP_D[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_WORK_ACC_SLIP_BODY_U("
															+"?,?,?,?,?,?,?,?,?,?,"
															+"?,?,?,?,?,?,?,?,?,?,"
															+"?,?,?,?,?,?,?,?,?,?,"
															+"?,?,?,?,?,?,?,?,?,?,"
															+"?,?,?,?,?,?,?,?,?,?,"
															+"?,?,?,?,?,?,?,?,?,?,"
															+"?,?,?,?,?,?,?,?,?,?,"
															+"?,?,?,?,?,?,?,?,?,?,"
															+"?,?,?,?,?,?,?,?,?,?,"
															+"?,?,?,?,?,?,?,?,?,?,"
															+"?,?,?,?,?,?,?,?,?,?,"
															+"?,?,?,?,?,?,?,?,?,?,"
															+"?,?,?,?,?,?,?,?,?,?,"
															+"?,?,?,?,?,?,?,?,?,?,"
															+"?,?,?,?,?,?,?,?,?,?,"
															+"?,?,?,?,?,?,?,?,?,?,"
															+"?,?,?,?,?,?,?,?,?,?,"
															+"?,?,?,?,?,?,?,?,?,?,"
															+"?,?,?,?,?,?,?,?,?,?,"
															+"?,?,?,?,?,?,?,?,?,?,"
															+"?,?,?,?,?,?,?,?,?,?,"
															+"?,?,?,?,?,?,?,?,?,?,"
															+"?,?,?,?,?,?,?,?,?,?,"
															+"?,?,?,?,?,?,?,?,?)}";

						lrArgData.addColumn("SLIP_ID",CITData.NUMBER);
						lrArgData.addColumn("SLIP_IDSEQ",CITData.NUMBER);
						lrArgData.addColumn("MODUSERNO",CITData.VARCHAR2);
						lrArgData.addColumn("MAKE_SLIPLINE",CITData.NUMBER);
						lrArgData.addColumn("ACC_CODE",CITData.VARCHAR2);
						lrArgData.addColumn("ACC_NAME",CITData.VARCHAR2);
						lrArgData.addColumn("ACC_REMAIN_POSITION",CITData.VARCHAR2);
						lrArgData.addColumn("DB_AMT",CITData.NUMBER);
						lrArgData.addColumn("DB_AMT_D",CITData.VARCHAR2);
						lrArgData.addColumn("CR_AMT",CITData.NUMBER);
						lrArgData.addColumn("CR_AMT_D",CITData.VARCHAR2);
						lrArgData.addColumn("SUMMARY_CLS",CITData.VARCHAR2);
						lrArgData.addColumn("SUMMARY_CODE",CITData.VARCHAR2);
						lrArgData.addColumn("SUMMARY1",CITData.VARCHAR2);
						lrArgData.addColumn("SUMMARY2",CITData.VARCHAR2);
						lrArgData.addColumn("TAX_COMP_CODE",CITData.VARCHAR2);
						lrArgData.addColumn("COMP_CODE",CITData.VARCHAR2);
						lrArgData.addColumn("DEPT_CODE",CITData.VARCHAR2);
						lrArgData.addColumn("DEPT_NAME",CITData.VARCHAR2);
						lrArgData.addColumn("CLASS_CODE",CITData.VARCHAR2);
						lrArgData.addColumn("CLASS_CODE_NAME",CITData.VARCHAR2);
						lrArgData.addColumn("VAT_CODE",CITData.VARCHAR2);
						lrArgData.addColumn("VAT_NAME",CITData.VARCHAR2);
						lrArgData.addColumn("VAT_DT",CITData.VARCHAR2);
						lrArgData.addColumn("SUPAMT",CITData.NUMBER);
						lrArgData.addColumn("VATAMT",CITData.NUMBER);
						lrArgData.addColumn("RCPTBILL_CLS",CITData.VARCHAR2);
						lrArgData.addColumn("SUBTR_CLS",CITData.VARCHAR2);
						lrArgData.addColumn("SALEBUY_CLS",CITData.VARCHAR2);
						lrArgData.addColumn("VATOCCUR_CLS",CITData.VARCHAR2);
						lrArgData.addColumn("SLIP_DETAIL_LIST",CITData.VARCHAR2);
						lrArgData.addColumn("VAT_ACC_CODE",CITData.VARCHAR2);
						lrArgData.addColumn("BUDG_MNG",CITData.VARCHAR2);
						lrArgData.addColumn("BUDG_EXEC_CLS",CITData.VARCHAR2);
						lrArgData.addColumn("CUST_CODE_MNG",CITData.VARCHAR2);
						lrArgData.addColumn("CUST_CODE_MNG_TG",CITData.VARCHAR2);
						lrArgData.addColumn("CUST_SEQ",CITData.VARCHAR2);
						lrArgData.addColumn("CUST_CODE",CITData.VARCHAR2);
						lrArgData.addColumn("CUST_NAME_MNG",CITData.VARCHAR2);
						lrArgData.addColumn("CUST_NAME_MNG_TG",CITData.VARCHAR2);
						lrArgData.addColumn("CUST_NAME",CITData.VARCHAR2);
						lrArgData.addColumn("BANK_MNG",CITData.VARCHAR2);
						lrArgData.addColumn("BANK_MNG_TG",CITData.VARCHAR2);
						lrArgData.addColumn("BANK_CODE",CITData.VARCHAR2);
						lrArgData.addColumn("BANK_NAME",CITData.VARCHAR2);
						lrArgData.addColumn("ACCNO_MNG",CITData.VARCHAR2);
						lrArgData.addColumn("ACCNO_MNG_TG",CITData.VARCHAR2);
						lrArgData.addColumn("ACCNO",CITData.VARCHAR2);
						lrArgData.addColumn("ACC_REMAIN_MNG",CITData.VARCHAR2);
						lrArgData.addColumn("RESET_SLIP_ID",CITData.NUMBER);
						lrArgData.addColumn("RESET_SLIP_IDSEQ",CITData.NUMBER);
						lrArgData.addColumn("CARD_SEQ_MNG",CITData.VARCHAR2);
						lrArgData.addColumn("CARD_SEQ_MNG_TG",CITData.VARCHAR2);
						lrArgData.addColumn("CARD_SEQ_B",CITData.VARCHAR2);
						lrArgData.addColumn("CHK_NO_MNG",CITData.VARCHAR2);
						lrArgData.addColumn("CHK_NO_MNG_TG",CITData.VARCHAR2);
						lrArgData.addColumn("CHK_NO",CITData.VARCHAR2);
						lrArgData.addColumn("CHK_PUBL_DT",CITData.VARCHAR2);
						lrArgData.addColumn("BILL_NO_MNG",CITData.VARCHAR2);
						lrArgData.addColumn("BILL_NO_MNG_TG",CITData.VARCHAR2);
						lrArgData.addColumn("BILL_NO",CITData.VARCHAR2);
						lrArgData.addColumn("BILL_NO_S",CITData.VARCHAR2);
						lrArgData.addColumn("BILL_PUBL_DT",CITData.VARCHAR2);
						lrArgData.addColumn("BILL_EXPR_DT",CITData.VARCHAR2);
						lrArgData.addColumn("BILL_NO_R",CITData.VARCHAR2);
						lrArgData.addColumn("BILL_PUBL_DT_R",CITData.VARCHAR2);
						lrArgData.addColumn("BILL_EXPR_DT_R",CITData.VARCHAR2);
						lrArgData.addColumn("BILL_CHG_EXPR_DT_R",CITData.VARCHAR2);
						lrArgData.addColumn("REC_BILL_NO_MNG",CITData.VARCHAR2);
						lrArgData.addColumn("REC_BILL_NO_MNG_TG",CITData.VARCHAR2);
						lrArgData.addColumn("REC_BILL_NO",CITData.VARCHAR2);
						lrArgData.addColumn("REC_BILL_NO_S",CITData.VARCHAR2);
						lrArgData.addColumn("REC_BILL_PUBL_DT",CITData.VARCHAR2);
						lrArgData.addColumn("REC_BILL_EXPR_DT",CITData.VARCHAR2);
						lrArgData.addColumn("REC_BILL_NO_R",CITData.VARCHAR2);
						lrArgData.addColumn("REC_BILL_PUBL_DT_R",CITData.VARCHAR2);
						lrArgData.addColumn("REC_BILL_EXPR_DT_R",CITData.VARCHAR2);
						lrArgData.addColumn("REC_BILL_PUBL_AMT_R",CITData.NUMBER);
						
						lrArgData.addColumn("REC_BILL_DISH_DT_R",CITData.VARCHAR2);
						lrArgData.addColumn("REC_BILL_TRUST_DT_R",CITData.VARCHAR2);
						lrArgData.addColumn("REC_BILL_TRUST_BANK_CODE_R",CITData.VARCHAR2);
						lrArgData.addColumn("REC_BILL_DISC_DT_R",CITData.VARCHAR2);
						lrArgData.addColumn("REC_BILL_DISC_BANK_CODE_R",CITData.VARCHAR2);
						lrArgData.addColumn("REC_BILL_DISC_RAT_R",CITData.NUMBER);
						lrArgData.addColumn("REC_BILL_DISC_AMT_R",CITData.NUMBER);
						lrArgData.addColumn("CP_NO_MNG",CITData.VARCHAR2);
						lrArgData.addColumn("CP_NO_MNG_TG",CITData.VARCHAR2);
						lrArgData.addColumn("CP_NO",CITData.VARCHAR2);
						
						lrArgData.addColumn("CP_NO_S",CITData.VARCHAR2);
						lrArgData.addColumn("CP_BUY_PUBL_DT",CITData.VARCHAR2);
						lrArgData.addColumn("CP_BUY_EXPR_DT",CITData.VARCHAR2);
						lrArgData.addColumn("CP_BUY_DUSE_DT",CITData.VARCHAR2);
						lrArgData.addColumn("CP_BUY_PUBL_AMT",CITData.NUMBER);
						lrArgData.addColumn("CP_BUY_INCOME_AMT",CITData.NUMBER);
						lrArgData.addColumn("CP_BUY_PUBL_PLACE",CITData.VARCHAR2);
						lrArgData.addColumn("CP_BUY_PUBL_NAME",CITData.VARCHAR2);
						lrArgData.addColumn("CP_BUY_INTR_RAT",CITData.NUMBER);
						lrArgData.addColumn("CP_BUY_CUST_SEQ",CITData.NUMBER);
						
						lrArgData.addColumn("CP_NO_R",CITData.VARCHAR2);
						lrArgData.addColumn("CP_BUY_PUBL_DT_R",CITData.VARCHAR2);
						lrArgData.addColumn("CP_BUY_EXPR_DT_R",CITData.VARCHAR2);
						lrArgData.addColumn("CP_BUY_DUSE_DT_R",CITData.VARCHAR2);
						lrArgData.addColumn("CP_BUY_PUBL_AMT_R",CITData.NUMBER);
						lrArgData.addColumn("CP_BUY_INCOME_AMT_R",CITData.NUMBER);
						lrArgData.addColumn("CP_BUY_PUBL_PLACE_R",CITData.VARCHAR2);
						lrArgData.addColumn("CP_BUY_PUBL_NAME_R",CITData.VARCHAR2);
						lrArgData.addColumn("CP_BUY_INTR_RAT_R",CITData.NUMBER);
						lrArgData.addColumn("CP_BUY_CUST_SEQ_R",CITData.NUMBER);
						lrArgData.addColumn("CP_BUY_RESET_AMT_R",CITData.NUMBER);
						
						lrArgData.addColumn("SECU_MNG",CITData.VARCHAR2);
						lrArgData.addColumn("SECU_MNG_TG",CITData.VARCHAR2);
						lrArgData.addColumn("SECU_NO",CITData.NUMBER);
						lrArgData.addColumn("SECU_REAL_SECU_NO",CITData.VARCHAR2);
						lrArgData.addColumn("SECU_NO_S",CITData.NUMBER);
						lrArgData.addColumn("SECU_REAL_SECU_NO_S",CITData.VARCHAR2);
						lrArgData.addColumn("SECU_SEC_KIND_CODE",CITData.VARCHAR2);
						lrArgData.addColumn("SECU_GET_DT",CITData.VARCHAR2);
						lrArgData.addColumn("SECU_GET_PLACE",CITData.VARCHAR2);
						lrArgData.addColumn("SECU_PERSTOCK_AMT",CITData.NUMBER);
						lrArgData.addColumn("SECU_INCOME_AMT",CITData.NUMBER);
						lrArgData.addColumn("SECU_BF_GET_ITR_AMT",CITData.NUMBER);
						lrArgData.addColumn("SECU_GET_ITR_AMT",CITData.NUMBER);
						lrArgData.addColumn("SECU_PUBL_DT",CITData.VARCHAR2);
						lrArgData.addColumn("SECU_ITR_TAG",CITData.VARCHAR2);
						lrArgData.addColumn("SECU_EXPR_DT",CITData.VARCHAR2);
						lrArgData.addColumn("SECU_INTR_RATE",CITData.NUMBER);
						
						lrArgData.addColumn("SECU_NO_R",CITData.NUMBER);
						lrArgData.addColumn("SECU_REAL_SECU_NO_R",CITData.VARCHAR2);
						lrArgData.addColumn("SECU_PERSTOCK_AMT_R",CITData.NUMBER);
						lrArgData.addColumn("SECU_PUBL_DT_R",CITData.VARCHAR2);
						lrArgData.addColumn("SECU_EXPR_DT_R",CITData.VARCHAR2);
						lrArgData.addColumn("SECU_INTR_RATE_R",CITData.NUMBER);
						lrArgData.addColumn("SECU_SALE_AMT_R",CITData.NUMBER);
						lrArgData.addColumn("SECU_SALE_DT_R",CITData.VARCHAR2);
						lrArgData.addColumn("SECU_RETURN_DT_R",CITData.VARCHAR2);
						lrArgData.addColumn("SECU_CONSIGN_BANK_R",CITData.VARCHAR2);
						lrArgData.addColumn("SECU_SALE_ITR_AMT_R",CITData.NUMBER);
						lrArgData.addColumn("SECU_SALE_TAX_R",CITData.NUMBER);
						lrArgData.addColumn("SECU_SALE_LOSS_R",CITData.NUMBER);
						lrArgData.addColumn("SECU_SALE_NP_ITR_AMT_R",CITData.NUMBER);
						
						lrArgData.addColumn("LOAN_NO_MNG",CITData.VARCHAR2);
						lrArgData.addColumn("LOAN_NO_MNG_TG",CITData.VARCHAR2);
						lrArgData.addColumn("LOAN_REFUND_NO",CITData.VARCHAR2);
						lrArgData.addColumn("LOAN_REFUND_SEQ",CITData.NUMBER);
						
						lrArgData.addColumn("LOAN_REFUND_NO_S",CITData.VARCHAR2);
						lrArgData.addColumn("LOAN_REFUND_SEQ_S",CITData.NUMBER);
						lrArgData.addColumn("LOAN_TRANS_DT",CITData.VARCHAR2);
						lrArgData.addColumn("LOAN_FDT",CITData.VARCHAR2);
						lrArgData.addColumn("LOAN_EXPR_DT",CITData.VARCHAR2);
						lrArgData.addColumn("LOAN_REAL_INTR_RATE",CITData.NUMBER);
						lrArgData.addColumn("LOAN_TITLE_INTR_RATE",CITData.NUMBER);
						
						lrArgData.addColumn("LOAN_REFUND_NO_R",CITData.VARCHAR2);
						lrArgData.addColumn("LOAN_REFUND_SEQ_R",CITData.NUMBER);
						lrArgData.addColumn("LOAN_TRANS_DT_R",CITData.VARCHAR2);
						lrArgData.addColumn("LOAN_REFUND_SCH_DT_R",CITData.VARCHAR2);
						lrArgData.addColumn("LOAN_REFUND_SCH_ORG_AMT_R",CITData.NUMBER);
						lrArgData.addColumn("LOAN_REFUND_SCH_INTR_AMT_R",CITData.NUMBER);
						lrArgData.addColumn("LOAN_REFUND_DT_R",CITData.VARCHAR2);
						lrArgData.addColumn("LOAN_REFUND_NO_I",CITData.VARCHAR2);
						lrArgData.addColumn("LOAN_REFUND_SEQ_I",CITData.NUMBER);
						lrArgData.addColumn("LOAN_REFUND_SCH_DT_I",CITData.VARCHAR2);
						lrArgData.addColumn("LOAN_REFUND_SCH_ORG_AMT_I",CITData.NUMBER);
						lrArgData.addColumn("LOAN_INTR_DT_I",CITData.VARCHAR2);
						lrArgData.addColumn("FIXED_MNG",CITData.VARCHAR2);
						lrArgData.addColumn("FIXED_MNG_TG",CITData.VARCHAR2);
						lrArgData.addColumn("FIX_ASSET_SEQ",CITData.VARCHAR2);
						lrArgData.addColumn("DEPOSIT_PAY_MNG",CITData.VARCHAR2);
						lrArgData.addColumn("DEPOSIT_PAY_MNG_TG",CITData.VARCHAR2);
						lrArgData.addColumn("DEPOSIT_ACCNO",CITData.VARCHAR2);
						lrArgData.addColumn("PAYMENT_SEQ",CITData.NUMBER);
						lrArgData.addColumn("PAYMENT_SCH_DT",CITData.VARCHAR2);
						lrArgData.addColumn("PAYMENT_SCH_AMT",CITData.NUMBER);
						lrArgData.addColumn("PAYMENT_DT",CITData.VARCHAR2);
						lrArgData.addColumn("PAYMENT_AMT",CITData.NUMBER);
						lrArgData.addColumn("PAY_CON_MNG",CITData.VARCHAR2);
						lrArgData.addColumn("PAY_CON_MNG_TG",CITData.VARCHAR2);
						lrArgData.addColumn("PAY_CON_CASH",CITData.NUMBER);
						lrArgData.addColumn("PAY_CON_BILL",CITData.NUMBER);
						lrArgData.addColumn("BILL_EXPR_MNG",CITData.VARCHAR2);
						lrArgData.addColumn("BILL_EXPR_MNG_TG",CITData.VARCHAR2);
						lrArgData.addColumn("PAY_CON_BILL_DT",CITData.VARCHAR2);
						lrArgData.addColumn("PAY_CON_BILL_DAYS",CITData.NUMBER);
						lrArgData.addColumn("EMP_NO_MNG",CITData.VARCHAR2);
						lrArgData.addColumn("EMP_NO_MNG_TG",CITData.VARCHAR2);
						lrArgData.addColumn("EMP_NO",CITData.VARCHAR2);
						lrArgData.addColumn("EMP_NAME",CITData.VARCHAR2);
						lrArgData.addColumn("ANTICIPATION_DT_MNG",CITData.VARCHAR2);
						lrArgData.addColumn("ANTICIPATION_DT_MNG_TG",CITData.VARCHAR2);
						lrArgData.addColumn("ANTICIPATION_DT",CITData.VARCHAR2);
						
						// 현금영수증
						lrArgData.addColumn("CASH_MNG",CITData.VARCHAR2);
						lrArgData.addColumn("CASH_SEQ",CITData.NUMBER);
						lrArgData.addColumn("CASH_CASHNO",CITData.VARCHAR2);
						lrArgData.addColumn("CASH_USE_DT",CITData.VARCHAR2);
						lrArgData.addColumn("CASH_TRADE_AMT",CITData.NUMBER);
						lrArgData.addColumn("CASH_REQ_TG",CITData.VARCHAR2);
						// 신용카드                             
						lrArgData.addColumn("CARD_MNG",CITData.VARCHAR2);
						lrArgData.addColumn("CARD_SEQ",CITData.NUMBER);
						lrArgData.addColumn("CARD_CARDNO",CITData.VARCHAR2);
						lrArgData.addColumn("CARD_USE_DT",CITData.VARCHAR2);
						lrArgData.addColumn("CARD_HAVE_PERS",CITData.VARCHAR2);
						lrArgData.addColumn("CARD_TRADE_AMT",CITData.NUMBER);
						lrArgData.addColumn("CARD_REQ_TG",CITData.VARCHAR2);
						
						lrArgData.addColumn("MNG_NAME_CHAR1",CITData.VARCHAR2);
						lrArgData.addColumn("MNG_TG_CHAR1",CITData.VARCHAR2);
						lrArgData.addColumn("MNG_ITEM_CHAR1",CITData.VARCHAR2);
						lrArgData.addColumn("MNG_NAME_CHAR2",CITData.VARCHAR2);
						lrArgData.addColumn("MNG_TG_CHAR2",CITData.VARCHAR2);
						lrArgData.addColumn("MNG_ITEM_CHAR2",CITData.VARCHAR2);
						lrArgData.addColumn("MNG_NAME_CHAR3",CITData.VARCHAR2);
						lrArgData.addColumn("MNG_TG_CHAR3",CITData.VARCHAR2);
						lrArgData.addColumn("MNG_ITEM_CHAR3",CITData.VARCHAR2);
						lrArgData.addColumn("MNG_NAME_CHAR4",CITData.VARCHAR2);
						lrArgData.addColumn("MNG_TG_CHAR4",CITData.VARCHAR2);
						lrArgData.addColumn("MNG_ITEM_CHAR4",CITData.VARCHAR2);
						lrArgData.addColumn("MNG_NAME_NUM1",CITData.VARCHAR2);
						lrArgData.addColumn("MNG_TG_NUM1",CITData.VARCHAR2);
						lrArgData.addColumn("MNG_ITEM_NUM1",CITData.NUMBER);
						lrArgData.addColumn("MNG_NAME_NUM2",CITData.VARCHAR2);
						lrArgData.addColumn("MNG_TG_NUM2",CITData.VARCHAR2);
						lrArgData.addColumn("MNG_ITEM_NUM2",CITData.NUMBER);
						lrArgData.addColumn("MNG_NAME_NUM3",CITData.VARCHAR2);
						lrArgData.addColumn("MNG_TG_NUM3",CITData.VARCHAR2);
						lrArgData.addColumn("MNG_ITEM_NUM3",CITData.NUMBER);
						lrArgData.addColumn("MNG_NAME_NUM4",CITData.VARCHAR2);
						lrArgData.addColumn("MNG_TG_NUM4",CITData.VARCHAR2);
						lrArgData.addColumn("MNG_ITEM_NUM4",CITData.NUMBER);
						lrArgData.addColumn("MNG_NAME_DT1",CITData.VARCHAR2);
						lrArgData.addColumn("MNG_TG_DT1",CITData.VARCHAR2);
						lrArgData.addColumn("MNG_ITEM_DT1",CITData.VARCHAR2);
						lrArgData.addColumn("MNG_NAME_DT2",CITData.VARCHAR2);
						lrArgData.addColumn("MNG_TG_DT2",CITData.VARCHAR2);
						lrArgData.addColumn("MNG_ITEM_DT2",CITData.VARCHAR2);
						lrArgData.addColumn("MNG_NAME_DT3",CITData.VARCHAR2);
						lrArgData.addColumn("MNG_TG_DT3",CITData.VARCHAR2);
						lrArgData.addColumn("MNG_ITEM_DT3",CITData.VARCHAR2);
						lrArgData.addColumn("MNG_NAME_DT4",CITData.VARCHAR2);
						lrArgData.addColumn("MNG_TG_DT4",CITData.VARCHAR2);
						lrArgData.addColumn("MNG_ITEM_DT4",CITData.VARCHAR2);
						lrArgData.addColumn("RESET_SLIPNO",CITData.VARCHAR2);
						
						lrArgData.addRow();
						
						strSLIP_ID = rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("SLIP_ID"));
						lrArgData.setValue("SLIP_ID", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("SLIP_ID")));
						lrArgData.setValue("SLIP_IDSEQ", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("SLIP_IDSEQ")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("MAKE_SLIPLINE", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("MAKE_SLIPLINE")));
						lrArgData.setValue("ACC_CODE", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("ACC_CODE")));
						lrArgData.setValue("ACC_NAME", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("ACC_NAME")));
						lrArgData.setValue("ACC_REMAIN_POSITION", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("ACC_REMAIN_POSITION")));
						lrArgData.setValue("DB_AMT", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("DB_AMT")));
						lrArgData.setValue("DB_AMT_D", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("DB_AMT_D")));
						lrArgData.setValue("CR_AMT", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CR_AMT")));
						lrArgData.setValue("CR_AMT_D", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CR_AMT_D")));
						lrArgData.setValue("SUMMARY_CLS", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("SUMMARY_CLS")));
						lrArgData.setValue("SUMMARY_CODE", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("SUMMARY_CODE")));
						lrArgData.setValue("SUMMARY1", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("SUMMARY1")));
						lrArgData.setValue("SUMMARY2", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("SUMMARY2")));
						lrArgData.setValue("TAX_COMP_CODE", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("TAX_COMP_CODE")));
						lrArgData.setValue("COMP_CODE", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("DEPT_CODE", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("DEPT_CODE")));
						lrArgData.setValue("DEPT_NAME", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("DEPT_NAME")));
						lrArgData.setValue("CLASS_CODE", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CLASS_CODE")));
						lrArgData.setValue("CLASS_CODE_NAME", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CLASS_CODE_NAME")));
						lrArgData.setValue("VAT_CODE", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("VAT_CODE")));
						lrArgData.setValue("VAT_NAME", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("VAT_NAME")));
						lrArgData.setValue("VAT_DT", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("VAT_DT")));
						lrArgData.setValue("SUPAMT", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("SUPAMT")));
						lrArgData.setValue("VATAMT", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("VATAMT")));
						lrArgData.setValue("RCPTBILL_CLS", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("RCPTBILL_CLS")));
						lrArgData.setValue("SUBTR_CLS", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("SUBTR_CLS")));
						lrArgData.setValue("SALEBUY_CLS", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("SALEBUY_CLS")));
						lrArgData.setValue("VATOCCUR_CLS", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("VATOCCUR_CLS")));
						lrArgData.setValue("SLIP_DETAIL_LIST", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("SLIP_DETAIL_LIST")));
						lrArgData.setValue("VAT_ACC_CODE", "");
						lrArgData.setValue("BUDG_MNG", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("BUDG_MNG")));
						lrArgData.setValue("BUDG_EXEC_CLS", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("BUDG_EXEC_CLS")));
						lrArgData.setValue("CUST_CODE_MNG", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CUST_CODE_MNG")));
						lrArgData.setValue("CUST_CODE_MNG_TG", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CUST_CODE_MNG_TG")));
						lrArgData.setValue("CUST_SEQ", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CUST_SEQ")));
						lrArgData.setValue("CUST_CODE", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CUST_CODE")));
						lrArgData.setValue("CUST_NAME_MNG", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CUST_NAME_MNG")));
						lrArgData.setValue("CUST_NAME_MNG_TG", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CUST_NAME_MNG_TG")));
						lrArgData.setValue("CUST_NAME", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CUST_NAME")));
						lrArgData.setValue("BANK_MNG", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("BANK_MNG")));
						lrArgData.setValue("BANK_MNG_TG", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("BANK_MNG_TG")));
						lrArgData.setValue("BANK_CODE", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("BANK_CODE")));
						lrArgData.setValue("BANK_NAME", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("BANK_NAME")));
						lrArgData.setValue("ACCNO_MNG", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("ACCNO_MNG")));
						lrArgData.setValue("ACCNO_MNG_TG", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("ACCNO_MNG_TG")));
						lrArgData.setValue("ACCNO", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("ACCNO")));
						lrArgData.setValue("ACC_REMAIN_MNG", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("ACC_REMAIN_MNG")));
						lrArgData.setValue("RESET_SLIP_ID", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("RESET_SLIP_ID")));
						lrArgData.setValue("RESET_SLIP_IDSEQ", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("RESET_SLIP_IDSEQ")));
						lrArgData.setValue("CARD_SEQ_MNG", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CARD_SEQ_MNG")));
						lrArgData.setValue("CARD_SEQ_MNG_TG", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CARD_SEQ_MNG_TG")));
						lrArgData.setValue("CARD_SEQ_B", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CARD_SEQ_B")));
						lrArgData.setValue("CHK_NO_MNG", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CHK_NO_MNG")));
						lrArgData.setValue("CHK_NO_MNG_TG", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CHK_NO_MNG_TG")));
						lrArgData.setValue("CHK_NO", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CHK_NO")));
						lrArgData.setValue("CHK_PUBL_DT", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CHK_PUBL_DT")));
						lrArgData.setValue("BILL_NO_MNG", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("BILL_NO_MNG")));
						lrArgData.setValue("BILL_NO_MNG_TG", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("BILL_NO_MNG_TG")));
						lrArgData.setValue("BILL_NO", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("BILL_NO")));
						lrArgData.setValue("BILL_NO_S", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("BILL_NO_S")));
						lrArgData.setValue("BILL_PUBL_DT", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("BILL_PUBL_DT")));
						lrArgData.setValue("BILL_EXPR_DT", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("BILL_EXPR_DT")));
						lrArgData.setValue("BILL_NO_R", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("BILL_NO_R")));
						lrArgData.setValue("BILL_PUBL_DT_R", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("BILL_PUBL_DT_R")));
						lrArgData.setValue("BILL_EXPR_DT_R", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("BILL_EXPR_DT_R")));
						lrArgData.setValue("BILL_CHG_EXPR_DT_R", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("BILL_CHG_EXPR_DT_R")));
						lrArgData.setValue("REC_BILL_NO_MNG", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("REC_BILL_NO_MNG")));
						lrArgData.setValue("REC_BILL_NO_MNG_TG", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("REC_BILL_NO_MNG_TG")));
						lrArgData.setValue("REC_BILL_NO", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("REC_BILL_NO")));
						lrArgData.setValue("REC_BILL_NO_S", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("REC_BILL_NO_S")));
						lrArgData.setValue("REC_BILL_PUBL_DT", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("REC_BILL_PUBL_DT")));
						lrArgData.setValue("REC_BILL_EXPR_DT", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("REC_BILL_EXPR_DT")));
						lrArgData.setValue("REC_BILL_NO_R", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("REC_BILL_NO_R")));
						lrArgData.setValue("REC_BILL_PUBL_DT_R", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("REC_BILL_PUBL_DT_R")));
						lrArgData.setValue("REC_BILL_EXPR_DT_R", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("REC_BILL_EXPR_DT_R")));
						lrArgData.setValue("REC_BILL_PUBL_AMT_R", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("REC_BILL_PUBL_AMT_R")));
						
						lrArgData.setValue("REC_BILL_DISH_DT_R", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("REC_BILL_DISH_DT_R")));
						lrArgData.setValue("REC_BILL_TRUST_DT_R", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("REC_BILL_TRUST_DT_R")));
						lrArgData.setValue("REC_BILL_TRUST_BANK_CODE_R", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("REC_BILL_TRUST_BANK_CODE_R")));
						lrArgData.setValue("REC_BILL_DISC_DT_R", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("REC_BILL_DISC_DT_R")));
						lrArgData.setValue("REC_BILL_DISC_BANK_CODE_R", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("REC_BILL_DISC_BANK_CODE_R")));
						lrArgData.setValue("REC_BILL_DISC_RAT_R", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("REC_BILL_DISC_RAT_R")));
						lrArgData.setValue("REC_BILL_DISC_AMT_R", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("REC_BILL_DISC_AMT_R")));
						
						
						lrArgData.setValue("CP_NO_MNG", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CP_NO_MNG")));
						lrArgData.setValue("CP_NO_MNG_TG", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CP_NO_MNG_TG")));
						lrArgData.setValue("CP_NO", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CP_NO")));
						
						lrArgData.setValue("CP_NO_S", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CP_NO_S")));
						lrArgData.setValue("CP_BUY_PUBL_DT", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CP_BUY_PUBL_DT")));
						lrArgData.setValue("CP_BUY_EXPR_DT", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CP_BUY_EXPR_DT")));
						lrArgData.setValue("CP_BUY_DUSE_DT", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CP_BUY_DUSE_DT")));
						lrArgData.setValue("CP_BUY_PUBL_AMT", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CP_BUY_PUBL_AMT")));
						lrArgData.setValue("CP_BUY_INCOME_AMT", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CP_BUY_INCOME_AMT")));
						lrArgData.setValue("CP_BUY_PUBL_PLACE", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CP_BUY_PUBL_PLACE")));
						lrArgData.setValue("CP_BUY_PUBL_NAME", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CP_BUY_PUBL_NAME")));
						lrArgData.setValue("CP_BUY_INTR_RAT", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CP_BUY_INTR_RAT")));
						lrArgData.setValue("CP_BUY_CUST_SEQ", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CP_BUY_CUST_SEQ")));

						lrArgData.setValue("CP_NO_R", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CP_NO_R")));
						lrArgData.setValue("CP_BUY_PUBL_DT_R", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CP_BUY_PUBL_DT_R")));
						lrArgData.setValue("CP_BUY_EXPR_DT_R", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CP_BUY_EXPR_DT_R")));
						lrArgData.setValue("CP_BUY_DUSE_DT_R", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CP_BUY_DUSE_DT_R")));
						lrArgData.setValue("CP_BUY_PUBL_AMT_R", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CP_BUY_PUBL_AMT_R")));
						lrArgData.setValue("CP_BUY_INCOME_AMT_R", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CP_BUY_INCOME_AMT_R")));
						lrArgData.setValue("CP_BUY_PUBL_PLACE_R", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CP_BUY_PUBL_PLACE_R")));
						lrArgData.setValue("CP_BUY_PUBL_NAME_R", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CP_BUY_PUBL_NAME_R")));
						lrArgData.setValue("CP_BUY_INTR_RAT_R", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CP_BUY_INTR_RAT_R")));
						lrArgData.setValue("CP_BUY_CUST_SEQ_R", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CP_BUY_CUST_SEQ_R")));
						lrArgData.setValue("CP_BUY_RESET_AMT_R", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CP_BUY_RESET_AMT_R")));
						

						lrArgData.setValue("SECU_MNG", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("SECU_MNG")));
						lrArgData.setValue("SECU_MNG_TG", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("SECU_MNG_TG")));
						lrArgData.setValue("SECU_NO", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("SECU_NO")));
						lrArgData.setValue("SECU_REAL_SECU_NO", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("SECU_NO")));
						lrArgData.setValue("SECU_NO_S", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("SECU_NO_S")));
						lrArgData.setValue("SECU_REAL_SECU_NO_S", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("SECU_REAL_SECU_NO_S")));
						lrArgData.setValue("SECU_SEC_KIND_CODE", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("SECU_SEC_KIND_CODE")));
						lrArgData.setValue("SECU_GET_DT", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("SECU_GET_DT")));
						lrArgData.setValue("SECU_GET_PLACE", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("SECU_GET_PLACE")));
						lrArgData.setValue("SECU_PERSTOCK_AMT", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("SECU_PERSTOCK_AMT")));
						lrArgData.setValue("SECU_INCOME_AMT", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("SECU_INCOME_AMT")));
						lrArgData.setValue("SECU_BF_GET_ITR_AMT", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("SECU_BF_GET_ITR_AMT")));
						lrArgData.setValue("SECU_GET_ITR_AMT", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("SECU_GET_ITR_AMT")));
						lrArgData.setValue("SECU_PUBL_DT", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("SECU_PUBL_DT")));
						lrArgData.setValue("SECU_ITR_TAG", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("SECU_ITR_TAG")));
						lrArgData.setValue("SECU_EXPR_DT", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("SECU_EXPR_DT")));
						lrArgData.setValue("SECU_INTR_RATE", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("SECU_INTR_RATE")));
						
						lrArgData.setValue("SECU_NO_R", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("SECU_NO_R")));
						lrArgData.setValue("SECU_REAL_SECU_NO_R", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("SECU_REAL_SECU_NO_R")));
						lrArgData.setValue("SECU_PERSTOCK_AMT_R", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("SECU_PERSTOCK_AMT_R")));
						lrArgData.setValue("SECU_PUBL_DT_R", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("SECU_PUBL_DT_R")));
						lrArgData.setValue("SECU_EXPR_DT_R", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("SECU_EXPR_DT_R")));
						lrArgData.setValue("SECU_INTR_RATE_R", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("SECU_INTR_RATE_R")));
						lrArgData.setValue("SECU_SALE_AMT_R", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("SECU_SALE_AMT_R")));
						lrArgData.setValue("SECU_SALE_DT_R", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("SECU_SALE_DT_R")));
						lrArgData.setValue("SECU_RETURN_DT_R", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("SECU_RETURN_DT_R")));
						lrArgData.setValue("SECU_CONSIGN_BANK_R", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("SECU_CONSIGN_BANK_R")));
						lrArgData.setValue("SECU_SALE_ITR_AMT_R", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("SECU_SALE_ITR_AMT_R")));
						lrArgData.setValue("SECU_SALE_TAX_R", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("SECU_SALE_TAX_R")));
						lrArgData.setValue("SECU_SALE_LOSS_R", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("SECU_SALE_LOSS_R")));
						lrArgData.setValue("SECU_SALE_NP_ITR_AMT_R", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("SECU_SALE_NP_ITR_AMT_R")));

						lrArgData.setValue("LOAN_NO_MNG", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("LOAN_NO_MNG")));
						lrArgData.setValue("LOAN_NO_MNG_TG", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("LOAN_NO_MNG_TG")));
						lrArgData.setValue("LOAN_REFUND_NO", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("LOAN_REFUND_NO")));
						lrArgData.setValue("LOAN_REFUND_SEQ", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("LOAN_REFUND_SEQ")));
						
						lrArgData.setValue("LOAN_REFUND_NO_S", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("LOAN_REFUND_NO_S")));
						lrArgData.setValue("LOAN_REFUND_SEQ_S", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("LOAN_REFUND_SEQ_S")));
						lrArgData.setValue("LOAN_TRANS_DT", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("LOAN_TRANS_DT")));
						lrArgData.setValue("LOAN_FDT", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("LOAN_FDT")));
						lrArgData.setValue("LOAN_EXPR_DT", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("LOAN_EXPR_DT")));
						lrArgData.setValue("LOAN_REAL_INTR_RATE", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("LOAN_REAL_INTR_RATE")));
						lrArgData.setValue("LOAN_TITLE_INTR_RATE", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("LOAN_TITLE_INTR_RATE")));
						
						lrArgData.setValue("LOAN_REFUND_NO_R", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("LOAN_REFUND_NO_R")));
						lrArgData.setValue("LOAN_REFUND_SEQ_R", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("LOAN_REFUND_SEQ_R")));
						lrArgData.setValue("LOAN_TRANS_DT_R", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("LOAN_TRANS_DT_R")));
						lrArgData.setValue("LOAN_REFUND_SCH_DT_R", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("LOAN_REFUND_SCH_DT_R")));
						lrArgData.setValue("LOAN_REFUND_SCH_ORG_AMT_R", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("LOAN_REFUND_SCH_ORG_AMT_R")));
						lrArgData.setValue("LOAN_REFUND_SCH_INTR_AMT_R", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("LOAN_REFUND_SCH_INTR_AMT_R")));
						lrArgData.setValue("LOAN_REFUND_DT_R", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("LOAN_REFUND_DT_R")));
						lrArgData.setValue("LOAN_REFUND_NO_I", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("LOAN_REFUND_NO_I")));
						lrArgData.setValue("LOAN_REFUND_SEQ_I", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("LOAN_REFUND_SEQ_I")));
						lrArgData.setValue("LOAN_REFUND_SCH_DT_I", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("LOAN_REFUND_SCH_DT_I")));
						lrArgData.setValue("LOAN_REFUND_SCH_ORG_AMT_I", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("LOAN_REFUND_SCH_ORG_AMT_I")));
						lrArgData.setValue("LOAN_INTR_DT_I", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("LOAN_INTR_DT_I")));
						lrArgData.setValue("FIXED_MNG", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("FIXED_MNG")));
						lrArgData.setValue("FIXED_MNG_TG", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("FIXED_MNG_TG")));
						lrArgData.setValue("FIX_ASSET_SEQ", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("FIX_ASSET_SEQ")));
						
						lrArgData.setValue("DEPOSIT_PAY_MNG", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("DEPOSIT_PAY_MNG")));
						lrArgData.setValue("DEPOSIT_PAY_MNG_TG", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("DEPOSIT_PAY_MNG_TG")));
						lrArgData.setValue("DEPOSIT_ACCNO", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("DEPOSIT_ACCNO")));
						lrArgData.setValue("PAYMENT_SEQ", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("PAYMENT_SEQ")));
						lrArgData.setValue("PAYMENT_SCH_DT", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("PAYMENT_SCH_DT")));
						lrArgData.setValue("PAYMENT_SCH_AMT", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("PAYMENT_SCH_AMT")));
						lrArgData.setValue("PAYMENT_DT", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("PAYMENT_DT")));
						lrArgData.setValue("PAYMENT_AMT", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("PAYMENT_AMT")));
						lrArgData.setValue("PAY_CON_MNG", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("PAY_CON_MNG")));
						lrArgData.setValue("PAY_CON_MNG_TG", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("PAY_CON_MNG_TG")));
						lrArgData.setValue("PAY_CON_CASH", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("PAY_CON_CASH")));
						lrArgData.setValue("PAY_CON_BILL", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("PAY_CON_BILL")));
						lrArgData.setValue("BILL_EXPR_MNG", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("BILL_EXPR_MNG")));
						lrArgData.setValue("BILL_EXPR_MNG_TG", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("BILL_EXPR_MNG_TG")));
						lrArgData.setValue("PAY_CON_BILL_DT", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("PAY_CON_BILL_DT")));
						lrArgData.setValue("PAY_CON_BILL_DAYS", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("PAY_CON_BILL_DAYS")));
						lrArgData.setValue("EMP_NO_MNG", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("EMP_NO_MNG")));
						lrArgData.setValue("EMP_NO_MNG_TG", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("EMP_NO_MNG_TG")));
						lrArgData.setValue("EMP_NO", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("EMP_NO")));
						lrArgData.setValue("EMP_NAME", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("EMP_NAME")));
						lrArgData.setValue("ANTICIPATION_DT_MNG", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("ANTICIPATION_DT_MNG")));
						lrArgData.setValue("ANTICIPATION_DT_MNG_TG", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("ANTICIPATION_DT_MNG_TG")));
						lrArgData.setValue("ANTICIPATION_DT", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("ANTICIPATION_DT")));
						
						lrArgData.setValue("CASH_MNG",       rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CASH_MNG")));      
						lrArgData.setValue("CASH_SEQ",       rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CASH_SEQ")));
						lrArgData.setValue("CASH_CASHNO",    rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CASH_CASHNO")));
						lrArgData.setValue("CASH_USE_DT",    rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CASH_USE_DT")));
						lrArgData.setValue("CASH_TRADE_AMT", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CASH_TRADE_AMT")));
						lrArgData.setValue("CASH_REQ_TG",    rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CASH_REQ_TG")));

						lrArgData.setValue("CARD_MNG",       rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CARD_MNG")));
						lrArgData.setValue("CARD_SEQ",       rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CARD_SEQ")));
						lrArgData.setValue("CARD_CARDNO",    rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CARD_CARDNO")));
						lrArgData.setValue("CARD_USE_DT",    rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CARD_USE_DT")));
						lrArgData.setValue("CARD_HAVE_PERS", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CARD_HAVE_PERS")));
						lrArgData.setValue("CARD_TRADE_AMT", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CARD_TRADE_AMT")));
						lrArgData.setValue("CARD_REQ_TG",    rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("CARD_REQ_TG")));
						
						lrArgData.setValue("MNG_NAME_CHAR1", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("MNG_NAME_CHAR1")));
						lrArgData.setValue("MNG_TG_CHAR1", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("MNG_TG_CHAR1")));
						lrArgData.setValue("MNG_ITEM_CHAR1", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("MNG_ITEM_CHAR1")));
						lrArgData.setValue("MNG_NAME_CHAR2", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("MNG_NAME_CHAR2")));
						lrArgData.setValue("MNG_TG_CHAR2", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("MNG_TG_CHAR2")));
						lrArgData.setValue("MNG_ITEM_CHAR2", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("MNG_ITEM_CHAR2")));
						lrArgData.setValue("MNG_NAME_CHAR3", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("MNG_NAME_CHAR3")));
						lrArgData.setValue("MNG_TG_CHAR3", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("MNG_TG_CHAR3")));
						lrArgData.setValue("MNG_ITEM_CHAR3", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("MNG_ITEM_CHAR3")));
						lrArgData.setValue("MNG_NAME_CHAR4", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("MNG_NAME_CHAR4")));
						lrArgData.setValue("MNG_TG_CHAR4", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("MNG_TG_CHAR4")));
						lrArgData.setValue("MNG_ITEM_CHAR4", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("MNG_ITEM_CHAR4")));
						lrArgData.setValue("MNG_NAME_NUM1", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("MNG_NAME_NUM1")));
						lrArgData.setValue("MNG_TG_NUM1", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("MNG_TG_NUM1")));
						lrArgData.setValue("MNG_ITEM_NUM1", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("MNG_ITEM_NUM1")));
						lrArgData.setValue("MNG_NAME_NUM2", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("MNG_NAME_NUM2")));
						lrArgData.setValue("MNG_TG_NUM2", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("MNG_TG_NUM2")));
						lrArgData.setValue("MNG_ITEM_NUM2", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("MNG_ITEM_NUM2")));
						lrArgData.setValue("MNG_NAME_NUM3", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("MNG_NAME_NUM3")));
						lrArgData.setValue("MNG_TG_NUM3", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("MNG_TG_NUM3")));
						lrArgData.setValue("MNG_ITEM_NUM3", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("MNG_ITEM_NUM3")));
						lrArgData.setValue("MNG_NAME_NUM4", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("MNG_NAME_NUM4")));
						lrArgData.setValue("MNG_TG_NUM4", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("MNG_TG_NUM4")));
						lrArgData.setValue("MNG_ITEM_NUM4", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("MNG_ITEM_NUM4")));
						lrArgData.setValue("MNG_NAME_DT1", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("MNG_NAME_DT1")));
						lrArgData.setValue("MNG_TG_DT1", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("MNG_TG_DT1")));
						lrArgData.setValue("MNG_ITEM_DT1", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("MNG_ITEM_DT1")));
						lrArgData.setValue("MNG_NAME_DT2", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("MNG_NAME_DT2")));
						lrArgData.setValue("MNG_TG_DT2", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("MNG_TG_DT2")));
						lrArgData.setValue("MNG_ITEM_DT2", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("MNG_ITEM_DT2")));
						lrArgData.setValue("MNG_NAME_DT3", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("MNG_NAME_DT3")));
						lrArgData.setValue("MNG_TG_DT3", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("MNG_TG_DT3")));
						lrArgData.setValue("MNG_ITEM_DT3", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("MNG_ITEM_DT3")));
						lrArgData.setValue("MNG_NAME_DT4", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("MNG_NAME_DT4")));
						lrArgData.setValue("MNG_TG_DT4", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("MNG_TG_DT4")));
						lrArgData.setValue("MNG_ITEM_DT4", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("MNG_ITEM_DT4")));
						lrArgData.setValue("RESET_SLIPNO", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("RESET_SLIPNO")));
					}
					else if (rows_SLIP_D[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_WORK_ACC_SLIP_BODY_D(?,?)}";

						lrArgData.addColumn("SLIP_ID", CITData.NUMBER);
						lrArgData.addColumn("SLIP_IDSEQ", CITData.NUMBER);

						lrArgData.addRow();
						strSLIP_ID = rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("SLIP_ID"));
						lrArgData.setValue("SLIP_ID", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("SLIP_ID")));
						lrArgData.setValue("SLIP_IDSEQ", rows_SLIP_D[i].getString(dsSLIP_D.indexOfColumn("SLIP_IDSEQ")));
					}
					else
					{
						continue;
					}

					CITDatabase.executeProcedure(strSql, lrArgData, conn);
				}
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001", "T_ACC_SLIP_BODY 테이블 데이타 갱신 에러" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
			
			/*
			
			// 전표 오류 CHECK
			if(!CITCommon.isNull(strSLIP_ID))
			{
				try
				{
					CITData lrArgData = new CITData();
					strSql = "{call SP_T_CHECK_SLIP(?,?,?,?)}";

	      			lrArgData.addColumn("SLIP_ID", CITData.NUMBER);
					lrArgData.addColumn("Check_Rela_Work", CITData.VARCHAR2);
					lrArgData.addColumn("Check_Confirmed_Remain", CITData.VARCHAR2);
					lrArgData.addColumn("UPDATE_CLS", CITData.VARCHAR2);
					lrArgData.addRow();
					lrArgData.setValue("SLIP_ID",  strSLIP_ID);
					lrArgData.setValue("Check_Rela_Work", "N");
					lrArgData.setValue("Check_Confirmed_Remain", "Y");
					lrArgData.setValue("UPDATE_CLS", "1");
	
					CITDatabase.executeProcedure(strSql, lrArgData, conn);
				}
				catch (Exception ex)
				{
					if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
					GauceInfo.response.writeException("USER", "900001", "전표 오류 체크 에러" + ex.getMessage());
					throw new Exception(ex.getMessage());
				}
			}
			*/
		}
		
		conn.commit();
	}
	catch (Exception ex)
	{
		if (conn != null) conn.rollback();
		if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
		GauceInfo.response.writeException("SYS", "100001", "페이지 초기화 오류 -> " + ex.getMessage());
	}
	finally
	{
		try
		{
			CITConnectionManager.freeConnection(conn);
			CITCommon.finalServerPage(GauceInfo);
		}
	    catch (Exception ex)
	    {
			if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
	    	GauceInfo.response.writeException("SYS", "100002", "페이지 종료 오류 -> " + ex.getMessage());
	    }
	}
%>
