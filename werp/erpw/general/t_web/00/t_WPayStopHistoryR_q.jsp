<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 한재원 작성(2005-11-24)
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
			
			String strSEARCH_CONDITION = CITCommon.toKOR(request.getParameter("SEARCH_CONDITION"));
			
			strSql  = " SELECT To_Char(A.CUST_SEQ) CUST_SEQ, 			\n";
			strSql += "        A.PAY_STOP_SEQ, \n";
			strSql += "        A.CRTUSERNO, \n";
			strSql += "        A.CRTDATE, \n";
			strSql += "        A.MODUSERNO, \n";
			strSql += "        A.MODDATE, \n";
			strSql += "        A.PAY_STOP_CLS, \n";
			strSql += "        F_T_DATETOSTRING(A.PAY_STOPSTR_DT) PAY_STOPSTR_DT, \n";
			strSql += "        F_T_DATETOSTRING(A.PAY_STOPEND_DT) PAY_STOPEND_DT, \n";
			strSql += "        A.PAY_STOPSTR_MEMO, \n";
			strSql += "        A.PAY_STOPEND_MEMO, \n";
			strSql += "        A.PAY_STOP_AMT, \n";
			strSql += "        A.DEPT_CODE, \n";
			strSql += "        B.DEPT_NAME, \n";
			strSql += "        F_T_Cust_Mask(C.CUST_CODE) CUST_CODE, \n";
			strSql += "        C.CUST_NAME \n";
			strSql += " FROM   T_PAY_STOP_HISTORY A, \n";
			strSql += "           T_DEPT_CODE B, \n";
			strSql += "           T_CUST_CODE C \n";
			strSql += " WHERE  A.DEPT_CODE = B.DEPT_CODE(+) \n";
			strSql += " And      A.CUST_SEQ    = C.CUST_SEQ \n";
			strSql += " And	C.CUST_CODE || C.CUST_NAME Like '%'|| Replace(?,' ','%') || '%' \n";
			strSql += " ORDER  BY C.CUST_CODE, PAY_STOPSTR_DT desc \n";
			
			lrArgData.addColumn("SEARCH_CONDITION", CITData.VARCHAR2);
			lrArgData.addRow();                                   
			lrArgData.setValue("SEARCH_CONDITION", strSEARCH_CONDITION);
			
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("CUST_SEQ", true);
				lrReturnData.setKey("CUST_CODE", true);
				lrReturnData.setNotNull("CUST_NAME", true);
				lrReturnData.setKey("PAY_STOP_SEQ", true);
				lrReturnData.setNotNull("PAY_STOP_CLS", true);
				lrReturnData.setNotNull("PAY_STOPSTR_DT", true);
				lrReturnData.setNotNull("DEPT_CODE", true);
				lrReturnData.setNotNull("DEPT_NAME", true);
				lrReturnData.setNotNull("PAY_STOPSTR_MEMO", true);

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
		
		else if (strAct.equals("SEQ"))
		{
			strSql  = " SELECT  	SQ_T_PAY_STOP_HISTORY_SEQ.NextVal PAY_STOP_SEQ	\n";
			strSql += " FROM   dual \n";
		 	
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