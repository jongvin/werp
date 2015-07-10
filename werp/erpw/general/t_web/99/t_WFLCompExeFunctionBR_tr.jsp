<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Update Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 김흥수 작성(2006-01-10)
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
						strSql = "{call SP_T_FL_COMP_EXE_FUNCTIONS_B_I(?,?,?,?,?)}";
						
						lrArgData.addColumn("DEPT_PLN_FUNC_NO", CITData.NUMBER);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("FUNC_TITLE", CITData.VARCHAR2);
						lrArgData.addColumn("FUNC_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("AUTO_RECALCC_TAG", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("DEPT_PLN_FUNC_NO", rows[i].getString(dsMAIN.indexOfColumn("DEPT_PLN_FUNC_NO")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("FUNC_TITLE", rows[i].getString(dsMAIN.indexOfColumn("FUNC_TITLE")));
						lrArgData.setValue("FUNC_NAME", rows[i].getString(dsMAIN.indexOfColumn("FUNC_NAME")));
						lrArgData.setValue("AUTO_RECALCC_TAG", rows[i].getString(dsMAIN.indexOfColumn("AUTO_RECALCC_TAG")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_FL_COMP_EXE_FUNCTIONS_B_U(?,?,?,?,?)}";
						
						lrArgData.addColumn("DEPT_PLN_FUNC_NO", CITData.NUMBER);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("FUNC_TITLE", CITData.VARCHAR2);
						lrArgData.addColumn("FUNC_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("AUTO_RECALCC_TAG", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("DEPT_PLN_FUNC_NO", rows[i].getString(dsMAIN.indexOfColumn("DEPT_PLN_FUNC_NO")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("FUNC_TITLE", rows[i].getString(dsMAIN.indexOfColumn("FUNC_TITLE")));
						lrArgData.setValue("FUNC_NAME", rows[i].getString(dsMAIN.indexOfColumn("FUNC_NAME")));
						lrArgData.setValue("AUTO_RECALCC_TAG", rows[i].getString(dsMAIN.indexOfColumn("AUTO_RECALCC_TAG")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_FL_COMP_EXE_FUNCTIONS_B_D(?)}";
						
						lrArgData.addColumn("DEPT_PLN_FUNC_NO", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("DEPT_PLN_FUNC_NO", rows[i].getString(dsMAIN.indexOfColumn("DEPT_PLN_FUNC_NO")));
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
				GauceInfo.response.writeException("USER", "900001", "T_FL_DEPT_PLN_FUNCTIONS 테이블 데이타 갱신 에러" + ex.getMessage());
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
