<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 배민정 작성(2006-01-20)
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
			String	strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String	strPAY_GUBUN = CITCommon.toKOR(request.getParameter("PAY_GUBUN"));
			String	strPAY_DUE_DATE = CITCommon.toKOR(request.getParameter("PAY_DUE_DATE"));
			String	strBANK_CODE = CITCommon.toKOR(request.getParameter("BANK_CODE"));
			String	strPAY_STATUS = CITCommon.toKOR(request.getParameter("PAY_STATUS"));

				strSql =
					"Select					"+"\r\n"+
					"	a.PAY_SEQ ,		"+"\r\n"+
					"	'F' SELECT_YN ,		"+"\r\n"+
					"	a.PAY_AMT, 		"+"\r\n"+
					"	a.PAY_KIND_GUBUN_NAME ,		"+"\r\n"+
					"	F_T_DATETOSTRING(a.PAY_DUE_YMD) PAY_DUE_YMD ,		"+"\r\n"+
					"	a.CHECK_NO ,		"+"\r\n"+
					"	F_T_DATETOSTRING(a.FUTURE_PAY_DUE_YMD) FUTURE_YMD ,			"+"\r\n"+
					"	a.PAY_STATUS_NAME ,			"+"\r\n"+
					"	a.PAY_STATUS ,			"+"\r\n"+
					"	b.VAT_REGISTRATION_NUM  REGIST_NUM ,			"+"\r\n"+
					"	b.BANK_CODE   ,			"+"\r\n"+
					"	REPLACE(b.ACCOUNT_NO,'-','') ACCOUNT_NO ,	"+"\r\n"+
					"	b.FRANCHISE_NO,			"+"\r\n"+
					"	a.CUST_NAME ,	"+"\r\n"+
					"	a.DESCRIPTION , 	"+"\r\n"+
					"	a.OUT_BANK_CODE,	"+"\r\n"+
					"	a.OUT_BANK_CODE_NAME,	"+"\r\n"+
					"	a.OUT_ACCOUNT_NO,	"+"\r\n"+	
					"	a.NAIVE_OUT_ACCOUNT_NO,	"+"\r\n"+										
					"	a.APPROVAL_NO , 	"+"\r\n"+
					"	a.RESULT_TEXT , 	"+"\r\n"+
					"	a.COMPANY_NAME 	"+"\r\n"+
					"From	VIEW_BILL_PAY_DATA a , "+"\r\n"+
					"     T_FB_BILL_VENDORS b "+"\r\n"+
					"Where	a.VAT_REGISTRATION_NUM = b.VAT_REGISTRATION_NUM "+"\r\n"+
					"And  a.COMP_CODE = ? "+"\r\n"+
					"And 	a.PAY_KIND_GUBUN like ?||'%' "+"\r\n"+
					"And 	a.PAY_DUE_YMD = F_T_STRINGTODATE(?) "+"\r\n"+
					"And 	a.OUT_BANK_CODE = ? "+"\r\n"+
					"And 	a.PAY_STATUS = ? "+"\r\n"+
//					"And 	NVL(a.PAY_METHOD_GUBUN,'R') <> 'B' "+"\r\n" +
					"Order By	a.PAY_KIND_GUBUN ";

			lrArgData.addColumn("COMP_CODE",CITData.VARCHAR2);
			lrArgData.addColumn("PAY_GUBUN",CITData.VARCHAR2);
			lrArgData.addColumn("PAY_DUE_DATE",CITData.VARCHAR2);
			lrArgData.addColumn("BANK_CODE",CITData.VARCHAR2);
			lrArgData.addColumn("PAY_STATUS",CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("COMP_CODE",strCOMP_CODE);
			lrArgData.setValue("PAY_GUBUN",strPAY_GUBUN);
			lrArgData.setValue("PAY_DUE_DATE",strPAY_DUE_DATE);
			lrArgData.setValue("BANK_CODE",strBANK_CODE);
			lrArgData.setValue("PAY_STATUS",strPAY_STATUS);

			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
		}
		else if (strAct.equals("COPY"))
		{			
			strSql  = " Select 0 PAY_SEQ ,       "+"\r\n"+ 
			          "        'XX' OUT_BANK_CODE , "+"\r\n"+ 
			          "        rpad('',20,'X') OUT_ACCOUNT_NO , "+"\r\n"+ 
			          "        'XX' BANK_CODE , "+"\r\n"+ 
			          "        rpad('',20,'X') ACCOUNT_NO , "+"\r\n"+ 
			          "        rpad('',20,'X') REGIST_NUM , "+"\r\n"+ 
			          "        rpad('',20,'X') CHECK_NO , "+"\r\n"+ 
			          "        rpad('',20,'X') FUTURE_YMD , "+"\r\n"+ 
			          "        rpad('',20,'X') PAY_AMT , "+"\r\n"+ 
			          "        rpad('',20,'X') FRANCHISE_NO  "+"\r\n"+ 
			          " from dual ";

			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

		}
		else if (strAct.equals("MSG"))
		{			
			String	strPAY_SEQ= CITCommon.toKOR(request.getParameter("PAY_SEQ"));
			
			strSql  = " Select f_real_status(?,'B') STATUS from dual \n";

			lrArgData.addColumn("PAY_SEQ", CITData.NUMBER);			
			lrArgData.addRow();
			lrArgData.setValue("PAY_SEQ", strPAY_SEQ);
			
			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
		} 				
		else if (strAct.equals("PASS"))
		{
			String	strEMP_NO= CITCommon.toKOR(request.getParameter("EMP_NO"));
			String	strMANAGER_PASS1= CITCommon.toKOR(request.getParameter("MANAGER_PASS1"));
			String	strMANAGER_PASS2= CITCommon.toKOR(request.getParameter("MANAGER_PASS2")); 
			
			strSql  = " Select FBS_UTIL_PKG.format_msg(FBS_UTIL_PKG.do_pwd_job('CHK_CASH_PW',?,?,?)) RET_MSG from dual \n";
			
			lrArgData.addColumn("EMP_NO", CITData.VARCHAR2);
			lrArgData.addColumn("MANAGER_PASS1", CITData.VARCHAR2);
			lrArgData.addColumn("MANAGER_PASS2", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("EMP_NO", strEMP_NO);
			lrArgData.setValue("MANAGER_PASS1", strMANAGER_PASS1);
			lrArgData.setValue("MANAGER_PASS2", strMANAGER_PASS2);
			
			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

		}			
		try
		{
			lrDataset = CITCommon.toGauceDataSet(lrReturnData);
			GauceInfo.response.enableFirstRow(lrDataset);
			lrDataset.flush();
		}
		catch (Exception ex)
		{
			GauceInfo.response.writeException("USER", "900001", ex.getMessage());
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