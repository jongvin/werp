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
			
			strSql  = " SELECT \n";
			strSql += " 	A.COMP_CODE, \n";
			strSql += " 	B.COMPANY_NAME COMP_NAME, \n";
			strSql += " 	A.DEPT_CODE, \n";
			strSql += " 	A.DEPT_NAME, \n";
			strSql += " 	A.DEPT_SHORT_NAME, \n";
			strSql += " 	A.TAX_COMP_CODE, \n";
			strSql += " 	C.COMPANY_NAME TAX_COMP_NAME, \n";
			strSql += " 	NVL(A.BUDG_CLS,'F') BUDG_CLS, \n";
			strSql += " 	A.GROUP_DEPT_CODE, \n";
			strSql += " 	A.COST_DEPT_KND_TAG, \n";
			strSql += " 	F_T_DATETOSTRING(A.INPUT_DT_F) INPUT_DT_F, \n";
			strSql += " 	F_T_DATETOSTRING(A.INPUT_DT_T) INPUT_DT_T, \n";
			strSql += " 	''||A.ACC_GRP_CODE ACC_GRP_CODE, \n";
			strSql += " 	A.LEGA_DEPT, \n";
			strSql += " 	A.EMP_CLASS_CODE, \n";
			strSql += " 	A.SAUP_TAX_TAG, \n";
			strSql += " 	E.SDEPTNM LEGA_DEPT_NAME \n";
			strSql += " FROM \n";
			strSql += " 	T_DEPT_CODE_ORG A, \n";
			strSql += " 	T_COMPANY B, \n";
			strSql += " 	T_COMPANY C, \n";
			strSql += " 	T_DEPT_CODE_ORG D, \n";
			strSql += " 	PORG005VV E \n";
			strSql += " WHERE	A.COMP_CODE = B.COMP_CODE(+) \n";
			strSql += " AND		A.TAX_COMP_CODE = C.COMP_CODE(+) \n";
			strSql += " AND		A.COMP_CODE = D.COMP_CODE(+) \n";
			strSql += " AND		A.GROUP_DEPT_CODE = D.COMP_CODE(+) \n";
			strSql += " AND		A.COMP_CODE LIKE  '%'||   ?   ||'%' \n";
			strSql += " AND		NVL(A.DEPT_NAME,' ') LIKE  '%'||   ?   || '%'  \n";
			strSql += " And		A.LEGA_DEPT = E.DEPT (+) \n";
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