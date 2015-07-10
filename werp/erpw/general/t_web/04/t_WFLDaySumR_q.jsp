<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 김흥수 작성(2006-03-07)
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
			String strWORK_DT_F = CITCommon.toKOR(request.getParameter("WORK_DT_F"));
			String strWORK_DT_T = CITCommon.toKOR(request.getParameter("WORK_DT_T"));
			
			strSql  = " Select \n";
			strSql += " 	F_T_DATETOSTRING(a.WORK_DT) WORK_DT , \n";
			strSql += " 	a.CRTUSERNO , \n";
			strSql += " 	a.CRTDATE , \n";
			strSql += " 	a.MODUSERNO , \n";
			strSql += " 	a.MODDATE , \n";
			strSql += " 	a.START_DT_TIME , \n";
			strSql += " 	a.END_DT_TIME , \n";
			strSql += " 	a.EMP_NO , \n";
			strSql += " 	a.NAME , \n";
			strSql += " 	a.ERRM \n";
			strSql += " From	T_FL_SUM_HISTORY a \n";
			strSql += " Where	a.WORK_DT Between F_T_STRINGTODATE( ? ) And F_T_STRINGTODATE( ? ) \n";
			strSql += " Order By \n";
			strSql += " 	a.WORK_DT Desc \n";
			strSql += "  ";
			
			lrArgData.addColumn("1WORK_DT_F", CITData.VARCHAR2);
			lrArgData.addColumn("2WORK_DT_T", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1WORK_DT_F", strWORK_DT_F);
			lrArgData.setValue("2WORK_DT_T", strWORK_DT_T);
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("WORK_DT",true);
				


				
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
		if (strAct.equals("SUB01"))
		{
			String strWORK_DT = CITCommon.toKOR(request.getParameter("WORK_DT"));
			
			strSql  = " Select \n";
			strSql += " 	F_T_DATETOSTRING(a.WORK_DT) WORK_DT , \n";
			strSql += " 	a.WORK_NO , \n";
			strSql += " 	a.START_DT_TIME , \n";
			strSql += " 	a.END_DT_TIME , \n";
			strSql += " 	a.EMP_NO , \n";
			strSql += " 	a.NAME , \n";
			strSql += " 	a.ERRM \n";
			strSql += " From	T_FL_SUM_HISTORY_DETAIL a \n";
			strSql += " Where	a.WORK_DT = F_T_STRINGTODATE( ? ) \n";
			strSql += " Order By \n";
			strSql += " 	a.WORK_NO \n";
			strSql += "  \n";
			strSql += "  ";
			
			lrArgData.addColumn("1WORK_DT", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1WORK_DT", strWORK_DT);
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
				GauceInfo.response.writeException("USER", "900001","SUB01 Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("SUM"))
		{
			strSql  = " Select 'XXXXXXXXXX' WORK_DT From Dual where 1= 0\n";

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
				GauceInfo.response.writeException("USER", "900001","SUM Select 오류-> "+ ex.getMessage());
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
