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
			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			
			strSql  = " Select \n";
			strSql += " 	a.COMP_CODE , \n";
			strSql += " 	a.BANK_MAIN_CODE , \n";
			strSql += " 	a.TRAN_CODE , \n";
			strSql += " 	a.ENTE_CODE , \n";
			strSql += " 	a.BILL_ENTE_CODE , \n";
			strSql += " 	a.BANK_EDI_LOGIN_ID , \n";
			strSql += " 	a.VENDOR_SUBJECT_NAME , \n";
			strSql += " 	a.CASH_SEND_SUBJECT_NAME , \n";
			strSql += " 	a.CASH_RECV_SUBJECT_NAME , \n";
			strSql += " 	a.BILL_SEND_SUBJECT_NAME , \n";
			strSql += " 	a.BILL_RECV_SUBJECT_NAME , \n";
			strSql += " 	a.CREATION_DATE , \n";
			strSql += " 	a.CREATION_EMP_NO , \n";
			strSql += " 	a.LAST_MODIFY_DATE , \n";
			strSql += " 	a.LAST_MODIFY_EMP_NO , \n";
			strSql += " 	a.ATTRIBUTE1 , \n";
			strSql += " 	a.ATTRIBUTE2 , \n";
			strSql += " 	a.ATTRIBUTE3 , \n";
			strSql += " 	a.COMP_PASSWORD \n";
			strSql += " from	T_FB_ORG_BANK a, \n";
			strSql += " 		T_BANK_MAIN b \n";
			strSql += " Where	a.BANK_MAIN_CODE = b.BANK_MAIN_CODE \n";
			strSql += " And		a.COMP_CODE =  ?  \n";
			strSql += " Order By \n";
			strSql += " 	a.BANK_MAIN_CODE \n";
			strSql += "  ";
			
			lrArgData.addColumn("1COMP_CODE", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1COMP_CODE", strCOMP_CODE);
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("COMP_CODE", true);
				lrReturnData.setKey("BANK_MAIN_CODE", true);

				
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