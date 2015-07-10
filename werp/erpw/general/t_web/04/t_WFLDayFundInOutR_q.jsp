<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 홍길동 작성(2006-04-24)
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
			String strWORK_DT = CITCommon.toKOR(request.getParameter("WORK_DT"));
			
			strSql  = " Select \n";
			strSql += " 	a.item_code, \n";
			strSql += "  	b.item_name, \n";
			strSql += "  	 ?  work_dt, \n";
			strSql += "  	Sum( \n";
			strSql += "  	Case When a.WORK_DT =  ?  Then \n";
			strSql += "  		0 \n";
			strSql += "  	Else \n";
			strSql += "  		a.amt \n";
			strSql += "  	End ) AMT_B, \n";
			strSql += "  	Sum( \n";
			strSql += "  	Case When a.WORK_DT =  ?  Then \n";
			strSql += "  		a.amt \n";
			strSql += "  	Else \n";
			strSql += "  		0 \n";
			strSql += "  	End ) AMT, \n";
			strSql += " 	Max(Case When a.WORK_DT =  ?  Then a.remarks Else Null End ) remarks \n";
			strSql += " from	t_fl_day_fund_in_out a, \n";
			strSql += " 		t_fl_fund_in_out_code b \n";
			strSql += " where	a.item_code=b.item_code \n";
			strSql += " and		work_dt Between Trunc( ? ,'MM') And  ?  \n";
			strSql += " Group By \n";
			strSql += " 	a.item_code, \n";
			strSql += "  	b.item_name \n";
			strSql += "  ";
			
			lrArgData.addColumn("1WORK_DT", CITData.DATE);
			lrArgData.addColumn("2WORK_DT", CITData.DATE);
			lrArgData.addColumn("3WORK_DT", CITData.DATE);
			lrArgData.addColumn("4WORK_DT", CITData.DATE);
			lrArgData.addColumn("5WORK_DT", CITData.DATE);
			lrArgData.addColumn("6WORK_DT", CITData.DATE);
			lrArgData.addRow();
			lrArgData.setValue("1WORK_DT", strWORK_DT);
			lrArgData.setValue("2WORK_DT", strWORK_DT);
			lrArgData.setValue("3WORK_DT", strWORK_DT);
			lrArgData.setValue("4WORK_DT", strWORK_DT);
			lrArgData.setValue("5WORK_DT", strWORK_DT);
			lrArgData.setValue("6WORK_DT", strWORK_DT);

			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("ITEM_CODE", true);
				lrReturnData.setKey("WORK_DT", true);

				
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
		if (strAct.equals("COPY"))
		{
			
			strSql  = " select 'XXXXXXXXXXXXXXXXXXX' WORK_DT From Dual \n";
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
				GauceInfo.response.writeException("USER", "900001","COPY Select 오류-> "+ ex.getMessage());
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