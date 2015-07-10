<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 김흥수 작성(2006-01-19)
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
			String strCOM_ID = CITCommon.toKOR(request.getParameter("COM_ID"));
			String strREG_NUM = CITCommon.toKOR(request.getParameter("REG_NUM"));
			String strCOMPANY = CITCommon.toKOR(request.getParameter("COMPANY"));
			
			strSql  = " select  \n";
			strSql += " 		F_T_Cust_Mask(REG_NUM) REG_NUM,		 \n";
			strSql += " 		COM_ID,		 \n";
			strSql += " 		SAUP_CODE,		 \n";
			strSql += " 		COMPANY,		 \n";
			strSql += " 		EMPLOYER,		 \n";
			strSql += " 		F_T_Zip_Mask(ZIP_CODE) ZIP_CODE,		 \n";
			strSql += " 		ADDRESS,		 \n";
			strSql += " 		BIZ_COND,		 \n";
			strSql += " 		BIZ_ITEM,		 \n";
			strSql += " 		TEL_NO,		 \n";
			strSql += " 		FAX_NO,		 \n";
			strSql += " 		TAXPUB_CLASS,		 \n";
			strSql += " 		TAX_TYPE,		 \n";
			strSql += " 		DEAL_CLASS,		 \n";
			strSql += " 		WEBTAX21_ID		 \n";
			strSql += " from      tb_wt_plant a \n";
			//strSql += " Where	 a.BANK_MAIN_CODE = b.BANK_MAIN_CODE \n";
			strSql += " Where	a.COM_ID =  ?  \n";
			strSql += " And	a.REG_NUM Like  '%'|| ? ||'%' \n";
			strSql += " And	a.COMPANY Like  '%'|| ? ||'%' \n";
			//strSql += " Order By \n";
			//strSql += " 	a.BANK_MAIN_CODE \n";

			
			lrArgData.addColumn("COM_ID", CITData.VARCHAR2);
			lrArgData.addColumn("REG_NUM", CITData.VARCHAR2);
			lrArgData.addColumn("COMPANY", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("COM_ID", strCOM_ID);
			lrArgData.setValue("REG_NUM", strREG_NUM);
			lrArgData.setValue("COMPANY", strCOMPANY);
			
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