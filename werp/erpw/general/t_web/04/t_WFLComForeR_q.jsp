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
			String strQUARTER_YEAR = CITCommon.toKOR(request.getParameter("QUARTER_YEAR"));
			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String strCLSE_ACC_ID = CITCommon.toKOR(request.getParameter("CLSE_ACC_ID"));
			
			strSql  = " Select \n";
			strSql += " 	a.COMP_CODE, \n";
			strSql += " 	a.CLSE_ACC_ID, \n";
			strSql += " 	a.FLOW_CODE_B FLOW_CODE, \n";
			strSql += " 	a.CRTUSERNO , \n";
			strSql += " 	a.CRTDATE , \n";
			strSql += " 	a.MODUSERNO , \n";
			strSql += " 	a.MODDATE , \n";
			strSql += " 	a.P_NO , \n";
			strSql += " 	a.LEVELED_FLOW_ITEM_NAME, \n";
			strSql += " 	a.IS_LEAF_TAG, \n";
			strSql += " 	a.RN, \n";
			strSql += " 	a.LV, \n";
			strSql += " 	 ?   QUARTER_YEAR , \n";
			strSql += " 	a.SUBTITLE_NAME , \n";
			strSql += " 	Decode(a.LV,3,Sum(Case When b.YM < To_Char(  ?    * 3 - 2 ,'FM00') And a.LV = 3 Then \n";
			strSql += " 		b.EXEC_AMT \n";
			strSql += " 	Else \n";
			strSql += " 		Null \n";
			strSql += " 	End)) EXEC_AMT, \n";
			strSql += " 	Decode(a.LV,1, Max(Decode(b.YM,To_Char(  ?    * 3 - 2 ,'FM00'),b.SUM_PLAN_AMT)), \n";
			strSql += " 			2,Max(Decode(b.YM,To_Char(  ?    * 3 - 2 ,'FM00'),b.MOD_PLAN_AMT))	, \n";
			strSql += " 			3,Max(Decode(b.YM,To_Char(  ?    * 3 - 2 ,'FM00'),b.B_MOD_PLAN_AMT))	, \n";
			strSql += " 			4,Max(Decode(b.YM,To_Char(  ?    * 3 - 2 ,'FM00'),b.PLAN_AMT)))			PLAN_AMT_01, \n";
			strSql += " 	Decode(a.LV,1, Max(Decode(b.YM,To_Char(  ?    * 3 - 1 ,'FM00'),b.SUM_PLAN_AMT)), \n";
			strSql += " 			2,Max(Decode(b.YM,To_Char(  ?    * 3 - 1 ,'FM00'),b.MOD_PLAN_AMT))	, \n";
			strSql += " 			3,Max(Decode(b.YM,To_Char(  ?    * 3 - 1 ,'FM00'),b.B_MOD_PLAN_AMT))	, \n";
			strSql += " 			4,Max(Decode(b.YM,To_Char(  ?    * 3 - 1 ,'FM00'),b.PLAN_AMT)))			PLAN_AMT_02, \n";
			strSql += " 	Decode(a.LV,1, Max(Decode(b.YM,To_Char(  ?    * 3 ,'FM00'),b.SUM_PLAN_AMT)), \n";
			strSql += " 			2,Max(Decode(b.YM,To_Char(  ?    * 3 ,'FM00'),b.MOD_PLAN_AMT)), \n";
			strSql += " 			3,Max(Decode(b.YM,To_Char(  ?    * 3 ,'FM00'),b.B_MOD_PLAN_AMT))	, \n";
			strSql += " 			4,Max(Decode(b.YM,To_Char(  ?    * 3 ,'FM00'),b.PLAN_AMT)))			PLAN_AMT_03, \n";
			strSql += " 	Decode(a.LV,1, Max(Decode(b.YM,To_Char(  ?    * 3 - 2 ,'FM00'),b.SUM_FORECAST_AMT)), \n";
			strSql += " 			2,Max(Decode(b.YM,To_Char(  ?    * 3 - 2 ,'FM00'),b.MOD_FORECAST_AMT)), \n";
			strSql += " 			3,Max(Decode(b.YM,To_Char(  ?    * 3 - 2 ,'FM00'),b.B_MOD_FORECAST_AMT)), \n";
			strSql += " 			4,Max(Decode(b.YM,To_Char(  ?    * 3 - 2 ,'FM00'),b.FORECAST_AMT)))			FORECAST_AMT_01, \n";
			strSql += " 	Decode(a.LV,1, Max(Decode(b.YM,To_Char(  ?    * 3 - 1 ,'FM00'),b.SUM_FORECAST_AMT)), \n";
			strSql += " 			2,Max(Decode(b.YM,To_Char(  ?    * 3 - 1 ,'FM00'),b.MOD_FORECAST_AMT)), \n";
			strSql += " 			3,Max(Decode(b.YM,To_Char(  ?    * 3 - 1 ,'FM00'),b.B_MOD_FORECAST_AMT)), \n";
			strSql += " 			4,Max(Decode(b.YM,To_Char(  ?    * 3 - 1 ,'FM00'),b.FORECAST_AMT)))			FORECAST_AMT_02, \n";
			strSql += " 	Decode(a.LV,1, Max(Decode(b.YM,To_Char(  ?    * 3 ,'FM00'),b.SUM_FORECAST_AMT)), \n";
			strSql += " 			2,Max(Decode(b.YM,To_Char(  ?    * 3 ,'FM00'),b.MOD_FORECAST_AMT)), \n";
			strSql += " 			3,Max(Decode(b.YM,To_Char(  ?    * 3 ,'FM00'),b.B_MOD_FORECAST_AMT)), \n";
			strSql += " 			4,Max(Decode(b.YM,To_Char(  ?    * 3 ,'FM00'),b.FORECAST_AMT)))			FORECAST_AMT_03 \n";
			strSql += " From \n";
			strSql += " 	( \n";
			strSql += " 		Select \n";
			strSql += " 			a.COMP_CODE, \n";
			strSql += " 			a.CLSE_ACC_ID, \n";
			strSql += " 			a.FLOW_CODE_B , \n";
			strSql += " 			a.CRTUSERNO , \n";
			strSql += " 			a.CRTDATE , \n";
			strSql += " 			a.MODUSERNO , \n";
			strSql += " 			a.MODDATE , \n";
			strSql += " 			a.P_NO , \n";
			strSql += " 			a.LEVELED_FLOW_ITEM_NAME, \n";
			strSql += " 			a.IS_LEAF_TAG, \n";
			strSql += " 			a.RN, \n";
			strSql += " 			x.LV, \n";
			strSql += " 			Decode(x.LV,1,'집계',2,'현장조정',3,'본사조정',4,'계') SUBTITLE_NAME \n";
			strSql += " 		From \n";
			strSql += " 			( \n";
			strSql += " 				Select \n";
			strSql += " 					 ?  COMP_CODE, \n";
			strSql += " 					 ?  CLSE_ACC_ID, \n";
			strSql += " 					a.CRTUSERNO , \n";
			strSql += " 					a.CRTDATE , \n";
			strSql += " 					a.MODUSERNO , \n";
			strSql += " 					a.MODDATE , \n";
			strSql += " 					a.FLOW_CODE_B , \n";
			strSql += " 					a.P_NO , \n";
			strSql += " 					RPad(' ',(Level - 1) * 2,' ') || a.FLOW_ITEM_NAME LEVELED_FLOW_ITEM_NAME, \n";
			strSql += " 					a.IS_LEAF_TAG, \n";
			strSql += " 					RowNum RN \n";
			strSql += " 				From	T_FL_FLOW_CODE_B a \n";
			strSql += " 				Start with a.P_NO = 0 \n";
			strSql += " 				Connect by \n";
			strSql += " 					Prior	a.FLOW_CODE_B = a.P_NO \n";
			strSql += " 				Order Siblings By \n";
			strSql += " 					a.LEVEL_SEQ \n";
			strSql += " 			) a, \n";
			strSql += " 			( \n";
			strSql += " 				Select \n";
			strSql += " 					LEVEL LV \n";
			strSql += " 				From	Dual \n";
			strSql += " 				Connect By \n";
			strSql += " 					LEVEL <= 4 \n";
			strSql += " 			) x \n";
			strSql += " 		Order By \n";
			strSql += " 			a.RN, \n";
			strSql += " 			x.LV \n";
			strSql += " 	) a, \n";
			strSql += " 	( \n";
			strSql += " 		Select \n";
			strSql += " 			b.COMP_CODE , \n";
			strSql += " 			b.CLSE_ACC_ID , \n";
			strSql += " 			SubStrb(b.WORK_YM,-2) YM, \n";
			strSql += " 			b.WORK_YM , \n";
			strSql += " 			b.FLOW_CODE_B , \n";
			strSql += " 			b.EXEC_AMT , \n";
			strSql += " 			b.SUM_PLAN_AMT , \n";
			strSql += " 			b.MOD_PLAN_AMT , \n";
			strSql += " 			b.B_MOD_PLAN_AMT , \n";
			strSql += " 			b.PLAN_AMT , \n";
			strSql += " 			b.SUM_FORECAST_AMT , \n";
			strSql += " 			b.MOD_FORECAST_AMT , \n";
			strSql += " 			b.B_MOD_FORECAST_AMT , \n";
			strSql += " 			b.FORECAST_AMT \n";
			strSql += " 		From	T_FL_MONTH_PLAN_EXEC_B b \n";
			strSql += " 		Where	b.COMP_CODE =  ?  \n";
			strSql += " 		And		b.CLSE_ACC_ID =  ?  \n";
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
			strSql += " 	a.RN, \n";
			strSql += " 	a.LV, \n";
			strSql += " 	a.SUBTITLE_NAME \n";
			strSql += " Order By \n";
			strSql += " 	a.RN, \n";
			strSql += " 	a.LV \n";
			strSql += "  ";
			
			lrArgData.addColumn("QUARTER_YEAR1", CITData.NUMBER);
			lrArgData.addColumn("QUARTER_YEAR2", CITData.NUMBER);
			lrArgData.addColumn("QUARTER_YEAR3", CITData.NUMBER);
			lrArgData.addColumn("QUARTER_YEAR4", CITData.NUMBER);
			lrArgData.addColumn("QUARTER_YEAR5", CITData.NUMBER);
			lrArgData.addColumn("QUARTER_YEAR6", CITData.NUMBER);
			lrArgData.addColumn("QUARTER_YEAR7", CITData.NUMBER);
			lrArgData.addColumn("QUARTER_YEAR8", CITData.NUMBER);
			lrArgData.addColumn("QUARTER_YEAR9", CITData.NUMBER);
			lrArgData.addColumn("QUARTER_YEAR10", CITData.NUMBER);
			lrArgData.addColumn("QUARTER_YEAR11", CITData.NUMBER);
			lrArgData.addColumn("QUARTER_YEAR12", CITData.NUMBER);
			lrArgData.addColumn("QUARTER_YEAR13", CITData.NUMBER);
			lrArgData.addColumn("QUARTER_YEAR14", CITData.NUMBER);
			lrArgData.addColumn("QUARTER_YEAR15", CITData.NUMBER);
			lrArgData.addColumn("QUARTER_YEAR16", CITData.NUMBER);
			lrArgData.addColumn("QUARTER_YEAR17", CITData.NUMBER);
			lrArgData.addColumn("QUARTER_YEAR18", CITData.NUMBER);
			lrArgData.addColumn("QUARTER_YEAR19", CITData.NUMBER);
			lrArgData.addColumn("QUARTER_YEAR20", CITData.NUMBER);
			lrArgData.addColumn("QUARTER_YEAR21", CITData.NUMBER);
			lrArgData.addColumn("QUARTER_YEAR22", CITData.NUMBER);
			lrArgData.addColumn("QUARTER_YEAR23", CITData.NUMBER);
			lrArgData.addColumn("QUARTER_YEAR24", CITData.NUMBER);
			lrArgData.addColumn("QUARTER_YEAR25", CITData.NUMBER);
			lrArgData.addColumn("QUARTER_YEAR26", CITData.NUMBER);
			lrArgData.addColumn("COMP_CODE1", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID1", CITData.VARCHAR2);
			lrArgData.addColumn("COMP_CODE2", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID2", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("QUARTER_YEAR1", strQUARTER_YEAR);
			lrArgData.setValue("QUARTER_YEAR2", strQUARTER_YEAR);
			lrArgData.setValue("QUARTER_YEAR3", strQUARTER_YEAR);
			lrArgData.setValue("QUARTER_YEAR4", strQUARTER_YEAR);
			lrArgData.setValue("QUARTER_YEAR5", strQUARTER_YEAR);
			lrArgData.setValue("QUARTER_YEAR6", strQUARTER_YEAR);
			lrArgData.setValue("QUARTER_YEAR7", strQUARTER_YEAR);
			lrArgData.setValue("QUARTER_YEAR8", strQUARTER_YEAR);
			lrArgData.setValue("QUARTER_YEAR9", strQUARTER_YEAR);
			lrArgData.setValue("QUARTER_YEAR10", strQUARTER_YEAR);
			lrArgData.setValue("QUARTER_YEAR11", strQUARTER_YEAR);
			lrArgData.setValue("QUARTER_YEAR12", strQUARTER_YEAR);
			lrArgData.setValue("QUARTER_YEAR13", strQUARTER_YEAR);
			lrArgData.setValue("QUARTER_YEAR14", strQUARTER_YEAR);
			lrArgData.setValue("QUARTER_YEAR15", strQUARTER_YEAR);
			lrArgData.setValue("QUARTER_YEAR16", strQUARTER_YEAR);
			lrArgData.setValue("QUARTER_YEAR17", strQUARTER_YEAR);
			lrArgData.setValue("QUARTER_YEAR18", strQUARTER_YEAR);
			lrArgData.setValue("QUARTER_YEAR19", strQUARTER_YEAR);
			lrArgData.setValue("QUARTER_YEAR20", strQUARTER_YEAR);
			lrArgData.setValue("QUARTER_YEAR21", strQUARTER_YEAR);
			lrArgData.setValue("QUARTER_YEAR22", strQUARTER_YEAR);
			lrArgData.setValue("QUARTER_YEAR23", strQUARTER_YEAR);
			lrArgData.setValue("QUARTER_YEAR24", strQUARTER_YEAR);
			lrArgData.setValue("QUARTER_YEAR25", strQUARTER_YEAR);
			lrArgData.setValue("QUARTER_YEAR26", strQUARTER_YEAR);
			lrArgData.setValue("COMP_CODE1", strCOMP_CODE);
			lrArgData.setValue("CLSE_ACC_ID1", strCLSE_ACC_ID);
			lrArgData.setValue("COMP_CODE2", strCOMP_CODE);
			lrArgData.setValue("CLSE_ACC_ID2", strCLSE_ACC_ID);
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
			
			strSql  = " Select 'XXXXXXXXXX' COMP_CODE,'XXXXXXXXXX' CLSE_ACC_ID,'XXXXXXXXXXXXXXXXXXXX' DEPT_CODE,0 QUARTER_YEAR  From Dual\n";
			
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
			
			strSql  = " Select 'XXXXXXXXXX' COMP_CODE,'XXXXXXXXXX' CLSE_ACC_ID,'XXXXXXXXXXXXXXXXXXXX' DEPT_CODE,0 QUARTER_YEAR  From Dual\n";
			
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
			String strQUARTER_YEAR = CITCommon.toKOR(request.getParameter("QUARTER_YEAR"));
			
			strSql  = " Select F_T_FL_Is_Close_Comp_F( ? , ? , ? ) FORE_CONFIRM_TAG \n";
			strSql += " from dual ";
			
			lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("QUARTER_YEAR", CITData.NUMBER);
			lrArgData.addRow();
			lrArgData.setValue("COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("QUARTER_YEAR", strQUARTER_YEAR);
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