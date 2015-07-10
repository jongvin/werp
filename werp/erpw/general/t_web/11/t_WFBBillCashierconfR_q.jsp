<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 배민정 작성(2006-01-17)
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
			String	strCOMP_CODE= CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String	strPAY_GUBUN= CITCommon.toKOR(request.getParameter("PAY_GUBUN"));
			String	strPAY_STATUS= CITCommon.toKOR(request.getParameter("PAY_STATUS"));
			String	strBANK_CODE= CITCommon.toKOR(request.getParameter("BANK_CODE"));
			String	strDT_F= CITCommon.toKOR(request.getParameter("DT_F"));
			String	strDT_T= CITCommon.toKOR(request.getParameter("DT_T"));
			String	strCUST_SEQ= CITCommon.toKOR(request.getParameter("CUST_CODE"));
//			String	strDT_F1= CITCommon.toKOR(request.getParameter("DT_F1"));
//			String	strDT_T1= CITCommon.toKOR(request.getParameter("DT_T1"));
			String	strMETHOD_CODE= CITCommon.toKOR(request.getParameter("METHOD_CODE"));

			{
				strSql =
					"Select					"+"\r\n"+
					"	a.PAY_SEQ ,		"+"\r\n"+
					"	'F' SELECT_YN ,		"+"\r\n"+
					"	TO_CHAR(a.PAY_AMT, 'FM9,999,999,999,999') PAY_AMT ,		"+"\r\n"+
					"	a.PAY_KIND_GUBUN_NAME ,		"+"\r\n"+
					"	a.PAY_STATUS_NAME ,			"+"\r\n"+
					"	a.PAY_STATUS ,			"+"\r\n"+
					"	F_T_DATETOSTRING(a.PAY_DUE_YMD) PAY_DUE_YMD ,		"+"\r\n"+
					"	F_T_DATETOSTRING(a.PAY_YMD) PAY_YMD ,		"+"\r\n"+					
					"	F_T_DATETOSTRING(a.FUTURE_PAY_DUE_YMD) FUTURE_YMD ,			"+"\r\n"+
					"	a.VAT_REGISTRATION_NUM  REGIST_NUM ,			"+"\r\n"+
					"	a.CUST_NAME CUST_NAME ,	"+"\r\n"+
					"	a.CHECK_NO ,		"+"\r\n"+
					"	a.OUT_BANK_CODE_NAME,	"+"\r\n"+
					"	a.DESCRIPTION , 	"+"\r\n"+
					"	a.COMPANY_NAME , 	"+"\r\n"+
					"	F_T_DATETOSTRING(a.CASHIER_CONFIRM_DATE) CASHIER_CONFIRM_DATE , 	"+"\r\n"+
					"	a.SLIP_ID||SLIP_IDSEQ SLIP_ID, 	"+"\r\n"+
					"	a.PAY_METHOD_GUBUN , 	"+"\r\n"+
					"	a.APPROVAL_NO , 	"+"\r\n"+
					"	a.RESULT_TEXT , 	"+"\r\n"+
					"	NVL(b.CONTRACT_GUBUN ,'C') CONTRACT_GUBUN , 	"+"\r\n"+
					"	F_T_DATETOSTRING(a.LAST_RECV_DATE ) LAST_RECV_DATE "+"\r\n"+
					"From	VIEW_BILL_PAY_DATA a , "+"\r\n"+
					"     T_FB_BILL_VENDORS  b "+"\r\n"+
					"Where	a.VAT_REGISTRATION_NUM = b.VAT_REGISTRATION_NUM(+) "+"\r\n"+
					"And  a.COMP_CODE = ? "+"\r\n"+
					"And 	a.PAY_KIND_GUBUN like ?||'%' "+"\r\n"+
					"And 	a.PAY_STATUS = ? "+"\r\n"+
					"And 	a.OUT_BANK_CODE = ? "+"\r\n"+
					"And 	a.PAY_DUE_YMD BETWEEN F_T_STRINGTODATE(?) AND F_T_STRINGTODATE(?) "+"\r\n";
					if(!"".equals(strCUST_SEQ)) 
					strSql += "And 	a.CUST_SEQ = ? "+"\r\n" ;
//					if(!"".equals(strDT_F1)) 
//					strSql += "And 	a.PAY_YMD BETWEEN F_T_STRINGTODATE(?) AND F_T_STRINGTODATE(?) "+"\r\n" ;
					if(!"%".equals(strMETHOD_CODE)) strSql += "And 	a.PAY_METHOD_GUBUN = ? "+"\r\n";
//					strSql += "And	b.CONTRACT_GUBUN IN ( 'N','M') "+"\r\n";
					strSql += "Order By	a.PAY_KIND_GUBUN ";
			}

			lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("PAY_GUBUN", CITData.VARCHAR2);
			lrArgData.addColumn("PAY_STATUS", CITData.VARCHAR2);
			lrArgData.addColumn("BANK_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("DT_F", CITData.VARCHAR2);
			lrArgData.addColumn("DT_T", CITData.VARCHAR2);
			if(!"".equals(strCUST_SEQ)) lrArgData.addColumn("CUST_CODE", CITData.VARCHAR2);
//			if(!"".equals(strDT_F1)) lrArgData.addColumn("DT_F1", CITData.VARCHAR2);
//			if(!"".equals(strDT_T1)) lrArgData.addColumn("DT_T1", CITData.VARCHAR2);
			if(!"%".equals(strMETHOD_CODE)) lrArgData.addColumn("METHOD_CODE", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("PAY_GUBUN", strPAY_GUBUN);
			lrArgData.setValue("PAY_STATUS", strPAY_STATUS);
			lrArgData.setValue("BANK_CODE", strBANK_CODE);
			lrArgData.setValue("DT_F", strDT_F);
			lrArgData.setValue("DT_T", strDT_T);
			if(!"".equals(strCUST_SEQ)) lrArgData.setValue("CUST_CODE", strCUST_SEQ);
//			if(!"".equals(strDT_F1)) lrArgData.setValue("DT_F1", strDT_F1);
//			if(!"".equals(strDT_T1)) lrArgData.setValue("DT_T1", strDT_T1);
			if(!"%".equals(strMETHOD_CODE)) lrArgData.setValue("METHOD_CODE", strMETHOD_CODE);

			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

			try
			{
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
		else if (strAct.equals("COPY"))
		{
			
			strSql  = " Select 0 PAY_SEQ from dual \n";
			
			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
		
			try
			{
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001","COPY Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("MAKE"))
		{
			
			strSql  = " Select 'XX' COMP_CODE , 'XXXXXXXX' FROM_DATE , 'XXXXXXXX' TO_DATE from dual \n";
			
			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
		
			try
			{
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001","MAKE Select 오류-> "+ ex.getMessage());
			}
		}		
		else if (strAct.equals("PASS"))
		{
			String	strEMP_NO= CITCommon.toKOR(request.getParameter("EMP_NO"));
			String	strMANAGER_PASS1= CITCommon.toKOR(request.getParameter("MANAGER_PASS1"));
			String	strMANAGER_PASS2= CITCommon.toKOR(request.getParameter("MANAGER_PASS2")); 
			
			strSql  = " Select FBS_UTIL_PKG.format_msg(FBS_UTIL_PKG.do_pwd_job('CHK_BILL_PW',?,?,?)) RET_MSG from dual \n";
			
			lrArgData.addColumn("EMP_NO", CITData.VARCHAR2);
			lrArgData.addColumn("MANAGER_PASS1", CITData.VARCHAR2);
			lrArgData.addColumn("MANAGER_PASS2", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("EMP_NO", strEMP_NO);
			lrArgData.setValue("MANAGER_PASS1", strMANAGER_PASS1);
			lrArgData.setValue("MANAGER_PASS2", strMANAGER_PASS2);
			
			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
		
			try
			{
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001","PASS Select 오류-> "+ ex.getMessage());
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
