<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 한재원 작성(2005-11-28)
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
			String strCLSE_ACC_ID = CITCommon.toKOR(request.getParameter("CLSE_ACC_ID"));
			
			strSql  = " SELECT  \n";
			strSql += "        A.COMP_CODE, \n";
			strSql += "        A.CLSE_ACC_ID, \n";
			strSql += "        A.CLSE_MONTH, \n";
			strSql += "        A.CLSE_CLS, \n";
			strSql += "        F_T_DateToString(A.CLSE_DT) CLSE_DT \n";
			strSql += " FROM T_MONTH_CLOSE A \n";
			strSql += " WHERE COMP_CODE = ? \n";
			strSql += " AND	  CLSE_ACC_ID = ? \n";
			strSql += " ORDER BY CLSE_MONTH \n";
			
			lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addRow();                                   
			lrArgData.setValue("COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("CLSE_ACC_ID", strCLSE_ACC_ID);

			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("COMP_CODE", true);
				lrReturnData.setKey("CLSE_ACC_ID", true);
				lrReturnData.setKey("CLSE_MONTH", true);
				
				
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

			String strCOMP_CODE 	= CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String strCLSE_ACC_ID = CITCommon.toKOR(request.getParameter("CLSE_ACC_ID"));
			String strCLSE_MONTH 	= CITCommon.toKOR(request.getParameter("CLSE_MONTH"));
			
			strSql  = " SELECT 								\n";
			strSql += "         A.COMP_CODE, 				\n";
			strSql += "         A.CLSE_ACC_ID, 				\n";
			strSql += "         A.CLSE_MONTH, 				\n";
			strSql += "         F_T_DateToString(A.CLSE_DAY) CLSE_DAY, \n";
			strSql += "         nvl(A.CLSE_CLS, 'F') CLSE_CLS \n";
			strSql += " FROM T_DAY_CLOSE A 			\n";
			strSql += " WHERE COMP_CODE = ? 		\n";
			strSql += " AND	  CLSE_ACC_ID = ? 		\n";
			strSql += " AND		CLSE_MONTH = ? 		\n";
			strSql += " ORDER BY CLSE_DAY ";
			
			lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_MONTH", CITData.VARCHAR2);
			lrArgData.addRow();                                   
			lrArgData.setValue("COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("CLSE_MONTH", strCLSE_MONTH);

			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("COMP_CODE", true);
				lrReturnData.setKey("CLSE_ACC_ID", true);
				lrReturnData.setKey("CLSE_MONTH", true);
				lrReturnData.setKey("CLSE_DAY", true);
				lrReturnData.setNotNull("COMP_CODE", true);
				lrReturnData.setNotNull("CLSE_ACC_ID", true);
				lrReturnData.setNotNull("CLSE_MONTH", true);
				lrReturnData.setNotNull("CLSE_DAY", true);
				
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
		
		else if (strAct.equals("CLSE_ACC_ID"))
		{

			String strCOMP_CODE 	= CITCommon.toKOR(request.getParameter("COMP_CODE"));
			
		strSql  = " SELECT  A.CLSE_ACC_ID || '년[' ||  ACC_ID || '기]' NAME, 	\n";
			strSql += "         A.CLSE_ACC_ID CLSE_ACC_ID, 	    \n";
			strSql += "         A.COMP_CODE, 	    \n";
			strSql += "         A.ACCOUNT_FDT, 			  		\n";
			strSql += "         A.ACCOUNT_EDT, 	 			  	\n";
			strSql += "         nvl(A.CLSE_CLS, 'F') CLSE_CLS \n";
			strSql += " FROM T_YEAR_CLOSE A \n";
			strSql += " WHERE COMP_CODE = ? 		\n";
			strSql += " ORDER BY CLSE_ACC_ID ";
			
			lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
			lrArgData.addRow();                                   
			lrArgData.setValue("COMP_CODE", strCOMP_CODE);

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
				GauceInfo.response.writeException("USER", "900001","CLSE_ACC_ID Select 오류-> "+ ex.getMessage());
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