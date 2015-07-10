<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 홍길동 작성(2005-11-17)
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
			
			//strSql  = " Select	A.CUST_SEQ , \n";
			strSql  = " Select	/*+ parallel(t_cust_code 4) */ A.CUST_SEQ , \n";
			strSql += "       	A.CRTUSERNO , \n";
			strSql += "       	A.CRTDATE , \n";
			strSql += "       	A.MODUSERNO , \n";
			strSql += "       	A.MODDATE , \n";
			strSql += "       	F_T_CUST_MASK(A.CUST_CODE) CUST_CODE , \n";
			strSql += "       	A.CUST_NAME , \n";
			strSql += "       	A.BOSS_NAME , \n";
			strSql += "       	A.TRADE_CLS , \n";
			strSql += "       	A.BIZCOND , \n";
			strSql += "       	A.BIZKND , \n";
			strSql += "       	F_T_ZIP_MASK(A.ZIPCODE) ZIPCODE , \n";
			strSql += "       	A.ADDR1 , \n";
			strSql += "       	A.ADDR2 , \n";
			strSql += "       	A.TELNO , \n";
			strSql += "       	A.GROUP_COMP_CLS , \n";
			strSql += "       	A.REPRESENT_CUST_SEQ , \n";
			strSql += "       	F_T_CUST_MASK(B.CUST_CODE) REPRESENT_CUST_CODE , \n";
			strSql += "       	B.CUST_NAME REPRESENT_CUST_NAME , \n";
			strSql += "       	A.USE_CLS \n";
			strSql += " From	T_CUST_CODE A, \n";
			strSql += " 		T_CUST_CODE B \n";
			strSql += " Where	A.CUST_SEQ = B.REPRESENT_CUST_SEQ(+) \n";
			strSql += " And	A.TRADE_CLS Like  '%'||  ?  ||'%' \n";
			strSql += " And	A.CUST_NAME Like '%'||  ?  ||'%' ";
			
			lrArgData.addColumn("TRADE_CLS", CITData.VARCHAR2);
			lrArgData.addColumn("CUST_NAME", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("TRADE_CLS", strTRADE_CLS);
			lrArgData.setValue("CUST_NAME", strCUST_NAME);
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("CUST_SEQ", true);
				lrReturnData.setNotNull("CUST_CODE", true);
				lrReturnData.setNotNull("CUST_NAME", true);
				lrReturnData.setNotNull("TRADE_CLS", true);
				lrReturnData.setNotNull("GROUP_COMP_CLS", true);
				lrReturnData.setNotNull("USE_CLS", true);
				
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001","T_CUST_CODE Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("CUST_SEQ"))
		{
			
			strSql  = " Select SQ_T_CUST_SEQ.nextval as CUST_SEQ from dual ";
			
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
				GauceInfo.response.writeException("USER", "900001","T_CUST_ACCNO_CODE Select 오류-> "+ ex.getMessage());
			}
		}
		if (strAct.equals("CUST_CODE"))
		{
			String strCUST_CODE = CITCommon.toKOR(request.getParameter("CUST_CODE"));
			
			strSql  = " Select	A.CUST_CODE \n";
			strSql += " From	T_CUST_CODE A \n";
			strSql += " Where	A.CUST_CODE =  ?  ";
			
			lrArgData.addColumn("CUST_CODE", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("CUST_CODE", strCUST_CODE);
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
		
		else if (strAct.equals("PAY_STOP"))
		{
			
			String strCUST_SEQ = CITCommon.toKOR(request.getParameter("CUST_SEQ"));
			
			strSql  = " SELECT  A.CUST_SEQ, \n";
			strSql += "         A.PAY_STOP_SEQ, \n";
			strSql += "         A.CRTUSERNO, \n";
			strSql += "         A.CRTDATE, \n";
			strSql += "         A.MODUSERNO, \n";
			strSql += "         A.MODDATE, \n";
			strSql += "         A.PAY_STOP_CLS, \n";
			strSql += "         F_T_DATETOSTRING(A.PAY_STOPSTR_DT) PAY_STOPSTR_DT, \n";
			strSql += "         F_T_DATETOSTRING(A.PAY_STOPEND_DT) PAY_STOPEND_DT, \n";
			strSql += "         A.PAY_STOPSTR_MEMO, \n";
			strSql += "         A.PAY_STOPEND_MEMO, \n";
			strSql += "         A.DEPT_CODE, \n";
			strSql += "         B.DEPT_NAME \n";
			strSql += "  FROM   T_PAY_STOP_HISTORY A, \n";
			strSql += "         T_DEPT_CODE B \n";
			strSql += " WHERE   A.DEPT_CODE = B.DEPT_CODE(+) \n";
			strSql += " AND		A.CUST_SEQ =  ?  \n";
			strSql += " ORDER BY PAY_STOP_SEQ desc ";
			
			lrArgData.addColumn("CUST_SEQ", CITData.NUMBER);
			lrArgData.addRow();
			lrArgData.setValue("CUST_SEQ", strCUST_SEQ);
			
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("CUST_SEQ", true);
				lrReturnData.setKey("PAY_STOP_SEQ", true);
				lrReturnData.setNotNull("PAY_STOP_CLS", true);
				lrReturnData.setNotNull("PAY_STOPSTR_DT", true);
				lrReturnData.setNotNull("PAY_STOPSTR_MEMO", true);
				lrReturnData.setNotNull("DEPT_CODE", true);
				lrReturnData.setNotNull("DEPT_NAME", true);
				
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001","dsPAY_STOP Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("CUST_PAYSTOP_SEQ"))
		{
			strSql  = " SELECT SQ_T_PAY_STOP_HISTORY_SEQ.NextVal PAY_STOP_SEQ FROM dual ";
		 	
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
				GauceInfo.response.writeException("USER", "900001","CUST_PAYSTOP_SEQ Select 오류-> "+ ex.getMessage());
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