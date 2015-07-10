<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*, java.util.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : t_WSessionStateR_q.jsp(세션변수 등록)
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 강덕율 작성(2005-11-25)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
 
	CITGauceInfo GauceInfo = null;
	
	CITData lrReturnData = null;
	GauceDataSet lrDataset = null;

	String	strSql = "";
	String	strAct = "";
	
	try
	{
		GauceInfo = CITCommon.initServerPage(request, response, session);
		
		CITData lrArgData = new CITData();
		
		strAct = CITCommon.toKOR(request.getParameter("ACT"));
		
		if (strAct.equals("MAIN"))
		{
			String lsSESSION_NAME = CITCommon.toKOR(request.getParameter("SESSION_NAME"));
			Enumeration emKeys = session.getAttributeNames();
			String lsKey = "";
			Object loValue = null;
			
			try
			{
				lrArgData.addColumn("SESSION_NAME", CITData.VARCHAR2);
				lrArgData.addColumn("SESSION_VALUE", CITData.VARCHAR2);
				
				while (emKeys.hasMoreElements())
				{
					lsKey = emKeys.nextElement().toString();
					loValue = session.getAttribute(lsKey);
					
					if (!CITCommon.isNull(lsSESSION_NAME) && lsKey.indexOf(lsSESSION_NAME) < 0) continue;
					
					lrArgData.addRow();
					
					lrArgData.setValue("SESSION_NAME", lsKey);
					lrArgData.setValue("SESSION_VALUE", loValue == null ? "" : loValue.toString());
				}
				
				lrArgData.setKey("SESSION_NAME", true);
				
				lrDataset = CITCommon.toGauceDataSet(lrArgData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001","Session 변수 List 오류-> "+ ex.getMessage());
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
			CITCommon.finalServerPage(GauceInfo);
		}
		catch (Exception ex)
		{
			if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
			GauceInfo.response.writeException("SYS", "100002", "페이지 종료 오류 -> " + ex.getMessage());
		}
	}
%>