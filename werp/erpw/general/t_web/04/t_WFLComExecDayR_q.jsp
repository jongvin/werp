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
			String strWORK_DT = CITCommon.toKOR(request.getParameter("WORK_DT"));
			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String strCLSE_ACC_ID = CITCommon.toKOR(request.getParameter("CLSE_ACC_ID"));
			
			strSql  = " Select \n";
			strSql += " 	a.COMP_CODE, \n";
			strSql += " 	a.CLSE_ACC_ID, \n";
			strSql += " 	a.FLOW_CODE_B FLOW_CODE , \n";
			strSql += " 	a.CRTUSERNO , \n";
			strSql += " 	a.CRTDATE , \n";
			strSql += " 	a.MODUSERNO , \n";
			strSql += " 	a.MODDATE , \n";
			strSql += " 	a.P_NO , \n";
			strSql += " 	a.LEVELED_FLOW_ITEM_NAME, \n";
			strSql += " 	a.IS_LEAF_TAG, \n";
			strSql += " 	a.RN, \n";
			strSql += " 	?  WORK_DT , \n";
			strSql += " 	Sum( \n";
			strSql += " 	Case When b.WORK_DT <  Trunc(F_T_STRINGTODATE( ? ),'MM')   Then \n";
			strSql += " 		b.EXEC_AMT \n";
			strSql += " 	Else \n";
			strSql += " 		Null \n";
			strSql += " 	End) PRE_MON_EXEC_AMT, \n";
			strSql += " 	Sum( \n";
			strSql += " 	Case When b.WORK_DT >= Trunc(F_T_STRINGTODATE( ? ),'MM') And b.WORK_DT < F_T_STRINGTODATE( ? )  Then \n";
			strSql += " 		b.EXEC_AMT \n";
			strSql += " 	Else \n";
			strSql += " 		Null \n";
			strSql += " 	End) PRE_EXEC_AMT, \n";
			strSql += " 	Sum( \n";
			strSql += " 	Case When b.WORK_DT = F_T_STRINGTODATE( ? ) Then \n";
			strSql += " 		b.SUM_EXEC_AMT \n";
			strSql += " 	Else \n";
			strSql += " 		Null \n";
			strSql += " 	End) SUM_EXEC_AMT, \n";
			strSql += " 	Sum( \n";
			strSql += " 	Case When b.WORK_DT = F_T_STRINGTODATE( ? ) Then \n";
			strSql += " 		b.MOD_EXEC_AMT \n";
			strSql += " 	Else \n";
			strSql += " 		Null \n";
			strSql += " 	End) MOD_EXEC_AMT, \n";
			strSql += " 	Sum( \n";
			strSql += " 	Case When b.WORK_DT = F_T_STRINGTODATE( ? ) Then \n";
			strSql += " 		b.EXEC_AMT \n";
			strSql += " 	Else \n";
			strSql += " 		Null \n";
			strSql += " 	End) EXEC_AMT, \n";
			strSql += " 	Sum(b.EXEC_AMT) TOT_EXEC_AMT \n";
			strSql += " From \n";
			strSql += " 	( \n";
			strSql += " 		Select \n";
			strSql += " 			 ?  COMP_CODE, \n";
			strSql += " 			 ?  CLSE_ACC_ID, \n";
			strSql += " 			a.CRTUSERNO , \n";
			strSql += " 			a.CRTDATE , \n";
			strSql += " 			a.MODUSERNO , \n";
			strSql += " 			a.MODDATE , \n";
			strSql += " 			a.FLOW_CODE_B , \n";
			strSql += " 			a.P_NO , \n";
			strSql += " 			RPad(' ',(Level - 1) * 2,' ') || a.FLOW_ITEM_NAME LEVELED_FLOW_ITEM_NAME, \n";
			strSql += " 			a.IS_LEAF_TAG, \n";
			strSql += " 			RowNum RN \n";
			strSql += " 		From	T_FL_FLOW_CODE_B a \n";
			strSql += " 		Start with a.P_NO = 0 \n";
			strSql += " 		Connect by \n";
			strSql += " 			Prior	a.FLOW_CODE_B = a.P_NO \n";
			strSql += " 		Order Siblings By \n";
			strSql += " 			a.LEVEL_SEQ \n";
			strSql += " 	) a, \n";
			strSql += " 	( \n";
			strSql += " 		Select \n";
			strSql += " 			b.COMP_CODE , \n";
			strSql += " 			b.CLSE_ACC_ID , \n";
			strSql += " 			b.WORK_DT , \n";
			strSql += " 			b.FLOW_CODE_B , \n";
			strSql += " 			b.SUM_EXEC_AMT , \n";
			strSql += " 			b.MOD_EXEC_AMT , \n";
			strSql += " 			b.EXEC_AMT \n";
			strSql += " 		From	T_FL_DAY_EXEC_B b \n";
			strSql += " 		Where	b.COMP_CODE =  ?  \n";
			strSql += " 		And		b.CLSE_ACC_ID =  ?  \n";
			strSql += " 		And		b.WORK_DT <= F_T_STRINGTODATE( ? ) \n";
			strSql += " 	) b \n";
			strSql += " Where	a.COMP_CODE = b.COMP_CODE (+) \n";
			strSql += " And		a.CLSE_ACC_ID = b.CLSE_ACC_ID (+) \n";
			strSql += " And		a.FLOW_CODE_B = b.FLOW_CODE_B (+) \n";
			strSql += " Group By \n";
			strSql += " 	a.COMP_CODE, \n";
			strSql += " 	a.CLSE_ACC_ID, \n";
			strSql += " 	a.FLOW_CODE_B , \n";
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
			
			lrArgData.addColumn("1WORK_DT", CITData.VARCHAR2);
			lrArgData.addColumn("2WORK_DT", CITData.VARCHAR2);
			lrArgData.addColumn("3WORK_DT", CITData.VARCHAR2);
			lrArgData.addColumn("4WORK_DT", CITData.VARCHAR2);
			lrArgData.addColumn("5WORK_DT", CITData.VARCHAR2);
			lrArgData.addColumn("6WORK_DT", CITData.VARCHAR2);
			lrArgData.addColumn("7WORK_DT", CITData.VARCHAR2);
			lrArgData.addColumn("8COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("9CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("10COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("11CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("12WORK_DT", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1WORK_DT", strWORK_DT);
			lrArgData.setValue("2WORK_DT", strWORK_DT);
			lrArgData.setValue("3WORK_DT", strWORK_DT);
			lrArgData.setValue("4WORK_DT", strWORK_DT);
			lrArgData.setValue("5WORK_DT", strWORK_DT);
			lrArgData.setValue("6WORK_DT", strWORK_DT);
			lrArgData.setValue("7WORK_DT", strWORK_DT);
			lrArgData.setValue("8COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("9CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("10COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("11CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("12WORK_DT", strWORK_DT);
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
			
			strSql  = " Select 'XXXXXXXXXX' COMP_CODE,'XXXXXXXXXX' CLSE_ACC_ID,'0000-00-00' WORK_DT From Dual\n";
			
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
			
			strSql  = " Select 'XXXXXXXXXX' COMP_CODE,'XXXXXXXXXX' CLSE_ACC_ID,'0000-00-00' WORK_DT From Dual\n";
			
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