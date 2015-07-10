<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : t_WSessionStateR_tr.jsp(세션변수 등록)
/* 2. 유형(시나리오) : Update Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 강덕율 작성(2005-11-25)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
	CITGauceInfo GauceInfo = null;
	
	GauceDataSet dsSession = null;
	
	GauceDataRow[] rowsSession = null;
	
	Connection conn = null;
	
	String strSql = "";
	String strAct = "";
	String strUserNo = "";
	
	try
	{
		GauceInfo = CITCommon.initServerPage(request, response, session);
		
		conn = CITConnectionManager.getConnection(false);
		
		/* 세션정보 */
		strUserNo = CITCommon.toKOR((String)session.getAttribute("emp_no"));
		
		strAct = GauceInfo.request.getParameter("ACT");
		
		if (CITCommon.isNull(strAct))
		{
			dsSession = GauceInfo.request.getGauceDataSet("dsSession");
			
			if (dsSession == null) throw new Exception("dsSession이(가) 널(Null)입니다.");
			
			rowsSession = dsSession.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	rowsSession.length; i++)
				{
					String lsKey = rowsSession[i].getString(dsSession.indexOfColumn("SESSION_NAME"));
					String lsValue = rowsSession[i].getString(dsSession.indexOfColumn("SESSION_VALUE"));
					
					if (rowsSession[i].getJobType() == GauceDataRow.TB_JOB_INSERT)
					{
						session.setAttribute(lsKey, lsValue);
					}
					else if (rowsSession[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						session.setAttribute(lsKey, lsValue);
					}
					else if (rowsSession[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						session.removeAttribute(lsKey);
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
				GauceInfo.response.writeException("USER", "900001", "Session 변수 갱신 에러" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
		}
	}
	catch (Exception ex)
	{
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
