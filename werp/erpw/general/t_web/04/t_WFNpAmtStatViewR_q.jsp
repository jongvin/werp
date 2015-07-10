<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 홍길동 작성(2006-05-15)
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
			String strWORK_YM_TO = CITCommon.toKOR(request.getParameter("WORK_YM_TO"));
			String strBASE_AMT = CITCommon.toKOR(request.getParameter("BASE_AMT"));
			String strRECEIVE_TAG = CITCommon.toKOR(request.getParameter("RECEIVE_TAG"));
			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String strDEPT_CODE = CITCommon.toKOR(request.getParameter("DEPT_CODE"));
			
			strSql  = " Select \n";
			strSql += " 	Nvl(a.RECEIVE_TAG,'*') RECEIVE_TAG, \n";
			strSql += " 	Nvl(Case When a.Grp1 = 1 And a.Grp2 = 0 Then a.RECEIVE_TAG_NAME||' 계' Else a.DEPT_NAME End,'*') DEPT_NAME, \n";
			strSql += " 	Nvl(Case When a.Grp2 = 1 Then '총   계' Else a.RECEIVE_TAG_NAME End,'*') RECEIVE_TAG_NAME, \n";
			strSql += " 	Nvl(a.DEPT_CODE,'*') DEPT_CODE, \n";
			strSql += " 	a.F_CONS_AMT, \n";
			strSql += " 	a.CONS_AMT, \n";
			strSql += " 	round(a.SET_AMT_00 / ? ) SET_AMT_00, \n";
			strSql += " 	round(a.RESET_AMT_00 / ? ) RESET_AMT_00, \n";
			strSql += " 	round(Case When a.REMAIN_AMT_00 < 0 Then 0 Else a.REMAIN_AMT_00 End / ? ) REMAIN_AMT_00, \n";
			strSql += " 	round(a.SET_AMT_01 / ? ) SET_AMT_01, \n";
			strSql += " 	round(a.RESET_AMT_01 / ? ) RESET_AMT_01, \n";
			strSql += " 	round(Case When a.REMAIN_AMT_03 < 0 Then 0 Else a.REMAIN_AMT_03 End / ? ) REMAIN_AMT_01, \n";
			strSql += " 	round(a.SET_AMT_02 / ? ) SET_AMT_02, \n";
			strSql += " 	round(a.RESET_AMT_02 / ? ) RESET_AMT_02, \n";
			strSql += " 	round(Case When a.REMAIN_AMT_03 < 0 Then 0 Else a.REMAIN_AMT_03 End / ? ) REMAIN_AMT_02, \n";
			strSql += " 	round(a.SET_AMT_03 / ? ) SET_AMT_03, \n";
			strSql += " 	round(a.RESET_AMT_03 / ? ) RESET_AMT_03, \n";
			strSql += " 	round(Case When a.REMAIN_AMT_03 < 0 Then 0 Else a.REMAIN_AMT_03 End / ? ) REMAIN_AMT_03 \n";
			strSql += " From \n";
			strSql += " 	( \n";
			strSql += " 		Select \n";
			strSql += " 			b.RECEIVE_TAG, \n";
			strSql += " 			b.RECEIVE_TAG_NAME, \n";
			strSql += " 			b.DEPT_CODE, \n";
			strSql += " 			b.DEPT_NAME, \n";
			strSql += " 			Grouping(b.DEPT_CODE) Grp1, \n";
			strSql += " 			Grouping(b.RECEIVE_TAG) Grp2, \n";
			strSql += " 			Round(b.F_CONS_AMT / ? ) F_CONS_AMT, \n";
			strSql += " 			Round(b.CONS_AMT / ? ) CONS_AMT, \n";
			strSql += " 			Sum(Case When a.WORK_YM < SubStrb( ? ,1,4)||'01' Then a.SET_AMT Else 0 End ) SET_AMT_00, \n";
			strSql += " 			Sum(Case When a.WORK_YM < SubStrb( ? ,1,4)||'01' Then a.RESET_AMT Else 0 End ) RESET_AMT_00, \n";
			strSql += " 			Sum(Case When a.WORK_YM < SubStrb( ? ,1,4)||'01' Then a.REMAIN_AMT Else 0 End ) REMAIN_AMT_00, \n";
			strSql += " 			Sum(Case When a.WORK_YM =  ?  Then a.SET_AMT Else 0 End ) SET_AMT_01, \n";
			strSql += " 			Sum(Case When a.WORK_YM =  ?  Then a.RESET_AMT Else 0 End ) RESET_AMT_01, \n";
			strSql += " 			Sum(Case When a.WORK_YM =  ?  Then a.REMAIN_AMT Else 0 End ) REMAIN_AMT_01, \n";
			strSql += " 			Sum(Case When a.WORK_YM >= SubStrb( ? ,1,4)||'01' Then a.SET_AMT Else 0 End ) SET_AMT_02, \n";
			strSql += " 			Sum(Case When a.WORK_YM >= SubStrb( ? ,1,4)||'01' Then a.RESET_AMT Else 0 End ) RESET_AMT_02, \n";
			strSql += " 			Sum(Case When a.WORK_YM >= SubStrb( ? ,1,4)||'01' Then a.REMAIN_AMT Else 0 End ) REMAIN_AMT_02, \n";
			strSql += " 			Sum(a.SET_AMT) SET_AMT_03, \n";
			strSql += " 			Sum(a.RESET_AMT) RESET_AMT_03, \n";
			strSql += " 			Sum(a.REMAIN_AMT) REMAIN_AMT_03 \n";
			strSql += " 		From \n";
			strSql += " 			( \n";
			strSql += " 				Select \n";
			strSql += " 					a.DEPT_CODE, \n";
			strSql += " 					To_Char(a.MAKE_DT,'YYYYMM') WORK_YM, \n";
			strSql += " 					Round(Sum( \n";
			strSql += " 						Case a.ACC_CODE \n";
			strSql += " 							When '111070200' Then \n";	
			strSql += " 								a.DB_AMT \n";
			strSql += " 							Else \n";
			strSql += " 								Nvl(a.DB_AMT,0) - Nvl(a.CR_AMT,0) \n";
			strSql += " 						End \n";
			strSql += " 					) /  1  ) SET_AMT, \n";
			strSql += " 					Round(Sum( \n";
			strSql += " 						Case a.ACC_CODE \n";
			strSql += " 							When '111070200' Then \n";
			strSql += " 								a.CR_AMT \n";
			strSql += " 							Else \n";
			strSql += " 								0 \n";
			strSql += " 						End \n";
			strSql += " 					) /  1  ) RESET_AMT, \n";
			strSql += " 					Round((Nvl(Sum( \n";
			strSql += " 						Case a.ACC_CODE \n";
			strSql += " 							When '111070200' Then \n";
			strSql += " 								a.DB_AMT \n";
			strSql += " 							Else \n";
			strSql += " 								Nvl(a.DB_AMT,0) - Nvl(a.CR_AMT,0) \n";
			strSql += " 						End \n";
			strSql += " 					),0) -  \n";
			strSql += " 					Nvl(Sum( \n";
			strSql += " 						Case a.ACC_CODE \n";
			strSql += " 							When '111070200' Then \n";
			strSql += " 								a.CR_AMT \n";
			strSql += " 							Else \n";
			strSql += " 								0 \n";
			strSql += " 						End \n";
			strSql += " 					),0)) /  1  ) REMAIN_AMT \n";
			strSql += " 				From	t_acc_slip_body1 a \n";
			strSql += " 				Where	a.KEEP_DT Is Not Null \n";
			strSql += " 				And		a.TRANSFER_TAG = 'F' \n";
			strSql += " 				And		a.COMP_CODE = ? \n";
			strSql += " 				And		a.ACC_CODE In ( \n";
			strSql += " 					'111070100',		--공사미수금작업진행율 \n";
			strSql += " 					'111070200',		--공사미수금세금계산 \n";
			strSql += " 					'111079000',		--공사미수금기타 \n";
			strSql += " 					'210060100',		--공사선수금 진행율 \n";
			strSql += " 					'210060200'			--공사선수금 계산서 \n";
			strSql += " 				) \n";
			strSql += " 				Group By \n";
			strSql += " 					a.DEPT_CODE, \n";
			strSql += " 					To_Char(a.MAKE_DT,'YYYYMM') \n";
			strSql += " 			) a, \n";
			strSql += " 			V_T_DEPT_CONTRACT_NP b \n";
			strSql += " 		Where	a.DEPT_CODE (+) = b.DEPT_CODE \n";
			strSql += " 		And		b.RECEIVE_TAG Like  ?  || '%' \n";
			strSql += " 		And		b.DEPT_CODE Like  ?  || '%' \n";
			strSql += " 		And		a.WORK_YM (+) <=  ?  \n";
			strSql += " 		Group By Grouping Sets \n";
			strSql += " 		( \n";
			strSql += " 			( \n";
			strSql += " 				b.RECEIVE_TAG, \n";
			strSql += " 				b.RECEIVE_TAG_NAME, \n";
			strSql += " 				b.DEPT_CODE, \n";
			strSql += " 				b.DEPT_NAME, \n";
			strSql += " 				b.F_CONS_AMT, \n";
			strSql += " 				b.CONS_AMT \n";
			strSql += " 			), \n";
			strSql += " 			( \n";
			strSql += " 				b.RECEIVE_TAG, \n";
			strSql += " 				b.RECEIVE_TAG_NAME \n";
			strSql += " 			), \n";
			strSql += " 			() \n";
			strSql += " 		) \n";
			strSql += " 	) a \n";
			strSql += " Order By \n";
			strSql += " 	a.RECEIVE_TAG, \n";
			strSql += " 	a.DEPT_CODE \n";
			strSql += "  ";
			
			lrArgData.addColumn("BASE_AMT_001", CITData.NUMBER);
			lrArgData.addColumn("BASE_AMT_002", CITData.NUMBER);
			lrArgData.addColumn("BASE_AMT_003", CITData.NUMBER);
			lrArgData.addColumn("BASE_AMT_004", CITData.NUMBER);
			lrArgData.addColumn("BASE_AMT_005", CITData.NUMBER);
			lrArgData.addColumn("BASE_AMT_006", CITData.NUMBER);
			lrArgData.addColumn("BASE_AMT_007", CITData.NUMBER);
			lrArgData.addColumn("BASE_AMT_008", CITData.NUMBER);
			lrArgData.addColumn("BASE_AMT_009", CITData.NUMBER);
			lrArgData.addColumn("BASE_AMT_010", CITData.NUMBER);
			lrArgData.addColumn("BASE_AMT_011", CITData.NUMBER);
			lrArgData.addColumn("BASE_AMT_012", CITData.NUMBER);

			lrArgData.addColumn("BASE_AMT_01", CITData.NUMBER);
			lrArgData.addColumn("BASE_AMT_02", CITData.NUMBER);
			lrArgData.addColumn("1WORK_YM_TO", CITData.VARCHAR2);
			lrArgData.addColumn("2WORK_YM_TO", CITData.VARCHAR2);
			lrArgData.addColumn("3WORK_YM_TO", CITData.VARCHAR2);
			lrArgData.addColumn("4WORK_YM_TO", CITData.VARCHAR2);
			lrArgData.addColumn("5WORK_YM_TO", CITData.VARCHAR2);
			lrArgData.addColumn("6WORK_YM_TO", CITData.VARCHAR2);
			lrArgData.addColumn("7WORK_YM_TO", CITData.VARCHAR2);
			lrArgData.addColumn("8WORK_YM_TO", CITData.VARCHAR2);
			lrArgData.addColumn("9WORK_YM_TO", CITData.VARCHAR2);
			lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("13RECEIVE_TAG", CITData.VARCHAR2);
			lrArgData.addColumn("14DEPT_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("16WORK_YM_TO", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("BASE_AMT_001", strBASE_AMT);
			lrArgData.setValue("BASE_AMT_002", strBASE_AMT);
			lrArgData.setValue("BASE_AMT_003", strBASE_AMT);
			lrArgData.setValue("BASE_AMT_004", strBASE_AMT);
			lrArgData.setValue("BASE_AMT_005", strBASE_AMT);
			lrArgData.setValue("BASE_AMT_006", strBASE_AMT);
			lrArgData.setValue("BASE_AMT_007", strBASE_AMT);
			lrArgData.setValue("BASE_AMT_008", strBASE_AMT);
			lrArgData.setValue("BASE_AMT_009", strBASE_AMT);
			lrArgData.setValue("BASE_AMT_010", strBASE_AMT);
			lrArgData.setValue("BASE_AMT_011", strBASE_AMT);
			lrArgData.setValue("BASE_AMT_012", strBASE_AMT);

			lrArgData.setValue("BASE_AMT_01", strBASE_AMT);
			lrArgData.setValue("BASE_AMT_02", strBASE_AMT);
			lrArgData.setValue("1WORK_YM_TO", strWORK_YM_TO);
			lrArgData.setValue("2WORK_YM_TO", strWORK_YM_TO);
			lrArgData.setValue("3WORK_YM_TO", strWORK_YM_TO);
			lrArgData.setValue("4WORK_YM_TO", strWORK_YM_TO);
			lrArgData.setValue("5WORK_YM_TO", strWORK_YM_TO);
			lrArgData.setValue("6WORK_YM_TO", strWORK_YM_TO);
			lrArgData.setValue("7WORK_YM_TO", strWORK_YM_TO);
			lrArgData.setValue("8WORK_YM_TO", strWORK_YM_TO);
			lrArgData.setValue("9WORK_YM_TO", strWORK_YM_TO);
			lrArgData.setValue("COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("13RECEIVE_TAG", strRECEIVE_TAG);
			lrArgData.setValue("14DEPT_CODE", strDEPT_CODE);
			lrArgData.setValue("16WORK_YM_TO", strWORK_YM_TO);
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