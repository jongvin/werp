<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id :
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 :
/* 4. 변  경  이  력 : 배민정 작성(2006-01-23)
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
			String	strACCNO_CODE = CITCommon.toKOR(request.getParameter("ACCNO_CODE"));

			strSql =
				"Select					"+"\r\n"+
				"	a.PAY_SEQ ,		"+"\r\n"+
				"	'F' SELECT_YN ,		"+"\r\n"+
				"	a.PAY_AMT  ,"+"\r\n"+
				"	a.PAY_KIND_GUBUN_NAME ,		"+"\r\n"+
				"	F_T_DATETOSTRING(a.PAY_DUE_YMD) PAY_DUE_YMD ,		"+"\r\n"+
				"	a.CUST_NAME , 	"+"\r\n"+					
				"	a.IN_BANK_CODE_NAME,	"+"\r\n"+
				"	a.IN_ACCOUNT_NO 		"+"\r\n"+				
				"From	VIEW_CASH_PAY_DATA a "+"\r\n"+
				"Where	a.COMP_CODE = ? "+"\r\n"+
				"And 	a.PAY_KIND_GUBUN like ?||'%' "+"\r\n"+
				"And 	a.PAY_STATUS IN ('2','5','6') "+"\r\n"+
				"And 	a.PAY_DUE_YMD = F_T_STRINGTODATE(?)  "+"\r\n"+
				"And 	a.OUT_BANK_CODE = ? "+"\r\n" +
				"And 	REPLACE(a.OUT_ACCOUNT_NO,'-','') = ? "+"\r\n" +
				"And 	a.EDI_CREATE_REQ_YN = 'N' "+"\r\n" +
//				"And 	NVL(a.PAY_METHOD_GUBUN ,'B') <> 'R' "+"\r\n" +
				"Order By	a.PAY_KIND_GUBUN ";

			lrArgData.addColumn("COMP_CODE",CITData.VARCHAR2);
			lrArgData.addColumn("PAY_GUBUN",CITData.VARCHAR2);
			lrArgData.addColumn("PAY_DUE_DATE",CITData.VARCHAR2);
			lrArgData.addColumn("BANK_CODE",CITData.VARCHAR2);
			lrArgData.addColumn("ACCNO_CODE",CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("COMP_CODE",strCOMP_CODE);
			lrArgData.setValue("PAY_GUBUN",strPAY_GUBUN);
			lrArgData.setValue("PAY_DUE_DATE",strPAY_DUE_DATE);
			lrArgData.setValue("BANK_CODE",strBANK_CODE);
			lrArgData.setValue("ACCNO_CODE",strACCNO_CODE);

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
		else if (strAct.equals("SUB01"))
		{
			String	strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String	strBANK_CODE = CITCommon.toKOR(request.getParameter("BANK_CODE"));
			
			strSql =
				"Select					"+"\r\n"+
				"	a.MAX_TRX_EDI_HISTORY_SEQ EDI_HISTORY_SEQ ,		"+"\r\n"+
				"	B.STD_YMD ,		"+"\r\n"+
				"	B.SEND_FILE_NAME ,		"+"\r\n"+
				"	'F' SELECT_YN ,		"+"\r\n"+
				"	C.BANK_MAIN_NAME OUT_BANK_CODE_NAME, "+"\r\n"+
				"	A.OUT_ACCOUNT_NO OUT_ACCOUNT_NO , "+"\r\n"+
				"	SUM(A.PAY_AMT) PAY_AMT ,		"+"\r\n"+
				"	COUNT(A.PAY_SEQ) EDI_CNT , "+"\r\n"+					
				"	F_T_DATETOSTRING(B.SEND_DATE) SEND_DATE ,	"+"\r\n"+
				"	F_T_DATETOSTRING(B.RECV_DATE) RECV_DATE,	"+"\r\n"+
				"	B.RESULT_TEXT	"+"\r\n"+
				"From	VIEW_CASH_PAY_DATA a, "+"\r\n"+
				" T_FB_EDI_HISTORY   b, "+"\r\n"+
				" T_BANK_MAIN        c  "+"\r\n"+
				"Where	a.MAX_TRX_EDI_HISTORY_SEQ = b.EDI_HISTORY_SEQ "+"\r\n"+
				"AND  B.BANK_CODE = c.BANK_MAIN_CODE (+) "+"\r\n"+
				"And 	B.COMP_CODE = ? "+"\r\n"+
				"And 	B.BANK_CODE = ? "+"\r\n"+
				"And 	B.CASH_BILL_GUBUN = 'C' "+"\r\n"+
			  "GROUP BY a.MAX_TRX_EDI_HISTORY_SEQ ,"+"\r\n"+
        "B.STD_YMD,         "+"\r\n"+  
        "B.SEND_FILE_NAME,  "+"\r\n"+
        "C.BANK_MAIN_NAME , "+"\r\n"+
        "A.OUT_ACCOUNT_NO,  "+"\r\n"+
        "B.SEND_DATE ,      "+"\r\n"+
        "B.RECV_DATE ,      "+"\r\n"+
        "B.RESULT_TEXT      "+"\r\n"+
        "HAVING MAX(A.PAY_STATUS) in ('3','5','6') "+"\r\n"+
        "ORDER BY a.MAX_TRX_EDI_HISTORY_SEQ DESC " ; 

			lrArgData.addColumn("COMP_CODE",CITData.VARCHAR2);
			lrArgData.addColumn("BANK_CODE",CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("COMP_CODE",strCOMP_CODE);
			lrArgData.setValue("BANK_CODE",strBANK_CODE);
			
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
				GauceInfo.response.writeException("USER", "900001","SUB01 Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("BANK"))
		{
			String	strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
					
			strSql  = 
				"select "+"\n"+
				"	a.BANK_MAIN_CODE  CODE, "+"\n"+
				"	a.BANK_MAIN_NAME NAME  "+"\n"+
				"from	VIEW_FBS_ACCOUNTS a "+"\n"+
				"where a.COMP_CODE = ? "+"\n"+
				"and   a.BANK_MAIN_CODE = '20' "+"\n"+
				"and   a.FBS_TRANSFER_CLS = 'T' "+"\n"+
				"group by"+"\n"+
				"	a.BANK_MAIN_CODE , "+"\n"+ 
				"	a.BANK_MAIN_NAME "+"\n";
			
			lrArgData.addColumn("COMP_CODE",CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("COMP_CODE",strCOMP_CODE);
	
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();				
			}
			catch(Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001","SUB01 Select 오류-> "+ ex.getMessage());
			}
		}				
		else if (strAct.equals("ACCOUNT"))
		{
			String	strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String	strBANK_CODE = CITCommon.toKOR(request.getParameter("BANK_CODE"));
					
			strSql  = 
				"select "+"\n"+
				"	a.NAIVE_ACCOUNT_NUMBER  CODE, "+"\n"+
				"	a.ACCOUNT_NUMBER NAME  "+"\n"+
				"from	VIEW_FBS_ACCOUNTS a "+"\n"+
				"where a.COMP_CODE = ? "+"\n"+
				"and  a.BANK_MAIN_CODE = ? "+"\n"+
				"and  a.FBS_TRANSFER_CLS = 'T' "+"\n"+
				"group by"+"\n"+
				"	a.NAIVE_ACCOUNT_NUMBER , "+"\n"+ 
				"	a.ACCOUNT_NUMBER "+"\n";
			
			lrArgData.addColumn("COMP_CODE",CITData.VARCHAR2);
			lrArgData.addColumn("BANK_CODE",CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("COMP_CODE",strCOMP_CODE);
			lrArgData.setValue("BANK_CODE",strBANK_CODE);
		
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();				
			}
			catch(Exception ex) 
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001","SUB01 Select 오류-> "+ ex.getMessage());
			}
		}	
		else if (strAct.equals("PASS"))
		{
			String	strEMP_NO= CITCommon.toKOR(request.getParameter("EMP_NO"));
			String	strMANAGER_PASS1= CITCommon.toKOR(request.getParameter("MANAGER_PASS1"));
			String	strMANAGER_PASS2= CITCommon.toKOR(request.getParameter("MANAGER_PASS2"));  
			
			strSql  = " Select FBS_UTIL_PKG.format_msg(FBS_UTIL_PKG.do_pwd_job('CHK_MNG_PW',?,?,?)) RET_MSG from dual \n";
			
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
		else if (strAct.equals("COPY"))
		{
			strSql  = 
				"select "+"\n"+
				"	'XXXXXXXXXXXXXXXX' PAY_SEQ , "+"\n"+
				"	'XX' COMP_CODE,  "+"\n"+
				"	'XX' PAY_GUBUN,  "+"\n"+
				"	'XXXXXXXXXX' PAY_YMD,  "+"\n"+
				"	'XX' BANK_CODE,  "+"\n"+
				"	'XXXXXXXXXXXXXXXX' ACCOUNT_NO , "+"\n"+
				"	RPAD('X',50,'X') FILE_NAME  "+"\n"+
				"from	dual "+"\n";
			
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
		else if (strAct.equals("DateChk"))
		{
			String	strDT_T= CITCommon.toKOR(request.getParameter("DT_T"));
			
			strSql  = " Select F_T_STRINGTODATE(?) - TO_DATE(TO_CHAR(SYSDATE,'YYYYMMDD'),'YYYYMMDD') DAYS from dual \n";
			
			lrArgData.addColumn("DT_T", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("DT_T", strDT_T);
			
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
				GauceInfo.response.writeException("USER", "900001","DateChk Select 오류-> "+ ex.getMessage());
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