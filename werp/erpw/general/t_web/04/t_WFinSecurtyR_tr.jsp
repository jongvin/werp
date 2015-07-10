<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Update Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 김흥수 작성(2005-12-26)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
	CITGauceInfo GauceInfo = null;
	
	GauceDataSet dsMAIN = null;
	GauceDataSet dsSUB01 = null;
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
						strSql = "{call SP_T_FIN_SECURTY_I(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("SECU_NO", CITData.NUMBER);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("SEC_KIND_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("REAL_SECU_NO", CITData.VARCHAR2);
						lrArgData.addColumn("SLIP_ID", CITData.NUMBER);
						lrArgData.addColumn("SLIP_IDSEQ", CITData.NUMBER);
						lrArgData.addColumn("RESET_SLIP_ID", CITData.NUMBER);
						lrArgData.addColumn("RESET_SLIP_IDSEQ", CITData.NUMBER);
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("GET_DT", CITData.VARCHAR2);
						lrArgData.addColumn("GET_PLACE", CITData.VARCHAR2);
						lrArgData.addColumn("PERSTOCK_AMT", CITData.NUMBER);
						lrArgData.addColumn("INCOME_AMT", CITData.NUMBER);
						lrArgData.addColumn("BF_GET_ITR_AMT", CITData.NUMBER);
						lrArgData.addColumn("GET_ITR_AMT", CITData.NUMBER);
						lrArgData.addColumn("SALE_AMT", CITData.NUMBER);
						lrArgData.addColumn("PUBL_DT", CITData.VARCHAR2);
						lrArgData.addColumn("ITR_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("INTR_RATE", CITData.NUMBER);
						lrArgData.addColumn("EXPR_DT", CITData.VARCHAR2);
						lrArgData.addColumn("SALE_DT", CITData.VARCHAR2);
						lrArgData.addColumn("RETURN_DT", CITData.VARCHAR2);
						lrArgData.addColumn("CONSIGN_BANK", CITData.VARCHAR2);
						lrArgData.addColumn("SALE_ITR_AMT", CITData.NUMBER);
						lrArgData.addColumn("SALE_TAX", CITData.NUMBER);
						lrArgData.addColumn("SALE_LOSS", CITData.NUMBER);
						lrArgData.addColumn("SALE_NP_ITR_AMT", CITData.NUMBER);
						lrArgData.addColumn("BF_GET_ITR_TAX", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("SECU_NO", rows[i].getString(dsMAIN.indexOfColumn("SECU_NO")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("SEC_KIND_CODE", rows[i].getString(dsMAIN.indexOfColumn("SEC_KIND_CODE")));
						lrArgData.setValue("REAL_SECU_NO", rows[i].getString(dsMAIN.indexOfColumn("REAL_SECU_NO")));
						lrArgData.setValue("SLIP_ID", rows[i].getString(dsMAIN.indexOfColumn("SLIP_ID")));
						lrArgData.setValue("SLIP_IDSEQ", rows[i].getString(dsMAIN.indexOfColumn("SLIP_IDSEQ")));
						lrArgData.setValue("RESET_SLIP_ID", rows[i].getString(dsMAIN.indexOfColumn("RESET_SLIP_ID")));
						lrArgData.setValue("RESET_SLIP_IDSEQ", rows[i].getString(dsMAIN.indexOfColumn("RESET_SLIP_IDSEQ")));
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsMAIN.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("GET_DT", rows[i].getString(dsMAIN.indexOfColumn("GET_DT")));
						lrArgData.setValue("GET_PLACE", rows[i].getString(dsMAIN.indexOfColumn("GET_PLACE")));
						lrArgData.setValue("PERSTOCK_AMT", rows[i].getString(dsMAIN.indexOfColumn("PERSTOCK_AMT")));
						lrArgData.setValue("INCOME_AMT", rows[i].getString(dsMAIN.indexOfColumn("INCOME_AMT")));
						lrArgData.setValue("BF_GET_ITR_AMT", rows[i].getString(dsMAIN.indexOfColumn("BF_GET_ITR_AMT")));
						lrArgData.setValue("GET_ITR_AMT", rows[i].getString(dsMAIN.indexOfColumn("GET_ITR_AMT")));
						lrArgData.setValue("SALE_AMT", rows[i].getString(dsMAIN.indexOfColumn("SALE_AMT")));
						lrArgData.setValue("PUBL_DT", rows[i].getString(dsMAIN.indexOfColumn("PUBL_DT")));
						lrArgData.setValue("ITR_TAG", rows[i].getString(dsMAIN.indexOfColumn("ITR_TAG")));
						lrArgData.setValue("INTR_RATE", rows[i].getString(dsMAIN.indexOfColumn("INTR_RATE")));
						lrArgData.setValue("EXPR_DT", rows[i].getString(dsMAIN.indexOfColumn("EXPR_DT")));
						lrArgData.setValue("SALE_DT", rows[i].getString(dsMAIN.indexOfColumn("SALE_DT")));
						lrArgData.setValue("RETURN_DT", rows[i].getString(dsMAIN.indexOfColumn("RETURN_DT")));
						lrArgData.setValue("CONSIGN_BANK", rows[i].getString(dsMAIN.indexOfColumn("CONSIGN_BANK")));
						lrArgData.setValue("SALE_ITR_AMT", rows[i].getString(dsMAIN.indexOfColumn("SALE_ITR_AMT")));
						lrArgData.setValue("SALE_TAX", rows[i].getString(dsMAIN.indexOfColumn("SALE_TAX")));
						lrArgData.setValue("SALE_LOSS", rows[i].getString(dsMAIN.indexOfColumn("SALE_LOSS")));
						lrArgData.setValue("SALE_NP_ITR_AMT", rows[i].getString(dsMAIN.indexOfColumn("SALE_NP_ITR_AMT")));
						lrArgData.setValue("BF_GET_ITR_TAX", rows[i].getString(dsMAIN.indexOfColumn("BF_GET_ITR_TAX")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_FIN_SECURTY_U(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("SECU_NO", CITData.NUMBER);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("SEC_KIND_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("REAL_SECU_NO", CITData.VARCHAR2);
						lrArgData.addColumn("SLIP_ID", CITData.NUMBER);
						lrArgData.addColumn("SLIP_IDSEQ", CITData.NUMBER);
						lrArgData.addColumn("RESET_SLIP_ID", CITData.NUMBER);
						lrArgData.addColumn("RESET_SLIP_IDSEQ", CITData.NUMBER);
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("GET_DT", CITData.VARCHAR2);
						lrArgData.addColumn("GET_PLACE", CITData.VARCHAR2);
						lrArgData.addColumn("PERSTOCK_AMT", CITData.NUMBER);
						lrArgData.addColumn("INCOME_AMT", CITData.NUMBER);
						lrArgData.addColumn("BF_GET_ITR_AMT", CITData.NUMBER);
						lrArgData.addColumn("GET_ITR_AMT", CITData.NUMBER);
						lrArgData.addColumn("SALE_AMT", CITData.NUMBER);
						lrArgData.addColumn("PUBL_DT", CITData.VARCHAR2);
						lrArgData.addColumn("ITR_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("INTR_RATE", CITData.NUMBER);
						lrArgData.addColumn("EXPR_DT", CITData.VARCHAR2);
						lrArgData.addColumn("SALE_DT", CITData.VARCHAR2);
						lrArgData.addColumn("RETURN_DT", CITData.VARCHAR2);
						lrArgData.addColumn("CONSIGN_BANK", CITData.VARCHAR2);
						lrArgData.addColumn("SALE_ITR_AMT", CITData.NUMBER);
						lrArgData.addColumn("SALE_TAX", CITData.NUMBER);
						lrArgData.addColumn("SALE_LOSS", CITData.NUMBER);
						lrArgData.addColumn("SALE_NP_ITR_AMT", CITData.NUMBER);
						lrArgData.addColumn("BF_GET_ITR_TAX", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("SECU_NO", rows[i].getString(dsMAIN.indexOfColumn("SECU_NO")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("SEC_KIND_CODE", rows[i].getString(dsMAIN.indexOfColumn("SEC_KIND_CODE")));
						lrArgData.setValue("REAL_SECU_NO", rows[i].getString(dsMAIN.indexOfColumn("REAL_SECU_NO")));
						lrArgData.setValue("SLIP_ID", rows[i].getString(dsMAIN.indexOfColumn("SLIP_ID")));
						lrArgData.setValue("SLIP_IDSEQ", rows[i].getString(dsMAIN.indexOfColumn("SLIP_IDSEQ")));
						lrArgData.setValue("RESET_SLIP_ID", rows[i].getString(dsMAIN.indexOfColumn("RESET_SLIP_ID")));
						lrArgData.setValue("RESET_SLIP_IDSEQ", rows[i].getString(dsMAIN.indexOfColumn("RESET_SLIP_IDSEQ")));
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsMAIN.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("GET_DT", rows[i].getString(dsMAIN.indexOfColumn("GET_DT")));
						lrArgData.setValue("GET_PLACE", rows[i].getString(dsMAIN.indexOfColumn("GET_PLACE")));
						lrArgData.setValue("PERSTOCK_AMT", rows[i].getString(dsMAIN.indexOfColumn("PERSTOCK_AMT")));
						lrArgData.setValue("INCOME_AMT", rows[i].getString(dsMAIN.indexOfColumn("INCOME_AMT")));
						lrArgData.setValue("BF_GET_ITR_AMT", rows[i].getString(dsMAIN.indexOfColumn("BF_GET_ITR_AMT")));
						lrArgData.setValue("GET_ITR_AMT", rows[i].getString(dsMAIN.indexOfColumn("GET_ITR_AMT")));
						lrArgData.setValue("SALE_AMT", rows[i].getString(dsMAIN.indexOfColumn("SALE_AMT")));
						lrArgData.setValue("PUBL_DT", rows[i].getString(dsMAIN.indexOfColumn("PUBL_DT")));
						lrArgData.setValue("ITR_TAG", rows[i].getString(dsMAIN.indexOfColumn("ITR_TAG")));
						lrArgData.setValue("INTR_RATE", rows[i].getString(dsMAIN.indexOfColumn("INTR_RATE")));
						lrArgData.setValue("EXPR_DT", rows[i].getString(dsMAIN.indexOfColumn("EXPR_DT")));
						lrArgData.setValue("SALE_DT", rows[i].getString(dsMAIN.indexOfColumn("SALE_DT")));
						lrArgData.setValue("RETURN_DT", rows[i].getString(dsMAIN.indexOfColumn("RETURN_DT")));
						lrArgData.setValue("CONSIGN_BANK", rows[i].getString(dsMAIN.indexOfColumn("CONSIGN_BANK")));
						lrArgData.setValue("SALE_ITR_AMT", rows[i].getString(dsMAIN.indexOfColumn("SALE_ITR_AMT")));
						lrArgData.setValue("SALE_TAX", rows[i].getString(dsMAIN.indexOfColumn("SALE_TAX")));
						lrArgData.setValue("SALE_LOSS", rows[i].getString(dsMAIN.indexOfColumn("SALE_LOSS")));
						lrArgData.setValue("SALE_NP_ITR_AMT", rows[i].getString(dsMAIN.indexOfColumn("SALE_NP_ITR_AMT")));
						lrArgData.setValue("BF_GET_ITR_TAX", rows[i].getString(dsMAIN.indexOfColumn("BF_GET_ITR_TAX")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_FIN_SECURTY_D(?)}";
						
						lrArgData.addColumn("SECU_NO", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("SECU_NO", rows[i].getString(dsMAIN.indexOfColumn("SECU_NO")));
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
				GauceInfo.response.writeException("USER", "900001", "T_FIN_SECURTY 테이블 데이타 갱신 에러" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
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
						strSql = "{call SP_T_FIN_SEC_ITR_AMT_I(?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("SECU_NO", CITData.NUMBER);
						lrArgData.addColumn("ITR_CALC_NO", CITData.NUMBER);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("KIND_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("CALC_DT_FROM", CITData.VARCHAR2);
						lrArgData.addColumn("CALC_DT_TO", CITData.VARCHAR2);
						lrArgData.addColumn("CALC_DAYS", CITData.NUMBER);
						lrArgData.addColumn("NP_ITR_AMT", CITData.NUMBER);
						lrArgData.addColumn("ITR_AMT", CITData.NUMBER);
						lrArgData.addColumn("SLIP_ID", CITData.NUMBER);
						lrArgData.addColumn("SLIP_IDSEQ", CITData.NUMBER);
						lrArgData.addColumn("REMARKS", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("SECU_NO", rows[i].getString(dsSUB01.indexOfColumn("SECU_NO")));
						lrArgData.setValue("ITR_CALC_NO", rows[i].getString(dsSUB01.indexOfColumn("ITR_CALC_NO")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("KIND_TAG", rows[i].getString(dsSUB01.indexOfColumn("KIND_TAG")));
						lrArgData.setValue("CALC_DT_FROM", rows[i].getString(dsSUB01.indexOfColumn("CALC_DT_FROM")));
						lrArgData.setValue("CALC_DT_TO", rows[i].getString(dsSUB01.indexOfColumn("CALC_DT_TO")));
						lrArgData.setValue("CALC_DAYS", rows[i].getString(dsSUB01.indexOfColumn("CALC_DAYS")));
						lrArgData.setValue("NP_ITR_AMT", rows[i].getString(dsSUB01.indexOfColumn("NP_ITR_AMT")));
						lrArgData.setValue("ITR_AMT", rows[i].getString(dsSUB01.indexOfColumn("ITR_AMT")));
						lrArgData.setValue("SLIP_ID", rows[i].getString(dsSUB01.indexOfColumn("SLIP_ID")));
						lrArgData.setValue("SLIP_IDSEQ", rows[i].getString(dsSUB01.indexOfColumn("SLIP_IDSEQ")));
						lrArgData.setValue("REMARKS", rows[i].getString(dsSUB01.indexOfColumn("REMARKS")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_FIN_SEC_ITR_AMT_U(?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("SECU_NO", CITData.NUMBER);
						lrArgData.addColumn("ITR_CALC_NO", CITData.NUMBER);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("KIND_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("CALC_DT_FROM", CITData.VARCHAR2);
						lrArgData.addColumn("CALC_DT_TO", CITData.VARCHAR2);
						lrArgData.addColumn("CALC_DAYS", CITData.NUMBER);
						lrArgData.addColumn("NP_ITR_AMT", CITData.NUMBER);
						lrArgData.addColumn("ITR_AMT", CITData.NUMBER);
						lrArgData.addColumn("SLIP_ID", CITData.NUMBER);
						lrArgData.addColumn("SLIP_IDSEQ", CITData.NUMBER);
						lrArgData.addColumn("REMARKS", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("SECU_NO", rows[i].getString(dsSUB01.indexOfColumn("SECU_NO")));
						lrArgData.setValue("ITR_CALC_NO", rows[i].getString(dsSUB01.indexOfColumn("ITR_CALC_NO")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("KIND_TAG", rows[i].getString(dsSUB01.indexOfColumn("KIND_TAG")));
						lrArgData.setValue("CALC_DT_FROM", rows[i].getString(dsSUB01.indexOfColumn("CALC_DT_FROM")));
						lrArgData.setValue("CALC_DT_TO", rows[i].getString(dsSUB01.indexOfColumn("CALC_DT_TO")));
						lrArgData.setValue("CALC_DAYS", rows[i].getString(dsSUB01.indexOfColumn("CALC_DAYS")));
						lrArgData.setValue("NP_ITR_AMT", rows[i].getString(dsSUB01.indexOfColumn("NP_ITR_AMT")));
						lrArgData.setValue("ITR_AMT", rows[i].getString(dsSUB01.indexOfColumn("ITR_AMT")));
						lrArgData.setValue("SLIP_ID", rows[i].getString(dsSUB01.indexOfColumn("SLIP_ID")));
						lrArgData.setValue("SLIP_IDSEQ", rows[i].getString(dsSUB01.indexOfColumn("SLIP_IDSEQ")));
						lrArgData.setValue("REMARKS", rows[i].getString(dsSUB01.indexOfColumn("REMARKS")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_FIN_SEC_ITR_AMT_D(?,?)}";
						
						lrArgData.addColumn("SECU_NO", CITData.NUMBER);
						lrArgData.addColumn("ITR_CALC_NO", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("SECU_NO", rows[i].getString(dsSUB01.indexOfColumn("SECU_NO")));
						lrArgData.setValue("ITR_CALC_NO", rows[i].getString(dsSUB01.indexOfColumn("ITR_CALC_NO")));
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
				GauceInfo.response.writeException("USER", "900001", "T_FIN_SEC_ITR_AMT 테이블 데이타 갱신 에러" + ex.getMessage());
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
					
					strSql = "{call SP_T_REMOVE_SECU_SLIP(?,?)}";
					
					lrArgData.addColumn("SECU_NO", CITData.VARCHAR2);
					lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);

					lrArgData.addRow();
					lrArgData.setValue("SECU_NO", rows[i].getString(dsREMOVE_SLIP.indexOfColumn("SECU_NO")));
					lrArgData.setValue("CRTUSERNO", strUserNo);
					
					CITDatabase.executeProcedure(strSql, lrArgData, conn);
				}
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001", "SP_T_REMOVE_SECU_SLIP 테이블 데이타 갱신 에러" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
		}
		else if(!CITCommon.isNull(strAct) && strAct.equals("REMOVE_ITR_SLIP"))
		{
			dsREMOVE_SLIP = GauceInfo.request.getGauceDataSet("dsREMOVE_SLIP");
			rows = dsREMOVE_SLIP.getDataRows();
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					strSql = "{call SP_T_REMOVE_ITR_SECU_SLIP(?,?)}";
					
					lrArgData.addColumn("SECU_NO", CITData.VARCHAR2);
					lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);

					lrArgData.addRow();
					lrArgData.setValue("SECU_NO", rows[i].getString(dsREMOVE_SLIP.indexOfColumn("SECU_NO")));
					lrArgData.setValue("CRTUSERNO", strUserNo);
					
					CITDatabase.executeProcedure(strSql, lrArgData, conn);
				}
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001", "SP_T_REMOVE_SECU_SLIP 테이블 데이타 갱신 에러" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
		}
		else if(!CITCommon.isNull(strAct) && strAct.equals("REMOVE_RESET_SLIP"))
		{
			dsREMOVE_SLIP = GauceInfo.request.getGauceDataSet("dsREMOVE_SLIP");
			rows = dsREMOVE_SLIP.getDataRows();
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					strSql = "{call SP_T_REMOVE_RET_SECU_SLIP(?,?)}";
					
					lrArgData.addColumn("SECU_NO", CITData.VARCHAR2);
					lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);

					lrArgData.addRow();
					lrArgData.setValue("SECU_NO", rows[i].getString(dsREMOVE_SLIP.indexOfColumn("SECU_NO")));
					lrArgData.setValue("CRTUSERNO", strUserNo);
					
					CITDatabase.executeProcedure(strSql, lrArgData, conn);
				}
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001", "SP_T_REMOVE_SECU_SLIP 테이블 데이타 갱신 에러" + ex.getMessage());
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
