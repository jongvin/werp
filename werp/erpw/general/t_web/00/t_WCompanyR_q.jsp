<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : t_WCompanyR_q(사업장 등록)
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 최언회 작성(2005-11-22)
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
			String strCOMPANY_NAME = CITCommon.toKOR(request.getParameter("COMPANY_NAME"));
			
			strSql  = " Select	A.COMP_CODE , \n";
			strSql += "       	F_T_Cust_Mask(A.BIZNO) BIZNO , \n";
			strSql += "       	A.COMPANY_NAME , \n";
			strSql += "       	A.HEAD_BRANCH_CLS , \n";
			strSql += "       	A.HEAD_COMP_CODE , \n";
			strSql += "       	B.COMPANY_NAME HEAD_COMP_NAME , \n";
			strSql += "       	F_T_Cust_Mask(A.BIZNO2) BIZNO2 , \n";
			strSql += "       	F_T_DateToString(A.OPEN_DT) OPEN_DT , \n";
			strSql += "       	A.BOSS , \n";
			strSql += "       	A.BOSS_NO , \n";
			strSql += "       	A.BIZCOND , \n";
			strSql += "       	A.BIZKND , \n";
			strSql += "       	A.TELNO , \n";
			strSql += "       	F_T_Zip_Mask(A.BIZPLACE_ZIPCODE) BIZPLACE_ZIPCODE , \n";
			strSql += "       	A.BIZPLACE_ADDR1 , \n";
			strSql += "       	A.BIZPLACE_ADDR2 , \n";
			strSql += "       	F_T_Zip_Mask(A.HEADOFF_ZIPCODE) HEADOFF_ZIPCODE , \n";
			strSql += "       	A.HEADOFF_ADDR1 , \n";
			strSql += "       	A.HEADOFF_ADDR2 , \n";
			strSql += "       	A.TAX_OFFICE_NAME , \n";
			strSql += "       	A.BUDG_DIVERT_CLS , \n";
			strSql += "       	A.BUDG_TRANS_CLS , \n";
			strSql += "       	TO_CHAR(A.ACCOUNT_CURR) ACCOUNT_CURR , \n";
			strSql += "       	F_T_DateToString(A.ACCOUNT_FDT) ACCOUNT_FDT , \n";
			strSql += "       	F_T_DateToString(A.ACCOUNT_EDT) ACCOUNT_EDT , \n";
			strSql += "       	A.DEPT_CODE , \n";
			strSql += "       	A.FIN_DEPT_CODE , \n";
			strSql += "       	A.ACC_DEPT_CODE , \n";
			strSql += "       	A.COMPANY_ACC_CODE , \n";
			strSql += "       	A.VAT_RETURN_ACCNO , \n";
			strSql += "       	F.ACC_NAME COMPANY_ACC_NAME, \n";
			strSql += "       	D.DEPT_NAME FIN_DEPT_NAME, \n";
			strSql += "       	E.DEPT_NAME ACC_DEPT_NAME, \n";
			strSql += "       	C.DEPT_NAME \n";
			strSql += " From	T_COMPANY A, \n";
			strSql += " 		T_COMPANY B, \n";
			strSql += " 		T_DEPT_CODE C, \n";
			strSql += " 		T_DEPT_CODE D, \n";
			strSql += " 		T_DEPT_CODE E, \n";
			strSql += " 		T_ACC_CODE F \n";
			strSql += " Where	A.HEAD_COMP_CODE = B.COMP_CODE(+) \n";
			strSql += " And		A.DEPT_CODE = C.DEPT_CODE(+) \n";
			strSql += " And		A.FIN_DEPT_CODE = D.DEPT_CODE(+) \n";
			strSql += " And		A.ACC_DEPT_CODE = E.DEPT_CODE(+) \n";
			strSql += " And		A.COMPANY_ACC_CODE = F.ACC_CODE(+) \n";
			strSql += " And		A.COMPANY_NAME Like '%'|| ? ||'%' \n";
			strSql += " Order By COMP_CODE ";
			
			lrArgData.addColumn("COMPANY_NAME", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("COMPANY_NAME", strCOMPANY_NAME);
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("COMP_CODE", true);
				lrReturnData.setNotNull("BIZNO", true);
				lrReturnData.setNotNull("COMPANY_NAME", true);
				lrReturnData.setNotNull("BOSS", true);
				lrReturnData.setNotNull("ACCOUNT_CURR", true);
				lrReturnData.setNotNull("ACCOUNT_FDT", true);
				lrReturnData.setNotNull("ACCOUNT_EDT", true);
				
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