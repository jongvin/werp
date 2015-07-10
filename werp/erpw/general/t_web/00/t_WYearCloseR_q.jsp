<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 한재원 작성(2005-11-25)
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

			
			strSql  = " SELECT A.COMP_CODE,  \n";
			strSql += "        A.COMPANY_NAME \n";
			strSql += " FROM   T_COMPANY A \n";
			strSql += " ORDER BY COMP_CODE ";
			

			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("COMP_CODE", true);
				lrReturnData.setNotNull("COMP_CODE", true);
				lrReturnData.setNotNull("COMPANY_NAME", true);
				
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

		else if (strAct.equals("LIST"))
		{

			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			
			strSql  = " SELECT A.COMP_CODE, \n";
			strSql += "        A.CLSE_ACC_ID, \n";
			strSql += "        A.ACC_ID, \n";
			strSql += "        F_T_DATETOSTRING(A.ACCOUNT_FDT) ACCOUNT_FDT, \n";
			strSql += "        F_T_DATETOSTRING(A.ACCOUNT_EDT) ACCOUNT_EDT, \n";
			strSql += "        A.CLSE_CLS, \n";
			strSql += "        F_T_DATETOSTRING(A.CLSE_DT) CLSE_DT \n";
			strSql += " FROM   T_YEAR_CLOSE A \n";
			strSql += " WHERE  A.COMP_CODE = ? \n";
			strSql += " ORDER  BY CLSE_ACC_ID DESC, CLSE_DT DESC ";
			
			lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
			lrArgData.addRow();                                   
			lrArgData.setValue("COMP_CODE", strCOMP_CODE);

			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("COMP_CODE", true);
				lrReturnData.setKey("CLSE_ACC_ID", true);
				lrReturnData.setNotNull("ACC_ID", true);
				lrReturnData.setNotNull("ACCOUNT_FDT", true);
				lrReturnData.setNotNull("ACCOUNT_EDT", true);
				
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001","LIST Select 오류-> "+ ex.getMessage());
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