<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Update Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 김흥수 작성(2006-01-26)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
	CITGauceInfo GauceInfo = null;
	
	GauceDataSet dsMAIN = null;
	GauceDataSet dsMAKE = null;
	GauceDataSet dsSUB01 = null;
	
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
					
					if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_FIN_MAKE_NP_DATA(?,?)}";
						
						lrArgData.addColumn("WORK_NO", CITData.NUMBER);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("WORK_NO", rows[i].getString(dsMAKE.indexOfColumn("WORK_NO")));
						lrArgData.setValue("MODUSERNO", strUserNo);
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
				GauceInfo.response.writeException("USER", "900001", "T_FIN_SEC_NP_ITR_WORK 테이블 데이타 갱신 에러" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
		}
		if(!CITCommon.isNull(strAct) && strAct.equals("REMOVE_SLIP"))
		{
			dsMAKE = GauceInfo.request.getGauceDataSet("dsMAKE");
			
			if (dsMAKE == null) throw new Exception("dsMAKE이(가) 널(Null)입니다.");
			
			rows = dsMAKE.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_FIN_REMOVE_NP_SLIP(?,?)}";
						
						lrArgData.addColumn("WORK_NO", CITData.NUMBER);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("WORK_NO", rows[i].getString(dsMAKE.indexOfColumn("WORK_NO")));
						lrArgData.setValue("MODUSERNO", strUserNo);
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
				GauceInfo.response.writeException("USER", "900001", "T_FIN_SEC_NP_ITR_WORK 테이블 데이타 갱신 에러" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
		}
		if(!CITCommon.isNull(strAct) && strAct.equals("MAKE_SLIP"))
		{
			dsMAKE = GauceInfo.request.getGauceDataSet("dsMAKE");
			
			if (dsMAKE == null) throw new Exception("dsMAKE이(가) 널(Null)입니다.");
			
			rows = dsMAKE.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_FIN_MAKE_NP_SLIP(?,?,?,?)}";
						
						lrArgData.addColumn("WORK_NO", CITData.NUMBER);
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("WORK_NO", rows[i].getString(dsMAKE.indexOfColumn("WORK_NO")));
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsMAKE.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("DEPT_CODE", rows[i].getString(dsMAKE.indexOfColumn("DEPT_CODE")));
						lrArgData.setValue("MODUSERNO", strUserNo);
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
				GauceInfo.response.writeException("USER", "900001", "T_FIN_SEC_NP_ITR_WORK 테이블 데이타 갱신 에러" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
		}
		if(!CITCommon.isNull(strAct) && strAct.equals("CALC"))
		{
			dsMAKE = GauceInfo.request.getGauceDataSet("dsMAKE");
			
			if (dsMAKE == null) throw new Exception("dsMAKE이(가) 널(Null)입니다.");
			
			rows = dsMAKE.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_FIN_CALC_NP_ITR(?,?)}";
						
						lrArgData.addColumn("WORK_NO", CITData.NUMBER);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("WORK_NO", rows[i].getString(dsMAKE.indexOfColumn("WORK_NO")));
						lrArgData.setValue("MODUSERNO", strUserNo);
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
				GauceInfo.response.writeException("USER", "900001", "T_FIN_SEC_NP_ITR_WORK 테이블 데이타 갱신 에러" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
		}
		else if (CITCommon.isNull(strAct))
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
						strSql = "{call SP_T_FIN_SEC_NP_ITR_WORK_I(?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("WORK_NO", CITData.NUMBER);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("WORK_DT", CITData.VARCHAR2);
						lrArgData.addColumn("DESCRIPTION", CITData.VARCHAR2);
						lrArgData.addColumn("CALC_DT_FROM", CITData.VARCHAR2);
						lrArgData.addColumn("CALC_DT_TO", CITData.VARCHAR2);
						lrArgData.addColumn("TARGET_COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("NP_ITR_AMT", CITData.NUMBER);
						lrArgData.addColumn("SLIP_ID", CITData.NUMBER);
						lrArgData.addColumn("SLIP_IDSEQ", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("WORK_NO", rows[i].getString(dsMAIN.indexOfColumn("WORK_NO")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("WORK_DT", rows[i].getString(dsMAIN.indexOfColumn("WORK_DT")));
						lrArgData.setValue("DESCRIPTION", rows[i].getString(dsMAIN.indexOfColumn("DESCRIPTION")));
						lrArgData.setValue("CALC_DT_FROM", rows[i].getString(dsMAIN.indexOfColumn("CALC_DT_FROM")));
						lrArgData.setValue("CALC_DT_TO", rows[i].getString(dsMAIN.indexOfColumn("CALC_DT_TO")));
						lrArgData.setValue("TARGET_COMP_CODE", rows[i].getString(dsMAIN.indexOfColumn("TARGET_COMP_CODE")));
						lrArgData.setValue("NP_ITR_AMT", rows[i].getString(dsMAIN.indexOfColumn("NP_ITR_AMT")));
						lrArgData.setValue("SLIP_ID", rows[i].getString(dsMAIN.indexOfColumn("SLIP_ID")));
						lrArgData.setValue("SLIP_IDSEQ", rows[i].getString(dsMAIN.indexOfColumn("SLIP_IDSEQ")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_FIN_SEC_NP_ITR_WORK_U(?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("WORK_NO", CITData.NUMBER);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("WORK_DT", CITData.VARCHAR2);
						lrArgData.addColumn("DESCRIPTION", CITData.VARCHAR2);
						lrArgData.addColumn("CALC_DT_FROM", CITData.VARCHAR2);
						lrArgData.addColumn("CALC_DT_TO", CITData.VARCHAR2);
						lrArgData.addColumn("TARGET_COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("NP_ITR_AMT", CITData.NUMBER);
						lrArgData.addColumn("SLIP_ID", CITData.NUMBER);
						lrArgData.addColumn("SLIP_IDSEQ", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("WORK_NO", rows[i].getString(dsMAIN.indexOfColumn("WORK_NO")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("WORK_DT", rows[i].getString(dsMAIN.indexOfColumn("WORK_DT")));
						lrArgData.setValue("DESCRIPTION", rows[i].getString(dsMAIN.indexOfColumn("DESCRIPTION")));
						lrArgData.setValue("CALC_DT_FROM", rows[i].getString(dsMAIN.indexOfColumn("CALC_DT_FROM")));
						lrArgData.setValue("CALC_DT_TO", rows[i].getString(dsMAIN.indexOfColumn("CALC_DT_TO")));
						lrArgData.setValue("TARGET_COMP_CODE", rows[i].getString(dsMAIN.indexOfColumn("TARGET_COMP_CODE")));
						lrArgData.setValue("NP_ITR_AMT", rows[i].getString(dsMAIN.indexOfColumn("NP_ITR_AMT")));
						lrArgData.setValue("SLIP_ID", rows[i].getString(dsMAIN.indexOfColumn("SLIP_ID")));
						lrArgData.setValue("SLIP_IDSEQ", rows[i].getString(dsMAIN.indexOfColumn("SLIP_IDSEQ")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_FIN_SEC_NP_ITR_WORK_D(?)}";
						
						lrArgData.addColumn("WORK_NO", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("WORK_NO", rows[i].getString(dsMAIN.indexOfColumn("WORK_NO")));
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
				GauceInfo.response.writeException("USER", "900001", "T_FIN_SEC_NP_ITR_WORK 테이블 데이타 갱신 에러" + ex.getMessage());
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
						strSql = "{call SP_T_FIN_NP_ITR_TAR_SEC_I(?,?,?,?)}";
						
						lrArgData.addColumn("WORK_NO", CITData.NUMBER);
						lrArgData.addColumn("SECU_NO", CITData.NUMBER);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("ITR_CALC_NO", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("WORK_NO", rows[i].getString(dsSUB01.indexOfColumn("WORK_NO")));
						lrArgData.setValue("SECU_NO", rows[i].getString(dsSUB01.indexOfColumn("SECU_NO")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("ITR_CALC_NO", rows[i].getString(dsSUB01.indexOfColumn("ITR_CALC_NO")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_FIN_NP_ITR_TAR_SEC_U(?,?,?,?)}";
						
						lrArgData.addColumn("WORK_NO", CITData.NUMBER);
						lrArgData.addColumn("SECU_NO", CITData.NUMBER);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("ITR_CALC_NO", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("WORK_NO", rows[i].getString(dsSUB01.indexOfColumn("WORK_NO")));
						lrArgData.setValue("SECU_NO", rows[i].getString(dsSUB01.indexOfColumn("SECU_NO")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("ITR_CALC_NO", rows[i].getString(dsSUB01.indexOfColumn("ITR_CALC_NO")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_FIN_NP_ITR_TAR_SEC_D(?,?)}";
						
						lrArgData.addColumn("WORK_NO", CITData.NUMBER);
						lrArgData.addColumn("SECU_NO", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("WORK_NO", rows[i].getString(dsSUB01.indexOfColumn("WORK_NO")));
						lrArgData.setValue("SECU_NO", rows[i].getString(dsSUB01.indexOfColumn("SECU_NO")));
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
				GauceInfo.response.writeException("USER", "900001", "T_FIN_NP_ITR_TAR_SEC 테이블 데이타 갱신 에러" + ex.getMessage());
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
