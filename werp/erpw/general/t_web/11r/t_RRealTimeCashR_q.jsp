<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 김흥수 작성(2006-02-16)
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
			String strPAY_YMD_F = CITCommon.toKOR(request.getParameter("PAY_YMD_F"));
			String strPAY_YMD_T = CITCommon.toKOR(request.getParameter("PAY_YMD_T"));
			
			strSql  = " Select \n";
			strSql += " 	'F' CHK_TAG, \n";
			strSql += " 	a.PAY_SEQ, \n";
			strSql += " 	a.OUT_ACCOUNT_NO, \n";
			strSql += " 	F_T_StringToYMDFormat(a.PAY_YMD) PAY_YMD, \n";
			strSql += " 	u.NAME, \n";
			strSql += " 	To_Char(a.CREATION_DATE,'YYYY-MM-DD HH24:MI:SS') CREATION_DATE , \n";
			strSql += " 	a.PAY_AMT, \n";
			strSql += " 	a.PAY_STATUS, \n";
			strSql += " 	a.DESCRIPTION, \n";
			strSql += " 	a.RESULT_TEXT, \n";
			strSql += " 	x.LOOKUP_VALUE PAY_STATUS_NAME \n";
			strSql += " From	T_FB_CASH_PAY_DATA a, \n";
			strSql += " 		Z_AUTHORITY_USER u, \n";
			strSql += " 		( \n";
			strSql += " 			Select \n";
			strSql += " 				x.LOOKUP_CODE , \n";
			strSql += " 				x.LOOKUP_VALUE \n";
			strSql += " 			From	T_FB_LOOKUP_VALUES x \n";
			strSql += " 			Where	x.LOOKUP_TYPE = 'CASH_PAY_STATUS' \n";
			strSql += " 		) x \n";
			strSql += " Where	a.COMP_CODE =  ?  \n";
			strSql += " And		a.PAY_DUE_YMD Between To_Char( ? ,'YYYYMMDD') And To_Char( ? ,'YYYYMMDD') \n";
			strSql += " And		a.CREATION_EMP_NO = u.EMPNO (+) \n";
			strSql += " And		a.PAY_STATUS = x.LOOKUP_CODE \n";
			strSql += " And		a.PAY_METHOD_GUBUN = 'R' \n";
			strSql += " And		Not Exists \n";
			strSql += " ( \n";
			strSql += " 	Select \n";
			strSql += " 		Null \n";
			strSql += " 	From	T_FB_CASH_PAY_HISTORY b \n";
			strSql += " 	Where	a.PAY_SEQ = b.PAY_SEQ \n";
			strSql += " 	And		b.EDI_HISTORY_SEQ Is Not Null \n";
			strSql += " ) \n";
			strSql += " And		Exists \n";
			strSql += " ( \n";
			strSql += " 	Select \n";
			strSql += " 		Null \n";
			strSql += " 	From	T_FB_CASH_PAY_DIVIDED_DATA b \n";
			strSql += " 	Where	a.PAY_SEQ = b.PAY_SEQ \n";
			strSql += " ) \n";
			strSql += "  ";
			
			lrArgData.addColumn("1COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("2PAY_YMD_F", CITData.DATE);
			lrArgData.addColumn("3PAY_YMD_T", CITData.DATE);
			lrArgData.addRow();
			lrArgData.setValue("1COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("2PAY_YMD_F", strPAY_YMD_F);
			lrArgData.setValue("3PAY_YMD_T", strPAY_YMD_T);
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
		else if (strAct.equals("PARAM"))
		{
			
			strSql  = " Select 0 PAY_SEQ From Dual Where 1 = 0 \n";
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