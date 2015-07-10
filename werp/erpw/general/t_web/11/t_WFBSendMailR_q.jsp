<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 김흥수 작성(2006-01-18)
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
			String strPAY_DUE_YMD = CITCommon.toKOR(request.getParameter("PAY_DUE_YMD"));
			String strMAIL_SEND_YN = CITCommon.toKOR(request.getParameter("MAIL_SEND_YN"));
			String strVAT_REGISTRATION_NUM = CITCommon.toKOR(request.getParameter("VAT_REGISTRATION_NUM"));
			strPAY_DUE_YMD = strPAY_DUE_YMD.replaceAll("-","");
			
			strSql  = " Select \n";
			strSql += " 	'F' CHK , \n";
			strSql += " 	a.MAIL_SEQ , \n";
			strSql += " 	a.PAY_DUE_YMD , \n";
			strSql += " 	a.VAT_REGISTRATION_NUM , \n";
			strSql += " 	F_T_CUST_MASK(a.VAT_REGISTRATION_NUM) VAT_REGISTRATION_NUM_MASK, \n";
			strSql += " 	a.VENDOR_NAME , \n";
			strSql += " 	To_Char(a.MAIL_SEND_DATE,'YYYY-MM-DD HH24MISS') MAIL_SEND_DATE , \n";
			strSql += " 	a.MAIL_SEND_YN , \n";
			strSql += " 	SubStrb(Decode(a.MAIL_SEND_YN,'N','미발신','Y','발신성공','F','발신실패'),1,50) MAIL_SEND_YN_NAME, \n";
			strSql += " 	a.MAIL_SEND_RESULT_MSG , \n";
			strSql += " 	a.COMP_CODE , \n";
			strSql += " 	a.CREATION_DATE , \n";
			strSql += " 	a.CREATION_EMP_NO , \n";
			strSql += " 	a.LAST_MODIFY_DATE , \n";
			strSql += " 	a.LAST_MODIFY_EMP_NO , \n";
			strSql += " 	a.TR_MANAGER_NAME , \n";
			strSql += " 	a.TR_MANAGER_EMAIL, \n";
			strSql += " 	Sum(Decode(b.CASH_BILL_GUBUN,'C',b.PAY_AMT)) C_AMT, \n";
			strSql += " 	Sum(Decode(b.CASH_BILL_GUBUN,'B',b.PAY_AMT)) B_AMT, \n";
			strSql += " 	Sum(Decode(b.CASH_BILL_GUBUN,'P',b.PAY_AMT)) P_AMT, \n";
			strSql += " 	Sum(Decode(b.CASH_BILL_GUBUN,'N',b.PAY_AMT)) N_AMT \n";
			strSql += " From	T_FB_PAYDUE_MAIL_MASTER a, \n";
			strSql += " 		T_FB_PAYDUE_MAIL_DETAIL b \n";
			strSql += " Where	a.COMP_CODE =  ?  \n";
			strSql += " And		a.PAY_DUE_YMD =  ?  \n";
			strSql += " And		a.MAIL_SEND_YN Like  ?  \n";
			if(!"".equals(strVAT_REGISTRATION_NUM))
			strSql += " And		a.VAT_REGISTRATION_NUM Like F_T_CUST_UMASK( ? ) \n";
			strSql += " And		a.MAIL_SEQ = b.MAIL_SEQ \n";
			strSql += " Group By \n";
			strSql += " 	a.MAIL_SEQ , \n";
			strSql += " 	a.PAY_DUE_YMD , \n";
			strSql += " 	a.VAT_REGISTRATION_NUM , \n";
			strSql += " 	a.VENDOR_NAME , \n";
			strSql += " 	a.MAIL_SEND_DATE, \n";
			strSql += " 	a.MAIL_SEND_YN , \n";
			strSql += " 	a.MAIL_SEND_RESULT_MSG , \n";
			strSql += " 	a.COMP_CODE , \n";
			strSql += " 	a.CREATION_DATE , \n";
			strSql += " 	a.CREATION_EMP_NO , \n";
			strSql += " 	a.LAST_MODIFY_DATE , \n";
			strSql += " 	a.LAST_MODIFY_EMP_NO , \n";
			strSql += " 	a.TR_MANAGER_NAME , \n";
			strSql += " 	a.TR_MANAGER_EMAIL \n";
			strSql += " Order By \n";
			strSql += " 	a.MAIL_SEQ \n";
			strSql += "  ";
			
			lrArgData.addColumn("1COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("2PAY_DUE_YMD", CITData.VARCHAR2);
			lrArgData.addColumn("3MAIL_SEND_YN", CITData.VARCHAR2);
			if(!"".equals(strVAT_REGISTRATION_NUM)) lrArgData.addColumn("4VAT_REGISTRATION_NUM", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("2PAY_DUE_YMD", strPAY_DUE_YMD);
			lrArgData.setValue("3MAIL_SEND_YN", strMAIL_SEND_YN);
			if(!"".equals(strVAT_REGISTRATION_NUM)) lrArgData.setValue("4VAT_REGISTRATION_NUM", strVAT_REGISTRATION_NUM);
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("MAIL_SEQ", true);

				
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
		else if (strAct.equals("BATCH"))
		{
			
			strSql  = " Select 'XXXXXXXXXXXXX' COMP_CODE , 'XXXXXXXXXXXXXXX' PAY_DUE_YMD, 'XXXXXXXXXXXXXXXXXXX' VAT_REGISTRATION_NUM From Dual \n";
			
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
				GauceInfo.response.writeException("USER", "900001","BATCH Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("SEND"))
		{
			
			strSql  = " Select 0 MAIL_SEQ From Dual Where 1=0 \n";
			
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
				GauceInfo.response.writeException("USER", "900001","BATCH Select 오류-> "+ ex.getMessage());
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