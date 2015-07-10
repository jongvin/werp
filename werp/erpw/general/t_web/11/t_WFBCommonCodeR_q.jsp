<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 김흥수 작성(2006-01-19)
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
			String strLOOKUP_TYPE = CITCommon.toKOR(request.getParameter("LOOKUP_TYPE"));
			
			strSql  = " Select \n";
			strSql += " 	a.LOOKUP_TYPE , \n";
			strSql += " 	a.LOOKUP_CODE , \n";
			strSql += " 	a.LOOKUP_VALUE , \n";
			strSql += " 	Decode(a.USE_YN,'Y','T','F') USE_YN , \n";
			strSql += " 	a.DESCRIPTION , \n";
			strSql += " 	a.CREATION_DATE , \n";
			strSql += " 	a.CREATION_EMP_NO , \n";
			strSql += " 	a.LAST_MODIFY_DATE , \n";
			strSql += " 	a.LAST_MODIFY_EMP_NO , \n";
			strSql += " 	a.ATTRIBUTE1 , \n";
			strSql += " 	a.ATTRIBUTE2 , \n";
			strSql += " 	a.ATTRIBUTE3 , \n";
			strSql += " 	a.ATTRIBUTE4 , \n";
			strSql += " 	a.ATTRIBUTE5 \n";
			strSql += " From	T_FB_LOOKUP_VALUES a \n";
			strSql += " Where	a.LOOKUP_TYPE =  ?  \n";
			strSql += " Order By \n";
			strSql += " 	a.LOOKUP_TYPE \n";
			
			lrArgData.addColumn("1LOOKUP_TYPE", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1LOOKUP_TYPE", strLOOKUP_TYPE);
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("LOOKUP_TYPE", true);
				lrReturnData.setKey("LOOKUP_CODE", true);
				lrReturnData.setNotNull("LOOKUP_VALUE", true);
				
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001","MAIN Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("MASTER"))
		{

			
			strSql  = " Select \n";
			strSql += " 	Distinct \n";
			strSql += " 	a.LOOKUP_TYPE CODE, \n";
			strSql += " 	a.LOOKUP_TYPE NAME \n";
			strSql += " From	T_FB_LOOKUP_VALUES a \n";
			strSql += " Where	a.LOOKUP_TYPE <> 'FBS_PASSWORD' \n";
			strSql += " Order By \n";
			strSql += " 	a.LOOKUP_TYPE \n";
			strSql += "  ";
			

			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				


				
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001","MASTER Select 오류-> "+ ex.getMessage());
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