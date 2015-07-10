<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 김흥수 작성(2006-01-06)
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
			
			strSql  = " Select \n";
			strSql += " 	a.MENU_NO , \n";
			strSql += " 	a.PROGRAM_NO , \n";
			strSql += " 	a.MAKE_PROGRAMMER , \n";
			strSql += " 	a.TEST_USER_NAME_1 , \n";
			strSql += " 	a.TEST_USER_NAME_2 , \n";
			strSql += " 	a.COMFIRM_USER_NAME , \n";
			strSql += " 	a.CHANGE_PROGRAMMER , \n";
			strSql += " 	F_T_DATETOSTRING(a.MAKE_DT) MAKE_DT , \n";
			strSql += " 	F_T_DATETOSTRING(a.CHANGE_DT) CHANGE_DT, \n";
			strSql += " 	F_T_DATETOSTRING(a.CONFIRM_DT) CONFIRM_DT, \n";
			strSql += " 	b.MENU_NAME , \n";
			strSql += " 	b.PROGRAM_NAME , \n";
			strSql += " 	b.PROGRAM_ID \n";
			strSql += " From	T_PROGRAM_STATUS a, \n";
			strSql += " 		V_T_PROGRAM_LIST b \n";
			strSql += " Where	a.MENU_NO = b.MENU_NO \n";
			strSql += " And		a.PROGRAM_NO = b.PROGRAM_NO \n";
			strSql += " And		b.MENU_NAME Like '%' ||  ?  || '%' \n";
			strSql += " And		b.PROGRAM_NAME Like '%' ||  ?  || '%' \n";
			strSql += " Order By \n";
			strSql += " 	b.MENU_SEQ , \n";
			strSql += " 	b.PROGRAM_SEQ ";
			
			lrArgData.addColumn("MENU_NAME", CITData.VARCHAR2);
			lrArgData.addColumn("PROGRAM_NAME", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("MENU_NAME", strMENU_NAME);
			lrArgData.setValue("PROGRAM_NAME", strPROGRAM_NAME);
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
				GauceInfo.response.writeException("USER", "900001","MAIN Select 오류-> "+ ex.getMessage());
			}
		}
		if (strAct.equals("SUB01"))
		{
			String strMENU_NO = CITCommon.toKOR(request.getParameter("MENU_NO"));
			String strPROGRAM_NO = CITCommon.toKOR(request.getParameter("PROGRAM_NO"));
			
			strSql  = " Select \n";
			strSql += " 	a.MENU_NO , \n";
			strSql += " 	a.PROGRAM_NO , \n";
			strSql += " 	a.REQ_NO , \n";
			strSql += " 	a.REQ_USER_NAME , \n";
			strSql += " 	a.REQ_CONTENTS , \n";
			strSql += " 	F_T_DATETOSTRING(a.REQ_DT) REQ_DT , \n";
			strSql += " 	F_T_DATETOSTRING(a.PROCESS_DT) PROCESS_DT , \n";
			strSql += " 	a.PROCESS_TAG , \n";
			strSql += " 	F_T_DATETOSTRING(a.CONFIRM_DT) CONFIRM_DT , \n";
			strSql += " 	a.CONFIRM_TAG \n";
			strSql += " From	T_PROGRAM_REQUEST a \n";
			strSql += " Where	a.MENU_NO =  ?  \n";
			strSql += " And		a.PROGRAM_NO =  ?  \n";
			strSql += " Order By \n";
			strSql += " 	a.REQ_DT Desc, \n";
			strSql += " 	a.REQ_NO Desc \n";
			strSql += "  ";
			
			lrArgData.addColumn("MENU_NO", CITData.VARCHAR2);
			lrArgData.addColumn("PROGRAM_NO", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("MENU_NO", strMENU_NO);
			lrArgData.setValue("PROGRAM_NO", strPROGRAM_NO);
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				

				lrReturnData.setNotNull("REQ_USER_NAME", true);
				lrReturnData.setNotNull("REQ_DT", true);
				
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
		else if (strAct.equals("REQ_NO"))
		{
			strSql  = " Select SQ_T_REQ_NO.nextval as REQ_NO \n";
			strSql += " From   DUAL ";
				
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
				GauceInfo.response.writeException("USER", "900001", "SQ_T_REQ_NO Sequence Select 오류 -> " + ex.getMessage());
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