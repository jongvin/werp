<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 홍길동 작성(2006-05-19)
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
			String strDEPT_NAME = CITCommon.toKOR(request.getParameter("DEPT_NAME"));
			
			strSql  = " Select \n";
			strSql += " 	a.DEPT_CODE , \n";
			strSql += " 	a.CRTUSERNO , \n";
			strSql += " 	a.CRTDATE , \n";
			strSql += " 	a.MODUSERNO , \n";
			strSql += " 	a.MODDATE , \n";
			strSql += " 	a.DEPT_NAME , \n";
			strSql += " 	a.DEPT_SHORT_NAME , \n";
			strSql += " 	a.COMP_CODE , \n";
			strSql += " 	a.TAX_COMP_CODE , \n";
			strSql += " 	a.BUDG_CLS , \n";
			strSql += " 	a.GROUP_DEPT_CODE , \n";
			strSql += " 	a.COST_DEPT_KND_TAG , \n";
			strSql += " 	a.INPUT_DT_F , \n";
			strSql += " 	a.INPUT_DT_T , \n";
			strSql += " 	a.ACC_GRP_CODE , \n";
			strSql += " 	a.LEGA_DEPT , \n";
			strSql += " 	a.SAUP_TAX_TAG , \n";
			strSql += " 	a.EMP_CLASS_CODE , \n";
			strSql += " 	a.COST_CONV_CODE , \n";
			strSql += " 	a.P_DEPT_CODE , \n";
			strSql += " 	a.DEPT_KIND_TAG , \n";
			strSql += " 	a.ACC_CLOSE_DT , \n";
			strSql += " 	a.ACC_CLOST_DT_SYS , \n";
			strSql += " 	a.CONS_AMT , \n";
			strSql += " 	a.BUDG_AMT , \n";
			strSql += " 	a.BUDG_APPL_DT , \n";
			strSql += " 	a.AS_AMT , \n";
			strSql += " 	a.COST_DESC_TAG , \n";
			strSql += " 	a.COST_GUESS_AMT , \n";
			strSql += " 	a.F_CONS_AMT , \n";
			strSql += " 	a.F_BUDG_AMT , \n";
			strSql += " 	a.CHARGE_PERS , \n";
			strSql += " 	a.TAX_MNG_OFFICE , \n";
			strSql += " 	a.NP_PRT_TAG \n";
			strSql += " From	T_DEPT_CODE_ORG a \n";
			strSql += " Where	a.DEPT_CODE || a.DEPT_NAME Like '%' ||Replace( ? ,' ','%') || '%' \n";
			strSql += " Order By \n";
			strSql += " 	a.DEPT_CODE \n";
			strSql += "  ";
			
			lrArgData.addColumn("1DEPT_NAME", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1DEPT_NAME", strDEPT_NAME);
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("DEPT_CODE", true);
				lrReturnData.setNotNull("DEPT_NAME", true);
				
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