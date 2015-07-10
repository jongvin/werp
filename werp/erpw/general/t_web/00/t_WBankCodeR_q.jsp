<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 김흥수 작성(2005-11-17)
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
			String	strBANKMAIN_CODE= CITCommon.toKOR(request.getParameter("BANK_MAIN_CODE"));

			{
				strSql =
					"Select					"+"\r\n"+
					"	a.BANK_CODE ,		"+"\r\n"+
					"	to_char(a.CRTUSERNO) CRTUSERNO ,		"+"\r\n"+
					"	a.CRTDATE ,			"+"\r\n"+
					"	to_char(a.MODUSERNO) MODUSERNO ,		"+"\r\n"+
					"	a.MODDATE ,			"+"\r\n"+
					"	a.BANK_MAIN_CODE ,	"+"\r\n"+
					"	a.BANK_NAME ,		"+"\r\n"+
					"	a.CURACCT_CLS ,		"+"\r\n"+
					"	a.CURACCT_MAX_AMT,	"+"\r\n"+
					"	a.BILL_CLS ,		"+"\r\n"+
					"	a.HSELL_USE_CLS 	"+"\r\n"+
					"From	T_BANK_CODE a "+"\r\n"+
					"Where	a.BANK_MAIN_CODE = ? "+"\r\n"+
					"Order By	a.BANK_CODE ";
			}

			lrArgData.addColumn("BANK_MAIN_CODE", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("BANK_MAIN_CODE", strBANKMAIN_CODE);

			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
			lrReturnData.setKey("BANK_CODE", true);
		}
		try
		{
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