<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 홍길동 작성(2006-05-21)
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
			String strBASE_AMT = CITCommon.toKOR(request.getParameter("BASE_AMT"));
			String strWORK_YM_01 = CITCommon.toKOR(request.getParameter("WORK_YM_01"));
			String strWORK_YM_02 = CITCommon.toKOR(request.getParameter("WORK_YM_02"));
			String strWORK_YM_03 = CITCommon.toKOR(request.getParameter("WORK_YM_03"));
			String strWORK_YM_04 = CITCommon.toKOR(request.getParameter("WORK_YM_04"));
			String strWORK_YM_05 = CITCommon.toKOR(request.getParameter("WORK_YM_05"));
			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String strWORK_YM_TO = CITCommon.toKOR(request.getParameter("WORK_YM_TO"));
			String strRECEIVE_TAG = CITCommon.toKOR(request.getParameter("RECEIVE_TAG"));
			String strDEPT_CODE = CITCommon.toKOR(request.getParameter("DEPT_CODE"));
			
			strSql  = " Select \n";
			strSql += " 	Nvl(a.RECEIVE_TAG,'*') RECEIVE_TAG, \n";
			strSql += " 	Nvl(a.DEPT_NAME ,'*') DEPT_NAME, \n";
			strSql += " 	Nvl(Case When a.Grp2 = 1 Then '총   계' When a.Grp1 = 1 And a.Grp2 = 0 Then a.RECEIVE_TAG_NAME||' 계' Else a.RECEIVE_TAG_NAME End,'*') RECEIVE_TAG_NAME, \n";
			strSql += " 	Nvl(a.DEPT_CODE,'*') DEPT_CODE, \n";
			strSql += " 	Case When a.REMAIN_AMT < 0 Then 0 Else a.REMAIN_AMT End REMAIN_AMT, \n";
			strSql += " 	a.AMT_01, \n";
			strSql += " 	a.AMT_02, \n";
			strSql += " 	a.AMT_03, \n";
			strSql += " 	a.AMT_04, \n";
			strSql += " 	a.AMT_05, \n";
			strSql += " 	a.AMT_06 \n";
			strSql += " From \n";
			strSql += " 	( \n";
			strSql += " 		Select \n";
			strSql += " 			a.RECEIVE_TAG, \n";
			strSql += " 			a.DEPT_CODE, \n";
			strSql += " 			a.DEPT_NAME, \n";
			strSql += " 			a.RECEIVE_TAG_NAME, \n";
			strSql += " 			Grouping(a.DEPT_CODE) Grp1, \n";
			strSql += " 			Grouping(a.RECEIVE_TAG) Grp2, \n";
			strSql += " 			Sum(a.REMAIN_AMT) REMAIN_AMT, \n";
			strSql += " 			Sum(a.AMT_01) AMT_01, \n";
			strSql += " 			Sum(a.AMT_02) AMT_02, \n";
			strSql += " 			Sum(a.AMT_03) AMT_03, \n";
			strSql += " 			Sum(a.AMT_04) AMT_04, \n";
			strSql += " 			Sum(a.AMT_05) AMT_05, \n";
			strSql += " 			Sum(a.AMT_06) AMT_06 \n";
			strSql += " 		From \n";
			strSql += " 			( \n";
			strSql += " 				Select \n";
			strSql += " 					b.RECEIVE_TAG, \n";
			strSql += " 					b.DEPT_CODE, \n";
			strSql += " 					b.DEPT_NAME, \n";
			strSql += " 					b.RECEIVE_TAG_NAME, \n";
			strSql += " 					Round((Nvl(Sum(a.REMAIN_AMT),0) - Nvl(Sum(a.RESET_AMT),0)) /  ? ) REMAIN_AMT, \n";
			strSql += " 					Round(Sum(Case When a.WORK_YM =  ?  Then a.LAG_RESET_REMAIN_RUN_SUM Else 0 End) /  ? ) AMT_01, \n";
			strSql += " 					Round(Sum(Case When a.WORK_YM >=  ?  And a.WORK_YM <  ?  Then a.LAG_RESET_REMAIN_RUN_SUM Else 0 End) /  ? ) AMT_02, \n";
			strSql += " 					Round(Sum(Case When a.WORK_YM >=  ?  And a.WORK_YM <  ?  Then a.LAG_RESET_REMAIN_RUN_SUM Else 0 End) /  ? ) AMT_03, \n";
			strSql += " 					Round(Sum(Case When a.WORK_YM >=  ?  And a.WORK_YM <  ?  Then a.LAG_RESET_REMAIN_RUN_SUM Else 0 End) /  ? ) AMT_04, \n";
			strSql += " 					Round(Sum(Case When a.WORK_YM >=  ?  And a.WORK_YM <  ?  Then a.LAG_RESET_REMAIN_RUN_SUM Else 0 End) /  ? ) AMT_05, \n";
			strSql += " 					Round(Sum(Case When a.WORK_YM <  ?  Then a.LAG_RESET_REMAIN_RUN_SUM Else 0 End) /  ? ) AMT_06 \n";
			strSql += " 				From \n";
			strSql += " 					( \n";
			strSql += " 						Select \n";
			strSql += " 							a.DEPT_CODE, \n";
			strSql += " 							a.WORK_YM, \n";
			strSql += " 							a.REMAIN_AMT, \n";
			strSql += " 							a.RESET_AMT, \n";
			strSql += " 							Case \n";
			strSql += " 							When a.RESET_REMAIN_RUN_SUM >= 0 Then \n";
			strSql += " 								0 \n";
			strSql += " 							When a.RESET_REMAIN_RUN_SUM < 0 And Nvl(Lag(a.RESET_REMAIN_RUN_SUM) Over (Partition By a.DEPT_CODE Order By a.DEPT_CODE,a.WORK_YM) ,0) >= 0 Then \n";
			strSql += " 								- a.RESET_REMAIN_RUN_SUM \n";
			strSql += " 							When a.RESET_REMAIN_RUN_SUM < 0 And Nvl(Lag(a.RESET_REMAIN_RUN_SUM) Over (Partition By a.DEPT_CODE Order By a.DEPT_CODE,a.WORK_YM) ,0) < 0 Then \n";
			strSql += " 								Nvl(Lag(a.RESET_REMAIN_RUN_SUM) Over (Partition By a.DEPT_CODE Order By a.DEPT_CODE,a.WORK_YM) ,0) - Nvl(a.RESET_REMAIN_RUN_SUM,0) \n";
			strSql += " 							Else \n";
			strSql += " 								0 \n";
			strSql += " 							End LAG_RESET_REMAIN_RUN_SUM \n";
			strSql += " 						From \n";
			strSql += " 							( \n";
			strSql += " 								Select \n";
			strSql += " 									a.DEPT_CODE, \n";
			strSql += " 									a.WORK_YM, \n";
			strSql += " 									a.SET_AMT, \n";
			strSql += " 									a.N_SET_AMT, \n";
			strSql += " 									a.REMAIN_AMT, \n";
			strSql += " 									a.RESET_AMT, \n";
			strSql += " 									Sum(a.RESET_AMT) Over ( Partition By a.DEPT_CODE) RESET_SUM, \n";
			strSql += " 									Sum(a.RESET_AMT) Over ( Partition By a.DEPT_CODE Order By a.DEPT_CODE,a.WORK_YM) RESET_RUN_SUM, \n";
			strSql += " 									Sum(a.REMAIN_AMT) Over( Partition By a.DEPT_CODE Order By a.DEPT_CODE,a.WORK_YM) REMAIN_RUN_SUM, \n";
			strSql += " 									Nvl(Sum(a.RESET_AMT) Over ( Partition By a.DEPT_CODE),0) -  \n";
			strSql += " 										Nvl(Sum(a.REMAIN_AMT) Over( Partition By a.DEPT_CODE Order By a.DEPT_CODE,a.WORK_YM),0) RESET_REMAIN_RUN_SUM \n";
			strSql += " 								From \n";
			strSql += " 									( \n";
			strSql += " 										Select \n";
			strSql += " 											a.DEPT_CODE, \n";
			strSql += " 											To_Char(a.MAKE_DT,'YYYYMM') WORK_YM, \n";
			strSql += " 											Nvl(Sum(a.DB_AMT),0) SET_AMT, \n";
			strSql += " 											Sum( \n";
			strSql += " 											Case a.ACC_CODE \n";
			strSql += " 											When '111070200' Then		--공사미수금세금계산 \n";
			strSql += " 												0 \n";
			strSql += " 											Else \n";
			strSql += " 												- a.CR_AMT \n";
			strSql += " 											End) N_SET_AMT, \n";
			strSql += " 											Sum(Case a.ACC_CODE \n";
			strSql += " 											When '111070200' Then		--공사미수금세금계산 \n";
			strSql += " 												a.CR_AMT \n";
			strSql += " 											Else \n";
			strSql += " 												0 \n";
			strSql += " 											End)   + \n";
			strSql += " 											Nvl(Case When \n";
			strSql += " 												Nvl(Sum(a.DB_AMT),0) +  \n";
			strSql += " 												Nvl( \n";
			strSql += " 												Sum( \n";
			strSql += " 												Case a.ACC_CODE \n";
			strSql += " 												When '111070200' Then		--공사미수금세금계산 \n";
			strSql += " 													0 \n";
			strSql += " 												Else \n";
			strSql += " 													- a.CR_AMT \n";
			strSql += " 												End),0) < 0 Then \n";
			strSql += " 												-(Nvl(Sum(a.DB_AMT),0) +  \n";
			strSql += " 												Nvl( \n";
			strSql += " 												Sum( \n";
			strSql += " 												Case a.ACC_CODE \n";
			strSql += " 												When '111070200' Then		--공사미수금세금계산 \n";
			strSql += " 													0 \n";
			strSql += " 												Else \n";
			strSql += " 													- a.CR_AMT \n";
			strSql += " 												End),0)) \n";
			strSql += " 											Else \n";
			strSql += " 												0 \n";
			strSql += " 											End,0) RESET_AMT, \n";
			strSql += " 											Case \n";
			strSql += " 											When  \n";
			strSql += " 												Nvl(Sum(a.DB_AMT),0) +  \n";
			strSql += " 												Nvl( \n";
			strSql += " 												Sum( \n";
			strSql += " 												Case a.ACC_CODE \n";
			strSql += " 												When '111070200' Then		--공사미수금세금계산 \n";
			strSql += " 													0 \n";
			strSql += " 												Else \n";
			strSql += " 													- a.CR_AMT \n";
			strSql += " 												End),0) < 0 Then \n";
			strSql += " 												0 \n";
			strSql += " 											Else \n";
			strSql += " 												Nvl(Sum(a.DB_AMT),0) +  \n";
			strSql += " 												Nvl( \n";
			strSql += " 												Sum( \n";
			strSql += " 												Case a.ACC_CODE \n";
			strSql += " 												When '111070200' Then		--공사미수금세금계산 \n";
			strSql += " 													0 \n";
			strSql += " 												Else \n";
			strSql += " 													- a.CR_AMT \n";
			strSql += " 												End),0) \n";
			strSql += " 											End REMAIN_AMT \n";
			strSql += " 										From	t_acc_slip_body1 a \n";
			strSql += " 										Where	a.KEEP_DT Is Not Null \n";
			strSql += " 										And		a.TRANSFER_TAG = 'F' \n";
			strSql += " 										And		a.COMP_CODE =  ?  \n";
			strSql += " 										And		a.MAKE_DT <= Last_Day(to_Date( ? ||'01')) \n";
			strSql += " 										And		a.ACC_CODE In ( \n";
			strSql += " 											'111070100',		--공사미수금작업진행율 \n";
			strSql += " 											'111070200',		--공사미수금세금계산 \n";
			strSql += " 											'111079000',		--공사미수금기타 \n";
			strSql += " 											'210060100',		--공사선수금 진행율 \n";
			strSql += " 											'210060200'			--공사선수금 계산서 \n";
			strSql += " 										) \n";
			strSql += " 										Group By \n";
			strSql += " 											a.DEPT_CODE, \n";
			strSql += " 											To_Char(a.MAKE_DT,'YYYYMM') \n";
			strSql += " 									) a \n";
			strSql += " 								Order By \n";
			strSql += " 									a.DEPT_CODE, \n";
			strSql += " 									a.WORK_YM \n";
			strSql += " 							) a \n";
			strSql += " 						Order By \n";
			strSql += " 							a.DEPT_CODE, \n";
			strSql += " 							a.WORK_YM \n";
			strSql += " 					) a, \n";
			strSql += " 					V_T_DEPT_CONTRACT_NP b \n";
			strSql += " 				Where	a.DEPT_CODE (+) = b.DEPT_CODE \n";
			strSql += " 				And		b.RECEIVE_TAG Like  ?  || '%' \n";
			strSql += " 				And		b.DEPT_CODE Like  ?  || '%' \n";
			strSql += " 				Group by \n";
			strSql += " 					b.RECEIVE_TAG, \n";
			strSql += " 					b.DEPT_CODE, \n";
			strSql += " 					b.DEPT_NAME, \n";
			strSql += " 					b.RECEIVE_TAG_NAME \n";
			strSql += " 			) a \n";
			strSql += " 		Group By Grouping Sets \n";
			strSql += " 		( \n";
			strSql += " 			( \n";
			strSql += " 				a.RECEIVE_TAG, \n";
			strSql += " 				a.RECEIVE_TAG_NAME, \n";
			strSql += " 				a.DEPT_CODE, \n";
			strSql += " 				a.DEPT_NAME \n";
			strSql += " 			), \n";
			strSql += " 			( \n";
			strSql += " 				a.RECEIVE_TAG, \n";
			strSql += " 				a.RECEIVE_TAG_NAME \n";
			strSql += " 			), \n";
			strSql += " 			( \n";
			strSql += " 			) \n";
			strSql += " 		) \n";
			strSql += " 	) a \n";
			strSql += " Order By \n";
			strSql += " 	a.RECEIVE_TAG, \n";
			strSql += " 	a.DEPT_CODE \n";
			strSql += "  ";
			
			lrArgData.addColumn("1BASE_AMT", CITData.NUMBER);
			lrArgData.addColumn("2WORK_YM_01", CITData.VARCHAR2);
			lrArgData.addColumn("3BASE_AMT", CITData.NUMBER);
			lrArgData.addColumn("4WORK_YM_02", CITData.VARCHAR2);
			lrArgData.addColumn("5WORK_YM_01", CITData.VARCHAR2);
			lrArgData.addColumn("6BASE_AMT", CITData.NUMBER);
			lrArgData.addColumn("7WORK_YM_03", CITData.VARCHAR2);
			lrArgData.addColumn("8WORK_YM_02", CITData.VARCHAR2);
			lrArgData.addColumn("9BASE_AMT", CITData.NUMBER);
			lrArgData.addColumn("10WORK_YM_04", CITData.VARCHAR2);
			lrArgData.addColumn("11WORK_YM_03", CITData.VARCHAR2);
			lrArgData.addColumn("12BASE_AMT", CITData.NUMBER);
			lrArgData.addColumn("13WORK_YM_05", CITData.VARCHAR2);
			lrArgData.addColumn("14WORK_YM_04", CITData.VARCHAR2);
			lrArgData.addColumn("15BASE_AMT", CITData.NUMBER);
			lrArgData.addColumn("16WORK_YM_05", CITData.VARCHAR2);
			lrArgData.addColumn("17BASE_AMT", CITData.NUMBER);
			lrArgData.addColumn("18COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("19WORK_YM_TO", CITData.VARCHAR2);
			lrArgData.addColumn("20RECEIVE_TAG", CITData.VARCHAR2);
			lrArgData.addColumn("21DEPT_CODE", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1BASE_AMT", strBASE_AMT);
			lrArgData.setValue("2WORK_YM_01", strWORK_YM_01);
			lrArgData.setValue("3BASE_AMT", strBASE_AMT);
			lrArgData.setValue("4WORK_YM_02", strWORK_YM_02);
			lrArgData.setValue("5WORK_YM_01", strWORK_YM_01);
			lrArgData.setValue("6BASE_AMT", strBASE_AMT);
			lrArgData.setValue("7WORK_YM_03", strWORK_YM_03);
			lrArgData.setValue("8WORK_YM_02", strWORK_YM_02);
			lrArgData.setValue("9BASE_AMT", strBASE_AMT);
			lrArgData.setValue("10WORK_YM_04", strWORK_YM_04);
			lrArgData.setValue("11WORK_YM_03", strWORK_YM_03);
			lrArgData.setValue("12BASE_AMT", strBASE_AMT);
			lrArgData.setValue("13WORK_YM_05", strWORK_YM_05);
			lrArgData.setValue("14WORK_YM_04", strWORK_YM_04);
			lrArgData.setValue("15BASE_AMT", strBASE_AMT);
			lrArgData.setValue("16WORK_YM_05", strWORK_YM_05);
			lrArgData.setValue("17BASE_AMT", strBASE_AMT);
			lrArgData.setValue("18COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("19WORK_YM_TO", strWORK_YM_TO);
			lrArgData.setValue("20RECEIVE_TAG", strRECEIVE_TAG);
			lrArgData.setValue("21DEPT_CODE", strDEPT_CODE);
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