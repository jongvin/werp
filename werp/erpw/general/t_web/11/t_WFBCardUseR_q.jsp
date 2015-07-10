<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 김흥수 작성(2006-02-22)
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
			String strCARDNUMBER = CITCommon.toKOR(request.getParameter("CARDNUMBER"));
			String strSENDDATE_F = CITCommon.toKOR(request.getParameter("SENDDATE_F"));
			String strSENDDATE_T = CITCommon.toKOR(request.getParameter("SENDDATE_T"));
			
			strSql  = " Select \n";
			strSql += " 	a.SEQNO, \n";
			strSql += " 	a.CARDNUMBER, \n";
			strSql += " 	F_T_StringToYMDFormat(a.APPROVALDATE) ||' '|| F_T_StringToTimeFormat(a.APPROVALTIME) USE_DATE_TIME, \n";
			strSql += " 	F_T_StringToYMDFormat(a.CHARGEDATE) CHARGEDATE, \n";
			strSql += " 	a.DomesticConversionAmt, \n";
			strSql += " 	to_number(decode(a.GUBUNCODE,'03','+','-')||Decode(Nvl(a.DomesticConversionAmt,0),0,a.ApprovalSumAmt,a.DomesticConversionAmt)) AMT, \n";
			strSql += " 	a.MerchantName, \n";
			strSql += " 	a.APPROVALNUMBER, \n";
			strSql += " 	a.MccName, \n";
			strSql += " 	decode(a.GUBUNCODE,'03','','취소') GUBUN , \n";
			strSql += " 	a.USAGEGUBUN , \n";
			strSql += " 	a.MEMO \n";
			strSql += " From	T_CARD_EXPENSE_DATA a \n";
			strSql += " Where	Replace(a.CARDNUMBER,'-','') = Replace( ? ,'-','') \n";
			strSql += " And		a.APPROVALDATE Between  ?  And  ?  \n";
			strSql += " And		a.GUBUNCODE in ('03')  \n";
			strSql += " Order By  \n";
			strSql += " 	F_T_StringToYMDFormat(a.APPROVALDATE) ||' '|| F_T_StringToTimeFormat(a.APPROVALTIME) DESC ";
			
			lrArgData.addColumn("1CARDNUMBER", CITData.VARCHAR2);
			lrArgData.addColumn("2SENDDATE_F", CITData.VARCHAR2);
			lrArgData.addColumn("3SENDDATE_T", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1CARDNUMBER", strCARDNUMBER);
			lrArgData.setValue("2SENDDATE_F", strSENDDATE_F);
			lrArgData.setValue("3SENDDATE_T", strSENDDATE_T);
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("SEQNO", true);

				
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