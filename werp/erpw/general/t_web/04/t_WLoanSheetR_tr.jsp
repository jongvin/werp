<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Update Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 김흥수 작성(2005-12-05)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
	CITGauceInfo GauceInfo = null;
	
	GauceDataSet dsMASTER = null;
	GauceDataSet dsMAIN = null;
	GauceDataSet dsSUB01 = null;
	GauceDataSet dsSUB02 = null;
	GauceDataSet dsDVD = null;
	GauceDataSet dsMAKE_ITR_SLIP = null;
	GauceDataSet dsREMOVE_SLIP = null;
	
	GauceDataRow[] rows = null;
	
	String strSql = "";
	String strAct = "";
	String strUserNo = "";
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
	//복사시작
			dsMASTER = GauceInfo.request.getGauceDataSet("dsMASTER");
			
			if (dsMASTER == null) throw new Exception("dsMASTER이(가) 널(Null)입니다.");
			
			rows = dsMASTER.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					if (rows[i].getJobType() == GauceDataRow.TB_JOB_INSERT)
					{
						strSql = "{call SP_T_FIN_LOAN_CONT_I(?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("LOAN_CONT_NO", CITData.NUMBER);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("LIMIT_AMT", CITData.NUMBER);
						lrArgData.addColumn("BANK_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("LOAN_CONT_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("LOAN_CONT_EXPR_DT", CITData.VARCHAR2);
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("FL_LOAN_KIND_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("REMARK", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("LOAN_CONT_NO", rows[i].getString(dsMASTER.indexOfColumn("LOAN_CONT_NO")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("LIMIT_AMT", rows[i].getString(dsMASTER.indexOfColumn("LIMIT_AMT")));
						lrArgData.setValue("BANK_CODE", rows[i].getString(dsMASTER.indexOfColumn("BANK_CODE")));
						lrArgData.setValue("LOAN_CONT_NAME", rows[i].getString(dsMASTER.indexOfColumn("LOAN_CONT_NAME")));
						lrArgData.setValue("LOAN_CONT_EXPR_DT", rows[i].getString(dsMASTER.indexOfColumn("LOAN_CONT_EXPR_DT")));
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsMASTER.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("FL_LOAN_KIND_CODE", rows[i].getString(dsMASTER.indexOfColumn("FL_LOAN_KIND_CODE")));
						lrArgData.setValue("REMARK", rows[i].getString(dsMASTER.indexOfColumn("REMARK")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_FIN_LOAN_CONT_U(?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("LOAN_CONT_NO", CITData.NUMBER);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("LIMIT_AMT", CITData.NUMBER);
						lrArgData.addColumn("BANK_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("LOAN_CONT_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("LOAN_CONT_EXPR_DT", CITData.VARCHAR2);
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("FL_LOAN_KIND_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("REMARK", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("LOAN_CONT_NO", rows[i].getString(dsMASTER.indexOfColumn("LOAN_CONT_NO")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("LIMIT_AMT", rows[i].getString(dsMASTER.indexOfColumn("LIMIT_AMT")));
						lrArgData.setValue("BANK_CODE", rows[i].getString(dsMASTER.indexOfColumn("BANK_CODE")));
						lrArgData.setValue("LOAN_CONT_NAME", rows[i].getString(dsMASTER.indexOfColumn("LOAN_CONT_NAME")));
						lrArgData.setValue("LOAN_CONT_EXPR_DT", rows[i].getString(dsMASTER.indexOfColumn("LOAN_CONT_EXPR_DT")));
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsMASTER.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("FL_LOAN_KIND_CODE", rows[i].getString(dsMASTER.indexOfColumn("FL_LOAN_KIND_CODE")));
						lrArgData.setValue("REMARK", rows[i].getString(dsMASTER.indexOfColumn("REMARK")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_FIN_LOAN_CONT_D(?)}";
						
						lrArgData.addColumn("LOAN_CONT_NO", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("LOAN_CONT_NO", rows[i].getString(dsMASTER.indexOfColumn("LOAN_CONT_NO")));
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
				GauceInfo.response.writeException("USER", "900001", "T_FIN_LOAN_CONT 테이블 데이타 갱신 에러" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
	//복사끝
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
						strSql = "{call SP_T_FIN_LOAN_SHEET_I(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("LOAN_NO", CITData.VARCHAR2);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("LOAN_KIND_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("LOAN_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("BANK_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("LOAN_AMT", CITData.NUMBER);
						lrArgData.addColumn("LIMIT_AMT", CITData.NUMBER);
						lrArgData.addColumn("LOAN_FDT", CITData.VARCHAR2);
						lrArgData.addColumn("LOAN_EXPR_DT", CITData.VARCHAR2);
						lrArgData.addColumn("CHG_EXPR_DT", CITData.VARCHAR2);
						lrArgData.addColumn("REAL_INTR_RATE", CITData.NUMBER);
						lrArgData.addColumn("TITLE_INTR_RATE", CITData.NUMBER);
						lrArgData.addColumn("ORG_REFUND_YEAR", CITData.VARCHAR2);
						lrArgData.addColumn("ORG_REFUND_DIV_YEAR", CITData.VARCHAR2);
						lrArgData.addColumn("ORG_REFUND_MONTH", CITData.VARCHAR2);
						lrArgData.addColumn("ORG_REFUND_FIRST_MONTH", CITData.VARCHAR2);
						lrArgData.addColumn("INTR_MTHD", CITData.VARCHAR2);
						lrArgData.addColumn("INTR_REFUND_DAY", CITData.VARCHAR2);
						lrArgData.addColumn("INTR_REFUND_DIV_MONTH", CITData.VARCHAR2);
						lrArgData.addColumn("INTR_REFUND_FIRST_DT", CITData.VARCHAR2);
						lrArgData.addColumn("REMARK", CITData.VARCHAR2);
						lrArgData.addColumn("REAL_LOAN_NO", CITData.VARCHAR2);
						lrArgData.addColumn("LOAN_CONT_NO", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("LOAN_NO", rows[i].getString(dsMAIN.indexOfColumn("LOAN_NO")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("LOAN_KIND_CODE", rows[i].getString(dsMAIN.indexOfColumn("LOAN_KIND_CODE")));
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsMAIN.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("LOAN_NAME", rows[i].getString(dsMAIN.indexOfColumn("LOAN_NAME")));
						lrArgData.setValue("BANK_CODE", rows[i].getString(dsMAIN.indexOfColumn("BANK_CODE")));
						lrArgData.setValue("LOAN_AMT", rows[i].getString(dsMAIN.indexOfColumn("LOAN_AMT")));
						lrArgData.setValue("LIMIT_AMT", rows[i].getString(dsMAIN.indexOfColumn("LIMIT_AMT")));
						lrArgData.setValue("LOAN_FDT", rows[i].getString(dsMAIN.indexOfColumn("LOAN_FDT")));
						lrArgData.setValue("LOAN_EXPR_DT", rows[i].getString(dsMAIN.indexOfColumn("LOAN_EXPR_DT")));
						lrArgData.setValue("CHG_EXPR_DT", rows[i].getString(dsMAIN.indexOfColumn("CHG_EXPR_DT")));
						lrArgData.setValue("REAL_INTR_RATE", rows[i].getString(dsMAIN.indexOfColumn("REAL_INTR_RATE")));
						lrArgData.setValue("TITLE_INTR_RATE", rows[i].getString(dsMAIN.indexOfColumn("TITLE_INTR_RATE")));
						lrArgData.setValue("ORG_REFUND_YEAR", rows[i].getString(dsMAIN.indexOfColumn("ORG_REFUND_YEAR")));
						lrArgData.setValue("ORG_REFUND_DIV_YEAR", rows[i].getString(dsMAIN.indexOfColumn("ORG_REFUND_DIV_YEAR")));
						lrArgData.setValue("ORG_REFUND_MONTH", rows[i].getString(dsMAIN.indexOfColumn("ORG_REFUND_MONTH")));
						lrArgData.setValue("ORG_REFUND_FIRST_MONTH", rows[i].getString(dsMAIN.indexOfColumn("ORG_REFUND_FIRST_MONTH")));
						lrArgData.setValue("INTR_MTHD", rows[i].getString(dsMAIN.indexOfColumn("INTR_MTHD")));
						lrArgData.setValue("INTR_REFUND_DAY", rows[i].getString(dsMAIN.indexOfColumn("INTR_REFUND_DAY")));
						lrArgData.setValue("INTR_REFUND_DIV_MONTH", rows[i].getString(dsMAIN.indexOfColumn("INTR_REFUND_DIV_MONTH")));
						lrArgData.setValue("INTR_REFUND_FIRST_DT", rows[i].getString(dsMAIN.indexOfColumn("INTR_REFUND_FIRST_DT")));
						lrArgData.setValue("REMARK", rows[i].getString(dsMAIN.indexOfColumn("REMARK")));
						lrArgData.setValue("REAL_LOAN_NO", rows[i].getString(dsMAIN.indexOfColumn("REAL_LOAN_NO")));
						lrArgData.setValue("LOAN_CONT_NO", rows[i].getString(dsMAIN.indexOfColumn("LOAN_CONT_NO")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_FIN_LOAN_SHEET_U(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("LOAN_NO", CITData.VARCHAR2);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("LOAN_KIND_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("LOAN_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("BANK_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("LOAN_AMT", CITData.NUMBER);
						lrArgData.addColumn("LIMIT_AMT", CITData.NUMBER);
						lrArgData.addColumn("LOAN_FDT", CITData.VARCHAR2);
						lrArgData.addColumn("LOAN_EXPR_DT", CITData.VARCHAR2);
						lrArgData.addColumn("CHG_EXPR_DT", CITData.VARCHAR2);
						lrArgData.addColumn("REAL_INTR_RATE", CITData.NUMBER);
						lrArgData.addColumn("TITLE_INTR_RATE", CITData.NUMBER);
						lrArgData.addColumn("ORG_REFUND_YEAR", CITData.VARCHAR2);
						lrArgData.addColumn("ORG_REFUND_DIV_YEAR", CITData.VARCHAR2);
						lrArgData.addColumn("ORG_REFUND_MONTH", CITData.VARCHAR2);
						lrArgData.addColumn("ORG_REFUND_FIRST_MONTH", CITData.VARCHAR2);
						lrArgData.addColumn("INTR_MTHD", CITData.VARCHAR2);
						lrArgData.addColumn("INTR_REFUND_DAY", CITData.VARCHAR2);
						lrArgData.addColumn("INTR_REFUND_DIV_MONTH", CITData.VARCHAR2);
						lrArgData.addColumn("INTR_REFUND_FIRST_DT", CITData.VARCHAR2);
						lrArgData.addColumn("REMARK", CITData.VARCHAR2);
						lrArgData.addColumn("REAL_LOAN_NO", CITData.VARCHAR2);
						lrArgData.addColumn("LOAN_CONT_NO", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("LOAN_NO", rows[i].getString(dsMAIN.indexOfColumn("LOAN_NO")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("LOAN_KIND_CODE", rows[i].getString(dsMAIN.indexOfColumn("LOAN_KIND_CODE")));
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsMAIN.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("LOAN_NAME", rows[i].getString(dsMAIN.indexOfColumn("LOAN_NAME")));
						lrArgData.setValue("BANK_CODE", rows[i].getString(dsMAIN.indexOfColumn("BANK_CODE")));
						lrArgData.setValue("LOAN_AMT", rows[i].getString(dsMAIN.indexOfColumn("LOAN_AMT")));
						lrArgData.setValue("LIMIT_AMT", rows[i].getString(dsMAIN.indexOfColumn("LIMIT_AMT")));
						lrArgData.setValue("LOAN_FDT", rows[i].getString(dsMAIN.indexOfColumn("LOAN_FDT")));
						lrArgData.setValue("LOAN_EXPR_DT", rows[i].getString(dsMAIN.indexOfColumn("LOAN_EXPR_DT")));
						lrArgData.setValue("CHG_EXPR_DT", rows[i].getString(dsMAIN.indexOfColumn("CHG_EXPR_DT")));
						lrArgData.setValue("REAL_INTR_RATE", rows[i].getString(dsMAIN.indexOfColumn("REAL_INTR_RATE")));
						lrArgData.setValue("TITLE_INTR_RATE", rows[i].getString(dsMAIN.indexOfColumn("TITLE_INTR_RATE")));
						lrArgData.setValue("ORG_REFUND_YEAR", rows[i].getString(dsMAIN.indexOfColumn("ORG_REFUND_YEAR")));
						lrArgData.setValue("ORG_REFUND_DIV_YEAR", rows[i].getString(dsMAIN.indexOfColumn("ORG_REFUND_DIV_YEAR")));
						lrArgData.setValue("ORG_REFUND_MONTH", rows[i].getString(dsMAIN.indexOfColumn("ORG_REFUND_MONTH")));
						lrArgData.setValue("ORG_REFUND_FIRST_MONTH", rows[i].getString(dsMAIN.indexOfColumn("ORG_REFUND_FIRST_MONTH")));
						lrArgData.setValue("INTR_MTHD", rows[i].getString(dsMAIN.indexOfColumn("INTR_MTHD")));
						lrArgData.setValue("INTR_REFUND_DAY", rows[i].getString(dsMAIN.indexOfColumn("INTR_REFUND_DAY")));
						lrArgData.setValue("INTR_REFUND_DIV_MONTH", rows[i].getString(dsMAIN.indexOfColumn("INTR_REFUND_DIV_MONTH")));
						lrArgData.setValue("INTR_REFUND_FIRST_DT", rows[i].getString(dsMAIN.indexOfColumn("INTR_REFUND_FIRST_DT")));
						lrArgData.setValue("REMARK", rows[i].getString(dsMAIN.indexOfColumn("REMARK")));
						lrArgData.setValue("REAL_LOAN_NO", rows[i].getString(dsMAIN.indexOfColumn("REAL_LOAN_NO")));
						lrArgData.setValue("LOAN_CONT_NO", rows[i].getString(dsMAIN.indexOfColumn("LOAN_CONT_NO")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_FIN_LOAN_SHEET_D(?)}";
						
						lrArgData.addColumn("LOAN_NO", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("LOAN_NO", rows[i].getString(dsMAIN.indexOfColumn("LOAN_NO")));
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
				GauceInfo.response.writeException("USER", "900001", "T_FIN_LOAN_SHEET 테이블 데이타 갱신 에러" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
	//복사시작
			dsSUB01 = GauceInfo.request.getGauceDataSet("dsSUB01");
			
			if (dsSUB01 == null) throw new Exception("dsSUB01이(가) 널(Null)입니다.");
			
			rows = dsSUB01.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					if (rows[i].getJobType() == GauceDataRow.TB_JOB_INSERT)
					{
						strSql = "{call SP_T_FIN_LOAN_REFUND_LIST_I(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("LOAN_NO", CITData.VARCHAR2);
						lrArgData.addColumn("LOAN_REFUND_SEQ", CITData.NUMBER);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("TRANS_DT", CITData.VARCHAR2);
						lrArgData.addColumn("LOAN_AMT", CITData.NUMBER);
						lrArgData.addColumn("REFUND_SCH_DT", CITData.VARCHAR2);
						lrArgData.addColumn("REFUND_SCH_ORG_AMT", CITData.NUMBER);
						lrArgData.addColumn("REFUND_SCH_INTR_AMT", CITData.NUMBER);
						lrArgData.addColumn("REFUND_INTR_DT", CITData.VARCHAR2);
						lrArgData.addColumn("REFUND_AMT", CITData.NUMBER);
						lrArgData.addColumn("INTR_AMT", CITData.NUMBER);
						lrArgData.addColumn("INTR_START_DT", CITData.VARCHAR2);
						lrArgData.addColumn("INTR_END_DT", CITData.VARCHAR2);
						lrArgData.addColumn("INTR_DAY_CNT", CITData.NUMBER);
						lrArgData.addColumn("LOAN_SLIP_ID", CITData.NUMBER);
						lrArgData.addColumn("LOAN_SLIP_IDSEQ", CITData.NUMBER);
						lrArgData.addColumn("ACC_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("REFUND_SLIP_ID", CITData.NUMBER);
						lrArgData.addColumn("REFUND_SLIP_IDSEQ", CITData.NUMBER);
						lrArgData.addColumn("INTR_SLIP_ID", CITData.NUMBER);
						lrArgData.addColumn("INTR_SLIP_IDSEQ", CITData.NUMBER);
						lrArgData.addColumn("PE_ITR_AMT", CITData.NUMBER);
						lrArgData.addColumn("PE_RESET_ITR_AMT", CITData.NUMBER);
						lrArgData.addColumn("NOE_ITR_AMT", CITData.NUMBER);
						lrArgData.addColumn("AE_ITR_AMT", CITData.NUMBER);
						lrArgData.addColumn("AE_RESET_ITR_AMT", CITData.NUMBER);
						lrArgData.addColumn("PE_RESET_ITR_ID", CITData.NUMBER);
						lrArgData.addColumn("PE_RESET_ITR_IDSEQ", CITData.NUMBER);
						lrArgData.addColumn("AE_RESET_ITR_ID", CITData.NUMBER);
						lrArgData.addColumn("AE_RESET_ITR_IDSEQ", CITData.NUMBER);
						lrArgData.addColumn("ITR_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("AE_ITR_NUM_DAYS", CITData.NUMBER);
						lrArgData.addColumn("PE_START_DT", CITData.VARCHAR2);
						lrArgData.addColumn("PE_END_DT", CITData.VARCHAR2);
						lrArgData.addColumn("AE_START_DT", CITData.VARCHAR2);
						lrArgData.addColumn("AE_END_DT", CITData.VARCHAR2);
						lrArgData.addColumn("ITR_TAR_TAG", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("LOAN_NO", rows[i].getString(dsSUB01.indexOfColumn("LOAN_NO")));
						lrArgData.setValue("LOAN_REFUND_SEQ", rows[i].getString(dsSUB01.indexOfColumn("LOAN_REFUND_SEQ")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("TRANS_DT", rows[i].getString(dsSUB01.indexOfColumn("TRANS_DT")));
						lrArgData.setValue("LOAN_AMT", rows[i].getString(dsSUB01.indexOfColumn("LOAN_AMT")));
						lrArgData.setValue("REFUND_SCH_DT", rows[i].getString(dsSUB01.indexOfColumn("REFUND_SCH_DT")));
						lrArgData.setValue("REFUND_SCH_ORG_AMT", rows[i].getString(dsSUB01.indexOfColumn("REFUND_SCH_ORG_AMT")));
						lrArgData.setValue("REFUND_SCH_INTR_AMT", rows[i].getString(dsSUB01.indexOfColumn("REFUND_SCH_INTR_AMT")));
						lrArgData.setValue("REFUND_INTR_DT", rows[i].getString(dsSUB01.indexOfColumn("REFUND_INTR_DT")));
						lrArgData.setValue("REFUND_AMT", rows[i].getString(dsSUB01.indexOfColumn("REFUND_AMT")));
						lrArgData.setValue("INTR_AMT", rows[i].getString(dsSUB01.indexOfColumn("INTR_AMT")));
						lrArgData.setValue("INTR_START_DT", rows[i].getString(dsSUB01.indexOfColumn("INTR_START_DT")));
						lrArgData.setValue("INTR_END_DT", rows[i].getString(dsSUB01.indexOfColumn("INTR_END_DT")));
						lrArgData.setValue("INTR_DAY_CNT", rows[i].getString(dsSUB01.indexOfColumn("INTR_DAY_CNT")));
						lrArgData.setValue("LOAN_SLIP_ID", rows[i].getString(dsSUB01.indexOfColumn("LOAN_SLIP_ID")));
						lrArgData.setValue("LOAN_SLIP_IDSEQ", rows[i].getString(dsSUB01.indexOfColumn("LOAN_SLIP_IDSEQ")));
						lrArgData.setValue("ACC_CODE", rows[i].getString(dsSUB01.indexOfColumn("ACC_CODE")));
						lrArgData.setValue("REFUND_SLIP_ID", rows[i].getString(dsSUB01.indexOfColumn("REFUND_SLIP_ID")));
						lrArgData.setValue("REFUND_SLIP_IDSEQ", rows[i].getString(dsSUB01.indexOfColumn("REFUND_SLIP_IDSEQ")));
						lrArgData.setValue("INTR_SLIP_ID", rows[i].getString(dsSUB01.indexOfColumn("INTR_SLIP_ID")));
						lrArgData.setValue("INTR_SLIP_IDSEQ", rows[i].getString(dsSUB01.indexOfColumn("INTR_SLIP_IDSEQ")));
						lrArgData.setValue("PE_ITR_AMT", rows[i].getString(dsSUB01.indexOfColumn("PE_ITR_AMT")));
						lrArgData.setValue("PE_RESET_ITR_AMT", rows[i].getString(dsSUB01.indexOfColumn("PE_RESET_ITR_AMT")));
						lrArgData.setValue("NOE_ITR_AMT", rows[i].getString(dsSUB01.indexOfColumn("NOE_ITR_AMT")));
						lrArgData.setValue("AE_ITR_AMT", rows[i].getString(dsSUB01.indexOfColumn("AE_ITR_AMT")));
						lrArgData.setValue("AE_RESET_ITR_AMT", rows[i].getString(dsSUB01.indexOfColumn("AE_RESET_ITR_AMT")));
						lrArgData.setValue("PE_RESET_ITR_ID", rows[i].getString(dsSUB01.indexOfColumn("PE_RESET_ITR_ID")));
						lrArgData.setValue("PE_RESET_ITR_IDSEQ", rows[i].getString(dsSUB01.indexOfColumn("PE_RESET_ITR_IDSEQ")));
						lrArgData.setValue("AE_RESET_ITR_ID", rows[i].getString(dsSUB01.indexOfColumn("AE_RESET_ITR_ID")));
						lrArgData.setValue("AE_RESET_ITR_IDSEQ", rows[i].getString(dsSUB01.indexOfColumn("AE_RESET_ITR_IDSEQ")));
						lrArgData.setValue("ITR_TAG", rows[i].getString(dsSUB01.indexOfColumn("ITR_TAG")));
						lrArgData.setValue("AE_ITR_NUM_DAYS", rows[i].getString(dsSUB01.indexOfColumn("AE_ITR_NUM_DAYS")));
						lrArgData.setValue("PE_START_DT", rows[i].getString(dsSUB01.indexOfColumn("PE_START_DT")));
						lrArgData.setValue("PE_END_DT", rows[i].getString(dsSUB01.indexOfColumn("PE_END_DT")));
						lrArgData.setValue("AE_START_DT", rows[i].getString(dsSUB01.indexOfColumn("AE_START_DT")));
						lrArgData.setValue("AE_END_DT", rows[i].getString(dsSUB01.indexOfColumn("AE_END_DT")));
						lrArgData.setValue("ITR_TAR_TAG", rows[i].getString(dsSUB01.indexOfColumn("ITR_TAR_TAG")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_FIN_LOAN_REFUND_LIST_U(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("LOAN_NO", CITData.VARCHAR2);
						lrArgData.addColumn("LOAN_REFUND_SEQ", CITData.NUMBER);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("TRANS_DT", CITData.VARCHAR2);
						lrArgData.addColumn("LOAN_AMT", CITData.NUMBER);
						lrArgData.addColumn("REFUND_SCH_DT", CITData.VARCHAR2);
						lrArgData.addColumn("REFUND_SCH_ORG_AMT", CITData.NUMBER);
						lrArgData.addColumn("REFUND_SCH_INTR_AMT", CITData.NUMBER);
						lrArgData.addColumn("REFUND_INTR_DT", CITData.VARCHAR2);
						lrArgData.addColumn("REFUND_AMT", CITData.NUMBER);
						lrArgData.addColumn("INTR_AMT", CITData.NUMBER);
						lrArgData.addColumn("INTR_START_DT", CITData.VARCHAR2);
						lrArgData.addColumn("INTR_END_DT", CITData.VARCHAR2);
						lrArgData.addColumn("INTR_DAY_CNT", CITData.NUMBER);
						lrArgData.addColumn("LOAN_SLIP_ID", CITData.NUMBER);
						lrArgData.addColumn("LOAN_SLIP_IDSEQ", CITData.NUMBER);
						lrArgData.addColumn("ACC_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("REFUND_SLIP_ID", CITData.NUMBER);
						lrArgData.addColumn("REFUND_SLIP_IDSEQ", CITData.NUMBER);
						lrArgData.addColumn("INTR_SLIP_ID", CITData.NUMBER);
						lrArgData.addColumn("INTR_SLIP_IDSEQ", CITData.NUMBER);
						lrArgData.addColumn("PE_ITR_AMT", CITData.NUMBER);
						lrArgData.addColumn("PE_RESET_ITR_AMT", CITData.NUMBER);
						lrArgData.addColumn("NOE_ITR_AMT", CITData.NUMBER);
						lrArgData.addColumn("AE_ITR_AMT", CITData.NUMBER);
						lrArgData.addColumn("AE_RESET_ITR_AMT", CITData.NUMBER);
						lrArgData.addColumn("PE_RESET_ITR_ID", CITData.NUMBER);
						lrArgData.addColumn("PE_RESET_ITR_IDSEQ", CITData.NUMBER);
						lrArgData.addColumn("AE_RESET_ITR_ID", CITData.NUMBER);
						lrArgData.addColumn("AE_RESET_ITR_IDSEQ", CITData.NUMBER);
						lrArgData.addColumn("ITR_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("AE_ITR_NUM_DAYS", CITData.NUMBER);
						lrArgData.addColumn("PE_START_DT", CITData.VARCHAR2);
						lrArgData.addColumn("PE_END_DT", CITData.VARCHAR2);
						lrArgData.addColumn("AE_START_DT", CITData.VARCHAR2);
						lrArgData.addColumn("AE_END_DT", CITData.VARCHAR2);
						lrArgData.addColumn("ITR_TAR_TAG", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("LOAN_NO", rows[i].getString(dsSUB01.indexOfColumn("LOAN_NO")));
						lrArgData.setValue("LOAN_REFUND_SEQ", rows[i].getString(dsSUB01.indexOfColumn("LOAN_REFUND_SEQ")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("TRANS_DT", rows[i].getString(dsSUB01.indexOfColumn("TRANS_DT")));
						lrArgData.setValue("LOAN_AMT", rows[i].getString(dsSUB01.indexOfColumn("LOAN_AMT")));
						lrArgData.setValue("REFUND_SCH_DT", rows[i].getString(dsSUB01.indexOfColumn("REFUND_SCH_DT")));
						lrArgData.setValue("REFUND_SCH_ORG_AMT", rows[i].getString(dsSUB01.indexOfColumn("REFUND_SCH_ORG_AMT")));
						lrArgData.setValue("REFUND_SCH_INTR_AMT", rows[i].getString(dsSUB01.indexOfColumn("REFUND_SCH_INTR_AMT")));
						lrArgData.setValue("REFUND_INTR_DT", rows[i].getString(dsSUB01.indexOfColumn("REFUND_INTR_DT")));
						lrArgData.setValue("REFUND_AMT", rows[i].getString(dsSUB01.indexOfColumn("REFUND_AMT")));
						lrArgData.setValue("INTR_AMT", rows[i].getString(dsSUB01.indexOfColumn("INTR_AMT")));
						lrArgData.setValue("INTR_START_DT", rows[i].getString(dsSUB01.indexOfColumn("INTR_START_DT")));
						lrArgData.setValue("INTR_END_DT", rows[i].getString(dsSUB01.indexOfColumn("INTR_END_DT")));
						lrArgData.setValue("INTR_DAY_CNT", rows[i].getString(dsSUB01.indexOfColumn("INTR_DAY_CNT")));
						lrArgData.setValue("LOAN_SLIP_ID", rows[i].getString(dsSUB01.indexOfColumn("LOAN_SLIP_ID")));
						lrArgData.setValue("LOAN_SLIP_IDSEQ", rows[i].getString(dsSUB01.indexOfColumn("LOAN_SLIP_IDSEQ")));
						lrArgData.setValue("ACC_CODE", rows[i].getString(dsSUB01.indexOfColumn("ACC_CODE")));
						lrArgData.setValue("REFUND_SLIP_ID", rows[i].getString(dsSUB01.indexOfColumn("REFUND_SLIP_ID")));
						lrArgData.setValue("REFUND_SLIP_IDSEQ", rows[i].getString(dsSUB01.indexOfColumn("REFUND_SLIP_IDSEQ")));
						lrArgData.setValue("INTR_SLIP_ID", rows[i].getString(dsSUB01.indexOfColumn("INTR_SLIP_ID")));
						lrArgData.setValue("INTR_SLIP_IDSEQ", rows[i].getString(dsSUB01.indexOfColumn("INTR_SLIP_IDSEQ")));
						lrArgData.setValue("PE_ITR_AMT", rows[i].getString(dsSUB01.indexOfColumn("PE_ITR_AMT")));
						lrArgData.setValue("PE_RESET_ITR_AMT", rows[i].getString(dsSUB01.indexOfColumn("PE_RESET_ITR_AMT")));
						lrArgData.setValue("NOE_ITR_AMT", rows[i].getString(dsSUB01.indexOfColumn("NOE_ITR_AMT")));
						lrArgData.setValue("AE_ITR_AMT", rows[i].getString(dsSUB01.indexOfColumn("AE_ITR_AMT")));
						lrArgData.setValue("AE_RESET_ITR_AMT", rows[i].getString(dsSUB01.indexOfColumn("AE_RESET_ITR_AMT")));
						lrArgData.setValue("PE_RESET_ITR_ID", rows[i].getString(dsSUB01.indexOfColumn("PE_RESET_ITR_ID")));
						lrArgData.setValue("PE_RESET_ITR_IDSEQ", rows[i].getString(dsSUB01.indexOfColumn("PE_RESET_ITR_IDSEQ")));
						lrArgData.setValue("AE_RESET_ITR_ID", rows[i].getString(dsSUB01.indexOfColumn("AE_RESET_ITR_ID")));
						lrArgData.setValue("AE_RESET_ITR_IDSEQ", rows[i].getString(dsSUB01.indexOfColumn("AE_RESET_ITR_IDSEQ")));
						lrArgData.setValue("ITR_TAG", rows[i].getString(dsSUB01.indexOfColumn("ITR_TAG")));
						lrArgData.setValue("AE_ITR_NUM_DAYS", rows[i].getString(dsSUB01.indexOfColumn("AE_ITR_NUM_DAYS")));
						lrArgData.setValue("PE_START_DT", rows[i].getString(dsSUB01.indexOfColumn("PE_START_DT")));
						lrArgData.setValue("PE_END_DT", rows[i].getString(dsSUB01.indexOfColumn("PE_END_DT")));
						lrArgData.setValue("AE_START_DT", rows[i].getString(dsSUB01.indexOfColumn("AE_START_DT")));
						lrArgData.setValue("AE_END_DT", rows[i].getString(dsSUB01.indexOfColumn("AE_END_DT")));
						lrArgData.setValue("ITR_TAR_TAG", rows[i].getString(dsSUB01.indexOfColumn("ITR_TAR_TAG")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_FIN_LOAN_REFUND_LIST_D(?,?)}";
						
						lrArgData.addColumn("LOAN_NO", CITData.VARCHAR2);
						lrArgData.addColumn("LOAN_REFUND_SEQ", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("LOAN_NO", rows[i].getString(dsSUB01.indexOfColumn("LOAN_NO")));
						lrArgData.setValue("LOAN_REFUND_SEQ", rows[i].getString(dsSUB01.indexOfColumn("LOAN_REFUND_SEQ")));
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
				GauceInfo.response.writeException("USER", "900001", "T_FIN_LOAN_REFUND_LIST 테이블 데이타 갱신 에러" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
	//복사끝
			dsSUB02 = GauceInfo.request.getGauceDataSet("dsSUB02");
			
			if (dsSUB02 == null) throw new Exception("dsSUB02이(가) 널(Null)입니다.");
			
			rows = dsSUB02.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					if (rows[i].getJobType() == GauceDataRow.TB_JOB_INSERT)
					{
						strSql = "{call SP_T_FIN_LOAN_GUAR_I(?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("LOAN_NO", CITData.VARCHAR2);
						lrArgData.addColumn("GUAR_SEQ", CITData.NUMBER);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("GUARANTOR", CITData.VARCHAR2);
						lrArgData.addColumn("GUAR_NO", CITData.VARCHAR2);
						lrArgData.addColumn("GUAR_NOTE", CITData.VARCHAR2);
						lrArgData.addColumn("GUAR_START_DT", CITData.VARCHAR2);
						lrArgData.addColumn("GUAR_END_DT", CITData.VARCHAR2);
						lrArgData.addColumn("GUAR_ORG_AMT", CITData.NUMBER);
						lrArgData.addColumn("GUAR_AMT", CITData.NUMBER);
						lrArgData.addColumn("GUAR_RATE", CITData.NUMBER);
						lrArgData.addColumn("GUAR_PAYMENT_DT", CITData.VARCHAR2);
						lrArgData.addColumn("GUAR_ESTAB_DT", CITData.VARCHAR2);
						lrArgData.addColumn("GUAR_CANCEL_DT", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("LOAN_NO", rows[i].getString(dsSUB02.indexOfColumn("LOAN_NO")));
						lrArgData.setValue("GUAR_SEQ", rows[i].getString(dsSUB02.indexOfColumn("GUAR_SEQ")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("GUARANTOR", rows[i].getString(dsSUB02.indexOfColumn("GUARANTOR")));
						lrArgData.setValue("GUAR_NO", rows[i].getString(dsSUB02.indexOfColumn("GUAR_NO")));
						lrArgData.setValue("GUAR_NOTE", rows[i].getString(dsSUB02.indexOfColumn("GUAR_NOTE")));
						lrArgData.setValue("GUAR_START_DT", rows[i].getString(dsSUB02.indexOfColumn("GUAR_START_DT")));
						lrArgData.setValue("GUAR_END_DT", rows[i].getString(dsSUB02.indexOfColumn("GUAR_END_DT")));
						lrArgData.setValue("GUAR_ORG_AMT", rows[i].getString(dsSUB02.indexOfColumn("GUAR_ORG_AMT")));
						lrArgData.setValue("GUAR_AMT", rows[i].getString(dsSUB02.indexOfColumn("GUAR_AMT")));
						lrArgData.setValue("GUAR_RATE", rows[i].getString(dsSUB02.indexOfColumn("GUAR_RATE")));
						lrArgData.setValue("GUAR_PAYMENT_DT", rows[i].getString(dsSUB02.indexOfColumn("GUAR_PAYMENT_DT")));
						lrArgData.setValue("GUAR_ESTAB_DT", rows[i].getString(dsSUB02.indexOfColumn("GUAR_ESTAB_DT")));
						lrArgData.setValue("GUAR_CANCEL_DT", rows[i].getString(dsSUB02.indexOfColumn("GUAR_CANCEL_DT")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_FIN_LOAN_GUAR_U(?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("LOAN_NO", CITData.VARCHAR2);
						lrArgData.addColumn("GUAR_SEQ", CITData.NUMBER);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("GUARANTOR", CITData.VARCHAR2);
						lrArgData.addColumn("GUAR_NO", CITData.VARCHAR2);
						lrArgData.addColumn("GUAR_NOTE", CITData.VARCHAR2);
						lrArgData.addColumn("GUAR_START_DT", CITData.VARCHAR2);
						lrArgData.addColumn("GUAR_END_DT", CITData.VARCHAR2);
						lrArgData.addColumn("GUAR_ORG_AMT", CITData.NUMBER);
						lrArgData.addColumn("GUAR_AMT", CITData.NUMBER);
						lrArgData.addColumn("GUAR_RATE", CITData.NUMBER);
						lrArgData.addColumn("GUAR_PAYMENT_DT", CITData.VARCHAR2);
						lrArgData.addColumn("GUAR_ESTAB_DT", CITData.VARCHAR2);
						lrArgData.addColumn("GUAR_CANCEL_DT", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("LOAN_NO", rows[i].getString(dsSUB02.indexOfColumn("LOAN_NO")));
						lrArgData.setValue("GUAR_SEQ", rows[i].getString(dsSUB02.indexOfColumn("GUAR_SEQ")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("GUARANTOR", rows[i].getString(dsSUB02.indexOfColumn("GUARANTOR")));
						lrArgData.setValue("GUAR_NO", rows[i].getString(dsSUB02.indexOfColumn("GUAR_NO")));
						lrArgData.setValue("GUAR_NOTE", rows[i].getString(dsSUB02.indexOfColumn("GUAR_NOTE")));
						lrArgData.setValue("GUAR_START_DT", rows[i].getString(dsSUB02.indexOfColumn("GUAR_START_DT")));
						lrArgData.setValue("GUAR_END_DT", rows[i].getString(dsSUB02.indexOfColumn("GUAR_END_DT")));
						lrArgData.setValue("GUAR_ORG_AMT", rows[i].getString(dsSUB02.indexOfColumn("GUAR_ORG_AMT")));
						lrArgData.setValue("GUAR_AMT", rows[i].getString(dsSUB02.indexOfColumn("GUAR_AMT")));
						lrArgData.setValue("GUAR_RATE", rows[i].getString(dsSUB02.indexOfColumn("GUAR_RATE")));
						lrArgData.setValue("GUAR_PAYMENT_DT", rows[i].getString(dsSUB02.indexOfColumn("GUAR_PAYMENT_DT")));
						lrArgData.setValue("GUAR_ESTAB_DT", rows[i].getString(dsSUB02.indexOfColumn("GUAR_ESTAB_DT")));
						lrArgData.setValue("GUAR_CANCEL_DT", rows[i].getString(dsSUB02.indexOfColumn("GUAR_CANCEL_DT")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_FIN_LOAN_GUAR_D(?,?)}";
						
						lrArgData.addColumn("LOAN_NO", CITData.VARCHAR2);
						lrArgData.addColumn("GUAR_SEQ", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("LOAN_NO", rows[i].getString(dsSUB02.indexOfColumn("LOAN_NO")));
						lrArgData.setValue("GUAR_SEQ", rows[i].getString(dsSUB02.indexOfColumn("GUAR_SEQ")));
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
				GauceInfo.response.writeException("USER", "900001", "T_FIN_LOAN_GUAR  테이블 데이타 갱신 에러" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
		}
		else if(!CITCommon.isNull(strAct) && strAct.equals("DVD"))
		{
			dsDVD = GauceInfo.request.getGauceDataSet("dsDVD");
			rows = dsDVD.getDataRows();
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					strSql = "{call SP_T_FUND_MAKE_SCHEDULE(?,?)}";
					
					lrArgData.addColumn("LOAN_NO", CITData.VARCHAR2);
					lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);

					lrArgData.addRow();
					lrArgData.setValue("LOAN_NO", rows[i].getString(dsDVD.indexOfColumn("LOAN_NO")));
					lrArgData.setValue("CRTUSERNO", strUserNo);
					
					CITDatabase.executeProcedure(strSql, lrArgData, conn);
				}
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001", "SP_T_FUND_MAKE_SCHEDULE 테이블 데이타 갱신 에러" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
		}
		else if(!CITCommon.isNull(strAct) && strAct.equals("MAKE_ITR_SLIP"))
		{
			dsMAKE_ITR_SLIP = GauceInfo.request.getGauceDataSet("dsMAKE_ITR_SLIP");
			rows = dsMAKE_ITR_SLIP.getDataRows();
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					strSql = "{call SP_T_MAKE_LOAN_ITR_SLIP(?,?,?,?,?)}";
					
					lrArgData.addColumn("LOAN_NO", CITData.VARCHAR2);
					lrArgData.addColumn("LOAN_REFUND_SEQ", CITData.NUMBER);
					lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
					lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
					lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);

					lrArgData.addRow();
					lrArgData.setValue("LOAN_NO", rows[i].getString(dsMAKE_ITR_SLIP.indexOfColumn("LOAN_NO")));
					lrArgData.setValue("LOAN_REFUND_SEQ", rows[i].getString(dsMAKE_ITR_SLIP.indexOfColumn("LOAN_REFUND_SEQ")));
					lrArgData.setValue("COMP_CODE", rows[i].getString(dsMAKE_ITR_SLIP.indexOfColumn("COMP_CODE")));
					lrArgData.setValue("DEPT_CODE", rows[i].getString(dsMAKE_ITR_SLIP.indexOfColumn("DEPT_CODE")));
					lrArgData.setValue("CRTUSERNO", strUserNo);
					
					CITDatabase.executeProcedure(strSql, lrArgData, conn);
				}
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001", "SP_T_FUND_MAKE_SCHEDULE 테이블 데이타 갱신 에러" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
		}
		else if(!CITCommon.isNull(strAct) && strAct.equals("REMOVE_SLIP"))
		{
			dsREMOVE_SLIP = GauceInfo.request.getGauceDataSet("dsREMOVE_SLIP");
			rows = dsREMOVE_SLIP.getDataRows();
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					strSql = "{call SP_T_REMOVE_LOAN_SLIP(?,?,?)}";
					
					lrArgData.addColumn("LOAN_NO", CITData.VARCHAR2);
					lrArgData.addColumn("LOAN_REFUND_SEQ", CITData.NUMBER);
					lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);

					lrArgData.addRow();
					lrArgData.setValue("LOAN_NO", rows[i].getString(dsREMOVE_SLIP.indexOfColumn("LOAN_NO")));
					lrArgData.setValue("LOAN_REFUND_SEQ", rows[i].getString(dsREMOVE_SLIP.indexOfColumn("LOAN_REFUND_SEQ")));
					lrArgData.setValue("CRTUSERNO", strUserNo);
					
					CITDatabase.executeProcedure(strSql, lrArgData, conn);
				}
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001", "SP_T_FUND_MAKE_SCHEDULE 테이블 데이타 갱신 에러" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
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
