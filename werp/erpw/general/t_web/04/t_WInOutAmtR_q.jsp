<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 김흥수 작성(2006-01-25)
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
			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String strIN_DT_F = CITCommon.toKOR(request.getParameter("IN_DT_F"));
			String strIN_DT_T = CITCommon.toKOR(request.getParameter("IN_DT_T"));
			
			strSql  = " Select \n";
			strSql += " 	a.IN_NO , \n";
			strSql += " 	a.CRTUSERNO , \n";
			strSql += " 	a.CRTDATE , \n";
			strSql += " 	a.MODUSERNO , \n";
			strSql += " 	a.MODDATE , \n";
			strSql += " 	a.COMP_CODE , \n";
			strSql += " 	F_T_DATETOSTRING(a.IN_DT) IN_DT , \n";
			strSql += " 	a.NO , \n";
			strSql += " 	a.IN_KIND_TG , \n";
			strSql += " 	a.IN_DESCRIPTION , \n";
			strSql += " 	a.OUT_KIND_TG , \n";
			strSql += " 	F_T_DATETOSTRING(a.OUT_DT) OUT_DT , \n";
			strSql += " 	a.OUT_DESCRIPTION , \n";
			strSql += " 	a.GET_PERSON, \n";
			strSql += " 	b.NAME \n";
			strSql += " From	T_FIN_IN_OUT_AMT a, \n";
			strSql += " 		Z_AUTHORITY_USER b \n";
			strSql += " Where	a.GET_PERSON = b.EMPNO (+) \n";
			strSql += " And		a.COMP_CODE =  ?  \n";
			strSql += " And		a.IN_DT Between  ?  And  ?  \n";
			strSql += " Order By \n";
			strSql += " 	a.IN_DT, \n";
			strSql += " 	a.NO ";
			
			lrArgData.addColumn("1COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("2IN_DT_F", CITData.VARCHAR2);
			lrArgData.addColumn("3IN_DT_T", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("2IN_DT_F", strIN_DT_F);
			lrArgData.setValue("3IN_DT_T", strIN_DT_T);

			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("IN_NO", true);
				lrReturnData.setNotNull("COMP_CODE", true);
				lrReturnData.setNotNull("IN_DT", true);
				lrReturnData.setNotNull("IN_KIND_TG", true);
				
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
		else if (strAct.equals("IN_NO"))
		{

			
			strSql  = " select SQ_T_IN_NO.NextVal IN_NO from dual ";
			

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
				GauceInfo.response.writeException("USER", "900001","IN_NO Select 오류-> "+ ex.getMessage());
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