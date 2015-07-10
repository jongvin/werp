<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : t_WAccCodeR_tr.jsp(계정과목등록)
/* 2. 유형(시나리오) : Update Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 최언회 작성(2005-11-16)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
	CITGauceInfo GauceInfo = null;
	
	GauceDataSet dsMAIN = null;
	
	GauceDataRow[] rows = null;
	
	String strSql = "";
	String strAct = "";
	String strUserNo = "";
	Connection conn = null;
	int		iCntInsDel = 0;
	
	try
	{
		GauceInfo = CITCommon.initServerPage(request, response, session);
		/* 세션정보 */
		conn = CITConnectionManager.getConnection(false);
		strUserNo = CITCommon.toKOR((String)session.getAttribute("emp_no"));
		
		strAct = GauceInfo.request.getParameter("ACT");
		
		if (CITCommon.isNull(strAct))
		{
			dsMAIN = GauceInfo.request.getGauceDataSet("dsMAIN");
			
			if (dsMAIN == null) throw new Exception("dsMAIN이(가) 널(Null)입니다.");
			
			rows = dsMAIN.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					if (rows[i].getJobType() == GauceDataRow.TB_JOB_INSERT)
					{
						iCntInsDel ++;
						strSql = "{call SP_T_ACC_CODE_I(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("ACC_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("ACC_SHRT_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("ACC_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("SHRT_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("COMPUTER_ACC", CITData.VARCHAR2);
						lrArgData.addColumn("ACC_GRP", CITData.VARCHAR2);
						lrArgData.addColumn("ACC_LVL", CITData.VARCHAR2);
						lrArgData.addColumn("ACC_REMAIN_POSITION", CITData.VARCHAR2);
						lrArgData.addColumn("FUND_INPUT_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("ACC_REMAIN_MNG", CITData.VARCHAR2);
						lrArgData.addColumn("SUMMARY_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("CUST_CODE_MNG", CITData.VARCHAR2);
						lrArgData.addColumn("CUST_CODE_MNG_TG", CITData.VARCHAR2);
						lrArgData.addColumn("CUST_NAME_MNG", CITData.VARCHAR2);
						lrArgData.addColumn("CUST_NAME_MNG_TG", CITData.VARCHAR2);
						lrArgData.addColumn("BUDG_MNG", CITData.VARCHAR2);
						lrArgData.addColumn("BUDG_EXEC_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("BANK_MNG", CITData.VARCHAR2);
						lrArgData.addColumn("BANK_MNG_TG", CITData.VARCHAR2);
						lrArgData.addColumn("ACCNO_MNG", CITData.VARCHAR2);
						lrArgData.addColumn("ACCNO_MNG_TG", CITData.VARCHAR2);
						lrArgData.addColumn("CHK_NO_MNG", CITData.VARCHAR2);
						lrArgData.addColumn("CHK_NO_MNG_TG", CITData.VARCHAR2);
						lrArgData.addColumn("BILL_NO_MNG", CITData.VARCHAR2);
						lrArgData.addColumn("BILL_NO_MNG_TG", CITData.VARCHAR2);
						lrArgData.addColumn("REC_BILL_NO_MNG", CITData.VARCHAR2);
						lrArgData.addColumn("REC_BILL_NO_MNG_TG", CITData.VARCHAR2);
						lrArgData.addColumn("CP_NO_MNG", CITData.VARCHAR2);
						lrArgData.addColumn("CP_NO_MNG_TG", CITData.VARCHAR2);
						lrArgData.addColumn("SECU_MNG", CITData.VARCHAR2);
						lrArgData.addColumn("SECU_MNG_TG", CITData.VARCHAR2);
						lrArgData.addColumn("LOAN_NO_MNG", CITData.VARCHAR2);
						lrArgData.addColumn("LOAN_NO_MNG_TG", CITData.VARCHAR2);
						lrArgData.addColumn("FIXED_MNG", CITData.VARCHAR2);
						lrArgData.addColumn("FIXED_MNG_TG", CITData.VARCHAR2);
						lrArgData.addColumn("DEPOSIT_PAY_MNG", CITData.VARCHAR2);
						lrArgData.addColumn("DEPOSIT_PAY_MNG_TG", CITData.VARCHAR2);
						lrArgData.addColumn("PAY_CON_MNG", CITData.VARCHAR2);
						lrArgData.addColumn("PAY_CON_MNG_TG", CITData.VARCHAR2);
						lrArgData.addColumn("BILL_EXPR_MNG", CITData.VARCHAR2);
						lrArgData.addColumn("BILL_EXPR_MNG_TG", CITData.VARCHAR2);
						lrArgData.addColumn("ANTICIPATION_DT_MNG", CITData.VARCHAR2);
						lrArgData.addColumn("ANTICIPATION_DT_MNG_TG", CITData.VARCHAR2);
						lrArgData.addColumn("EMP_NO_MNG", CITData.VARCHAR2);
						lrArgData.addColumn("EMP_NO_MNG_TG", CITData.VARCHAR2);
						lrArgData.addColumn("MNG_NAME_CHAR1", CITData.VARCHAR2);
						lrArgData.addColumn("MNG_TG_CHAR1", CITData.VARCHAR2);
						lrArgData.addColumn("MNG_NAME_CHAR2", CITData.VARCHAR2);
						lrArgData.addColumn("MNG_TG_CHAR2", CITData.VARCHAR2);
						lrArgData.addColumn("MNG_NAME_CHAR3", CITData.VARCHAR2);
						lrArgData.addColumn("MNG_TG_CHAR3", CITData.VARCHAR2);
						lrArgData.addColumn("MNG_NAME_CHAR4", CITData.VARCHAR2);
						lrArgData.addColumn("MNG_TG_CHAR4", CITData.VARCHAR2);
						lrArgData.addColumn("MNG_NAME_NUM1", CITData.VARCHAR2);
						lrArgData.addColumn("MNG_TG_NUM1", CITData.VARCHAR2);
						lrArgData.addColumn("MNG_NAME_NUM2", CITData.VARCHAR2);
						lrArgData.addColumn("MNG_TG_NUM2", CITData.VARCHAR2);
						lrArgData.addColumn("MNG_NAME_NUM3", CITData.VARCHAR2);
						lrArgData.addColumn("MNG_TG_NUM3", CITData.VARCHAR2);
						lrArgData.addColumn("MNG_NAME_NUM4", CITData.VARCHAR2);
						lrArgData.addColumn("MNG_TG_NUM4", CITData.VARCHAR2);
						lrArgData.addColumn("MNG_NAME_DT1", CITData.VARCHAR2);
						lrArgData.addColumn("MNG_TG_DT1", CITData.VARCHAR2);
						lrArgData.addColumn("MNG_NAME_DT2", CITData.VARCHAR2);
						lrArgData.addColumn("MNG_TG_DT2", CITData.VARCHAR2);
						lrArgData.addColumn("MNG_NAME_DT3", CITData.VARCHAR2);
						lrArgData.addColumn("MNG_TG_DT3", CITData.VARCHAR2);
						lrArgData.addColumn("MNG_NAME_DT4", CITData.VARCHAR2);
						lrArgData.addColumn("MNG_TG_DT4", CITData.VARCHAR2);
						lrArgData.addColumn("PRINT_SHEET_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("CARD_SEQ_MNG", CITData.VARCHAR2);
						lrArgData.addColumn("CARD_SEQ_MNG_TG", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("ACC_CODE", rows[i].getString(dsMAIN.indexOfColumn("ACC_CODE")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("ACC_SHRT_NAME", rows[i].getString(dsMAIN.indexOfColumn("ACC_SHRT_NAME")));
						lrArgData.setValue("ACC_NAME", rows[i].getString(dsMAIN.indexOfColumn("ACC_NAME")));
						lrArgData.setValue("SHRT_CODE", rows[i].getString(dsMAIN.indexOfColumn("SHRT_CODE")));
						lrArgData.setValue("COMPUTER_ACC", rows[i].getString(dsMAIN.indexOfColumn("COMPUTER_ACC")));
						lrArgData.setValue("ACC_GRP", rows[i].getString(dsMAIN.indexOfColumn("ACC_GRP")));
						lrArgData.setValue("ACC_LVL", rows[i].getString(dsMAIN.indexOfColumn("ACC_LVL")));
						lrArgData.setValue("ACC_REMAIN_POSITION", rows[i].getString(dsMAIN.indexOfColumn("ACC_REMAIN_POSITION")));
						lrArgData.setValue("FUND_INPUT_CLS", rows[i].getString(dsMAIN.indexOfColumn("FUND_INPUT_CLS")));
						lrArgData.setValue("ACC_REMAIN_MNG", rows[i].getString(dsMAIN.indexOfColumn("ACC_REMAIN_MNG")));
						lrArgData.setValue("SUMMARY_CLS", rows[i].getString(dsMAIN.indexOfColumn("SUMMARY_CLS")));
						lrArgData.setValue("CUST_CODE_MNG", rows[i].getString(dsMAIN.indexOfColumn("CUST_CODE_MNG")));
						lrArgData.setValue("CUST_CODE_MNG_TG", rows[i].getString(dsMAIN.indexOfColumn("CUST_CODE_MNG_TG")));
						lrArgData.setValue("CUST_NAME_MNG", rows[i].getString(dsMAIN.indexOfColumn("CUST_NAME_MNG")));
						lrArgData.setValue("CUST_NAME_MNG_TG", rows[i].getString(dsMAIN.indexOfColumn("CUST_NAME_MNG_TG")));
						lrArgData.setValue("BUDG_MNG", rows[i].getString(dsMAIN.indexOfColumn("BUDG_MNG")));
						lrArgData.setValue("BUDG_EXEC_CLS", rows[i].getString(dsMAIN.indexOfColumn("BUDG_EXEC_CLS")));
						lrArgData.setValue("BANK_MNG", rows[i].getString(dsMAIN.indexOfColumn("BANK_MNG")));
						lrArgData.setValue("BANK_MNG_TG", rows[i].getString(dsMAIN.indexOfColumn("BANK_MNG_TG")));
						lrArgData.setValue("ACCNO_MNG", rows[i].getString(dsMAIN.indexOfColumn("ACCNO_MNG")));
						lrArgData.setValue("ACCNO_MNG_TG", rows[i].getString(dsMAIN.indexOfColumn("ACCNO_MNG_TG")));
						lrArgData.setValue("CHK_NO_MNG", rows[i].getString(dsMAIN.indexOfColumn("CHK_NO_MNG")));
						lrArgData.setValue("CHK_NO_MNG_TG", rows[i].getString(dsMAIN.indexOfColumn("CHK_NO_MNG_TG")));
						lrArgData.setValue("BILL_NO_MNG", rows[i].getString(dsMAIN.indexOfColumn("BILL_NO_MNG")));
						lrArgData.setValue("BILL_NO_MNG_TG", rows[i].getString(dsMAIN.indexOfColumn("BILL_NO_MNG_TG")));
						lrArgData.setValue("REC_BILL_NO_MNG", rows[i].getString(dsMAIN.indexOfColumn("REC_BILL_NO_MNG")));
						lrArgData.setValue("REC_BILL_NO_MNG_TG", rows[i].getString(dsMAIN.indexOfColumn("REC_BILL_NO_MNG_TG")));
						lrArgData.setValue("CP_NO_MNG", rows[i].getString(dsMAIN.indexOfColumn("CP_NO_MNG")));
						lrArgData.setValue("CP_NO_MNG_TG", rows[i].getString(dsMAIN.indexOfColumn("CP_NO_MNG_TG")));
						lrArgData.setValue("SECU_MNG", rows[i].getString(dsMAIN.indexOfColumn("SECU_MNG")));
						lrArgData.setValue("SECU_MNG_TG", rows[i].getString(dsMAIN.indexOfColumn("SECU_MNG_TG")));
						lrArgData.setValue("LOAN_NO_MNG", rows[i].getString(dsMAIN.indexOfColumn("LOAN_NO_MNG")));
						lrArgData.setValue("LOAN_NO_MNG_TG", rows[i].getString(dsMAIN.indexOfColumn("LOAN_NO_MNG_TG")));
						lrArgData.setValue("FIXED_MNG", rows[i].getString(dsMAIN.indexOfColumn("FIXED_MNG")));
						lrArgData.setValue("FIXED_MNG_TG", rows[i].getString(dsMAIN.indexOfColumn("FIXED_MNG_TG")));
						lrArgData.setValue("DEPOSIT_PAY_MNG", rows[i].getString(dsMAIN.indexOfColumn("DEPOSIT_PAY_MNG")));
						lrArgData.setValue("DEPOSIT_PAY_MNG_TG", rows[i].getString(dsMAIN.indexOfColumn("DEPOSIT_PAY_MNG_TG")));
						lrArgData.setValue("PAY_CON_MNG", rows[i].getString(dsMAIN.indexOfColumn("PAY_CON_MNG")));
						lrArgData.setValue("PAY_CON_MNG_TG", rows[i].getString(dsMAIN.indexOfColumn("PAY_CON_MNG_TG")));
						lrArgData.setValue("BILL_EXPR_MNG", rows[i].getString(dsMAIN.indexOfColumn("BILL_EXPR_MNG")));
						lrArgData.setValue("BILL_EXPR_MNG_TG", rows[i].getString(dsMAIN.indexOfColumn("BILL_EXPR_MNG_TG")));
						lrArgData.setValue("ANTICIPATION_DT_MNG", rows[i].getString(dsMAIN.indexOfColumn("ANTICIPATION_DT_MNG")));
						lrArgData.setValue("ANTICIPATION_DT_MNG_TG", rows[i].getString(dsMAIN.indexOfColumn("ANTICIPATION_DT_MNG_TG")));
						lrArgData.setValue("EMP_NO_MNG", rows[i].getString(dsMAIN.indexOfColumn("EMP_NO_MNG")));
						lrArgData.setValue("EMP_NO_MNG_TG", rows[i].getString(dsMAIN.indexOfColumn("EMP_NO_MNG_TG")));
						lrArgData.setValue("MNG_NAME_CHAR1", rows[i].getString(dsMAIN.indexOfColumn("MNG_NAME_CHAR1")));
						lrArgData.setValue("MNG_TG_CHAR1", rows[i].getString(dsMAIN.indexOfColumn("MNG_TG_CHAR1")));
						lrArgData.setValue("MNG_NAME_CHAR2", rows[i].getString(dsMAIN.indexOfColumn("MNG_NAME_CHAR2")));
						lrArgData.setValue("MNG_TG_CHAR2", rows[i].getString(dsMAIN.indexOfColumn("MNG_TG_CHAR2")));
						lrArgData.setValue("MNG_NAME_CHAR3", rows[i].getString(dsMAIN.indexOfColumn("MNG_NAME_CHAR3")));
						lrArgData.setValue("MNG_TG_CHAR3", rows[i].getString(dsMAIN.indexOfColumn("MNG_TG_CHAR3")));
						lrArgData.setValue("MNG_NAME_CHAR4", rows[i].getString(dsMAIN.indexOfColumn("MNG_NAME_CHAR4")));
						lrArgData.setValue("MNG_TG_CHAR4", rows[i].getString(dsMAIN.indexOfColumn("MNG_TG_CHAR4")));
						lrArgData.setValue("MNG_NAME_NUM1", rows[i].getString(dsMAIN.indexOfColumn("MNG_NAME_NUM1")));
						lrArgData.setValue("MNG_TG_NUM1", rows[i].getString(dsMAIN.indexOfColumn("MNG_TG_NUM1")));
						lrArgData.setValue("MNG_NAME_NUM2", rows[i].getString(dsMAIN.indexOfColumn("MNG_NAME_NUM2")));
						lrArgData.setValue("MNG_TG_NUM2", rows[i].getString(dsMAIN.indexOfColumn("MNG_TG_NUM2")));
						lrArgData.setValue("MNG_NAME_NUM3", rows[i].getString(dsMAIN.indexOfColumn("MNG_NAME_NUM3")));
						lrArgData.setValue("MNG_TG_NUM3", rows[i].getString(dsMAIN.indexOfColumn("MNG_TG_NUM3")));
						lrArgData.setValue("MNG_NAME_NUM4", rows[i].getString(dsMAIN.indexOfColumn("MNG_NAME_NUM4")));
						lrArgData.setValue("MNG_TG_NUM4", rows[i].getString(dsMAIN.indexOfColumn("MNG_TG_NUM4")));
						lrArgData.setValue("MNG_NAME_DT1", rows[i].getString(dsMAIN.indexOfColumn("MNG_NAME_DT1")));
						lrArgData.setValue("MNG_TG_DT1", rows[i].getString(dsMAIN.indexOfColumn("MNG_TG_DT1")));
						lrArgData.setValue("MNG_NAME_DT2", rows[i].getString(dsMAIN.indexOfColumn("MNG_NAME_DT2")));
						lrArgData.setValue("MNG_TG_DT2", rows[i].getString(dsMAIN.indexOfColumn("MNG_TG_DT2")));
						lrArgData.setValue("MNG_NAME_DT3", rows[i].getString(dsMAIN.indexOfColumn("MNG_NAME_DT3")));
						lrArgData.setValue("MNG_TG_DT3", rows[i].getString(dsMAIN.indexOfColumn("MNG_TG_DT3")));
						lrArgData.setValue("MNG_NAME_DT4", rows[i].getString(dsMAIN.indexOfColumn("MNG_NAME_DT4")));
						lrArgData.setValue("MNG_TG_DT4", rows[i].getString(dsMAIN.indexOfColumn("MNG_TG_DT4")));
						lrArgData.setValue("PRINT_SHEET_TAG", rows[i].getString(dsMAIN.indexOfColumn("PRINT_SHEET_TAG")));
						lrArgData.setValue("CARD_SEQ_MNG", rows[i].getString(dsMAIN.indexOfColumn("CARD_SEQ_MNG")));
						lrArgData.setValue("CARD_SEQ_MNG_TG", rows[i].getString(dsMAIN.indexOfColumn("CARD_SEQ_MNG_TG")));
						
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_ACC_CODE_U(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("ACC_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("ACC_SHRT_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("ACC_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("SHRT_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("COMPUTER_ACC", CITData.VARCHAR2);
						lrArgData.addColumn("ACC_GRP", CITData.VARCHAR2);
						lrArgData.addColumn("ACC_LVL", CITData.VARCHAR2);
						lrArgData.addColumn("ACC_REMAIN_POSITION", CITData.VARCHAR2);
						lrArgData.addColumn("FUND_INPUT_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("ACC_REMAIN_MNG", CITData.VARCHAR2);
						lrArgData.addColumn("SUMMARY_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("CUST_CODE_MNG", CITData.VARCHAR2);
						lrArgData.addColumn("CUST_CODE_MNG_TG", CITData.VARCHAR2);
						lrArgData.addColumn("CUST_NAME_MNG", CITData.VARCHAR2);
						lrArgData.addColumn("CUST_NAME_MNG_TG", CITData.VARCHAR2);
						lrArgData.addColumn("BUDG_MNG", CITData.VARCHAR2);
						lrArgData.addColumn("BUDG_EXEC_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("BANK_MNG", CITData.VARCHAR2);
						lrArgData.addColumn("BANK_MNG_TG", CITData.VARCHAR2);
						lrArgData.addColumn("ACCNO_MNG", CITData.VARCHAR2);
						lrArgData.addColumn("ACCNO_MNG_TG", CITData.VARCHAR2);
						lrArgData.addColumn("CHK_NO_MNG", CITData.VARCHAR2);
						lrArgData.addColumn("CHK_NO_MNG_TG", CITData.VARCHAR2);
						lrArgData.addColumn("BILL_NO_MNG", CITData.VARCHAR2);
						lrArgData.addColumn("BILL_NO_MNG_TG", CITData.VARCHAR2);
						lrArgData.addColumn("REC_BILL_NO_MNG", CITData.VARCHAR2);
						lrArgData.addColumn("REC_BILL_NO_MNG_TG", CITData.VARCHAR2);
						lrArgData.addColumn("CP_NO_MNG", CITData.VARCHAR2);
						lrArgData.addColumn("CP_NO_MNG_TG", CITData.VARCHAR2);
						lrArgData.addColumn("SECU_MNG", CITData.VARCHAR2);
						lrArgData.addColumn("SECU_MNG_TG", CITData.VARCHAR2);
						lrArgData.addColumn("LOAN_NO_MNG", CITData.VARCHAR2);
						lrArgData.addColumn("LOAN_NO_MNG_TG", CITData.VARCHAR2);
						lrArgData.addColumn("FIXED_MNG", CITData.VARCHAR2);
						lrArgData.addColumn("FIXED_MNG_TG", CITData.VARCHAR2);
						lrArgData.addColumn("DEPOSIT_PAY_MNG", CITData.VARCHAR2);
						lrArgData.addColumn("DEPOSIT_PAY_MNG_TG", CITData.VARCHAR2);
						lrArgData.addColumn("PAY_CON_MNG", CITData.VARCHAR2);
						lrArgData.addColumn("PAY_CON_MNG_TG", CITData.VARCHAR2);
						lrArgData.addColumn("BILL_EXPR_MNG", CITData.VARCHAR2);
						lrArgData.addColumn("BILL_EXPR_MNG_TG", CITData.VARCHAR2);
						lrArgData.addColumn("ANTICIPATION_DT_MNG", CITData.VARCHAR2);
						lrArgData.addColumn("ANTICIPATION_DT_MNG_TG", CITData.VARCHAR2);
						lrArgData.addColumn("EMP_NO_MNG", CITData.VARCHAR2);
						lrArgData.addColumn("EMP_NO_MNG_TG", CITData.VARCHAR2);
						lrArgData.addColumn("MNG_NAME_CHAR1", CITData.VARCHAR2);
						lrArgData.addColumn("MNG_TG_CHAR1", CITData.VARCHAR2);
						lrArgData.addColumn("MNG_NAME_CHAR2", CITData.VARCHAR2);
						lrArgData.addColumn("MNG_TG_CHAR2", CITData.VARCHAR2);
						lrArgData.addColumn("MNG_NAME_CHAR3", CITData.VARCHAR2);
						lrArgData.addColumn("MNG_TG_CHAR3", CITData.VARCHAR2);
						lrArgData.addColumn("MNG_NAME_CHAR4", CITData.VARCHAR2);
						lrArgData.addColumn("MNG_TG_CHAR4", CITData.VARCHAR2);
						lrArgData.addColumn("MNG_NAME_NUM1", CITData.VARCHAR2);
						lrArgData.addColumn("MNG_TG_NUM1", CITData.VARCHAR2);
						lrArgData.addColumn("MNG_NAME_NUM2", CITData.VARCHAR2);
						lrArgData.addColumn("MNG_TG_NUM2", CITData.VARCHAR2);
						lrArgData.addColumn("MNG_NAME_NUM3", CITData.VARCHAR2);
						lrArgData.addColumn("MNG_TG_NUM3", CITData.VARCHAR2);
						lrArgData.addColumn("MNG_NAME_NUM4", CITData.VARCHAR2);
						lrArgData.addColumn("MNG_TG_NUM4", CITData.VARCHAR2);
						lrArgData.addColumn("MNG_NAME_DT1", CITData.VARCHAR2);
						lrArgData.addColumn("MNG_TG_DT1", CITData.VARCHAR2);
						lrArgData.addColumn("MNG_NAME_DT2", CITData.VARCHAR2);
						lrArgData.addColumn("MNG_TG_DT2", CITData.VARCHAR2);
						lrArgData.addColumn("MNG_NAME_DT3", CITData.VARCHAR2);
						lrArgData.addColumn("MNG_TG_DT3", CITData.VARCHAR2);
						lrArgData.addColumn("MNG_NAME_DT4", CITData.VARCHAR2);
						lrArgData.addColumn("MNG_TG_DT4", CITData.VARCHAR2);
						lrArgData.addColumn("PRINT_SHEET_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("CARD_SEQ_MNG", CITData.VARCHAR2);
						lrArgData.addColumn("CARD_SEQ_MNG_TG", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("ACC_CODE", rows[i].getString(dsMAIN.indexOfColumn("ACC_CODE")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("ACC_SHRT_NAME", rows[i].getString(dsMAIN.indexOfColumn("ACC_SHRT_NAME")));
						lrArgData.setValue("ACC_NAME", rows[i].getString(dsMAIN.indexOfColumn("ACC_NAME")));
						lrArgData.setValue("SHRT_CODE", rows[i].getString(dsMAIN.indexOfColumn("SHRT_CODE")));
						lrArgData.setValue("COMPUTER_ACC", rows[i].getString(dsMAIN.indexOfColumn("COMPUTER_ACC")));
						lrArgData.setValue("ACC_GRP", rows[i].getString(dsMAIN.indexOfColumn("ACC_GRP")));
						lrArgData.setValue("ACC_LVL", rows[i].getString(dsMAIN.indexOfColumn("ACC_LVL")));
						lrArgData.setValue("ACC_REMAIN_POSITION", rows[i].getString(dsMAIN.indexOfColumn("ACC_REMAIN_POSITION")));
						lrArgData.setValue("FUND_INPUT_CLS", rows[i].getString(dsMAIN.indexOfColumn("FUND_INPUT_CLS")));
						lrArgData.setValue("ACC_REMAIN_MNG", rows[i].getString(dsMAIN.indexOfColumn("ACC_REMAIN_MNG")));
						lrArgData.setValue("SUMMARY_CLS", rows[i].getString(dsMAIN.indexOfColumn("SUMMARY_CLS")));
						lrArgData.setValue("CUST_CODE_MNG", rows[i].getString(dsMAIN.indexOfColumn("CUST_CODE_MNG")));
						lrArgData.setValue("CUST_CODE_MNG_TG", rows[i].getString(dsMAIN.indexOfColumn("CUST_CODE_MNG_TG")));
						lrArgData.setValue("CUST_NAME_MNG", rows[i].getString(dsMAIN.indexOfColumn("CUST_NAME_MNG")));
						lrArgData.setValue("CUST_NAME_MNG_TG", rows[i].getString(dsMAIN.indexOfColumn("CUST_NAME_MNG_TG")));
						lrArgData.setValue("BUDG_MNG", rows[i].getString(dsMAIN.indexOfColumn("BUDG_MNG")));
						lrArgData.setValue("BUDG_EXEC_CLS", rows[i].getString(dsMAIN.indexOfColumn("BUDG_EXEC_CLS")));
						lrArgData.setValue("BANK_MNG", rows[i].getString(dsMAIN.indexOfColumn("BANK_MNG")));
						lrArgData.setValue("BANK_MNG_TG", rows[i].getString(dsMAIN.indexOfColumn("BANK_MNG_TG")));
						lrArgData.setValue("ACCNO_MNG", rows[i].getString(dsMAIN.indexOfColumn("ACCNO_MNG")));
						lrArgData.setValue("ACCNO_MNG_TG", rows[i].getString(dsMAIN.indexOfColumn("ACCNO_MNG_TG")));
						lrArgData.setValue("CHK_NO_MNG", rows[i].getString(dsMAIN.indexOfColumn("CHK_NO_MNG")));
						lrArgData.setValue("CHK_NO_MNG_TG", rows[i].getString(dsMAIN.indexOfColumn("CHK_NO_MNG_TG")));
						lrArgData.setValue("BILL_NO_MNG", rows[i].getString(dsMAIN.indexOfColumn("BILL_NO_MNG")));
						lrArgData.setValue("BILL_NO_MNG_TG", rows[i].getString(dsMAIN.indexOfColumn("BILL_NO_MNG_TG")));
						lrArgData.setValue("REC_BILL_NO_MNG", rows[i].getString(dsMAIN.indexOfColumn("REC_BILL_NO_MNG")));
						lrArgData.setValue("REC_BILL_NO_MNG_TG", rows[i].getString(dsMAIN.indexOfColumn("REC_BILL_NO_MNG_TG")));
						lrArgData.setValue("CP_NO_MNG", rows[i].getString(dsMAIN.indexOfColumn("CP_NO_MNG")));
						lrArgData.setValue("CP_NO_MNG_TG", rows[i].getString(dsMAIN.indexOfColumn("CP_NO_MNG_TG")));
						lrArgData.setValue("SECU_MNG", rows[i].getString(dsMAIN.indexOfColumn("SECU_MNG")));
						lrArgData.setValue("SECU_MNG_TG", rows[i].getString(dsMAIN.indexOfColumn("SECU_MNG_TG")));
						lrArgData.setValue("LOAN_NO_MNG", rows[i].getString(dsMAIN.indexOfColumn("LOAN_NO_MNG")));
						lrArgData.setValue("LOAN_NO_MNG_TG", rows[i].getString(dsMAIN.indexOfColumn("LOAN_NO_MNG_TG")));
						lrArgData.setValue("FIXED_MNG", rows[i].getString(dsMAIN.indexOfColumn("FIXED_MNG")));
						lrArgData.setValue("FIXED_MNG_TG", rows[i].getString(dsMAIN.indexOfColumn("FIXED_MNG_TG")));
						lrArgData.setValue("DEPOSIT_PAY_MNG", rows[i].getString(dsMAIN.indexOfColumn("DEPOSIT_PAY_MNG")));
						lrArgData.setValue("DEPOSIT_PAY_MNG_TG", rows[i].getString(dsMAIN.indexOfColumn("DEPOSIT_PAY_MNG_TG")));
						lrArgData.setValue("PAY_CON_MNG", rows[i].getString(dsMAIN.indexOfColumn("PAY_CON_MNG")));
						lrArgData.setValue("PAY_CON_MNG_TG", rows[i].getString(dsMAIN.indexOfColumn("PAY_CON_MNG_TG")));
						lrArgData.setValue("BILL_EXPR_MNG", rows[i].getString(dsMAIN.indexOfColumn("BILL_EXPR_MNG")));
						lrArgData.setValue("BILL_EXPR_MNG_TG", rows[i].getString(dsMAIN.indexOfColumn("BILL_EXPR_MNG_TG")));
						lrArgData.setValue("ANTICIPATION_DT_MNG", rows[i].getString(dsMAIN.indexOfColumn("ANTICIPATION_DT_MNG")));
						lrArgData.setValue("ANTICIPATION_DT_MNG_TG", rows[i].getString(dsMAIN.indexOfColumn("ANTICIPATION_DT_MNG_TG")));
						lrArgData.setValue("EMP_NO_MNG", rows[i].getString(dsMAIN.indexOfColumn("EMP_NO_MNG")));
						lrArgData.setValue("EMP_NO_MNG_TG", rows[i].getString(dsMAIN.indexOfColumn("EMP_NO_MNG_TG")));
						lrArgData.setValue("MNG_NAME_CHAR1", rows[i].getString(dsMAIN.indexOfColumn("MNG_NAME_CHAR1")));
						lrArgData.setValue("MNG_TG_CHAR1", rows[i].getString(dsMAIN.indexOfColumn("MNG_TG_CHAR1")));
						lrArgData.setValue("MNG_NAME_CHAR2", rows[i].getString(dsMAIN.indexOfColumn("MNG_NAME_CHAR2")));
						lrArgData.setValue("MNG_TG_CHAR2", rows[i].getString(dsMAIN.indexOfColumn("MNG_TG_CHAR2")));
						lrArgData.setValue("MNG_NAME_CHAR3", rows[i].getString(dsMAIN.indexOfColumn("MNG_NAME_CHAR3")));
						lrArgData.setValue("MNG_TG_CHAR3", rows[i].getString(dsMAIN.indexOfColumn("MNG_TG_CHAR3")));
						lrArgData.setValue("MNG_NAME_CHAR4", rows[i].getString(dsMAIN.indexOfColumn("MNG_NAME_CHAR4")));
						lrArgData.setValue("MNG_TG_CHAR4", rows[i].getString(dsMAIN.indexOfColumn("MNG_TG_CHAR4")));
						lrArgData.setValue("MNG_NAME_NUM1", rows[i].getString(dsMAIN.indexOfColumn("MNG_NAME_NUM1")));
						lrArgData.setValue("MNG_TG_NUM1", rows[i].getString(dsMAIN.indexOfColumn("MNG_TG_NUM1")));
						lrArgData.setValue("MNG_NAME_NUM2", rows[i].getString(dsMAIN.indexOfColumn("MNG_NAME_NUM2")));
						lrArgData.setValue("MNG_TG_NUM2", rows[i].getString(dsMAIN.indexOfColumn("MNG_TG_NUM2")));
						lrArgData.setValue("MNG_NAME_NUM3", rows[i].getString(dsMAIN.indexOfColumn("MNG_NAME_NUM3")));
						lrArgData.setValue("MNG_TG_NUM3", rows[i].getString(dsMAIN.indexOfColumn("MNG_TG_NUM3")));
						lrArgData.setValue("MNG_NAME_NUM4", rows[i].getString(dsMAIN.indexOfColumn("MNG_NAME_NUM4")));
						lrArgData.setValue("MNG_TG_NUM4", rows[i].getString(dsMAIN.indexOfColumn("MNG_TG_NUM4")));
						lrArgData.setValue("MNG_NAME_DT1", rows[i].getString(dsMAIN.indexOfColumn("MNG_NAME_DT1")));
						lrArgData.setValue("MNG_TG_DT1", rows[i].getString(dsMAIN.indexOfColumn("MNG_TG_DT1")));
						lrArgData.setValue("MNG_NAME_DT2", rows[i].getString(dsMAIN.indexOfColumn("MNG_NAME_DT2")));
						lrArgData.setValue("MNG_TG_DT2", rows[i].getString(dsMAIN.indexOfColumn("MNG_TG_DT2")));
						lrArgData.setValue("MNG_NAME_DT3", rows[i].getString(dsMAIN.indexOfColumn("MNG_NAME_DT3")));
						lrArgData.setValue("MNG_TG_DT3", rows[i].getString(dsMAIN.indexOfColumn("MNG_TG_DT3")));
						lrArgData.setValue("MNG_NAME_DT4", rows[i].getString(dsMAIN.indexOfColumn("MNG_NAME_DT4")));
						lrArgData.setValue("MNG_TG_DT4", rows[i].getString(dsMAIN.indexOfColumn("MNG_TG_DT4")));
						lrArgData.setValue("PRINT_SHEET_TAG", rows[i].getString(dsMAIN.indexOfColumn("PRINT_SHEET_TAG")));
						lrArgData.setValue("CARD_SEQ_MNG", rows[i].getString(dsMAIN.indexOfColumn("CARD_SEQ_MNG")));
						lrArgData.setValue("CARD_SEQ_MNG_TG", rows[i].getString(dsMAIN.indexOfColumn("CARD_SEQ_MNG_TG")));
						
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						iCntInsDel ++;
						strSql = "{call SP_T_ACC_CODE_D(?)}";
						
						lrArgData.addColumn("ACC_CODE", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("ACC_CODE", rows[i].getString(dsMAIN.indexOfColumn("ACC_CODE")));
					}
					else
					{
						continue;
					}
					
					CITDatabase.executeProcedure(strSql, lrArgData,conn);
				}
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001", "T_ACC_CODE 테이블 데이타 갱신 에러" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
		}
		if(iCntInsDel > 0)
		{
			strSql = "{call SP_T_CHECK_ACC_CODE()}";
	
	
			CITDatabase.executeProcedure(strSql, new CITData(), conn);
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
