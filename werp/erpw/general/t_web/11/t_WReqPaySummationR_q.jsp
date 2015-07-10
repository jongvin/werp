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
			String strBANK_CODE = CITCommon.toKOR(request.getParameter("BANK_CODE"));
			String strACCT_NUMBER = CITCommon.toKOR(request.getParameter("ACCT_NUMBER"));
			
			strSql  = " Select \n";
			strSql += " 	To_Char(P_DA_REQ_CNT,'fm999,999,999,999,999,990') P_DA_REQ_CNT, \n";
			strSql += " 	To_Char(P_DA_REQ_AMT,'fm999,999,999,999,999,990') P_DA_REQ_AMT, \n";
			strSql += " 	To_Char(P_DA_SUCCESS_CNT,'fm999,999,999,999,999,990') P_DA_SUCCESS_CNT, \n";
			strSql += " 	To_Char(P_DA_SUCCESS_AMT,'fm999,999,999,999,999,990') P_DA_SUCCESS_AMT, \n";
			strSql += " 	To_Char(Nvl(P_DA_REQ_CNT,0) - Nvl(P_DA_SUCCESS_CNT,0),'fm999,999,999,999,999,990')  P_DA_FAIL_CNT, \n";
			strSql += " 	To_Char(Nvl(P_DA_REQ_AMT,0) - Nvl(P_DA_SUCCESS_AMT,0),'fm999,999,999,999,999,990')  P_DA_FAIL_AMT, \n";
			strSql += " 	To_Char(P_DA_COMMISSION,'fm999,999,999,999,999,990') P_DA_COMMISSION, \n";
			strSql += " 	To_Char(P_TA_REQ_CNT,'fm999,999,999,999,999,990') P_TA_REQ_CNT, \n";
			strSql += " 	To_Char(P_TA_REQ_AMT,'fm999,999,999,999,999,990') P_TA_REQ_AMT, \n";
			strSql += " 	To_Char(P_TA_SUCCESS_CNT,'fm999,999,999,999,999,990') P_TA_SUCCESS_CNT, \n";
			strSql += " 	To_Char(P_TA_SUCCESS_AMT,'fm999,999,999,999,999,990') P_TA_SUCCESS_AMT, \n";
			strSql += " 	To_Char(Nvl(P_TA_REQ_CNT,0) - Nvl(P_TA_SUCCESS_CNT,0),'fm999,999,999,999,999,990')  P_TA_FAIL_CNT, \n";
			strSql += " 	To_Char(Nvl(P_TA_REQ_AMT,0) - Nvl(P_TA_SUCCESS_AMT,0),'fm999,999,999,999,999,990')  P_TA_FAIL_AMT, \n";
			strSql += " 	To_Char(P_TA_COMMISSION,'fm999,999,999,999,999,990') P_TA_COMMISSION, \n";
			strSql += " 	P_RESP_CODE,	P_RESP_MSG \n";
			strSql += " From \n";
			strSql += " 	( \n";
			strSql += " 		select * from table(F_T_retieve_pay_summation( ? , Replace(?,'-','') )) \n";
			strSql += " 	) \n";
			strSql += "  \n";
			strSql += "  ";
			
			lrArgData.addColumn("1BANK_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("2ACCT_NUMBER", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1BANK_CODE", strBANK_CODE);
			lrArgData.setValue("2ACCT_NUMBER", strACCT_NUMBER);
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