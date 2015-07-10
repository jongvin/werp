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
			String	strCONTRACT_GUBUN= CITCommon.toKOR(request.getParameter("CONTRACT_GUBUN"));
			String	strBANK_CODE= CITCommon.toKOR(request.getParameter("BANK_CODE"));
			String	strDT_F= CITCommon.toKOR(request.getParameter("DT_F"));
			String	strDT_T= CITCommon.toKOR(request.getParameter("DT_T"));
			String	strCUST_CODE= CITCommon.toKOR(request.getParameter("CUST_CODE"));

			{
				strSql =
					"Select					      "+"\r\n"+
					"	b.BANK_MAIN_NAME ,	"+"\r\n"+
					"	a.VAT_REGISTRATION_NUM ,		"+"\r\n"+
					"	a.VENDOR_NAME CUST_NAME ,		"+"\r\n"+
					"	a.FRANCHISE_NO  ,		        "+"\r\n"+
					"	a.CHECK_NO   ,		          "+"\r\n"+
					"	d.NAME CONTRACT_NAME,			"+"\r\n"+
					"	F_T_DATETOSTRING(a.ATTRIBUTE1) CREATION_DATE ,		"+"\r\n"+
					"	F_T_DATETOSTRING(a.CHANGE_YMD) CHANGE_YMD 			"+"\r\n"+
					"From	T_FB_BILL_VENDORS a ,"+"\r\n"+
					"     T_BANK_MAIN  b , "+"\r\n"+
					"     ( select "+"\n"+
					"	      LOOKUP_CODE  CODE, "+"\n"+
					"	      LOOKUP_VALUE NAME  "+"\n"+
					"       from	T_FB_LOOKUP_VALUES "+"\n"+
					"       where lookup_type = upper('VENDOR_CONTRACT_GUBUN')"+"\n"+
					"       and   use_yn      = 'Y' )  d "+"\n"+					
					"Where 	a.BANK_CODE = b.BANK_MAIN_CODE(+) "+"\r\n"+
					"And  a.CONTRACT_GUBUN = d.CODE(+) "+"\r\n"+
					"And  a.COMP_CODE = ? "+"\r\n"+
					"And 	a.CONTRACT_GUBUN like ?||'%' "+"\r\n"+
					"And 	a.BANK_CODE like ?||'%' "+"\r\n";
					if(!"".equals(strDT_F)) strSql
					 += "And 	a.CHANGE_YMD BETWEEN F_T_STRINGTODATE(?) AND F_T_STRINGTODATE(?) "+"\r\n";
					if(!"".equals(strCUST_CODE)) strSql 
					 += "And 	a.VAT_REGISTRATION_NUM||a.VENDOR_NAME like '%'||?||'%' "+"\r\n" ;
					strSql+= "Order By	a.SEQ ";
			}
			
			lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("CONTRACT_GUBUN", CITData.VARCHAR2);
			lrArgData.addColumn("BANK_CODE", CITData.VARCHAR2);
			if(!"".equals(strDT_F)) lrArgData.addColumn("DT_F", CITData.VARCHAR2);
			if(!"".equals(strDT_F)) lrArgData.addColumn("DT_T", CITData.VARCHAR2);
			if(!"".equals(strCUST_CODE)) lrArgData.addColumn("CUST_CODE", CITData.VARCHAR2);

			lrArgData.addRow();
			lrArgData.setValue("COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("CONTRACT_GUBUN", strCONTRACT_GUBUN);
			lrArgData.setValue("BANK_CODE", strBANK_CODE);
			if(!"".equals(strDT_F)) lrArgData.setValue("DT_F", strDT_F);
			if(!"".equals(strDT_F)) lrArgData.setValue("DT_T", strDT_T);
			if(!"".equals(strCUST_CODE)) lrArgData.setValue("CUST_CODE", strCUST_CODE);

			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
		}
		else if (strAct.equals("COPY"))
		{
			
			strSql  = " Select 'XX' PAY_SEQ from dual \n";
			
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