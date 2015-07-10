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
	
	GauceDataSet dsMAIN01 = null;
	GauceDataSet dsMAIN03 = null;
	
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
			dsMAIN01 = GauceInfo.request.getGauceDataSet("dsMAIN01");
			
			if (dsMAIN01 == null) throw new Exception("dsMAIN01이(가) 널(Null)입니다.");
			
			rows = dsMAIN01.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					if (rows[i].getJobType() == GauceDataRow.TB_JOB_INSERT)
					{
						strSql = "{call SP_T_FIN_PAY_CHK_BILL_I(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("CHK_BILL_NO", CITData.VARCHAR2);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("CHK_BILL_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("BILL_KIND", CITData.VARCHAR2);
						lrArgData.addColumn("STAT_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("BANK_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CUST_SEQ", CITData.NUMBER);
						lrArgData.addColumn("ACPT_DT", CITData.VARCHAR2);
						lrArgData.addColumn("PUBL_DT", CITData.VARCHAR2);
						lrArgData.addColumn("PUBL_AMT", CITData.NUMBER);
						lrArgData.addColumn("EXPR_DT", CITData.VARCHAR2);
						lrArgData.addColumn("CHG_EXPR_DT", CITData.VARCHAR2);
						lrArgData.addColumn("DUSE_DT", CITData.VARCHAR2);
						lrArgData.addColumn("CUST_DOUT_DT", CITData.VARCHAR2);
						lrArgData.addColumn("COLL_DT", CITData.VARCHAR2);
						lrArgData.addColumn("RETURN_DT", CITData.VARCHAR2);
						lrArgData.addColumn("DISC_RAT", CITData.NUMBER);
						lrArgData.addColumn("DISC_AMT", CITData.NUMBER);
						lrArgData.addColumn("SLIP_ID", CITData.NUMBER);
						lrArgData.addColumn("SLIP_IDSEQ", CITData.NUMBER);
						lrArgData.addColumn("RESET_SLIP_ID", CITData.NUMBER);
						lrArgData.addColumn("RESET_SLIP_IDSEQ", CITData.NUMBER);
						lrArgData.addColumn("REMARKS", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("CHK_BILL_NO", rows[i].getString(dsMAIN01.indexOfColumn("CHK_BILL_NO")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("CHK_BILL_CLS", rows[i].getString(dsMAIN01.indexOfColumn("CHK_BILL_CLS")));
						lrArgData.setValue("BILL_KIND", rows[i].getString(dsMAIN01.indexOfColumn("BILL_KIND")));
						lrArgData.setValue("STAT_CLS", rows[i].getString(dsMAIN01.indexOfColumn("STAT_CLS")));
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsMAIN01.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("BANK_CODE", rows[i].getString(dsMAIN01.indexOfColumn("BANK_CODE")));
						lrArgData.setValue("CUST_SEQ", rows[i].getString(dsMAIN01.indexOfColumn("CUST_SEQ")));
						lrArgData.setValue("ACPT_DT", rows[i].getString(dsMAIN01.indexOfColumn("ACPT_DT")));
						lrArgData.setValue("PUBL_DT", rows[i].getString(dsMAIN01.indexOfColumn("PUBL_DT")));
						lrArgData.setValue("PUBL_AMT", rows[i].getString(dsMAIN01.indexOfColumn("PUBL_AMT")));
						lrArgData.setValue("EXPR_DT", rows[i].getString(dsMAIN01.indexOfColumn("EXPR_DT")));
						lrArgData.setValue("CHG_EXPR_DT", rows[i].getString(dsMAIN01.indexOfColumn("CHG_EXPR_DT")));
						lrArgData.setValue("DUSE_DT", rows[i].getString(dsMAIN01.indexOfColumn("DUSE_DT")));
						lrArgData.setValue("CUST_DOUT_DT", rows[i].getString(dsMAIN01.indexOfColumn("CUST_DOUT_DT")));
						lrArgData.setValue("COLL_DT", rows[i].getString(dsMAIN01.indexOfColumn("COLL_DT")));
						lrArgData.setValue("RETURN_DT", rows[i].getString(dsMAIN01.indexOfColumn("RETURN_DT")));
						lrArgData.setValue("DISC_RAT", rows[i].getString(dsMAIN01.indexOfColumn("DISC_RAT")));
						lrArgData.setValue("DISC_AMT", rows[i].getString(dsMAIN01.indexOfColumn("DISC_AMT")));
						lrArgData.setValue("SLIP_ID", rows[i].getString(dsMAIN01.indexOfColumn("SLIP_ID")));
						lrArgData.setValue("SLIP_IDSEQ", rows[i].getString(dsMAIN01.indexOfColumn("SLIP_IDSEQ")));
						lrArgData.setValue("RESET_SLIP_ID", rows[i].getString(dsMAIN01.indexOfColumn("RESET_SLIP_ID")));
						lrArgData.setValue("RESET_SLIP_IDSEQ", rows[i].getString(dsMAIN01.indexOfColumn("RESET_SLIP_IDSEQ")));
						lrArgData.setValue("REMARKS", rows[i].getString(dsMAIN01.indexOfColumn("REMARKS")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_FIN_PAY_CHK_BILL_U(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("CHK_BILL_NO", CITData.VARCHAR2);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("CHK_BILL_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("BILL_KIND", CITData.VARCHAR2);
						lrArgData.addColumn("STAT_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("BANK_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CUST_SEQ", CITData.NUMBER);
						lrArgData.addColumn("ACPT_DT", CITData.VARCHAR2);
						lrArgData.addColumn("PUBL_DT", CITData.VARCHAR2);
						lrArgData.addColumn("PUBL_AMT", CITData.NUMBER);
						lrArgData.addColumn("EXPR_DT", CITData.VARCHAR2);
						lrArgData.addColumn("CHG_EXPR_DT", CITData.VARCHAR2);
						lrArgData.addColumn("DUSE_DT", CITData.VARCHAR2);
						lrArgData.addColumn("CUST_DOUT_DT", CITData.VARCHAR2);
						lrArgData.addColumn("COLL_DT", CITData.VARCHAR2);
						lrArgData.addColumn("RETURN_DT", CITData.VARCHAR2);
						lrArgData.addColumn("DISC_RAT", CITData.NUMBER);
						lrArgData.addColumn("DISC_AMT", CITData.NUMBER);
						lrArgData.addColumn("SLIP_ID", CITData.NUMBER);
						lrArgData.addColumn("SLIP_IDSEQ", CITData.NUMBER);
						lrArgData.addColumn("RESET_SLIP_ID", CITData.NUMBER);
						lrArgData.addColumn("RESET_SLIP_IDSEQ", CITData.NUMBER);
						lrArgData.addColumn("REMARKS", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("CHK_BILL_NO", rows[i].getString(dsMAIN01.indexOfColumn("CHK_BILL_NO")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("CHK_BILL_CLS", rows[i].getString(dsMAIN01.indexOfColumn("CHK_BILL_CLS")));
						lrArgData.setValue("BILL_KIND", rows[i].getString(dsMAIN01.indexOfColumn("BILL_KIND")));
						lrArgData.setValue("STAT_CLS", rows[i].getString(dsMAIN01.indexOfColumn("STAT_CLS")));
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsMAIN01.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("BANK_CODE", rows[i].getString(dsMAIN01.indexOfColumn("BANK_CODE")));
						lrArgData.setValue("CUST_SEQ", rows[i].getString(dsMAIN01.indexOfColumn("CUST_SEQ")));
						lrArgData.setValue("ACPT_DT", rows[i].getString(dsMAIN01.indexOfColumn("ACPT_DT")));
						lrArgData.setValue("PUBL_DT", rows[i].getString(dsMAIN01.indexOfColumn("PUBL_DT")));
						lrArgData.setValue("PUBL_AMT", rows[i].getString(dsMAIN01.indexOfColumn("PUBL_AMT")));
						lrArgData.setValue("EXPR_DT", rows[i].getString(dsMAIN01.indexOfColumn("EXPR_DT")));
						lrArgData.setValue("CHG_EXPR_DT", rows[i].getString(dsMAIN01.indexOfColumn("CHG_EXPR_DT")));
						lrArgData.setValue("DUSE_DT", rows[i].getString(dsMAIN01.indexOfColumn("DUSE_DT")));
						lrArgData.setValue("CUST_DOUT_DT", rows[i].getString(dsMAIN01.indexOfColumn("CUST_DOUT_DT")));
						lrArgData.setValue("COLL_DT", rows[i].getString(dsMAIN01.indexOfColumn("COLL_DT")));
						lrArgData.setValue("RETURN_DT", rows[i].getString(dsMAIN01.indexOfColumn("RETURN_DT")));
						lrArgData.setValue("DISC_RAT", rows[i].getString(dsMAIN01.indexOfColumn("DISC_RAT")));
						lrArgData.setValue("DISC_AMT", rows[i].getString(dsMAIN01.indexOfColumn("DISC_AMT")));
						lrArgData.setValue("SLIP_ID", rows[i].getString(dsMAIN01.indexOfColumn("SLIP_ID")));
						lrArgData.setValue("SLIP_IDSEQ", rows[i].getString(dsMAIN01.indexOfColumn("SLIP_IDSEQ")));
						lrArgData.setValue("RESET_SLIP_ID", rows[i].getString(dsMAIN01.indexOfColumn("RESET_SLIP_ID")));
						lrArgData.setValue("RESET_SLIP_IDSEQ", rows[i].getString(dsMAIN01.indexOfColumn("RESET_SLIP_IDSEQ")));
						lrArgData.setValue("REMARKS", rows[i].getString(dsMAIN01.indexOfColumn("REMARKS")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_FIN_PAY_CHK_BILL_D(?)}";
						
						lrArgData.addColumn("CHK_BILL_NO", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("CHK_BILL_NO", rows[i].getString(dsMAIN01.indexOfColumn("CHK_BILL_NO")));
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
				GauceInfo.response.writeException("USER", "900001", "T_FIN_PAY_CHK_BILL 테이블 데이타 갱신 에러" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
			dsMAIN03 = GauceInfo.request.getGauceDataSet("dsMAIN03");
			
			if (dsMAIN03 == null) throw new Exception("dsMAIN03이(가) 널(Null)입니다.");
			
			rows = dsMAIN03.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					if (rows[i].getJobType() == GauceDataRow.TB_JOB_INSERT)
					{
						strSql = "{call SP_T_FIN_PAY_CHK_BILL_I(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("CHK_BILL_NO", CITData.VARCHAR2);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("CHK_BILL_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("BILL_KIND", CITData.VARCHAR2);
						lrArgData.addColumn("STAT_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("BANK_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CUST_SEQ", CITData.NUMBER);
						lrArgData.addColumn("ACPT_DT", CITData.VARCHAR2);
						lrArgData.addColumn("PUBL_DT", CITData.VARCHAR2);
						lrArgData.addColumn("PUBL_AMT", CITData.NUMBER);
						lrArgData.addColumn("EXPR_DT", CITData.VARCHAR2);
						lrArgData.addColumn("CHG_EXPR_DT", CITData.VARCHAR2);
						lrArgData.addColumn("DUSE_DT", CITData.VARCHAR2);
						lrArgData.addColumn("CUST_DOUT_DT", CITData.VARCHAR2);
						lrArgData.addColumn("COLL_DT", CITData.VARCHAR2);
						lrArgData.addColumn("RETURN_DT", CITData.VARCHAR2);
						lrArgData.addColumn("DISC_RAT", CITData.NUMBER);
						lrArgData.addColumn("DISC_AMT", CITData.NUMBER);
						lrArgData.addColumn("SLIP_ID", CITData.NUMBER);
						lrArgData.addColumn("SLIP_IDSEQ", CITData.NUMBER);
						lrArgData.addColumn("RESET_SLIP_ID", CITData.NUMBER);
						lrArgData.addColumn("RESET_SLIP_IDSEQ", CITData.NUMBER);
						lrArgData.addColumn("REMARKS", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("CHK_BILL_NO", rows[i].getString(dsMAIN03.indexOfColumn("CHK_BILL_NO")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("CHK_BILL_CLS", rows[i].getString(dsMAIN03.indexOfColumn("CHK_BILL_CLS")));
						lrArgData.setValue("BILL_KIND", rows[i].getString(dsMAIN03.indexOfColumn("BILL_KIND")));
						lrArgData.setValue("STAT_CLS", rows[i].getString(dsMAIN03.indexOfColumn("STAT_CLS")));
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsMAIN03.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("BANK_CODE", rows[i].getString(dsMAIN03.indexOfColumn("BANK_CODE")));
						lrArgData.setValue("CUST_SEQ", rows[i].getString(dsMAIN03.indexOfColumn("CUST_SEQ")));
						lrArgData.setValue("ACPT_DT", rows[i].getString(dsMAIN03.indexOfColumn("ACPT_DT")));
						lrArgData.setValue("PUBL_DT", rows[i].getString(dsMAIN03.indexOfColumn("PUBL_DT")));
						lrArgData.setValue("PUBL_AMT", rows[i].getString(dsMAIN03.indexOfColumn("PUBL_AMT")));
						lrArgData.setValue("EXPR_DT", rows[i].getString(dsMAIN03.indexOfColumn("EXPR_DT")));
						lrArgData.setValue("CHG_EXPR_DT", rows[i].getString(dsMAIN03.indexOfColumn("CHG_EXPR_DT")));
						lrArgData.setValue("DUSE_DT", rows[i].getString(dsMAIN03.indexOfColumn("DUSE_DT")));
						lrArgData.setValue("CUST_DOUT_DT", rows[i].getString(dsMAIN03.indexOfColumn("CUST_DOUT_DT")));
						lrArgData.setValue("COLL_DT", rows[i].getString(dsMAIN03.indexOfColumn("COLL_DT")));
						lrArgData.setValue("RETURN_DT", rows[i].getString(dsMAIN03.indexOfColumn("RETURN_DT")));
						lrArgData.setValue("DISC_RAT", rows[i].getString(dsMAIN03.indexOfColumn("DISC_RAT")));
						lrArgData.setValue("DISC_AMT", rows[i].getString(dsMAIN03.indexOfColumn("DISC_AMT")));
						lrArgData.setValue("SLIP_ID", rows[i].getString(dsMAIN03.indexOfColumn("SLIP_ID")));
						lrArgData.setValue("SLIP_IDSEQ", rows[i].getString(dsMAIN03.indexOfColumn("SLIP_IDSEQ")));
						lrArgData.setValue("RESET_SLIP_ID", rows[i].getString(dsMAIN03.indexOfColumn("RESET_SLIP_ID")));
						lrArgData.setValue("RESET_SLIP_IDSEQ", rows[i].getString(dsMAIN03.indexOfColumn("RESET_SLIP_IDSEQ")));
						lrArgData.setValue("REMARKS", rows[i].getString(dsMAIN03.indexOfColumn("REMARKS")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_FIN_PAY_CHK_BILL_U(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("CHK_BILL_NO", CITData.VARCHAR2);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("CHK_BILL_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("BILL_KIND", CITData.VARCHAR2);
						lrArgData.addColumn("STAT_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("BANK_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CUST_SEQ", CITData.NUMBER);
						lrArgData.addColumn("ACPT_DT", CITData.VARCHAR2);
						lrArgData.addColumn("PUBL_DT", CITData.VARCHAR2);
						lrArgData.addColumn("PUBL_AMT", CITData.NUMBER);
						lrArgData.addColumn("EXPR_DT", CITData.VARCHAR2);
						lrArgData.addColumn("CHG_EXPR_DT", CITData.VARCHAR2);
						lrArgData.addColumn("DUSE_DT", CITData.VARCHAR2);
						lrArgData.addColumn("CUST_DOUT_DT", CITData.VARCHAR2);
						lrArgData.addColumn("COLL_DT", CITData.VARCHAR2);
						lrArgData.addColumn("RETURN_DT", CITData.VARCHAR2);
						lrArgData.addColumn("DISC_RAT", CITData.NUMBER);
						lrArgData.addColumn("DISC_AMT", CITData.NUMBER);
						lrArgData.addColumn("SLIP_ID", CITData.NUMBER);
						lrArgData.addColumn("SLIP_IDSEQ", CITData.NUMBER);
						lrArgData.addColumn("RESET_SLIP_ID", CITData.NUMBER);
						lrArgData.addColumn("RESET_SLIP_IDSEQ", CITData.NUMBER);
						lrArgData.addColumn("REMARKS", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("CHK_BILL_NO", rows[i].getString(dsMAIN03.indexOfColumn("CHK_BILL_NO")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("CHK_BILL_CLS", rows[i].getString(dsMAIN03.indexOfColumn("CHK_BILL_CLS")));
						lrArgData.setValue("BILL_KIND", rows[i].getString(dsMAIN03.indexOfColumn("BILL_KIND")));
						lrArgData.setValue("STAT_CLS", rows[i].getString(dsMAIN03.indexOfColumn("STAT_CLS")));
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsMAIN03.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("BANK_CODE", rows[i].getString(dsMAIN03.indexOfColumn("BANK_CODE")));
						lrArgData.setValue("CUST_SEQ", rows[i].getString(dsMAIN03.indexOfColumn("CUST_SEQ")));
						lrArgData.setValue("ACPT_DT", rows[i].getString(dsMAIN03.indexOfColumn("ACPT_DT")));
						lrArgData.setValue("PUBL_DT", rows[i].getString(dsMAIN03.indexOfColumn("PUBL_DT")));
						lrArgData.setValue("PUBL_AMT", rows[i].getString(dsMAIN03.indexOfColumn("PUBL_AMT")));
						lrArgData.setValue("EXPR_DT", rows[i].getString(dsMAIN03.indexOfColumn("EXPR_DT")));
						lrArgData.setValue("CHG_EXPR_DT", rows[i].getString(dsMAIN03.indexOfColumn("CHG_EXPR_DT")));
						lrArgData.setValue("DUSE_DT", rows[i].getString(dsMAIN03.indexOfColumn("DUSE_DT")));
						lrArgData.setValue("CUST_DOUT_DT", rows[i].getString(dsMAIN03.indexOfColumn("CUST_DOUT_DT")));
						lrArgData.setValue("COLL_DT", rows[i].getString(dsMAIN03.indexOfColumn("COLL_DT")));
						lrArgData.setValue("RETURN_DT", rows[i].getString(dsMAIN03.indexOfColumn("RETURN_DT")));
						lrArgData.setValue("DISC_RAT", rows[i].getString(dsMAIN03.indexOfColumn("DISC_RAT")));
						lrArgData.setValue("DISC_AMT", rows[i].getString(dsMAIN03.indexOfColumn("DISC_AMT")));
						lrArgData.setValue("SLIP_ID", rows[i].getString(dsMAIN03.indexOfColumn("SLIP_ID")));
						lrArgData.setValue("SLIP_IDSEQ", rows[i].getString(dsMAIN03.indexOfColumn("SLIP_IDSEQ")));
						lrArgData.setValue("RESET_SLIP_ID", rows[i].getString(dsMAIN03.indexOfColumn("RESET_SLIP_ID")));
						lrArgData.setValue("RESET_SLIP_IDSEQ", rows[i].getString(dsMAIN03.indexOfColumn("RESET_SLIP_IDSEQ")));
						lrArgData.setValue("REMARKS", rows[i].getString(dsMAIN03.indexOfColumn("REMARKS")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_FIN_PAY_CHK_BILL_D(?)}";
						
						lrArgData.addColumn("CHK_BILL_NO", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("CHK_BILL_NO", rows[i].getString(dsMAIN03.indexOfColumn("CHK_BILL_NO")));
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
				GauceInfo.response.writeException("USER", "900001", "T_FIN_PAY_CHK_BILL 테이블 데이타 갱신 에러" + ex.getMessage());
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
