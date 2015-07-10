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
	
	GauceDataSet dsEXEC_PROC = null;
	
	GauceDataRow[] rows = null;
	
	String strSql = "";
	String strAct = "";
	String strKeepDt = "";
	String strUserNo = "";
	String strDeptCode = "";
	Connection conn = null;
	
	try
	{
		GauceInfo = CITCommon.initServerPage(request, response, session);
		/* 세션정보 */
		strUserNo = CITCommon.toKOR((String)session.getAttribute("emp_no"));
		strDeptCode = CITCommon.NvlString(session.getAttribute("dept_code"));
		conn = CITConnectionManager.getConnection(false);
		
		strAct = GauceInfo.request.getParameter("ACT");
		strKeepDt = GauceInfo.request.getParameter("KEEP_DT");
		
		dsEXEC_PROC = GauceInfo.request.getGauceDataSet("dsEXEC_PROC");
		
		if (dsEXEC_PROC == null) throw new Exception("dsEXEC_PROC이(가) 널(Null)입니다.");
		
		rows = dsEXEC_PROC.getDataRows();
		
		try
		{
			for	(int i = 0;	i <	rows.length; i++)
			{
				CITData lrArgData = new CITData();
				
				if (rows[i].getJobType() == GauceDataRow.TB_JOB_INSERT)
				{
				}
				else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
				{
					if("CONF_T".equals(rows[i].getString(dsEXEC_PROC.indexOfColumn("CMD"))))
					{

						strSql = "{call SP_T_ACC_SLIP_CONF(?,?,?,?,?,?,?)} ";
						
						lrArgData.addColumn("SLIP_ID",CITData.NUMBER);
						lrArgData.addColumn("KEEP_SLIPNO",CITData.VARCHAR2);
						lrArgData.addColumn("KEEP_DT",CITData.VARCHAR2);
						lrArgData.addColumn("KEEP_DT_TRANS",CITData.VARCHAR2);
						lrArgData.addColumn("KEEP_DEPT",CITData.VARCHAR2);
						lrArgData.addColumn("KEEP_KEEPER",CITData.NUMBER);
						lrArgData.addColumn("CONFIRM_YN",CITData.VARCHAR2);
					
						lrArgData.addRow();
						lrArgData.setValue("SLIP_ID",      rows[i].getString(dsEXEC_PROC.indexOfColumn("SLIP_ID")));
						lrArgData.setValue("KEEP_SLIPNO",  rows[i].getString(dsEXEC_PROC.indexOfColumn("KEEP_SLIPNO")));
						lrArgData.setValue("KEEP_DT",      rows[i].getString(dsEXEC_PROC.indexOfColumn("KEEP_DT")));
						lrArgData.setValue("KEEP_DT_TRANS",rows[i].getString(dsEXEC_PROC.indexOfColumn("KEEP_DT")));
						lrArgData.setValue("KEEP_DEPT",    rows[i].getString(dsEXEC_PROC.indexOfColumn("DEPT_CODE")));
						lrArgData.setValue("KEEP_KEEPER",  rows[i].getString(dsEXEC_PROC.indexOfColumn("KEEP_KEEPER")));
						lrArgData.setValue("CONFIRM_YN",   "T");
					
						try
						{
							CITDatabase.executeProcedure(strSql, lrArgData, conn);
						}
						catch (Exception ex)
						{
							if (GauceInfo != null) GauceInfo.response.writeException("USER", "900001","??? Select 오류-> "+ ex.getMessage());
							throw new Exception("USER-900001:??? Select 오류 -> " + ex.getMessage());
						}
					
					} else if("CONF_F".equals(rows[i].getString(dsEXEC_PROC.indexOfColumn("CMD")))) {						
							
						strSql = "{call SP_T_ACC_SLIP_CONF(?,?,?,?,?,?,?)} ";
						
						lrArgData.addColumn("SLIP_ID",CITData.NUMBER);
						lrArgData.addColumn("KEEP_SLIPNO",CITData.VARCHAR2);
						lrArgData.addColumn("KEEP_DT",CITData.VARCHAR2);
						lrArgData.addColumn("KEEP_DT_TRANS",CITData.VARCHAR2);
						lrArgData.addColumn("KEEP_DEPT",CITData.VARCHAR2);
						lrArgData.addColumn("KEEP_KEEPER",CITData.NUMBER);
						lrArgData.addColumn("CONFIRM_YN",CITData.VARCHAR2);
					
						lrArgData.addRow();
						lrArgData.setValue("SLIP_ID",      rows[i].getString(dsEXEC_PROC.indexOfColumn("SLIP_ID")));
						lrArgData.setValue("KEEP_SLIPNO",  rows[i].getString(dsEXEC_PROC.indexOfColumn("KEEP_SLIPNO")));
						lrArgData.setValue("KEEP_DT",      rows[i].getString(dsEXEC_PROC.indexOfColumn("KEEP_DT")));
						lrArgData.setValue("KEEP_DT_TRANS",rows[i].getString(dsEXEC_PROC.indexOfColumn("KEEP_DT")));
						lrArgData.setValue("KEEP_DEPT",    rows[i].getString(dsEXEC_PROC.indexOfColumn("DEPT_CODE")));
						lrArgData.setValue("KEEP_KEEPER",  rows[i].getString(dsEXEC_PROC.indexOfColumn("KEEP_KEEPER")));
						lrArgData.setValue("CONFIRM_YN", "F");
					
						try
						{
							CITDatabase.executeProcedure(strSql, lrArgData, conn);
						}
						catch (Exception ex)
						{
							if (GauceInfo != null) GauceInfo.response.writeException("USER", "900001","??? Select 오류-> "+ ex.getMessage());
							throw new Exception("USER-900001:??? Select 오류 -> " + ex.getMessage());
						}
					}			
				}
				else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
				{

				}
				else
				{
					continue;
				}
			}
		}
		catch (Exception ex)
		{
			if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
			GauceInfo.response.writeException("USER", "900001", "T_FIN_LOAN_SHEET 테이블 데이타 갱신 에러" + ex.getMessage());
			throw new Exception(ex.getMessage());
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
