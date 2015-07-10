<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/***************************************************/
/* 최초작성자 : 김흥수
/* 최초작성일 : 2004-11-15
/* 최종수정자 : 
/* 최종수정일 : 
/***************************************************/

	CITGauceInfo GauceInfo = null;
	
	CITData lrReturnData = null;
	GauceDataSet lrDataset = null;
	String	strSql = "";
	
	String	strAct = "";
	String	strAct2 = "";
	
	String strCondition = "";
	try
	{
		GauceInfo = CITCommon.initServerPage(request, response, session, false);
		
		CITData lrArgData = new CITData();
		
		strAct = CITCommon.toKOR(request.getParameter("ACT"));
		
		if (strAct.equals("MAIN"))
		{
			strSql = 
				"Select 1 ARG_NO , RPad('X',40) DATA_ARG_NAME , RPad('VARCHAR2',40) ARG_TYPE from dual where rownum < 1 ";
		}
		else if(strAct.equals("COLUMN"))
		{
			strSql = 
				"Select 1 DATA_COLNO , RPad('X',40) DATA_COLNAME , RPad('VARCHAR2',40) DATA_TYPE , RPad('F',40) DATA_ISKEY , RPad('T',40) DATA_ISNOTNULL, RPad('F',40) DATA_ISSELECT from dual where rownum < 1 ";
		}
		try
		{
			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
			lrDataset = CITCommon.toGauceDataSet(lrReturnData);
			GauceInfo.response.enableFirstRow(lrDataset);
			lrDataset.flush();
		}
		catch (Exception ex)
		{
			GauceInfo.response.writeException("USER", "900001", ex.getMessage());
		}
	}
	catch (Exception ex)
	{
		GauceInfo.response.writeException("SYS", "100001", "페이지 초기화 오류 -> " + ex.getMessage());
	}
	finally
	{
		try
		{
			CITCommon.finalServerPage(GauceInfo);
		}
	    catch (Exception ex)
	    {
	    	GauceInfo.response.writeException("SYS", "100002", "페이지 종료 오류 -> " + ex.getMessage());
	    }
	}
%>
