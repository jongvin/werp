<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 김흥수 작성(2006-01-26)
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
			String strMENU_NAME = CITCommon.toKOR(request.getParameter("MENU_NAME"));
			String strPROGRAM_NAME = CITCommon.toKOR(request.getParameter("PROGRAM_NAME"));
			String strMAKE_PROGRAMMER = CITCommon.toKOR(request.getParameter("MAKE_PROGRAMMER"));
			String strREQ_DT_F = CITCommon.toKOR(request.getParameter("REQ_DT_F"));
			String strREQ_DT_T = CITCommon.toKOR(request.getParameter("REQ_DT_T"));
			String strPROCESS_TAG = CITCommon.toKOR(request.getParameter("PROCESS_TAG"));
			String strCONFIRM_TAG = CITCommon.toKOR(request.getParameter("CONFIRM_TAG"));
			
			strSql  = " Select \n";
			strSql += " 	c.MENU_NO , \n";
			strSql += " 	c.PROGRAM_NO , \n";
			strSql += " 	a.MAKE_PROGRAMMER , \n";
			strSql += " 	a.TEST_USER_NAME_1 , \n";
			strSql += " 	a.TEST_USER_NAME_2 , \n";
			strSql += " 	a.COMFIRM_USER_NAME , \n";
			strSql += " 	a.CHANGE_PROGRAMMER , \n";
			strSql += " 	F_T_DATETOSTRING(a.MAKE_DT) MAKE_DT , \n";
			strSql += " 	F_T_DATETOSTRING(a.CHANGE_DT) CHANGE_DT, \n";
			strSql += " 	b.MENU_NAME , \n";
			strSql += " 	b.PROGRAM_NAME , \n";
			strSql += " 	b.PROGRAM_ID, \n";
			strSql += " 	c.REQ_NO, \n";
			strSql += " 	c.REQ_USER_NAME, \n";
			strSql += " 	F_T_DATETOSTRING(c.REQ_DT) REQ_DT, \n";
			strSql += " 	F_T_DATETOSTRING(c.PROCESS_DT) PROCESS_DT, \n";
			strSql += " 	F_T_DATETOSTRING(c.CONFIRM_DT) CONFIRM_DT, \n";
			strSql += " 	c.PROCESS_TAG, \n";
			strSql += " 	c.CONFIRM_TAG, \n";
			strSql += " 	c.REQ_CONTENTS \n";
			strSql += " From	T_PROGRAM_STATUS a, \n";
			strSql += " 		V_T_PROGRAM_LIST b, \n";
			strSql += " 		T_PROGRAM_REQUEST c \n";
			strSql += " Where	a.MENU_NO = b.MENU_NO \n";
			strSql += " And		a.PROGRAM_NO = b.PROGRAM_NO \n";
			strSql += " And		b.MENU_NAME Like '%' ||  ?  || '%' \n";
			strSql += " And		b.PROGRAM_NAME Like '%' ||  ?  || '%' \n";
			strSql += " And		a.MAKE_PROGRAMMER Like '%' ||  ?  || '%' \n";
			strSql += " And		c.REQ_DT Between  ?  And  ?  \n";
			strSql += " And		Nvl(c.PROCESS_TAG,'F') Like Decode( ? ,'A','%','T','T','F','F') \n";
			strSql += " And		Nvl(c.CONFIRM_TAG,'F') Like Decode( ? ,'A','%','T','T','F','F') \n";
			strSql += " And		a.MENU_NO = c.MENU_NO \n";
			strSql += " And		a.PROGRAM_NO = c.PROGRAM_NO \n";
			strSql += " Order By \n";
			strSql += " 	b.MENU_SEQ , \n";
			strSql += " 	b.PROGRAM_SEQ, \n";
			strSql += " 	c.REQ_DT, \n";
			strSql += " 	c.REQ_NO \n";
			strSql += "  ";
			
			lrArgData.addColumn("1MENU_NAME", CITData.VARCHAR2);
			lrArgData.addColumn("2PROGRAM_NAME", CITData.VARCHAR2);
			lrArgData.addColumn("3MAKE_PROGRAMMER", CITData.VARCHAR2);
			lrArgData.addColumn("4REQ_DT_F", CITData.VARCHAR2);
			lrArgData.addColumn("5REQ_DT_T", CITData.VARCHAR2);
			lrArgData.addColumn("6PROCESS_TAG", CITData.VARCHAR2);
			lrArgData.addColumn("7CONFIRM_TAG", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1MENU_NAME", strMENU_NAME);
			lrArgData.setValue("2PROGRAM_NAME", strPROGRAM_NAME);
			lrArgData.setValue("3MAKE_PROGRAMMER", strMAKE_PROGRAMMER);
			lrArgData.setValue("4REQ_DT_F", strREQ_DT_F);
			lrArgData.setValue("5REQ_DT_T", strREQ_DT_T);
			lrArgData.setValue("6PROCESS_TAG", strPROCESS_TAG);
			lrArgData.setValue("7CONFIRM_TAG", strCONFIRM_TAG);
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("MENU_NO", true);
				lrReturnData.setKey("PROGRAM_NO", true);
				lrReturnData.setKey("REQ_NO", true);

				
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