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
			String	strTRX_GUBUN = CITCommon.toKOR(request.getParameter("TRX_GUBUN"));
			String	strBANK_CD = CITCommon.toKOR(request.getParameter("BANK_CD"));
			String	strFUTUREBANK_CD = CITCommon.toKOR(request.getParameter("FUTUREBANK_CD"));
			String	strDT_F = CITCommon.toKOR(request.getParameter("DT_F"));
			String	strDT_T = CITCommon.toKOR(request.getParameter("DT_T"));
			String	strACCNO_CODE = CITCommon.toKOR(request.getParameter("ACCNO_CODE"));

			strSql =
				"Select					"+"\r\n"+
				"	a.DOCU_NUMC,		"+"\r\n"+
				"	a.BANK_CODE,		"+"\r\n"+
				"	b.BANK_MAIN_CODE BANK_NAME ,		"+"\r\n"+
				"	a.ACCOUNT_NO  ,"+"\r\n"+
				"	F_T_DATETOSTRING(a.TRADE_YMD)||' '||SUBSTR(TRADE_TIME,1,2)||':'||SUBSTR(TRADE_TIME,3,2) TRADE_YMD ,		"+"\r\n"+
				"	a.TRX_GUBUN , 	"+"\r\n"+	
				"	c.LOOKUP_VALUE TRX_GUBUN_NAME , 	"+"\r\n"+	
				"	a.ISSUE_NAME , 	"+"\r\n"+	
				"	a.AMOUNT  , 	"+"\r\n"+	
				"	a.REMAIN_AMT , 	"+"\r\n"+	
				"	a.BILL_NO , 	"+"\r\n"+	
				"	a.TRADE_YMD PAY_YMD, 	"+"\r\n"+	
				"	a.FUTURE_PAY_DUE_YMD , 	"+"\r\n"+	
				"	a.FUTURE_PAY_BANK_CODE ,"+"\r\n"+	
				"	d.BANK_MAIN_CODE FUTURE_BANK_NAME ,"+"\r\n"+	
				"	a.CMS_CODE  	"+"\r\n"+	
				"From	T_FB_BILL_TRX_DATA a , "+"\r\n"+
				"     T_BANK_MAIN b , "+"\r\n"+
				"     T_BANK_MAIN d , "+"\r\n"+
				"     ( SELECT LOOKUP_CODE , "+"\r\n"+
				"              LOOKUP_VALUE  "+"\r\n"+
				"       FROM	T_FB_LOOKUP_VALUES "+"\r\n"+
				"       WHERE LOOKUP_TYPE = upper('CHECK_TRX_GUBUN')"+"\r\n"+
				"       AND   USE_YN      = 'Y') c "+"\r\n"+
				"Where	a.BANK_CODE = b.BANK_MAIN_CODE "+"\r\n"+
				"And  a.TRX_GUBUN = c.LOOKUP_CODE "+"\r\n"+
				"And  a.FUTURE_PAY_BANK_CODE = d.BANK_MAIN_CODE "+"\r\n"+
				"And  a.COMP_CODE = ? "+"\r\n"+
				"And 	a.TRX_GUBUN like ?||'%' "+"\r\n"+
				"And 	a.BANK_CODE like ?||'%' "+"\r\n"+		
				"And 	a.FUTURE_PAY_BANK_CODE like ?||'%' "+"\r\n";
				if(!"".equals(strDT_F)) 
				strSql +="And 	a.TRADE_YMD BETWEEN F_T_STRINGTODATE(?) AND F_T_STRINGTODATE(?) "+"\r\n";
				if(!"".equals(strACCNO_CODE))
				strSql +="And 	a.ACCOUNT_NO = ? "+"\r\n";
				strSql +="Order By	a.BANK_CODE,a.TRADE_YMD ,a.DOCU_NUMC ";

			lrArgData.addColumn("COMP_CODE",CITData.VARCHAR2);
			lrArgData.addColumn("TRX_GUBUN",CITData.VARCHAR2);
			lrArgData.addColumn("BANK_CD",CITData.VARCHAR2);
			lrArgData.addColumn("FUTUREBANK_CD",CITData.VARCHAR2);
			if(!"".equals(strDT_F)) lrArgData.addColumn("DT_F",CITData.VARCHAR2);
			if(!"".equals(strDT_F)) lrArgData.addColumn("DT_T",CITData.VARCHAR2);
			if(!"".equals(strACCNO_CODE)) lrArgData.addColumn("ACCNO_CODE",CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("COMP_CODE",strCOMP_CODE);
			lrArgData.setValue("TRX_GUBUN",strTRX_GUBUN);
			lrArgData.setValue("BANK_CD",strBANK_CD);
			lrArgData.setValue("FUTUREBANK_CD",strFUTUREBANK_CD);
			if(!"".equals(strDT_F)) lrArgData.setValue("DT_F",strDT_F);
			if(!"".equals(strDT_F)) lrArgData.setValue("DT_T",strDT_T);
			if(!"".equals(strACCNO_CODE)) lrArgData.setValue("ACCNO_CODE",strACCNO_CODE);

			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
		}
		else if (strAct.equals("COPY"))
		{			
			strSql  = " Select 'XX' COMP_CODE, "+"\r\n"+ 
			          "        'XX' BANK_CODE, "+"\r\n"+  
			          "        'XXXXXXXXXX' TRADE_YMD, "+"\r\n"+  
			          "        'XXXXXX' MISS_NUM "+"\r\n"+  
			          " from dual \n";

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