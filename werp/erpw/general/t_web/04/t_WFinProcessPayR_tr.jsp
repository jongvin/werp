<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Update Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 김흥수 작성(2006-02-13)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
	CITGauceInfo GauceInfo = null;
	
	//Dataset이 여러개이면 이부분을 복사에 붙이셔요(시작)
	GauceDataSet dsMASTER = null;
	GauceDataSet dsMAKE = null;
	GauceDataSet dsREMOVE = null;
	GauceDataSet dsMAIN = null;
	GauceDataSet dsSUB01 = null;
	GauceDataSet dsSUB02 = null;
	GauceDataSet dsSUB03 = null;
	GauceDataSet dsSUB04 = null;
	GauceDataSet dsMAKE_SLIP_INFO = null;
	GauceDataSet dsMAKE_SLIP = null;
	GauceDataSet dsMAKE_PAY_INFO = null;
	GauceDataSet dsMAKE_PAY = null;
	//Dataset이 여러개이면 이부분을 복사에 붙이셔요(끝)
	//Dataset이 여러개이면 아래 나타나는 부분중 '//복사시작' 에서 '//복사끝' 까지를 기존 갱신 페이지의 '//여기에 붙여넣으세요' 자리에 붙여넣으세요
	
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
		if(!CITCommon.isNull(strAct) && strAct.equals("MAKE"))
		{
			dsMAKE = GauceInfo.request.getGauceDataSet("dsMAKE");
			
			if (dsMAKE == null) throw new Exception("dsMAKE이(가) 널(Null)입니다.");
			
			rows = dsMAKE.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					strSql = "{call SP_T_MAKE_PAY_TARGET(?,?,?)}";
						
					lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
					lrArgData.addColumn("WORK_DT", CITData.VARCHAR2);
					lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);

					lrArgData.addRow();
					lrArgData.setValue("COMP_CODE", rows[i].getString(dsMAKE.indexOfColumn("COMP_CODE")));
					lrArgData.setValue("WORK_DT", rows[i].getString(dsMAKE.indexOfColumn("WORK_DT")));
					lrArgData.setValue("CRTUSERNO", strUserNo);
					
					CITDatabase.executeProcedure(strSql, lrArgData, conn);
				}
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001", "T_FIN_PAY_SUM_LIST 테이블 데이타 갱신 에러" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
		}
		if(!CITCommon.isNull(strAct) && strAct.equals("REMOVE"))
		{
			dsREMOVE = GauceInfo.request.getGauceDataSet("dsREMOVE");
			
			if (dsREMOVE == null) throw new Exception("dsREMOVE이(가) 널(Null)입니다.");
			
			rows = dsREMOVE.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					strSql = "{call SP_T_FIN_REMOVE_PAY_SLIP(?,?,?,?,?)}";
						
					lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
					lrArgData.addColumn("WORK_DT", CITData.VARCHAR2);
					lrArgData.addColumn("SLIP_ID", CITData.NUMBER);
					lrArgData.addColumn("SLIP_IDSEQ", CITData.NUMBER);
					lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);

					lrArgData.addRow();
					lrArgData.setValue("COMP_CODE", rows[i].getString(dsREMOVE.indexOfColumn("COMP_CODE")));
					lrArgData.setValue("WORK_DT", rows[i].getString(dsREMOVE.indexOfColumn("WORK_DT")));
					lrArgData.setValue("SLIP_ID", rows[i].getString(dsREMOVE.indexOfColumn("SLIP_ID")));
					lrArgData.setValue("SLIP_IDSEQ", rows[i].getString(dsREMOVE.indexOfColumn("SLIP_IDSEQ")));
					lrArgData.setValue("CRTUSERNO", strUserNo);
					
					CITDatabase.executeProcedure(strSql, lrArgData, conn);
				}
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001", "전표삭제 테이블 데이타 갱신 에러" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
		}
		if(!CITCommon.isNull(strAct) && strAct.equals("MAKE_SLIP"))
		{
	//복사시작
			dsMAKE_SLIP_INFO = GauceInfo.request.getGauceDataSet("dsMAKE_SLIP_INFO");
			
			if (dsMAKE_SLIP_INFO == null) throw new Exception("dsMAKE_SLIP_INFO이(가) 널(Null)입니다.");
			
			rows = dsMAKE_SLIP_INFO.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					if (rows[i].getJobType() == GauceDataRow.TB_JOB_INSERT)
					{
						strSql = "{call SP_T_FIN_PAY_EXEC_LIST_TMP_I(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("WORK_DT", CITData.VARCHAR2);
						lrArgData.addColumn("SEQ", CITData.NUMBER);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("EXEC_KIND_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("TARGET_SLIP_ID", CITData.NUMBER);
						lrArgData.addColumn("TARGET_SLIP_IDSEQ", CITData.NUMBER);
						lrArgData.addColumn("EXEC_AMT", CITData.NUMBER);
						lrArgData.addColumn("OUT_ACC_NO", CITData.VARCHAR2);
						lrArgData.addColumn("IN_BANK_MAIN_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("IN_ACC_NO", CITData.VARCHAR2);
						lrArgData.addColumn("SLIP_PUB_SEQ", CITData.NUMBER);
						lrArgData.addColumn("SLIP_ID", CITData.NUMBER);
						lrArgData.addColumn("SLIP_IDSEQ", CITData.NUMBER);
						lrArgData.addColumn("CHK_BILL_NO", CITData.VARCHAR2);
						lrArgData.addColumn("ACCNO_OWNER", CITData.VARCHAR2);
						lrArgData.addColumn("EXPR_DT", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsMAKE_SLIP_INFO.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("WORK_DT", rows[i].getString(dsMAKE_SLIP_INFO.indexOfColumn("WORK_DT")));
						lrArgData.setValue("SEQ", rows[i].getString(dsMAKE_SLIP_INFO.indexOfColumn("SEQ")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("EXEC_KIND_TAG", rows[i].getString(dsMAKE_SLIP_INFO.indexOfColumn("EXEC_KIND_TAG")));
						lrArgData.setValue("TARGET_SLIP_ID", rows[i].getString(dsMAKE_SLIP_INFO.indexOfColumn("TARGET_SLIP_ID")));
						lrArgData.setValue("TARGET_SLIP_IDSEQ", rows[i].getString(dsMAKE_SLIP_INFO.indexOfColumn("TARGET_SLIP_IDSEQ")));
						lrArgData.setValue("EXEC_AMT", rows[i].getString(dsMAKE_SLIP_INFO.indexOfColumn("EXEC_AMT")));
						lrArgData.setValue("OUT_ACC_NO", rows[i].getString(dsMAKE_SLIP_INFO.indexOfColumn("OUT_ACC_NO")));
						lrArgData.setValue("IN_BANK_MAIN_CODE", rows[i].getString(dsMAKE_SLIP_INFO.indexOfColumn("IN_BANK_MAIN_CODE")));
						lrArgData.setValue("IN_ACC_NO", rows[i].getString(dsMAKE_SLIP_INFO.indexOfColumn("IN_ACC_NO")));
						lrArgData.setValue("SLIP_PUB_SEQ", rows[i].getString(dsMAKE_SLIP_INFO.indexOfColumn("SLIP_PUB_SEQ")));
						lrArgData.setValue("SLIP_ID", rows[i].getString(dsMAKE_SLIP_INFO.indexOfColumn("SLIP_ID")));
						lrArgData.setValue("SLIP_IDSEQ", rows[i].getString(dsMAKE_SLIP_INFO.indexOfColumn("SLIP_IDSEQ")));
						lrArgData.setValue("CHK_BILL_NO", rows[i].getString(dsMAKE_SLIP_INFO.indexOfColumn("CHK_BILL_NO")));
						lrArgData.setValue("ACCNO_OWNER", rows[i].getString(dsMAKE_SLIP_INFO.indexOfColumn("ACCNO_OWNER")));
						lrArgData.setValue("EXPR_DT", rows[i].getString(dsMAKE_SLIP_INFO.indexOfColumn("EXPR_DT")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_FIN_PAY_EXEC_LIST_TMP_U(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("WORK_DT", CITData.VARCHAR2);
						lrArgData.addColumn("SEQ", CITData.NUMBER);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("EXEC_KIND_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("TARGET_SLIP_ID", CITData.NUMBER);
						lrArgData.addColumn("TARGET_SLIP_IDSEQ", CITData.NUMBER);
						lrArgData.addColumn("EXEC_AMT", CITData.NUMBER);
						lrArgData.addColumn("OUT_ACC_NO", CITData.VARCHAR2);
						lrArgData.addColumn("IN_BANK_MAIN_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("IN_ACC_NO", CITData.VARCHAR2);
						lrArgData.addColumn("SLIP_PUB_SEQ", CITData.NUMBER);
						lrArgData.addColumn("SLIP_ID", CITData.NUMBER);
						lrArgData.addColumn("SLIP_IDSEQ", CITData.NUMBER);
						lrArgData.addColumn("CHK_BILL_NO", CITData.VARCHAR2);
						lrArgData.addColumn("ACCNO_OWNER", CITData.VARCHAR2);
						lrArgData.addColumn("EXPR_DT", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsMAKE_SLIP_INFO.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("WORK_DT", rows[i].getString(dsMAKE_SLIP_INFO.indexOfColumn("WORK_DT")));
						lrArgData.setValue("SEQ", rows[i].getString(dsMAKE_SLIP_INFO.indexOfColumn("SEQ")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("EXEC_KIND_TAG", rows[i].getString(dsMAKE_SLIP_INFO.indexOfColumn("EXEC_KIND_TAG")));
						lrArgData.setValue("TARGET_SLIP_ID", rows[i].getString(dsMAKE_SLIP_INFO.indexOfColumn("TARGET_SLIP_ID")));
						lrArgData.setValue("TARGET_SLIP_IDSEQ", rows[i].getString(dsMAKE_SLIP_INFO.indexOfColumn("TARGET_SLIP_IDSEQ")));
						lrArgData.setValue("EXEC_AMT", rows[i].getString(dsMAKE_SLIP_INFO.indexOfColumn("EXEC_AMT")));
						lrArgData.setValue("OUT_ACC_NO", rows[i].getString(dsMAKE_SLIP_INFO.indexOfColumn("OUT_ACC_NO")));
						lrArgData.setValue("IN_BANK_MAIN_CODE", rows[i].getString(dsMAKE_SLIP_INFO.indexOfColumn("IN_BANK_MAIN_CODE")));
						lrArgData.setValue("IN_ACC_NO", rows[i].getString(dsMAKE_SLIP_INFO.indexOfColumn("IN_ACC_NO")));
						lrArgData.setValue("SLIP_PUB_SEQ", rows[i].getString(dsMAKE_SLIP_INFO.indexOfColumn("SLIP_PUB_SEQ")));
						lrArgData.setValue("SLIP_ID", rows[i].getString(dsMAKE_SLIP_INFO.indexOfColumn("SLIP_ID")));
						lrArgData.setValue("SLIP_IDSEQ", rows[i].getString(dsMAKE_SLIP_INFO.indexOfColumn("SLIP_IDSEQ")));
						lrArgData.setValue("CHK_BILL_NO", rows[i].getString(dsMAKE_SLIP_INFO.indexOfColumn("CHK_BILL_NO")));
						lrArgData.setValue("ACCNO_OWNER", rows[i].getString(dsMAKE_SLIP_INFO.indexOfColumn("ACCNO_OWNER")));
						lrArgData.setValue("EXPR_DT", rows[i].getString(dsMAKE_SLIP_INFO.indexOfColumn("EXPR_DT")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_FIN_PAY_EXEC_LIST_TMP_D(?,?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("WORK_DT", CITData.VARCHAR2);
						lrArgData.addColumn("SEQ", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsMAKE_SLIP_INFO.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("WORK_DT", rows[i].getString(dsMAKE_SLIP_INFO.indexOfColumn("WORK_DT")));
						lrArgData.setValue("SEQ", rows[i].getString(dsMAKE_SLIP_INFO.indexOfColumn("SEQ")));
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
				GauceInfo.response.writeException("USER", "900001", "T_FIN_PAY_EXEC_LIST 테이블 데이타 갱신 에러" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
	//복사끝
			dsMAKE_SLIP = GauceInfo.request.getGauceDataSet("dsMAKE_SLIP");
			
			if (dsMAKE_SLIP == null) throw new Exception("dsMAKE_SLIP이(가) 널(Null)입니다.");
			
			rows = dsMAKE_SLIP.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					strSql = "{call SP_T_MAKE_PAY_SLIP(?,?,?,?)}";
						
					lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
					lrArgData.addColumn("WORK_DT", CITData.VARCHAR2);
					lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
					lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);

					lrArgData.addRow();
					lrArgData.setValue("COMP_CODE", rows[i].getString(dsMAKE_SLIP.indexOfColumn("COMP_CODE")));
					lrArgData.setValue("WORK_DT", rows[i].getString(dsMAKE_SLIP.indexOfColumn("WORK_DT")));
					lrArgData.setValue("DEPT_CODE", rows[i].getString(dsMAKE_SLIP.indexOfColumn("DEPT_CODE")));
					lrArgData.setValue("CRTUSERNO", strUserNo);
					
					CITDatabase.executeProcedure(strSql, lrArgData, conn);
				}
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001", "T_FIN_PAY_SUM_LIST 테이블 데이타 갱신 에러" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
		}
		if(!CITCommon.isNull(strAct) && strAct.equals("MAKE_PAY"))
		{
	//복사시작
			dsMAKE_PAY_INFO = GauceInfo.request.getGauceDataSet("dsMAKE_PAY_INFO");
			
			if (dsMAKE_PAY_INFO == null) throw new Exception("dsMAKE_PAY_INFO이(가) 널(Null)입니다.");
			
			rows = dsMAKE_PAY_INFO.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					if (rows[i].getJobType() == GauceDataRow.TB_JOB_INSERT)
					{
						strSql = "{call SP_T_FIN_PAY_EXEC_LIST_TMP_I(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("WORK_DT", CITData.VARCHAR2);
						lrArgData.addColumn("SEQ", CITData.NUMBER);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("EXEC_KIND_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("TARGET_SLIP_ID", CITData.NUMBER);
						lrArgData.addColumn("TARGET_SLIP_IDSEQ", CITData.NUMBER);
						lrArgData.addColumn("EXEC_AMT", CITData.NUMBER);
						lrArgData.addColumn("OUT_ACC_NO", CITData.VARCHAR2);
						lrArgData.addColumn("IN_BANK_MAIN_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("IN_ACC_NO", CITData.VARCHAR2);
						lrArgData.addColumn("SLIP_PUB_SEQ", CITData.NUMBER);
						lrArgData.addColumn("SLIP_ID", CITData.NUMBER);
						lrArgData.addColumn("SLIP_IDSEQ", CITData.NUMBER);
						lrArgData.addColumn("CHK_BILL_NO", CITData.VARCHAR2);
						lrArgData.addColumn("ACCNO_OWNER", CITData.VARCHAR2);
						lrArgData.addColumn("EXPR_DT", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsMAKE_PAY_INFO.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("WORK_DT", rows[i].getString(dsMAKE_PAY_INFO.indexOfColumn("WORK_DT")));
						lrArgData.setValue("SEQ", rows[i].getString(dsMAKE_PAY_INFO.indexOfColumn("SEQ")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("EXEC_KIND_TAG", rows[i].getString(dsMAKE_PAY_INFO.indexOfColumn("EXEC_KIND_TAG")));
						lrArgData.setValue("TARGET_SLIP_ID", rows[i].getString(dsMAKE_PAY_INFO.indexOfColumn("TARGET_SLIP_ID")));
						lrArgData.setValue("TARGET_SLIP_IDSEQ", rows[i].getString(dsMAKE_PAY_INFO.indexOfColumn("TARGET_SLIP_IDSEQ")));
						lrArgData.setValue("EXEC_AMT", rows[i].getString(dsMAKE_PAY_INFO.indexOfColumn("EXEC_AMT")));
						lrArgData.setValue("OUT_ACC_NO", rows[i].getString(dsMAKE_PAY_INFO.indexOfColumn("OUT_ACC_NO")));
						lrArgData.setValue("IN_BANK_MAIN_CODE", rows[i].getString(dsMAKE_PAY_INFO.indexOfColumn("IN_BANK_MAIN_CODE")));
						lrArgData.setValue("IN_ACC_NO", rows[i].getString(dsMAKE_PAY_INFO.indexOfColumn("IN_ACC_NO")));
						lrArgData.setValue("SLIP_PUB_SEQ", rows[i].getString(dsMAKE_PAY_INFO.indexOfColumn("SLIP_PUB_SEQ")));
						lrArgData.setValue("SLIP_ID", rows[i].getString(dsMAKE_PAY_INFO.indexOfColumn("SLIP_ID")));
						lrArgData.setValue("SLIP_IDSEQ", rows[i].getString(dsMAKE_PAY_INFO.indexOfColumn("SLIP_IDSEQ")));
						lrArgData.setValue("CHK_BILL_NO", rows[i].getString(dsMAKE_PAY_INFO.indexOfColumn("CHK_BILL_NO")));
						lrArgData.setValue("ACCNO_OWNER", rows[i].getString(dsMAKE_PAY_INFO.indexOfColumn("ACCNO_OWNER")));
						lrArgData.setValue("EXPR_DT", rows[i].getString(dsMAKE_PAY_INFO.indexOfColumn("EXPR_DT")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_FIN_PAY_EXEC_LIST_TMP_U(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("WORK_DT", CITData.VARCHAR2);
						lrArgData.addColumn("SEQ", CITData.NUMBER);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("EXEC_KIND_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("TARGET_SLIP_ID", CITData.NUMBER);
						lrArgData.addColumn("TARGET_SLIP_IDSEQ", CITData.NUMBER);
						lrArgData.addColumn("EXEC_AMT", CITData.NUMBER);
						lrArgData.addColumn("OUT_ACC_NO", CITData.VARCHAR2);
						lrArgData.addColumn("IN_BANK_MAIN_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("IN_ACC_NO", CITData.VARCHAR2);
						lrArgData.addColumn("SLIP_PUB_SEQ", CITData.NUMBER);
						lrArgData.addColumn("SLIP_ID", CITData.NUMBER);
						lrArgData.addColumn("SLIP_IDSEQ", CITData.NUMBER);
						lrArgData.addColumn("CHK_BILL_NO", CITData.VARCHAR2);
						lrArgData.addColumn("ACCNO_OWNER", CITData.VARCHAR2);
						lrArgData.addColumn("EXPR_DT", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsMAKE_PAY_INFO.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("WORK_DT", rows[i].getString(dsMAKE_PAY_INFO.indexOfColumn("WORK_DT")));
						lrArgData.setValue("SEQ", rows[i].getString(dsMAKE_PAY_INFO.indexOfColumn("SEQ")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("EXEC_KIND_TAG", rows[i].getString(dsMAKE_PAY_INFO.indexOfColumn("EXEC_KIND_TAG")));
						lrArgData.setValue("TARGET_SLIP_ID", rows[i].getString(dsMAKE_PAY_INFO.indexOfColumn("TARGET_SLIP_ID")));
						lrArgData.setValue("TARGET_SLIP_IDSEQ", rows[i].getString(dsMAKE_PAY_INFO.indexOfColumn("TARGET_SLIP_IDSEQ")));
						lrArgData.setValue("EXEC_AMT", rows[i].getString(dsMAKE_PAY_INFO.indexOfColumn("EXEC_AMT")));
						lrArgData.setValue("OUT_ACC_NO", rows[i].getString(dsMAKE_PAY_INFO.indexOfColumn("OUT_ACC_NO")));
						lrArgData.setValue("IN_BANK_MAIN_CODE", rows[i].getString(dsMAKE_PAY_INFO.indexOfColumn("IN_BANK_MAIN_CODE")));
						lrArgData.setValue("IN_ACC_NO", rows[i].getString(dsMAKE_PAY_INFO.indexOfColumn("IN_ACC_NO")));
						lrArgData.setValue("SLIP_PUB_SEQ", rows[i].getString(dsMAKE_PAY_INFO.indexOfColumn("SLIP_PUB_SEQ")));
						lrArgData.setValue("SLIP_ID", rows[i].getString(dsMAKE_PAY_INFO.indexOfColumn("SLIP_ID")));
						lrArgData.setValue("SLIP_IDSEQ", rows[i].getString(dsMAKE_PAY_INFO.indexOfColumn("SLIP_IDSEQ")));
						lrArgData.setValue("CHK_BILL_NO", rows[i].getString(dsMAKE_PAY_INFO.indexOfColumn("CHK_BILL_NO")));
						lrArgData.setValue("ACCNO_OWNER", rows[i].getString(dsMAKE_PAY_INFO.indexOfColumn("ACCNO_OWNER")));
						lrArgData.setValue("EXPR_DT", rows[i].getString(dsMAKE_PAY_INFO.indexOfColumn("EXPR_DT")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_FIN_PAY_EXEC_LIST_TMP_D(?,?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("WORK_DT", CITData.VARCHAR2);
						lrArgData.addColumn("SEQ", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsMAKE_PAY_INFO.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("WORK_DT", rows[i].getString(dsMAKE_PAY_INFO.indexOfColumn("WORK_DT")));
						lrArgData.setValue("SEQ", rows[i].getString(dsMAKE_PAY_INFO.indexOfColumn("SEQ")));
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
				GauceInfo.response.writeException("USER", "900001", "T_FIN_PAY_EXEC_LIST 테이블 데이타 갱신 에러" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
	//복사끝
			dsMAKE_PAY = GauceInfo.request.getGauceDataSet("dsMAKE_PAY");
			
			if (dsMAKE_PAY == null) throw new Exception("dsMAKE_PAY이(가) 널(Null)입니다.");
			
			rows = dsMAKE_PAY.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					strSql = "{call SP_T_MAKE_PAY_FBS(?,?,?,?)}";
						
					lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
					lrArgData.addColumn("WORK_DT", CITData.VARCHAR2);
					lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
					lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);

					lrArgData.addRow();
					lrArgData.setValue("COMP_CODE", rows[i].getString(dsMAKE_PAY.indexOfColumn("COMP_CODE")));
					lrArgData.setValue("WORK_DT", rows[i].getString(dsMAKE_PAY.indexOfColumn("WORK_DT")));
					lrArgData.setValue("DEPT_CODE", rows[i].getString(dsMAKE_PAY.indexOfColumn("DEPT_CODE")));
					lrArgData.setValue("CRTUSERNO", strUserNo);
					
					CITDatabase.executeProcedure(strSql, lrArgData, conn);
				}
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001", "T_FIN_PAY_SUM_LIST 테이블 데이타 갱신 에러" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
		}
		else if (CITCommon.isNull(strAct))
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
						strSql = "{call SP_T_FIN_PAY_SUM_LIST_I(?,?,?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("WORK_DT", CITData.VARCHAR2);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("CONTENTS", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsMASTER.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("WORK_DT", rows[i].getString(dsMASTER.indexOfColumn("WORK_DT")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("CONTENTS", rows[i].getString(dsMASTER.indexOfColumn("CONTENTS")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_FIN_PAY_SUM_LIST_U(?,?,?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("WORK_DT", CITData.VARCHAR2);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("CONTENTS", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsMASTER.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("WORK_DT", rows[i].getString(dsMASTER.indexOfColumn("WORK_DT")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("CONTENTS", rows[i].getString(dsMASTER.indexOfColumn("CONTENTS")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_FIN_PAY_SUM_LIST_D(?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("WORK_DT", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsMASTER.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("WORK_DT", rows[i].getString(dsMASTER.indexOfColumn("WORK_DT")));
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
				GauceInfo.response.writeException("USER", "900001", "T_FIN_PAY_SUM_LIST 테이블 데이타 갱신 에러" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
	//복사끝
	//복사시작
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
						strSql = "{call SP_T_FIN_PAY_TAR_SLIP_LIST_I(?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("WORK_DT", CITData.VARCHAR2);
						lrArgData.addColumn("SEQ", CITData.NUMBER);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("ACC_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("TARGET_SLIP_ID", CITData.NUMBER);
						lrArgData.addColumn("TARGET_SLIP_IDSEQ", CITData.NUMBER);
						lrArgData.addColumn("CUST_SEQ", CITData.NUMBER);
						lrArgData.addColumn("CUST_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("SET_AMT", CITData.NUMBER);
						lrArgData.addColumn("PRE_RESET_AMT", CITData.NUMBER);
						lrArgData.addColumn("EXCEPT_AMT", CITData.NUMBER);
						lrArgData.addColumn("C_RATIO", CITData.NUMBER);
						lrArgData.addColumn("B_RATIO", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsMAIN.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("WORK_DT", rows[i].getString(dsMAIN.indexOfColumn("WORK_DT")));
						lrArgData.setValue("SEQ", rows[i].getString(dsMAIN.indexOfColumn("SEQ")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("ACC_CODE", rows[i].getString(dsMAIN.indexOfColumn("ACC_CODE")));
						lrArgData.setValue("TARGET_SLIP_ID", rows[i].getString(dsMAIN.indexOfColumn("TARGET_SLIP_ID")));
						lrArgData.setValue("TARGET_SLIP_IDSEQ", rows[i].getString(dsMAIN.indexOfColumn("TARGET_SLIP_IDSEQ")));
						lrArgData.setValue("CUST_SEQ", rows[i].getString(dsMAIN.indexOfColumn("CUST_SEQ")));
						lrArgData.setValue("CUST_NAME", rows[i].getString(dsMAIN.indexOfColumn("CUST_NAME")));
						lrArgData.setValue("SET_AMT", rows[i].getString(dsMAIN.indexOfColumn("SET_AMT")));
						lrArgData.setValue("PRE_RESET_AMT", rows[i].getString(dsMAIN.indexOfColumn("PRE_RESET_AMT")));
						lrArgData.setValue("EXCEPT_AMT", rows[i].getString(dsMAIN.indexOfColumn("EXCEPT_AMT")));
						lrArgData.setValue("C_RATIO", rows[i].getString(dsMAIN.indexOfColumn("C_RATIO")));
						lrArgData.setValue("B_RATIO", rows[i].getString(dsMAIN.indexOfColumn("B_RATIO")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_FIN_PAY_TAR_SLIP_LIST_U(?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("WORK_DT", CITData.VARCHAR2);
						lrArgData.addColumn("SEQ", CITData.NUMBER);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("ACC_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("TARGET_SLIP_ID", CITData.NUMBER);
						lrArgData.addColumn("TARGET_SLIP_IDSEQ", CITData.NUMBER);
						lrArgData.addColumn("CUST_SEQ", CITData.NUMBER);
						lrArgData.addColumn("CUST_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("SET_AMT", CITData.NUMBER);
						lrArgData.addColumn("PRE_RESET_AMT", CITData.NUMBER);
						lrArgData.addColumn("EXCEPT_AMT", CITData.NUMBER);
						lrArgData.addColumn("C_RATIO", CITData.NUMBER);
						lrArgData.addColumn("B_RATIO", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsMAIN.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("WORK_DT", rows[i].getString(dsMAIN.indexOfColumn("WORK_DT")));
						lrArgData.setValue("SEQ", rows[i].getString(dsMAIN.indexOfColumn("SEQ")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("ACC_CODE", rows[i].getString(dsMAIN.indexOfColumn("ACC_CODE")));
						lrArgData.setValue("TARGET_SLIP_ID", rows[i].getString(dsMAIN.indexOfColumn("TARGET_SLIP_ID")));
						lrArgData.setValue("TARGET_SLIP_IDSEQ", rows[i].getString(dsMAIN.indexOfColumn("TARGET_SLIP_IDSEQ")));
						lrArgData.setValue("CUST_SEQ", rows[i].getString(dsMAIN.indexOfColumn("CUST_SEQ")));
						lrArgData.setValue("CUST_NAME", rows[i].getString(dsMAIN.indexOfColumn("CUST_NAME")));
						lrArgData.setValue("SET_AMT", rows[i].getString(dsMAIN.indexOfColumn("SET_AMT")));
						lrArgData.setValue("PRE_RESET_AMT", rows[i].getString(dsMAIN.indexOfColumn("PRE_RESET_AMT")));
						lrArgData.setValue("EXCEPT_AMT", rows[i].getString(dsMAIN.indexOfColumn("EXCEPT_AMT")));
						lrArgData.setValue("C_RATIO", rows[i].getString(dsMAIN.indexOfColumn("C_RATIO")));
						lrArgData.setValue("B_RATIO", rows[i].getString(dsMAIN.indexOfColumn("B_RATIO")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_FIN_PAY_TAR_SLIP_LIST_D(?,?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("WORK_DT", CITData.VARCHAR2);
						lrArgData.addColumn("SEQ", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsMAIN.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("WORK_DT", rows[i].getString(dsMAIN.indexOfColumn("WORK_DT")));
						lrArgData.setValue("SEQ", rows[i].getString(dsMAIN.indexOfColumn("SEQ")));
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
				GauceInfo.response.writeException("USER", "900001", "T_FIN_PAY_TARGET_SLIP_LIST 테이블 데이타 갱신 에러" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
	//복사끝
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
						strSql = "{call SP_T_FIN_PAY_EXEC_LIST_I(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("WORK_DT", CITData.VARCHAR2);
						lrArgData.addColumn("SEQ", CITData.NUMBER);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("EXEC_KIND_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("TARGET_SLIP_ID", CITData.NUMBER);
						lrArgData.addColumn("TARGET_SLIP_IDSEQ", CITData.NUMBER);
						lrArgData.addColumn("EXEC_AMT", CITData.NUMBER);
						lrArgData.addColumn("OUT_ACC_NO", CITData.VARCHAR2);
						lrArgData.addColumn("IN_BANK_MAIN_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("IN_ACC_NO", CITData.VARCHAR2);
						lrArgData.addColumn("SLIP_PUB_SEQ", CITData.NUMBER);
						lrArgData.addColumn("SLIP_ID", CITData.NUMBER);
						lrArgData.addColumn("SLIP_IDSEQ", CITData.NUMBER);
						lrArgData.addColumn("CHK_BILL_NO", CITData.VARCHAR2);
						lrArgData.addColumn("ACCNO_OWNER", CITData.VARCHAR2);
						lrArgData.addColumn("EXPR_DT", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsSUB01.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("WORK_DT", rows[i].getString(dsSUB01.indexOfColumn("WORK_DT")));
						lrArgData.setValue("SEQ", rows[i].getString(dsSUB01.indexOfColumn("SEQ")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("EXEC_KIND_TAG", rows[i].getString(dsSUB01.indexOfColumn("EXEC_KIND_TAG")));
						lrArgData.setValue("TARGET_SLIP_ID", rows[i].getString(dsSUB01.indexOfColumn("TARGET_SLIP_ID")));
						lrArgData.setValue("TARGET_SLIP_IDSEQ", rows[i].getString(dsSUB01.indexOfColumn("TARGET_SLIP_IDSEQ")));
						lrArgData.setValue("EXEC_AMT", rows[i].getString(dsSUB01.indexOfColumn("EXEC_AMT")));
						lrArgData.setValue("OUT_ACC_NO", rows[i].getString(dsSUB01.indexOfColumn("OUT_ACC_NO")));
						lrArgData.setValue("IN_BANK_MAIN_CODE", rows[i].getString(dsSUB01.indexOfColumn("IN_BANK_MAIN_CODE")));
						lrArgData.setValue("IN_ACC_NO", rows[i].getString(dsSUB01.indexOfColumn("IN_ACC_NO")));
						lrArgData.setValue("SLIP_PUB_SEQ", rows[i].getString(dsSUB01.indexOfColumn("SLIP_PUB_SEQ")));
						lrArgData.setValue("SLIP_ID", rows[i].getString(dsSUB01.indexOfColumn("SLIP_ID")));
						lrArgData.setValue("SLIP_IDSEQ", rows[i].getString(dsSUB01.indexOfColumn("SLIP_IDSEQ")));
						lrArgData.setValue("CHK_BILL_NO", rows[i].getString(dsSUB01.indexOfColumn("CHK_BILL_NO")));
						lrArgData.setValue("ACCNO_OWNER", rows[i].getString(dsSUB01.indexOfColumn("ACCNO_OWNER")));
						lrArgData.setValue("EXPR_DT", rows[i].getString(dsSUB01.indexOfColumn("EXPR_DT")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_FIN_PAY_EXEC_LIST_U(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("WORK_DT", CITData.VARCHAR2);
						lrArgData.addColumn("SEQ", CITData.NUMBER);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("EXEC_KIND_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("TARGET_SLIP_ID", CITData.NUMBER);
						lrArgData.addColumn("TARGET_SLIP_IDSEQ", CITData.NUMBER);
						lrArgData.addColumn("EXEC_AMT", CITData.NUMBER);
						lrArgData.addColumn("OUT_ACC_NO", CITData.VARCHAR2);
						lrArgData.addColumn("IN_BANK_MAIN_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("IN_ACC_NO", CITData.VARCHAR2);
						lrArgData.addColumn("SLIP_PUB_SEQ", CITData.NUMBER);
						lrArgData.addColumn("SLIP_ID", CITData.NUMBER);
						lrArgData.addColumn("SLIP_IDSEQ", CITData.NUMBER);
						lrArgData.addColumn("CHK_BILL_NO", CITData.VARCHAR2);
						lrArgData.addColumn("ACCNO_OWNER", CITData.VARCHAR2);
						lrArgData.addColumn("EXPR_DT", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsSUB01.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("WORK_DT", rows[i].getString(dsSUB01.indexOfColumn("WORK_DT")));
						lrArgData.setValue("SEQ", rows[i].getString(dsSUB01.indexOfColumn("SEQ")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("EXEC_KIND_TAG", rows[i].getString(dsSUB01.indexOfColumn("EXEC_KIND_TAG")));
						lrArgData.setValue("TARGET_SLIP_ID", rows[i].getString(dsSUB01.indexOfColumn("TARGET_SLIP_ID")));
						lrArgData.setValue("TARGET_SLIP_IDSEQ", rows[i].getString(dsSUB01.indexOfColumn("TARGET_SLIP_IDSEQ")));
						lrArgData.setValue("EXEC_AMT", rows[i].getString(dsSUB01.indexOfColumn("EXEC_AMT")));
						lrArgData.setValue("OUT_ACC_NO", rows[i].getString(dsSUB01.indexOfColumn("OUT_ACC_NO")));
						lrArgData.setValue("IN_BANK_MAIN_CODE", rows[i].getString(dsSUB01.indexOfColumn("IN_BANK_MAIN_CODE")));
						lrArgData.setValue("IN_ACC_NO", rows[i].getString(dsSUB01.indexOfColumn("IN_ACC_NO")));
						lrArgData.setValue("SLIP_PUB_SEQ", rows[i].getString(dsSUB01.indexOfColumn("SLIP_PUB_SEQ")));
						lrArgData.setValue("SLIP_ID", rows[i].getString(dsSUB01.indexOfColumn("SLIP_ID")));
						lrArgData.setValue("SLIP_IDSEQ", rows[i].getString(dsSUB01.indexOfColumn("SLIP_IDSEQ")));
						lrArgData.setValue("CHK_BILL_NO", rows[i].getString(dsSUB01.indexOfColumn("CHK_BILL_NO")));
						lrArgData.setValue("ACCNO_OWNER", rows[i].getString(dsSUB01.indexOfColumn("ACCNO_OWNER")));
						lrArgData.setValue("EXPR_DT", rows[i].getString(dsSUB01.indexOfColumn("EXPR_DT")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_FIN_PAY_EXEC_LIST_D(?,?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("WORK_DT", CITData.VARCHAR2);
						lrArgData.addColumn("SEQ", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsSUB01.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("WORK_DT", rows[i].getString(dsSUB01.indexOfColumn("WORK_DT")));
						lrArgData.setValue("SEQ", rows[i].getString(dsSUB01.indexOfColumn("SEQ")));
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
				GauceInfo.response.writeException("USER", "900001", "T_FIN_PAY_EXEC_LIST 테이블 데이타 갱신 에러" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
	//복사끝
	//복사시작
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
						strSql = "{call SP_T_FIN_PAY_EXEC_LIST_I(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("WORK_DT", CITData.VARCHAR2);
						lrArgData.addColumn("SEQ", CITData.NUMBER);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("EXEC_KIND_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("TARGET_SLIP_ID", CITData.NUMBER);
						lrArgData.addColumn("TARGET_SLIP_IDSEQ", CITData.NUMBER);
						lrArgData.addColumn("EXEC_AMT", CITData.NUMBER);
						lrArgData.addColumn("OUT_ACC_NO", CITData.VARCHAR2);
						lrArgData.addColumn("IN_BANK_MAIN_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("IN_ACC_NO", CITData.VARCHAR2);
						lrArgData.addColumn("SLIP_PUB_SEQ", CITData.NUMBER);
						lrArgData.addColumn("SLIP_ID", CITData.NUMBER);
						lrArgData.addColumn("SLIP_IDSEQ", CITData.NUMBER);
						lrArgData.addColumn("CHK_BILL_NO", CITData.VARCHAR2);
						lrArgData.addColumn("ACCNO_OWNER", CITData.VARCHAR2);
						lrArgData.addColumn("EXPR_DT", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsSUB02.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("WORK_DT", rows[i].getString(dsSUB02.indexOfColumn("WORK_DT")));
						lrArgData.setValue("SEQ", rows[i].getString(dsSUB02.indexOfColumn("SEQ")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("EXEC_KIND_TAG", rows[i].getString(dsSUB02.indexOfColumn("EXEC_KIND_TAG")));
						lrArgData.setValue("TARGET_SLIP_ID", rows[i].getString(dsSUB02.indexOfColumn("TARGET_SLIP_ID")));
						lrArgData.setValue("TARGET_SLIP_IDSEQ", rows[i].getString(dsSUB02.indexOfColumn("TARGET_SLIP_IDSEQ")));
						lrArgData.setValue("EXEC_AMT", rows[i].getString(dsSUB02.indexOfColumn("EXEC_AMT")));
						lrArgData.setValue("OUT_ACC_NO", rows[i].getString(dsSUB02.indexOfColumn("OUT_ACC_NO")));
						lrArgData.setValue("IN_BANK_MAIN_CODE", rows[i].getString(dsSUB02.indexOfColumn("IN_BANK_MAIN_CODE")));
						lrArgData.setValue("IN_ACC_NO", rows[i].getString(dsSUB02.indexOfColumn("IN_ACC_NO")));
						lrArgData.setValue("SLIP_PUB_SEQ", rows[i].getString(dsSUB02.indexOfColumn("SLIP_PUB_SEQ")));
						lrArgData.setValue("SLIP_ID", rows[i].getString(dsSUB02.indexOfColumn("SLIP_ID")));
						lrArgData.setValue("SLIP_IDSEQ", rows[i].getString(dsSUB02.indexOfColumn("SLIP_IDSEQ")));
						lrArgData.setValue("CHK_BILL_NO", rows[i].getString(dsSUB02.indexOfColumn("CHK_BILL_NO")));
						lrArgData.setValue("ACCNO_OWNER", rows[i].getString(dsSUB02.indexOfColumn("ACCNO_OWNER")));
						lrArgData.setValue("EXPR_DT", rows[i].getString(dsSUB02.indexOfColumn("EXPR_DT")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_FIN_PAY_EXEC_LIST_U(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("WORK_DT", CITData.VARCHAR2);
						lrArgData.addColumn("SEQ", CITData.NUMBER);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("EXEC_KIND_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("TARGET_SLIP_ID", CITData.NUMBER);
						lrArgData.addColumn("TARGET_SLIP_IDSEQ", CITData.NUMBER);
						lrArgData.addColumn("EXEC_AMT", CITData.NUMBER);
						lrArgData.addColumn("OUT_ACC_NO", CITData.VARCHAR2);
						lrArgData.addColumn("IN_BANK_MAIN_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("IN_ACC_NO", CITData.VARCHAR2);
						lrArgData.addColumn("SLIP_PUB_SEQ", CITData.NUMBER);
						lrArgData.addColumn("SLIP_ID", CITData.NUMBER);
						lrArgData.addColumn("SLIP_IDSEQ", CITData.NUMBER);
						lrArgData.addColumn("CHK_BILL_NO", CITData.VARCHAR2);
						lrArgData.addColumn("ACCNO_OWNER", CITData.VARCHAR2);
						lrArgData.addColumn("EXPR_DT", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsSUB02.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("WORK_DT", rows[i].getString(dsSUB02.indexOfColumn("WORK_DT")));
						lrArgData.setValue("SEQ", rows[i].getString(dsSUB02.indexOfColumn("SEQ")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("EXEC_KIND_TAG", rows[i].getString(dsSUB02.indexOfColumn("EXEC_KIND_TAG")));
						lrArgData.setValue("TARGET_SLIP_ID", rows[i].getString(dsSUB02.indexOfColumn("TARGET_SLIP_ID")));
						lrArgData.setValue("TARGET_SLIP_IDSEQ", rows[i].getString(dsSUB02.indexOfColumn("TARGET_SLIP_IDSEQ")));
						lrArgData.setValue("EXEC_AMT", rows[i].getString(dsSUB02.indexOfColumn("EXEC_AMT")));
						lrArgData.setValue("OUT_ACC_NO", rows[i].getString(dsSUB02.indexOfColumn("OUT_ACC_NO")));
						lrArgData.setValue("IN_BANK_MAIN_CODE", rows[i].getString(dsSUB02.indexOfColumn("IN_BANK_MAIN_CODE")));
						lrArgData.setValue("IN_ACC_NO", rows[i].getString(dsSUB02.indexOfColumn("IN_ACC_NO")));
						lrArgData.setValue("SLIP_PUB_SEQ", rows[i].getString(dsSUB02.indexOfColumn("SLIP_PUB_SEQ")));
						lrArgData.setValue("SLIP_ID", rows[i].getString(dsSUB02.indexOfColumn("SLIP_ID")));
						lrArgData.setValue("SLIP_IDSEQ", rows[i].getString(dsSUB02.indexOfColumn("SLIP_IDSEQ")));
						lrArgData.setValue("CHK_BILL_NO", rows[i].getString(dsSUB02.indexOfColumn("CHK_BILL_NO")));
						lrArgData.setValue("ACCNO_OWNER", rows[i].getString(dsSUB02.indexOfColumn("ACCNO_OWNER")));
						lrArgData.setValue("EXPR_DT", rows[i].getString(dsSUB02.indexOfColumn("EXPR_DT")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_FIN_PAY_EXEC_LIST_D(?,?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("WORK_DT", CITData.VARCHAR2);
						lrArgData.addColumn("SEQ", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsSUB02.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("WORK_DT", rows[i].getString(dsSUB02.indexOfColumn("WORK_DT")));
						lrArgData.setValue("SEQ", rows[i].getString(dsSUB02.indexOfColumn("SEQ")));
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
				GauceInfo.response.writeException("USER", "900001", "T_FIN_PAY_EXEC_LIST 테이블 데이타 갱신 에러" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
	//복사끝
	//복사시작
			dsSUB03 = GauceInfo.request.getGauceDataSet("dsSUB03");
			
			if (dsSUB03 == null) throw new Exception("dsSUB03이(가) 널(Null)입니다.");
			
			rows = dsSUB03.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					if (rows[i].getJobType() == GauceDataRow.TB_JOB_INSERT)
					{
						strSql = "{call SP_T_FIN_PAY_EXEC_LIST_I(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("WORK_DT", CITData.VARCHAR2);
						lrArgData.addColumn("SEQ", CITData.NUMBER);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("EXEC_KIND_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("TARGET_SLIP_ID", CITData.NUMBER);
						lrArgData.addColumn("TARGET_SLIP_IDSEQ", CITData.NUMBER);
						lrArgData.addColumn("EXEC_AMT", CITData.NUMBER);
						lrArgData.addColumn("OUT_ACC_NO", CITData.VARCHAR2);
						lrArgData.addColumn("IN_BANK_MAIN_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("IN_ACC_NO", CITData.VARCHAR2);
						lrArgData.addColumn("SLIP_PUB_SEQ", CITData.NUMBER);
						lrArgData.addColumn("SLIP_ID", CITData.NUMBER);
						lrArgData.addColumn("SLIP_IDSEQ", CITData.NUMBER);
						lrArgData.addColumn("CHK_BILL_NO", CITData.VARCHAR2);
						lrArgData.addColumn("ACCNO_OWNER", CITData.VARCHAR2);
						lrArgData.addColumn("EXPR_DT", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsSUB03.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("WORK_DT", rows[i].getString(dsSUB03.indexOfColumn("WORK_DT")));
						lrArgData.setValue("SEQ", rows[i].getString(dsSUB03.indexOfColumn("SEQ")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("EXEC_KIND_TAG", rows[i].getString(dsSUB03.indexOfColumn("EXEC_KIND_TAG")));
						lrArgData.setValue("TARGET_SLIP_ID", rows[i].getString(dsSUB03.indexOfColumn("TARGET_SLIP_ID")));
						lrArgData.setValue("TARGET_SLIP_IDSEQ", rows[i].getString(dsSUB03.indexOfColumn("TARGET_SLIP_IDSEQ")));
						lrArgData.setValue("EXEC_AMT", rows[i].getString(dsSUB03.indexOfColumn("EXEC_AMT")));
						lrArgData.setValue("OUT_ACC_NO", rows[i].getString(dsSUB03.indexOfColumn("OUT_ACC_NO")));
						lrArgData.setValue("IN_BANK_MAIN_CODE", rows[i].getString(dsSUB03.indexOfColumn("IN_BANK_MAIN_CODE")));
						lrArgData.setValue("IN_ACC_NO", rows[i].getString(dsSUB03.indexOfColumn("IN_ACC_NO")));
						lrArgData.setValue("SLIP_PUB_SEQ", rows[i].getString(dsSUB03.indexOfColumn("SLIP_PUB_SEQ")));
						lrArgData.setValue("SLIP_ID", rows[i].getString(dsSUB03.indexOfColumn("SLIP_ID")));
						lrArgData.setValue("SLIP_IDSEQ", rows[i].getString(dsSUB03.indexOfColumn("SLIP_IDSEQ")));
						lrArgData.setValue("CHK_BILL_NO", rows[i].getString(dsSUB03.indexOfColumn("CHK_BILL_NO")));
						lrArgData.setValue("ACCNO_OWNER", rows[i].getString(dsSUB03.indexOfColumn("ACCNO_OWNER")));
						lrArgData.setValue("EXPR_DT", rows[i].getString(dsSUB03.indexOfColumn("EXPR_DT")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_FIN_PAY_EXEC_LIST_U(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("WORK_DT", CITData.VARCHAR2);
						lrArgData.addColumn("SEQ", CITData.NUMBER);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("EXEC_KIND_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("TARGET_SLIP_ID", CITData.NUMBER);
						lrArgData.addColumn("TARGET_SLIP_IDSEQ", CITData.NUMBER);
						lrArgData.addColumn("EXEC_AMT", CITData.NUMBER);
						lrArgData.addColumn("OUT_ACC_NO", CITData.VARCHAR2);
						lrArgData.addColumn("IN_BANK_MAIN_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("IN_ACC_NO", CITData.VARCHAR2);
						lrArgData.addColumn("SLIP_PUB_SEQ", CITData.NUMBER);
						lrArgData.addColumn("SLIP_ID", CITData.NUMBER);
						lrArgData.addColumn("SLIP_IDSEQ", CITData.NUMBER);
						lrArgData.addColumn("CHK_BILL_NO", CITData.VARCHAR2);
						lrArgData.addColumn("ACCNO_OWNER", CITData.VARCHAR2);
						lrArgData.addColumn("EXPR_DT", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsSUB03.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("WORK_DT", rows[i].getString(dsSUB03.indexOfColumn("WORK_DT")));
						lrArgData.setValue("SEQ", rows[i].getString(dsSUB03.indexOfColumn("SEQ")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("EXEC_KIND_TAG", rows[i].getString(dsSUB03.indexOfColumn("EXEC_KIND_TAG")));
						lrArgData.setValue("TARGET_SLIP_ID", rows[i].getString(dsSUB03.indexOfColumn("TARGET_SLIP_ID")));
						lrArgData.setValue("TARGET_SLIP_IDSEQ", rows[i].getString(dsSUB03.indexOfColumn("TARGET_SLIP_IDSEQ")));
						lrArgData.setValue("EXEC_AMT", rows[i].getString(dsSUB03.indexOfColumn("EXEC_AMT")));
						lrArgData.setValue("OUT_ACC_NO", rows[i].getString(dsSUB03.indexOfColumn("OUT_ACC_NO")));
						lrArgData.setValue("IN_BANK_MAIN_CODE", rows[i].getString(dsSUB03.indexOfColumn("IN_BANK_MAIN_CODE")));
						lrArgData.setValue("IN_ACC_NO", rows[i].getString(dsSUB03.indexOfColumn("IN_ACC_NO")));
						lrArgData.setValue("SLIP_PUB_SEQ", rows[i].getString(dsSUB03.indexOfColumn("SLIP_PUB_SEQ")));
						lrArgData.setValue("SLIP_ID", rows[i].getString(dsSUB03.indexOfColumn("SLIP_ID")));
						lrArgData.setValue("SLIP_IDSEQ", rows[i].getString(dsSUB03.indexOfColumn("SLIP_IDSEQ")));
						lrArgData.setValue("CHK_BILL_NO", rows[i].getString(dsSUB03.indexOfColumn("CHK_BILL_NO")));
						lrArgData.setValue("ACCNO_OWNER", rows[i].getString(dsSUB03.indexOfColumn("ACCNO_OWNER")));
						lrArgData.setValue("EXPR_DT", rows[i].getString(dsSUB03.indexOfColumn("EXPR_DT")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_FIN_PAY_EXEC_LIST_D(?,?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("WORK_DT", CITData.VARCHAR2);
						lrArgData.addColumn("SEQ", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsSUB03.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("WORK_DT", rows[i].getString(dsSUB03.indexOfColumn("WORK_DT")));
						lrArgData.setValue("SEQ", rows[i].getString(dsSUB03.indexOfColumn("SEQ")));
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
				GauceInfo.response.writeException("USER", "900001", "T_FIN_PAY_EXEC_LIST 테이블 데이타 갱신 에러" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
	//복사끝
	//복사시작
			dsSUB04 = GauceInfo.request.getGauceDataSet("dsSUB04");
			
			if (dsSUB04 == null) throw new Exception("dsSUB04이(가) 널(Null)입니다.");
			
			rows = dsSUB04.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					if (rows[i].getJobType() == GauceDataRow.TB_JOB_INSERT)
					{
						strSql = "{call SP_T_FIN_PAY_EXEC_LIST_I(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("WORK_DT", CITData.VARCHAR2);
						lrArgData.addColumn("SEQ", CITData.NUMBER);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("EXEC_KIND_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("TARGET_SLIP_ID", CITData.NUMBER);
						lrArgData.addColumn("TARGET_SLIP_IDSEQ", CITData.NUMBER);
						lrArgData.addColumn("EXEC_AMT", CITData.NUMBER);
						lrArgData.addColumn("OUT_ACC_NO", CITData.VARCHAR2);
						lrArgData.addColumn("IN_BANK_MAIN_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("IN_ACC_NO", CITData.VARCHAR2);
						lrArgData.addColumn("SLIP_PUB_SEQ", CITData.NUMBER);
						lrArgData.addColumn("SLIP_ID", CITData.NUMBER);
						lrArgData.addColumn("SLIP_IDSEQ", CITData.NUMBER);
						lrArgData.addColumn("CHK_BILL_NO", CITData.VARCHAR2);
						lrArgData.addColumn("ACCNO_OWNER", CITData.VARCHAR2);
						lrArgData.addColumn("EXPR_DT", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsSUB04.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("WORK_DT", rows[i].getString(dsSUB04.indexOfColumn("WORK_DT")));
						lrArgData.setValue("SEQ", rows[i].getString(dsSUB04.indexOfColumn("SEQ")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("EXEC_KIND_TAG", rows[i].getString(dsSUB04.indexOfColumn("EXEC_KIND_TAG")));
						lrArgData.setValue("TARGET_SLIP_ID", rows[i].getString(dsSUB04.indexOfColumn("TARGET_SLIP_ID")));
						lrArgData.setValue("TARGET_SLIP_IDSEQ", rows[i].getString(dsSUB04.indexOfColumn("TARGET_SLIP_IDSEQ")));
						lrArgData.setValue("EXEC_AMT", rows[i].getString(dsSUB04.indexOfColumn("EXEC_AMT")));
						lrArgData.setValue("OUT_ACC_NO", rows[i].getString(dsSUB04.indexOfColumn("OUT_ACC_NO")));
						lrArgData.setValue("IN_BANK_MAIN_CODE", rows[i].getString(dsSUB04.indexOfColumn("IN_BANK_MAIN_CODE")));
						lrArgData.setValue("IN_ACC_NO", rows[i].getString(dsSUB04.indexOfColumn("IN_ACC_NO")));
						lrArgData.setValue("SLIP_PUB_SEQ", rows[i].getString(dsSUB04.indexOfColumn("SLIP_PUB_SEQ")));
						lrArgData.setValue("SLIP_ID", rows[i].getString(dsSUB04.indexOfColumn("SLIP_ID")));
						lrArgData.setValue("SLIP_IDSEQ", rows[i].getString(dsSUB04.indexOfColumn("SLIP_IDSEQ")));
						lrArgData.setValue("CHK_BILL_NO", rows[i].getString(dsSUB04.indexOfColumn("CHK_BILL_NO")));
						lrArgData.setValue("ACCNO_OWNER", rows[i].getString(dsSUB04.indexOfColumn("ACCNO_OWNER")));
						lrArgData.setValue("EXPR_DT", rows[i].getString(dsSUB04.indexOfColumn("EXPR_DT")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_FIN_PAY_EXEC_LIST_U(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("WORK_DT", CITData.VARCHAR2);
						lrArgData.addColumn("SEQ", CITData.NUMBER);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("EXEC_KIND_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("TARGET_SLIP_ID", CITData.NUMBER);
						lrArgData.addColumn("TARGET_SLIP_IDSEQ", CITData.NUMBER);
						lrArgData.addColumn("EXEC_AMT", CITData.NUMBER);
						lrArgData.addColumn("OUT_ACC_NO", CITData.VARCHAR2);
						lrArgData.addColumn("IN_BANK_MAIN_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("IN_ACC_NO", CITData.VARCHAR2);
						lrArgData.addColumn("SLIP_PUB_SEQ", CITData.NUMBER);
						lrArgData.addColumn("SLIP_ID", CITData.NUMBER);
						lrArgData.addColumn("SLIP_IDSEQ", CITData.NUMBER);
						lrArgData.addColumn("CHK_BILL_NO", CITData.VARCHAR2);
						lrArgData.addColumn("ACCNO_OWNER", CITData.VARCHAR2);
						lrArgData.addColumn("EXPR_DT", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsSUB04.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("WORK_DT", rows[i].getString(dsSUB04.indexOfColumn("WORK_DT")));
						lrArgData.setValue("SEQ", rows[i].getString(dsSUB04.indexOfColumn("SEQ")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("EXEC_KIND_TAG", rows[i].getString(dsSUB04.indexOfColumn("EXEC_KIND_TAG")));
						lrArgData.setValue("TARGET_SLIP_ID", rows[i].getString(dsSUB04.indexOfColumn("TARGET_SLIP_ID")));
						lrArgData.setValue("TARGET_SLIP_IDSEQ", rows[i].getString(dsSUB04.indexOfColumn("TARGET_SLIP_IDSEQ")));
						lrArgData.setValue("EXEC_AMT", rows[i].getString(dsSUB04.indexOfColumn("EXEC_AMT")));
						lrArgData.setValue("OUT_ACC_NO", rows[i].getString(dsSUB04.indexOfColumn("OUT_ACC_NO")));
						lrArgData.setValue("IN_BANK_MAIN_CODE", rows[i].getString(dsSUB04.indexOfColumn("IN_BANK_MAIN_CODE")));
						lrArgData.setValue("IN_ACC_NO", rows[i].getString(dsSUB04.indexOfColumn("IN_ACC_NO")));
						lrArgData.setValue("SLIP_PUB_SEQ", rows[i].getString(dsSUB04.indexOfColumn("SLIP_PUB_SEQ")));
						lrArgData.setValue("SLIP_ID", rows[i].getString(dsSUB04.indexOfColumn("SLIP_ID")));
						lrArgData.setValue("SLIP_IDSEQ", rows[i].getString(dsSUB04.indexOfColumn("SLIP_IDSEQ")));
						lrArgData.setValue("CHK_BILL_NO", rows[i].getString(dsSUB04.indexOfColumn("CHK_BILL_NO")));
						lrArgData.setValue("ACCNO_OWNER", rows[i].getString(dsSUB04.indexOfColumn("ACCNO_OWNER")));
						lrArgData.setValue("EXPR_DT", rows[i].getString(dsSUB04.indexOfColumn("EXPR_DT")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_FIN_PAY_EXEC_LIST_D(?,?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("WORK_DT", CITData.VARCHAR2);
						lrArgData.addColumn("SEQ", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsSUB04.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("WORK_DT", rows[i].getString(dsSUB04.indexOfColumn("WORK_DT")));
						lrArgData.setValue("SEQ", rows[i].getString(dsSUB04.indexOfColumn("SEQ")));
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
				GauceInfo.response.writeException("USER", "900001", "T_FIN_PAY_EXEC_LIST 테이블 데이타 갱신 에러" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
	//복사끝
	//여기에 붙여넣으세요
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
