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

			String strTRADE_CLS = CITCommon.toKOR(request.getParameter("TRADE_CLS"));
			String strCUST_NAME = CITCommon.toKOR(request.getParameter("CUST_NAME"));
			
			strSql  = " SELECT \n";
			strSql += " 			A.CUST_SEQ, \n";
			strSql += " 			F_T_CUST_MASK(A.CUST_CODE) CUST_CODE, \n";
			strSql += " 			A.CUST_NAME, \n";
			strSql += " 			A.BOSS_NAME, \n";
			strSql += " 			A.TRADE_CLS, \n";
			strSql += " 			C.CODE_LIST_NAME TRADE_CLS_NAME \n";
			strSql += " FROM  T_CUST_CODE  A, \n";
			strSql += "       T_CODE_GROUP B, \n";
			strSql += " 			T_CODE_LIST  C 	\n";
			strSql += " WHERE	B.CODE_GROUP_NO = C.CODE_GROUP_NO \n";
			strSql += " AND		A.TRADE_CLS = C.CODE_LIST_ID \n";
			strSql += " AND		B.CODE_GROUP_ID = 'TRADE_CLS' \n";
			strSql += " AND		C.USE_TAG = 'T' \n";
			strSql += " AND	  A.TRADE_CLS Like '%'|| ? ||'%' \n";
			strSql += " AND	  A.CUST_NAME Like '%'|| ? ||'%' \n";
			
			lrArgData.addColumn("TRADE_CLS", CITData.VARCHAR2);
			lrArgData.addColumn("CUST_NAME", CITData.VARCHAR2);
			lrArgData.addRow();                                   
			lrArgData.setValue("TRADE_CLS", strTRADE_CLS);
			lrArgData.setValue("CUST_NAME", strCUST_NAME);
			
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
		
		else if (strAct.equals("LIST"))
		{
			String strCUST_SEQ = CITCommon.toKOR(request.getParameter("CUST_SEQ"));
			
			strSql  = " SELECT  A.CUST_SEQ, \n";
			strSql += "         B.ACCNO, \n";
			strSql += "         B.BANK_MAIN_CODE, \n";
			strSql += "         C.BANK_MAIN_NAME, \n";
			strSql += "         B.ACCNO_OWNER, \n";
			strSql += "         B.ACCNO_CLS, \n";
			strSql += "         B.USE_TG, \n";
			strSql += "         B.CRTUSERNO \n";
			strSql += " FROM    T_CUST_CODE A, \n";
			strSql += "         T_CUST_ACCNO_CODE B, \n";
			strSql += "         T_BANK_MAIN C \n";
			strSql += " WHERE   A.CUST_SEQ = B.CUST_SEQ \n";
			strSql += " AND     B.BANK_MAIN_CODE = C.BANK_MAIN_CODE \n";
			strSql += " AND     B.USE_TG = 'T' \n";
			strSql += " AND	  	A.CUST_SEQ Like '%'|| ? ||'%' \n";
			
			lrArgData.addColumn("CUST_SEQ", CITData.VARCHAR2);
			lrArgData.addRow();                                   
			lrArgData.setValue("CUST_SEQ", strCUST_SEQ);
			
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("CUST_SEQ", true);
				lrReturnData.setKey("ACCNO", true);
				lrReturnData.setNotNull("CUST_SEQ", true);
				lrReturnData.setNotNull("ACCNO", true);
				lrReturnData.setNotNull("BANK_MAIN_NAME", true);
				lrReturnData.setNotNull("BANK_MAIN_CODE", true);
				lrReturnData.setNotNull("ACCNO_OWNER", true);
				
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
		
		else if (strAct.equals("ACCNO_CLS"))
		{

			strSql  = "Select   \n";
			strSql  += "	a.CODE_LIST_ID,   \n";
			strSql  += "	a.CODE_LIST_NAME,   \n";
			strSql  += "	a.SEQ   \n";
			strSql  += "From	V_T_CODE_LIST a   \n";
			strSql  += "Where	a.CODE_GROUP_ID = 'ACCNO_CLS'   \n";
			strSql  += "And		a.USE_TAG = 'T'   \n";
			strSql  += "Order By   \n";
			strSql  += "	3";


			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);




				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo != null)
				{
					GauceInfo.response.writeException("USER", "900001","BANK_CLS Select 오류-> "+ ex.getMessage());
				}
				else
				{
					throw new Exception("USER-900001:BANK_CLS Select 오류 -> " + ex.getMessage());
				}
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