<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : t_WETaxDeptR_q(부서 등록)
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
			String strDEPT_CODE = CITCommon.toKOR(request.getParameter("DEPT_CODE"));
			String strDEPT_NAME = CITCommon.toKOR(request.getParameter("DEPT_NAME"));

			strSql  = " Select	A.COM_ID		, \n";
			strSql += "       	A.SECT_CODE , \n";
			strSql += "       	A.SECT_NAME , \n";
			strSql += "       	A.SAUP_CODE , \n";
			strSql += "       	A.ORGAN_CODE, \n";
			strSql += "       	F_T_DATETOSTRING(SUBSTR(A.INSERT_DATE,1,8)) || ' ' || F_T_StringToTimeFormat(SUBSTR(A.INSERT_DATE,9,6)) INSERT_DATE , \n";
			strSql += "       	F_T_DATETOSTRING(SUBSTR(A.UPDATE_DATE,1,8)) || ' ' || F_T_StringToTimeFormat(SUBSTR(A.UPDATE_DATE,9,6)) UPDATE_DATE , \n";			
			strSql += "       	A.INSERT_EMP   , \n";			
			strSql += "       	A.UPDATE_EMP   , \n";
			strSql += "       	( select b.com_name from tb_wt_company b 	\n";
			strSql += "       		where  b.com_id = A.com_id ) COM_NAME		\n";			
			strSql += " From	TB_WT_SECT A  \n";
			strSql += " Where	A.COM_ID   = ?   \n";
			if(!"".equals(strDEPT_CODE)) strSql += " And		A.SECT_CODE like ? ||'%' \n";
			if(!"".equals(strDEPT_NAME)) strSql += " And		A.SECT_NAME like '%' || ? || '%' \n";
			
			lrArgData.addColumn("COMPANY_CODE", CITData.VARCHAR2);
			if(!"".equals(strDEPT_CODE)) lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
			if(!"".equals(strDEPT_NAME)) lrArgData.addColumn("DEPT_NAME", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("COMPANY_CODE", strCOMPANY_CODE);
			if(!"".equals(strDEPT_CODE)) lrArgData.setValue("DEPT_CODE", strDEPT_CODE);
			if(!"".equals(strDEPT_NAME)) lrArgData.setValue("DEPT_NAME", strDEPT_NAME);
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("COM_ID", true);
				lrReturnData.setKey("SECT_CODE", true);
				lrReturnData.setNotNull("SECT_CODE", true);
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