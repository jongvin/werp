<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Update Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 한재원 작성(2006-01-16)
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
						strSql = "{call SP_T_FIX_DEPREC_RAT_I(?,?,?,?,?)}";
						
						lrArgData.addColumn("SRVLIFE", CITData.NUMBER);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("DEPREC_RAT5", CITData.NUMBER);
						lrArgData.addColumn("DEPREC_RAT10", CITData.NUMBER);
						lrArgData.addColumn("DEPREC_AMT", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("SRVLIFE", rows[i].getString(dsMAIN.indexOfColumn("SRVLIFE")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("DEPREC_RAT5", rows[i].getString(dsMAIN.indexOfColumn("DEPREC_RAT5")));
						lrArgData.setValue("DEPREC_RAT10", rows[i].getString(dsMAIN.indexOfColumn("DEPREC_RAT10")));
						lrArgData.setValue("DEPREC_AMT", rows[i].getString(dsMAIN.indexOfColumn("DEPREC_AMT")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_FIX_DEPREC_RAT_U(?,?,?,?,?)}";
						
						lrArgData.addColumn("SRVLIFE", CITData.NUMBER);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("DEPREC_RAT5", CITData.NUMBER);
						lrArgData.addColumn("DEPREC_RAT10", CITData.NUMBER);
						lrArgData.addColumn("DEPREC_AMT", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("SRVLIFE", rows[i].getString(dsMAIN.indexOfColumn("SRVLIFE")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("DEPREC_RAT5", rows[i].getString(dsMAIN.indexOfColumn("DEPREC_RAT5")));
						lrArgData.setValue("DEPREC_RAT10", rows[i].getString(dsMAIN.indexOfColumn("DEPREC_RAT10")));
						lrArgData.setValue("DEPREC_AMT", rows[i].getString(dsMAIN.indexOfColumn("DEPREC_AMT")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_FIX_DEPREC_RAT_D(?)}";
						
						lrArgData.addColumn("SRVLIFE", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("SRVLIFE", rows[i].getString(dsMAIN.indexOfColumn("SRVLIFE")));
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
				GauceInfo.response.writeException("USER", "900001", "T_FIX_DEPREC_RAT 테이블 데이타 갱신 에러" + ex.getMessage());
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
