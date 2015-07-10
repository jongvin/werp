<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 김흥수 작성(2006-01-12)
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
			String strCLSE_ACC_ID = CITCommon.toKOR(request.getParameter("CLSE_ACC_ID"));
			String strDEPT_PROJ_TAG = CITCommon.toKOR(request.getParameter("DEPT_PROJ_TAG"));
			
			strSql  = " Select \n";
			strSql += " 	a.COMP_CODE , \n";
			strSql += " 	a.CLSE_ACC_ID , \n";
			strSql += " 	a.DEPT_CODE , \n";
			strSql += " 	a.CRTUSERNO , \n";
			strSql += " 	a.CRTDATE , \n";
			strSql += " 	a.MODUSERNO , \n";
			strSql += " 	a.MODDATE, \n";
			strSql += " 	b.DEPT_NAME, \n";
			strSql += " 	b.DEPT_SHORT_NAME \n";
			strSql += " From	T_PL_PLAN_DEPT a, \n";
			strSql += " 		T_PL_REAL_N_VIR_DEPT b \n";
			strSql += " Where	a.DEPT_CODE = b.DEPT_CODE \n";
			strSql += " And		a.COMP_CODE =  ?  \n";
			strSql += " And		a.CLSE_ACC_ID =  ?  \n";
			strSql += " And		b.DEPT_PROJ_TAG Like  ?  \n";
			strSql += " Order By \n";
			strSql += " 	a.DEPT_CODE ";
			
			lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("DEPT_PROJ_TAG", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("DEPT_PROJ_TAG", strDEPT_PROJ_TAG);
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
		else if (strAct.equals("SUB01"))
		{
			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String strCLSE_ACC_ID = CITCommon.toKOR(request.getParameter("CLSE_ACC_ID"));
			String strDEPT_PROJ_TAG = CITCommon.toKOR(request.getParameter("DEPT_PROJ_TAG"));
			
			strSql  = " Select \n";
			strSql += " 	a.DEPT_CODE , \n";
			strSql += " 	a.CRTUSERNO , \n";
			strSql += " 	a.CRTDATE , \n";
			strSql += " 	a.MODUSERNO , \n";
			strSql += " 	a.MODDATE , \n";
			strSql += " 	a.COMP_CODE , \n";
			strSql += " 	a.DEPT_NAME , \n";
			strSql += " 	a.DEPT_SHORT_NAME , \n";
			strSql += " 	a.IS_REAL_DEPT \n";
			strSql += " From	T_PL_REAL_N_VIR_DEPT a \n";
			strSql += " Where	a.COMP_CODE = ?  \n";
			strSql += " And		a.DEPT_PROJ_TAG Like  ?  \n";
			strSql += " And		a.DEPT_CODE Not In \n";
			strSql += " ( \n";
			strSql += " 	Select	b.DEPT_CODE \n";
			strSql += " 	From	T_PL_PLAN_DEPT b \n";
			strSql += " 	Where	b.COMP_CODE =  ?  \n";
			strSql += " 	And		b.CLSE_ACC_ID =  ?  \n";
			strSql += " ) \n";
			strSql += " Order By \n";
			strSql += " 	a.DEPT_CODE ";
			
			lrArgData.addColumn("COMP_CODE1", CITData.VARCHAR2);
			lrArgData.addColumn("DEPT_PROJ_TAG", CITData.VARCHAR2);
			lrArgData.addColumn("COMP_CODE2", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("COMP_CODE1", strCOMP_CODE);
			lrArgData.setValue("DEPT_PROJ_TAG", strDEPT_PROJ_TAG);
			lrArgData.setValue("COMP_CODE2", strCOMP_CODE);
			lrArgData.setValue("CLSE_ACC_ID", strCLSE_ACC_ID);
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
				GauceInfo.response.writeException("USER", "900001","SUB01 Select 오류-> "+ ex.getMessage());
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