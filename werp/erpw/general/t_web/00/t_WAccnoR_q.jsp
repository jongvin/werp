<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : t_WAccnoR_q.jsp(계좌등록)
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 최언회 작성(2005-11-29)
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
			String strBANK_CODE = CITCommon.toKOR(request.getParameter("BANK_CODE"));
			String strBANK_MAIN_CODE = CITCommon.toKOR(request.getParameter("BANK_MAIN_CODE"));
			
			strSql  = " Select \n";
			strSql += " 	a.ACCNO , \n";
			strSql += " 	a.CRTUSERNO , \n";
			strSql += " 	a.CRTDATE , \n";
			strSql += " 	a.MODUSERNO , \n";
			strSql += " 	a.MODDATE , \n";
			strSql += " 	a.BANK_CODE , \n";
			strSql += " 	b.BANK_NAME , \n";
			strSql += " 	a.COMP_CODE , \n";
			strSql += " 	a.ACCT_NAME , \n";
			strSql += " 	a.ACCT_CLS , \n";
			strSql += " 	a.PAY_ACCNO_CLS , \n";
			strSql += " 	a.CHK_ACCNO_CLS , \n";
			strSql += " 	a.CHK_MAX_AMT , \n";
			strSql += " 	F_T_DATETOSTRING(a.CONT_DT) CONT_DT , \n";
			strSql += " 	F_T_DATETOSTRING(a.EXPR_DT) EXPR_DT , \n";
			strSql += " 	F_T_DATETOSTRING(a.EXPR_CHG_DT) EXPR_CHG_DT , \n";
			strSql += " 	F_T_DATETOSTRING(a.MIDD_CANCEL_DT) MIDD_CANCEL_DT , \n";
			strSql += " 	a.ORG_AMT , \n";
			strSql += " 	a.EXPR_AMT , \n";
			strSql += " 	a.MONTH_INTR_AMT , \n";
			strSql += " 	a.INTR_RATE , \n";
			strSql += " 	a.PAYMENT_SEQ_AMT , \n";
			strSql += " 	a.PAYMENT_SEQ_DAY , \n";
			strSql += " 	a.DEPT_CODE , \n";
			strSql += " 	c.DEPT_NAME , \n";
			strSql += " 	a.ACC_CODE , \n";
			strSql += " 	d.ACC_NAME , \n";
			strSql += " 	a.ITR_ACC_CODE , \n";
			strSql += " 	e.ACC_NAME ITR_ACC_NAME, \n";
			strSql += " 	a.HSMS_USE_CLS , \n";
			strSql += " 	a.REMARKS , \n";
			strSql += " 	a.USE_CLS , \n";
			strSql += " 	a.FBS_ACCOUNT_CLS , \n";
			strSql += " 	a.FBS_TRANSFER_CLS , \n";
			strSql += " 	a.VIRTUAL_ACCOUNT_CLS , \n";
			strSql += " 	a.FBS_DISPLAY_ORDER , \n";
			strSql += " 	a.ACC_OWNER , \n";
			strSql += " 	a.ACCOUNT_NO \n";
			strSql += " From	T_ACCNO_CODE a, \n";
			strSql += " 		T_BANK_CODE b, \n";
			strSql += " 		T_DEPT_CODE c, \n";
			strSql += " 		T_ACC_CODE d, \n";
			strSql += " 		T_ACC_CODE e \n";
			strSql += " Where	a.BANK_CODE = b.BANK_CODE \n";
			strSql += " And		a.DEPT_CODE = c.DEPT_CODE(+) \n";
			strSql += " And		a.ACC_CODE = d.ACC_CODE(+) \n";
			strSql += " And		a.ITR_ACC_CODE = e.ACC_CODE(+) \n";
			strSql += " And		a.COMP_CODE Like '%'|| ? ||'%' \n";
			strSql += " And		a.BANK_CODE Like '%'|| ? ||'%' \n";
			strSql += " And		b.BANK_MAIN_CODE Like '%'|| ? ||'%' ";
			strSql += " Order By b.BANK_MAIN_CODE,b.BANK_CODE,a.ACCNO ";
			
			lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("BANK_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("BANK_MAIN_CODE", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("BANK_CODE", strBANK_CODE);
			lrArgData.setValue("BANK_MAIN_CODE", strBANK_MAIN_CODE);

			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("ACCNO", true);
				lrReturnData.setNotNull("BANK_CODE", true);
				lrReturnData.setNotNull("COMP_CODE", true);
				lrReturnData.setNotNull("ACCT_CLS", true);
				
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
		else if (strAct.equals("BANK_MAIN"))
		{

			
			strSql  = " Select	A.BANK_MAIN_CODE , \n";
			strSql += " 		A.BANK_MAIN_NAME , \n";
			strSql += " 		1 SORT_GB \n";
			strSql += " From	T_BANK_MAIN A \n";
			strSql += " Union \n";
			strSql += " Select	'%' , \n";
			strSql += " 		'전체' , \n";
			strSql += " 		-1 \n";
			strSql += " From	DUAL \n";
			strSql += " Order by 3, 1 ";
			

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
				GauceInfo.response.writeException("USER", "900001","BANK_MAIN Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("BANK_CODE"))
		{
			String strBANK_MAIN_CODE = CITCommon.toKOR(request.getParameter("BANK_MAIN_CODE"));
			
			strSql  = " Select	A.BANK_CODE , \n";
			strSql += " 		A.BANK_NAME , \n";
			strSql += " 		A.BANK_MAIN_CODE , \n";
			strSql += " 		1 SORT_GB \n";
			strSql += " From	T_BANK_CODE A \n";
			strSql += " Where	A.BANK_MAIN_CODE Like '%'|| ? ||'%' \n";
			strSql += " Union \n";
			strSql += " Select	'%' , \n";
			strSql += " 		'전체' , \n";
			strSql += " 		'%' , \n";
			strSql += " 		-1 \n";
			strSql += " From	DUAL \n";
			strSql += " Order by 4, 1 ";
			
			lrArgData.addColumn("BANK_MAIN_CODE", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("BANK_MAIN_CODE", strBANK_MAIN_CODE);
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
				GauceInfo.response.writeException("USER", "900001","BANK_CODE Select 오류-> "+ ex.getMessage());
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