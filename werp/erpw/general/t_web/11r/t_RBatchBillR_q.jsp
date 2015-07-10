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
			strSql += " 	a.EDI_HISTORY_SEQ PAY_SEQ, \n";
			strSql += " 	bn.BANK_MAIN_NAME OUT_ACCOUNT_NO, \n";
			strSql += " 	F_T_StringToYMDFormat(a.STD_YMD) PAY_YMD, \n";
			strSql += " 	u.NAME, \n";
			strSql += " 	To_Char(a.CREATION_DATE,'YYYY-MM-DD HH24:MI:SS') CREATION_DATE , \n";
			strSql += " 	( \n";
			strSql += " 		Select \n";
			strSql += " 			Sum(l.PAY_AMT) \n";
			strSql += " 		From	T_FB_BILL_PAY_DATA l \n";
			strSql += " 		Where	l.PAY_SEQ In \n";
			strSql += " 		( \n";
			strSql += " 			Select \n";
			strSql += " 				k.PAY_SEQ  \n";
			strSql += " 			From	T_FB_BILL_PAY_HISTORY k \n";
			strSql += " 			Where	k.EDI_HISTORY_SEQ = a.EDI_HISTORY_SEQ \n";
			strSql += " 		) \n";
			strSql += " 	) PAY_AMT, \n";
			strSql += " 	'' PAY_STATUS, \n";
			strSql += " 	a.SEND_FILE_NAME DESCRIPTION, \n";
			strSql += " 	a.RESULT_TEXT, \n";
			strSql += " 	'성공금액: '||to_char(a.PAY_SUCCESS_AMT,'fm999,999,999,999,999,990')||' '|| \n";
			strSql += " 	 '실패금액: '||to_char(a.PAY_FAIL_AMT,'fm999,999,999,999,999,990') PAY_STATUS_NAME \n";
			strSql += " From	T_FB_EDI_HISTORY a, \n";
			strSql += " 		Z_AUTHORITY_USER u, \n";
			strSql += " 		T_BANK_MAIN bn \n";
			strSql += " Where	a.CREATION_EMP_NO = u.EMPNO (+) \n";
			strSql += " And		a.CASH_BILL_GUBUN = 'B' \n";
			strSql += " And		a.COMP_CODE =   ?  \n";
			strSql += " And		a.STD_YMD Between To_Char(  ?  ,'YYYYMMDD') And To_Char(  ?  ,'YYYYMMDD') \n";
			strSql += " And		a.RECV_DATE IS NOT NULL  \n";
			strSql += " And		a.BANK_CODE = bn.BANK_MAIN_CODE \n";
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