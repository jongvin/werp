<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Update Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 배민정 작성(2006-01-17)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
	CITGauceInfo GauceInfo = null;
	
	GauceDataSet dsMAIN = null;
	GauceDataSet dsCOPY = null;
	
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
		
		if(strAct.equals("COPY"))
		{
			dsCOPY = GauceInfo.request.getGauceDataSet("dsCOPY");
			
			if (dsCOPY == null) throw new Exception("dsCOPY이(가) 널(Null)입니다.");
			
			rows = dsCOPY.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					strSql = "{call SP_CASH_PAY_WINDOW_CHECK2(?,?,?)}";
																
					lrArgData.addColumn("PAY_SEQ", CITData.NUMBER);
					lrArgData.addColumn("PROC_GUBUN", CITData.VARCHAR2);
					lrArgData.addColumn("EMP_NO", CITData.VARCHAR2);

					lrArgData.addRow();
					lrArgData.setValue("PAY_SEQ", rows[i].getString(dsCOPY.indexOfColumn("PAY_SEQ")));
					lrArgData.setValue("PROC_GUBUN", "CHECK");					
					lrArgData.setValue("EMP_NO", strUserNo);

					CITDatabase.executeProcedure(strSql, lrArgData, conn);
				}
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001", "승인 처리 에러" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
		}
		else if (strAct.equals("COPY2"))
		{
			dsCOPY = GauceInfo.request.getGauceDataSet("dsCOPY");
			
			if (dsCOPY == null) throw new Exception("dsCOPY이(가) 널(Null)입니다.");
			
			rows = dsCOPY.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					strSql = "{call SP_CASH_PAY_WINDOW_CHECK2(?,?,?)}";
																
					lrArgData.addColumn("PAY_SEQ", CITData.NUMBER);
					lrArgData.addColumn("PROC_GUBUN", CITData.VARCHAR2);
					lrArgData.addColumn("EMP_NO", CITData.VARCHAR2);

					lrArgData.addRow();
					lrArgData.setValue("PAY_SEQ", rows[i].getString(dsCOPY.indexOfColumn("PAY_SEQ")));
					lrArgData.setValue("PROC_GUBUN", "CANCEL");					
					lrArgData.setValue("EMP_NO", strUserNo);

					CITDatabase.executeProcedure(strSql, lrArgData, conn);
				}
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001", "승인 취소 처리 에러" + ex.getMessage());
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
