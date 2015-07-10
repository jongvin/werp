<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 김흥수 작성(2006-01-16)
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
			String strWORK_YM = CITCommon.toKOR(request.getParameter("WORK_YM"));
			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String strCLSE_ACC_ID = CITCommon.toKOR(request.getParameter("CLSE_ACC_ID"));
			
			strSql  = " Select \n";
			strSql += " 	a.COMP_CODE, \n";
			strSql += " 	a.CLSE_ACC_ID, \n";
			strSql += " 	a.BIZ_PLAN_ITEM_NO FLOW_CODE , \n";
			strSql += " 	a.CRTUSERNO , \n";
			strSql += " 	a.CRTDATE , \n";
			strSql += " 	a.MODUSERNO , \n";
			strSql += " 	a.MODDATE , \n";
			strSql += " 	a.P_NO , \n";
			strSql += " 	a.LEVELED_FLOW_ITEM_NAME, \n";
			strSql += " 	a.IS_LEAF_TAG, \n";
			strSql += " 	a.RN, \n";
			strSql += " 	 ?   WORK_YM , \n";
			strSql += " 	Sum( \n";
			strSql += " 	Case When b.WORK_YM <    ?    Then \n";
			strSql += " 		b.EXEC_AMT \n";
			strSql += " 	Else \n";
			strSql += " 		Null \n";
			strSql += " 	End) PRE_EXEC_AMT, \n";
			strSql += " 	Sum( \n";
			strSql += " 	Case When b.WORK_YM =    ?    Then \n";
			strSql += " 		b.EXEC_AMT \n";
			strSql += " 	Else \n";
			strSql += " 		Null \n";
			strSql += " 	End) EXEC_AMT, \n";
			strSql += " 	Sum(Case When b.WORK_YM =    ?    Then \n";
			strSql += " 		b.PLAN_AMT \n";
			strSql += " 	Else \n";
			strSql += " 		Null \n";
			strSql += " 	End) PLAN_AMT, \n";
			strSql += " 	Sum(Case When b.WORK_YM =    ?    Then \n";
			strSql += " 		b.FORECAST_AMT \n";
			strSql += " 	Else \n";
			strSql += " 		Null \n";
			strSql += " 	End) FORECAST_AMT, \n";
			strSql += " 	Sum(b.EXEC_AMT) SUM_EXEC_AMT, \n";
			strSql += " 	Sum(b.PLAN_AMT) SUM_PLAN_AMT \n";
			strSql += " From \n";
			strSql += " 	( \n";
			strSql += " 		Select \n";
			strSql += " 			 ?   COMP_CODE, \n";
			strSql += " 			 ?   CLSE_ACC_ID, \n";
			strSql += " 			0 CHG_SEQ, \n";
			strSql += " 			a.CRTUSERNO , \n";
			strSql += " 			a.CRTDATE , \n";
			strSql += " 			a.MODUSERNO , \n";
			strSql += " 			a.MODDATE , \n";
			strSql += " 			a.BIZ_PLAN_ITEM_NO , \n";
			strSql += " 			a.P_NO , \n";
			strSql += " 			RPad(' ',(Level - 1) * 2,' ') || a.BIZ_PLAN_ITEM_NAME LEVELED_FLOW_ITEM_NAME, \n";
			strSql += " 			a.IS_LEAF_TAG, \n";
			strSql += " 			RowNum RN \n";
			strSql += " 		From	T_PL_ITEM a \n";
			strSql += " 		Start with a.P_NO = 0 \n";
			strSql += " 		Connect by \n";
			strSql += " 			Prior	a.BIZ_PLAN_ITEM_NO = a.P_NO \n";
			strSql += " 		Order Siblings By \n";
			strSql += " 			a.ITEM_LEVEL_SEQ \n";
			strSql += " 	) a, \n";
			strSql += " 	( \n";
			strSql += " 		Select \n";
			strSql += " 			b.COMP_CODE , \n";
			strSql += " 			b.CLSE_ACC_ID , \n";
			strSql += " 			b.CHG_SEQ, \n";
			strSql += " 			b.WORK_YM , \n";
			strSql += " 			b.BIZ_PLAN_ITEM_NO , \n";
			strSql += " 			b.EXEC_AMT , \n";
			strSql += " 			b.SUM_PLAN_AMT , \n";
			strSql += " 			b.MOD_PLAN_AMT , \n";
			strSql += " 			b.PLAN_AMT , \n";
			strSql += " 			b.SUM_FORECAST_AMT , \n";
			strSql += " 			b.MOD_FORECAST_AMT , \n";
			strSql += " 			b.FORECAST_AMT \n";
			strSql += " 		From	T_PL_COMP_PLAN_EXEC b \n";
			strSql += " 		Where	b.COMP_CODE =  ?  \n";
			strSql += " 		And		b.CLSE_ACC_ID =  ?  \n";
			strSql += " 		And		b.WORK_YM <=  ?  \n";
			strSql += " 		And		b.CHG_SEQ = 0 \n";
			strSql += " 	) b \n";
			strSql += " Where	a.COMP_CODE = b.COMP_CODE (+) \n";
			strSql += " And		a.CLSE_ACC_ID = b.CLSE_ACC_ID (+) \n";
			strSql += " And		a.BIZ_PLAN_ITEM_NO = b.BIZ_PLAN_ITEM_NO (+) \n";
			strSql += " And		a.CHG_SEQ = b.CHG_SEQ (+) \n";
			strSql += " Group By \n";
			strSql += " 	a.COMP_CODE, \n";
			strSql += " 	a.CLSE_ACC_ID, \n";
			strSql += " 	a.BIZ_PLAN_ITEM_NO , \n";
			strSql += " 	a.CRTUSERNO , \n";
			strSql += " 	a.CRTDATE , \n";
			strSql += " 	a.MODUSERNO , \n";
			strSql += " 	a.MODDATE , \n";
			strSql += " 	a.P_NO , \n";
			strSql += " 	a.LEVELED_FLOW_ITEM_NAME, \n";
			strSql += " 	a.IS_LEAF_TAG, \n";
			strSql += " 	a.RN \n";
			strSql += " Order By \n";
			strSql += " 	a.RN \n";
			strSql += "  ";
			
			lrArgData.addColumn("1WORK_YM", CITData.VARCHAR2);
			lrArgData.addColumn("2WORK_YM", CITData.VARCHAR2);
			lrArgData.addColumn("3WORK_YM", CITData.VARCHAR2);
			lrArgData.addColumn("4WORK_YM", CITData.VARCHAR2);
			lrArgData.addColumn("5WORK_YM", CITData.VARCHAR2);
			lrArgData.addColumn("6COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("7CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("8COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("9CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("10WORK_YM", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1WORK_YM", strWORK_YM);
			lrArgData.setValue("2WORK_YM", strWORK_YM);
			lrArgData.setValue("3WORK_YM", strWORK_YM);
			lrArgData.setValue("4WORK_YM", strWORK_YM);
			lrArgData.setValue("5WORK_YM", strWORK_YM);
			lrArgData.setValue("6COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("7CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("8COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("9CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("10WORK_YM", strWORK_YM);
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
		else if (strAct.equals("COPY"))
		{
			
			strSql  = " Select 'XXXXXXXXXX' COMP_CODE,'XXXXXXXXXX' CLSE_ACC_ID,'XXXXXXXXXXXXXXXXXXXX' DEPT_CODE,'000000' WORK_YM From Dual\n";
			
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
				GauceInfo.response.writeException("USER", "900001","COPY Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("REMOVE"))
		{
			
			strSql  = " Select 'XXXXXXXXXX' COMP_CODE,'XXXXXXXXXX' CLSE_ACC_ID,'XXXXXXXXXXXXXXXXXXXX' DEPT_CODE,'000000' WORK_YM From Dual\n";
			
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
				GauceInfo.response.writeException("USER", "900001","COPY Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("CLOSE"))
		{
			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String strCLSE_ACC_ID = CITCommon.toKOR(request.getParameter("CLSE_ACC_ID"));
			String strWORK_YM = CITCommon.toKOR(request.getParameter("WORK_YM"));
			
			strSql  = " Select F_T_FL_Is_Close_Comp_E( ? , ? , ? ) FORE_CONFIRM_TAG \n";
			strSql += " from dual ";
			
			lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("WORK_YM", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("WORK_YM", strWORK_YM);
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
				GauceInfo.response.writeException("USER", "900001","CLOSE Select 오류-> "+ ex.getMessage());
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