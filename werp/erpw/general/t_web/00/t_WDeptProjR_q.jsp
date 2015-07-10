<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 김흥수 작성(2005-11-21)
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
			String strDEPT_NAME = CITCommon.toKOR(request.getParameter("DEPT_NAME"));
			String strCLOSE_TAG = CITCommon.toKOR(request.getParameter("CLOSE_TAG"));
			
			strSql  = " SELECT \n";
			strSql += " 	A.COMP_CODE, \n";
			strSql += " 	B.COMPANY_NAME COMP_NAME, \n";
			strSql += " 	A.DEPT_CODE, \n";
			strSql += " 	A.DEPT_NAME, \n";
			strSql += " 	A.DEPT_SHORT_NAME, \n";
			strSql += " 	A.TAX_COMP_CODE, \n";
			strSql += " 	C.COMPANY_NAME TAX_COMP_NAME, \n";
			strSql += " 	NVL(A.BUDG_CLS,'F') BUDG_CLS, \n";
			strSql += " 	A.DEPT_KIND_TAG, \n";
			strSql += " 	A.P_DEPT_CODE, \n";
			strSql += " 	A.GROUP_DEPT_CODE, \n";
			strSql += " 	A.COST_CONV_CODE, \n";
			strSql += " 	D.DEPT_NAME P_DEPT_NAME , \n";
			strSql += " 	A.COST_DEPT_KND_TAG, \n";
			strSql += " 	F_T_DATETOSTRING(A.INPUT_DT_F) INPUT_DT_F, \n";
			strSql += " 	F_T_DATETOSTRING(A.INPUT_DT_T) INPUT_DT_T, \n";
			strSql += " 	''||A.ACC_GRP_CODE ACC_GRP_CODE, \n";
			strSql += " 	A.LEGA_DEPT, \n";
			strSql += " 	F_T_DATETOSTRING(A.ACC_CLOSE_DT) ACC_CLOSE_DT, \n";
			strSql += " 	A.SAUP_TAX_TAG, \n";
			strSql += " 	A.CONS_AMT, \n";
			strSql += " 	A.BUDG_AMT, \n";
			strSql += " 	A.F_CONS_AMT, \n";
			strSql += " 	A.F_BUDG_AMT, \n";
			strSql += " 	A.COST_GUESS_AMT, \n";
			strSql += " 	A.AS_AMT, \n";
			strSql += " 	A.COST_DESC_TAG, \n";
			strSql += " 	F_T_DATETOSTRING(A.BUDG_APPL_DT) BUDG_APPL_DT, \n";
			strSql += " 	E.SDEPTNM LEGA_DEPT_NAME \n";
			strSql += " FROM \n";
			strSql += " 	T_DEPT_CODE A, \n";
			strSql += " 	T_COMPANY B, \n";
			strSql += " 	T_COMPANY C, \n";
			strSql += " 	T_DEPT_CODE_ORG D, \n";
			strSql += " 	PORG005VV E \n";
			strSql += " WHERE	A.COMP_CODE = B.COMP_CODE(+) \n";
			strSql += " AND		A.TAX_COMP_CODE = C.COMP_CODE(+) \n";
			strSql += " AND		A.P_DEPT_CODE = D.DEPT_CODE(+) \n";
			strSql += " AND		A.COMP_CODE LIKE  '%'||   ?   ||'%' \n";
			strSql += " AND		NVL(A.DEPT_NAME,' ') LIKE  '%'||   ?   || '%'  \n";
			strSql += " And		A.LEGA_DEPT = E.DEPT (+) \n";
			strSql += " And		A.DEPT_PROJ_TAG = 'P' \n";
			if(strCLOSE_TAG.equals("2"))		//진행현장
			{
			strSql += " And		a.ACC_CLOSE_DT Is Null \n";
			}
			else if(strCLOSE_TAG.equals("3"))		//마감현장
			{
			strSql += " And		a.ACC_CLOSE_DT Is Not Null \n";
			}
			strSql += " Order By A.DEPT_CODE \n";
			strSql += "  ";
			
			lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("DEPT_NAME", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("DEPT_NAME", strDEPT_NAME);
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("COMP_CODE", true);
				lrReturnData.setKey("DEPT_CODE", true);

				
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
		else if (strAct.equals("INFO"))
		{
			String strDEPT_CODE = CITCommon.toKOR(request.getParameter("DEPT_CODE"));
			String strBASE_DT = CITCommon.toKOR(request.getParameter("BASE_DT"));
			
			strSql  = " Select \n";
			strSql += " f_t_get_const_cnt_amt1( ?  ) F_CONS_AMT, \n";
			strSql += " f_t_get_const_amt1( ?  ) F_BUDG_AMT, \n";
			strSql += " f_t_get_const_amt( ? , ? ) BUDG_AMT, \n";
			strSql += " F_SUM_PRE_RESULT_AMT( ? , To_Char(?,'YYYYMM') ) COST_GUESS_AMT, \n";
			strSql += " f_t_get_const_cnt_amt( ? , ? ) CONS_AMT \n";
			strSql += " from dual ";
			
			lrArgData.addColumn("10DEPT_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("11DEPT_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("1DEPT_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("2BASE_DT", CITData.DATE);
			lrArgData.addColumn("3DEPT_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("4BASE_DT", CITData.DATE);
			lrArgData.addColumn("5DEPT_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("6BASE_DT", CITData.DATE);
			lrArgData.addRow();
			lrArgData.setValue("10DEPT_CODE", strDEPT_CODE);
			lrArgData.setValue("11DEPT_CODE", strDEPT_CODE);
			lrArgData.setValue("1DEPT_CODE", strDEPT_CODE);
			lrArgData.setValue("2BASE_DT", strBASE_DT);
			lrArgData.setValue("3DEPT_CODE", strDEPT_CODE);
			lrArgData.setValue("4BASE_DT", strBASE_DT);
			lrArgData.setValue("5DEPT_CODE", strDEPT_CODE);
			lrArgData.setValue("6BASE_DT", strBASE_DT);
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
				GauceInfo.response.writeException("USER", "900001","INFO Select 오류-> "+ ex.getMessage());
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