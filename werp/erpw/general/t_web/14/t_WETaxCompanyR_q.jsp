<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : t_WETaxCompanyR_q(사업장 등록)
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 배민정 작성(2006-05-11)
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
			String strCOMPANY_CODE = CITCommon.toKOR(request.getParameter("COMPANY_CODE"));
			String strREG_NUM = CITCommon.toKOR(request.getParameter("REG_NUM"));
			String strCOMPANY = CITCommon.toKOR(request.getParameter("COMPANY"));

			strSql  = " Select	RTRIM(A.REG_NUM) REG_NUM , \n";
			strSql += "       	A.COM_ID    , \n";
			strSql += "       	A.SAUP_CODE , \n";
			strSql += "       	A.COMPANY   , \n";
			strSql += "       	A.EMPLOYER  , \n";
			strSql += "       	A.ZIP_CODE  , \n";
			strSql += "       	A.ADDRESS   , \n";
			strSql += "       	A.BIZ_COND  , \n";
			strSql += "       	A.BIZ_ITEM  , \n";
			strSql += "       	A.TEL_NO    , \n";
			strSql += "       	A.FAX_NO    , \n";
			strSql += "       	A.TAXPUB_CLASS , \n";
			strSql += "       	A.TAX_TYPE     , \n";
			strSql += "       	A.DEAL_CLASS   , \n";
			strSql += "       	A.WEBTAX21_ID  , \n";
			strSql += "       	F_T_DATETOSTRING(SUBSTR(A.INSERT_DATE,1,8)) || ' ' || F_T_StringToTimeFormat(SUBSTR(A.INSERT_DATE,9,6)) INSERT_DATE , \n";
			strSql += "       	F_T_DATETOSTRING(SUBSTR(A.UPDATE_DATE,1,8)) || ' ' || F_T_StringToTimeFormat(SUBSTR(A.UPDATE_DATE,9,6)) UPDATE_DATE , \n";
			strSql += "       	A.INSERT_EMP   , \n";			
			strSql += "       	A.UPDATE_EMP   , \n";
			strSql += "       	( select b.com_name from tb_wt_company b 	\n";
			strSql += "       		where  b.com_id = A.com_id ) COM_NAME		\n";
			strSql += " From	TB_WT_PLANT A  \n";
			strSql += " Where	A.COM_ID   = ?   \n";
			if(!"".equals(strREG_NUM)) strSql += " And		A.REG_NUM like ? ||'%' \n";
			if(!"".equals(strCOMPANY)) strSql += " And		A.COMPANY like '%' || ? || '%' \n";
			
			lrArgData.addColumn("COMPANY_CODE", CITData.VARCHAR2);
			if(!"".equals(strREG_NUM)) lrArgData.addColumn("REG_NUM", CITData.VARCHAR2);
			if(!"".equals(strCOMPANY)) lrArgData.addColumn("COMPANY", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("COMPANY_CODE", strCOMPANY_CODE);
			if(!"".equals(strREG_NUM)) lrArgData.setValue("REG_NUM", strREG_NUM);
			if(!"".equals(strCOMPANY)) lrArgData.setValue("COMPANY", strCOMPANY);
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("COM_ID", true);
				lrReturnData.setKey("REG_NUM", true);
				lrReturnData.setNotNull("REG_NUM", true);
				lrReturnData.setNotNull("COM_ID", true);
			
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