<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 김흥수 작성(2006-01-17)
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
			String strCLSE_ACC_ID = CITCommon.toKOR(request.getParameter("CLSE_ACC_ID"));
			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String strDEPT_CODE = CITCommon.toKOR(request.getParameter("DEPT_CODE"));
			
			strSql  = " Select \n";
			strSql += " 	a.COMP_CODE, \n";
			strSql += " 	a.DEPT_CODE, \n";
			strSql += " 	a.FLOW_CODE , \n";
			strSql += " 	a.P_NO , \n";
			strSql += " 	a.LEVELED_FLOW_ITEM_NAME, \n";
			strSql += " 	a.IS_LEAF_TAG, \n";
			strSql += " 	a.RN, \n";
			strSql += " 	a.LV, \n";
			strSql += " 	a.SUBTITLE_NAME , \n";
			strSql += " 	a.PRE_EXEC_AMT, \n";
			strSql += " 	a.PLAN_AMT_01, \n";
			strSql += " 	a.PLAN_AMT_02, \n";
			strSql += " 	a.PLAN_AMT_03, \n";
			strSql += " 	a.PLAN_AMT_04, \n";
			strSql += " 	a.PLAN_AMT_05, \n";
			strSql += " 	a.PLAN_AMT_06, \n";
			strSql += " 	a.PLAN_AMT_07, \n";
			strSql += " 	a.PLAN_AMT_08, \n";
			strSql += " 	a.PLAN_AMT_09, \n";
			strSql += " 	a.PLAN_AMT_10, \n";
			strSql += " 	a.PLAN_AMT_11, \n";
			strSql += " 	a.PLAN_AMT_12, \n";
			strSql += " 	a.EXEC_AMT_01, \n";
			strSql += " 	a.EXEC_AMT_02, \n";
			strSql += " 	a.EXEC_AMT_03, \n";
			strSql += " 	a.EXEC_AMT_04, \n";
			strSql += " 	a.EXEC_AMT_05, \n";
			strSql += " 	a.EXEC_AMT_06, \n";
			strSql += " 	a.EXEC_AMT_07, \n";
			strSql += " 	a.EXEC_AMT_08, \n";
			strSql += " 	a.EXEC_AMT_09, \n";
			strSql += " 	a.EXEC_AMT_10, \n";
			strSql += " 	a.EXEC_AMT_11, \n";
			strSql += " 	a.EXEC_AMT_12, \n";
			strSql += " 	Round((Nvl(a.EXEC_AMT_01,0) * 100) / NullIf(a.PLAN_AMT_01, 0),2) RATIO_01, \n";
			strSql += " 	Round((Nvl(a.EXEC_AMT_02,0) * 100) / NullIf(a.PLAN_AMT_02, 0),2) RATIO_02, \n";
			strSql += " 	Round((Nvl(a.EXEC_AMT_03,0) * 100) / NullIf(a.PLAN_AMT_03, 0),2) RATIO_03, \n";
			strSql += " 	Round((Nvl(a.EXEC_AMT_04,0) * 100) / NullIf(a.PLAN_AMT_04, 0),2) RATIO_04, \n";
			strSql += " 	Round((Nvl(a.EXEC_AMT_05,0) * 100) / NullIf(a.PLAN_AMT_05, 0),2) RATIO_05, \n";
			strSql += " 	Round((Nvl(a.EXEC_AMT_06,0) * 100) / NullIf(a.PLAN_AMT_06, 0),2) RATIO_06, \n";
			strSql += " 	Round((Nvl(a.EXEC_AMT_07,0) * 100) / NullIf(a.PLAN_AMT_07, 0),2) RATIO_07, \n";
			strSql += " 	Round((Nvl(a.EXEC_AMT_08,0) * 100) / NullIf(a.PLAN_AMT_08, 0),2) RATIO_08, \n";
			strSql += " 	Round((Nvl(a.EXEC_AMT_09,0) * 100) / NullIf(a.PLAN_AMT_09, 0),2) RATIO_09, \n";
			strSql += " 	Round((Nvl(a.EXEC_AMT_10,0) * 100) / NullIf(a.PLAN_AMT_10, 0),2) RATIO_10, \n";
			strSql += " 	Round((Nvl(a.EXEC_AMT_11,0) * 100) / NullIf(a.PLAN_AMT_11, 0),2) RATIO_11, \n";
			strSql += " 	Round((Nvl(a.EXEC_AMT_12,0) * 100) / NullIf(a.PLAN_AMT_12, 0),2) RATIO_12, \n";
			strSql += " 	Round((Nvl(Decode(a.LV,2,Nvl(a.PRE_EXEC_AMT,0) + Nvl(a.EXEC_AMT_12,0)),0) * 100) / NullIf(Decode(a.LV,2,Nvl(a.PRE_EXEC_AMT,0) + Nvl(a.PLAN_AMT_12,0)), 0),2) RATIO_SUM, \n";
			strSql += " 	Decode(a.LV,2,Nvl(a.PRE_EXEC_AMT,0) + Nvl(a.PLAN_AMT_12,0)) PLAN_AMT_SUM, \n";
			strSql += " 	Decode(a.LV,2,Nvl(a.PRE_EXEC_AMT,0) + Nvl(a.EXEC_AMT_12,0)) EXEC_AMT_SUM \n";
			strSql += " From \n";
			strSql += " 	( \n";
			strSql += " 		Select \n";
			strSql += " 			a.COMP_CODE, \n";
			strSql += " 			a.DEPT_CODE, \n";
			strSql += " 			a.FLOW_CODE , \n";
			strSql += " 			a.P_NO , \n";
			strSql += " 			a.LEVELED_FLOW_ITEM_NAME, \n";
			strSql += " 			a.IS_LEAF_TAG, \n";
			strSql += " 			a.RN, \n";
			strSql += " 			a.LV, \n";
			strSql += " 			a.SUBTITLE_NAME , \n";
			strSql += " 			Sum( \n";
			strSql += " 				Case When b.WORK_YM <  ? ||'01' Then \n";
			strSql += " 					b.EXEC_AMT \n";
			strSql += " 				Else \n";
			strSql += " 					Null \n";
			strSql += " 				End \n";
			strSql += " 			) PRE_EXEC_AMT, \n";
			strSql += " 			Decode(a.LV,1,Max(Decode(b.WORK_YM, ? ||'01',b.PLAN_AMT)), \n";
			strSql += " 						2,Max(Decode(b.WORK_YM, ? ||'01',b.A_PLAN_AMT)))			PLAN_AMT_01, \n";
			strSql += " 			Decode(a.LV,1,Max(Decode(b.WORK_YM, ? ||'02',b.PLAN_AMT)), \n";
			strSql += " 						2,Max(Decode(b.WORK_YM, ? ||'02',b.A_PLAN_AMT)))			PLAN_AMT_02, \n";
			strSql += " 			Decode(a.LV,1,Max(Decode(b.WORK_YM, ? ||'03',b.PLAN_AMT)), \n";
			strSql += " 						2,Max(Decode(b.WORK_YM, ? ||'03',b.A_PLAN_AMT)))			PLAN_AMT_03, \n";
			strSql += " 			Decode(a.LV,1,Max(Decode(b.WORK_YM, ? ||'04',b.PLAN_AMT)), \n";
			strSql += " 						2,Max(Decode(b.WORK_YM, ? ||'04',b.A_PLAN_AMT)))			PLAN_AMT_04, \n";
			strSql += " 			Decode(a.LV,1,Max(Decode(b.WORK_YM, ? ||'05',b.PLAN_AMT)), \n";
			strSql += " 						2,Max(Decode(b.WORK_YM, ? ||'05',b.A_PLAN_AMT)))			PLAN_AMT_05, \n";
			strSql += " 			Decode(a.LV,1,Max(Decode(b.WORK_YM, ? ||'06',b.PLAN_AMT)), \n";
			strSql += " 						2,Max(Decode(b.WORK_YM, ? ||'06',b.A_PLAN_AMT)))			PLAN_AMT_06, \n";
			strSql += " 			Decode(a.LV,1,Max(Decode(b.WORK_YM, ? ||'07',b.PLAN_AMT)), \n";
			strSql += " 						2,Max(Decode(b.WORK_YM, ? ||'07',b.A_PLAN_AMT)))			PLAN_AMT_07, \n";
			strSql += " 			Decode(a.LV,1,Max(Decode(b.WORK_YM, ? ||'08',b.PLAN_AMT)), \n";
			strSql += " 						2,Max(Decode(b.WORK_YM, ? ||'08',b.A_PLAN_AMT)))			PLAN_AMT_08, \n";
			strSql += " 			Decode(a.LV,1,Max(Decode(b.WORK_YM, ? ||'09',b.PLAN_AMT)), \n";
			strSql += " 						2,Max(Decode(b.WORK_YM, ? ||'09',b.A_PLAN_AMT)))			PLAN_AMT_09, \n";
			strSql += " 			Decode(a.LV,1,Max(Decode(b.WORK_YM, ? ||'10',b.PLAN_AMT)), \n";
			strSql += " 						2,Max(Decode(b.WORK_YM, ? ||'10',b.A_PLAN_AMT)))			PLAN_AMT_10, \n";
			strSql += " 			Decode(a.LV,1,Max(Decode(b.WORK_YM, ? ||'11',b.PLAN_AMT)), \n";
			strSql += " 						2,Max(Decode(b.WORK_YM, ? ||'11',b.A_PLAN_AMT)))			PLAN_AMT_11, \n";
			strSql += " 			Decode(a.LV,1,Max(Decode(b.WORK_YM, ? ||'12',b.PLAN_AMT)), \n";
			strSql += " 						2,Max(Decode(b.WORK_YM, ? ||'12',b.A_PLAN_AMT)))			PLAN_AMT_12, \n";
			strSql += " 			Decode(a.LV,1,Max(Decode(b.WORK_YM, ? ||'01',b.EXEC_AMT)), \n";
			strSql += " 						2,Max(Decode(b.WORK_YM, ? ||'01',b.A_EXEC_AMT)))			EXEC_AMT_01, \n";
			strSql += " 			Decode(a.LV,1,Max(Decode(b.WORK_YM, ? ||'02',b.EXEC_AMT)), \n";
			strSql += " 						2,Max(Decode(b.WORK_YM, ? ||'02',b.A_EXEC_AMT)))			EXEC_AMT_02, \n";
			strSql += " 			Decode(a.LV,1,Max(Decode(b.WORK_YM, ? ||'03',b.EXEC_AMT)), \n";
			strSql += " 						2,Max(Decode(b.WORK_YM, ? ||'03',b.A_EXEC_AMT)))			EXEC_AMT_03, \n";
			strSql += " 			Decode(a.LV,1,Max(Decode(b.WORK_YM, ? ||'04',b.EXEC_AMT)), \n";
			strSql += " 						2,Max(Decode(b.WORK_YM, ? ||'04',b.A_EXEC_AMT)))			EXEC_AMT_04, \n";
			strSql += " 			Decode(a.LV,1,Max(Decode(b.WORK_YM, ? ||'05',b.EXEC_AMT)), \n";
			strSql += " 						2,Max(Decode(b.WORK_YM, ? ||'05',b.A_EXEC_AMT)))			EXEC_AMT_05, \n";
			strSql += " 			Decode(a.LV,1,Max(Decode(b.WORK_YM, ? ||'06',b.EXEC_AMT)), \n";
			strSql += " 						2,Max(Decode(b.WORK_YM, ? ||'06',b.A_EXEC_AMT)))			EXEC_AMT_06, \n";
			strSql += " 			Decode(a.LV,1,Max(Decode(b.WORK_YM, ? ||'07',b.EXEC_AMT)), \n";
			strSql += " 						2,Max(Decode(b.WORK_YM, ? ||'07',b.A_EXEC_AMT)))			EXEC_AMT_07, \n";
			strSql += " 			Decode(a.LV,1,Max(Decode(b.WORK_YM, ? ||'08',b.EXEC_AMT)), \n";
			strSql += " 						2,Max(Decode(b.WORK_YM, ? ||'08',b.A_EXEC_AMT)))			EXEC_AMT_08, \n";
			strSql += " 			Decode(a.LV,1,Max(Decode(b.WORK_YM, ? ||'09',b.EXEC_AMT)), \n";
			strSql += " 						2,Max(Decode(b.WORK_YM, ? ||'09',b.A_EXEC_AMT)))			EXEC_AMT_09, \n";
			strSql += " 			Decode(a.LV,1,Max(Decode(b.WORK_YM, ? ||'10',b.EXEC_AMT)), \n";
			strSql += " 						2,Max(Decode(b.WORK_YM, ? ||'10',b.A_EXEC_AMT)))			EXEC_AMT_10, \n";
			strSql += " 			Decode(a.LV,1,Max(Decode(b.WORK_YM, ? ||'11',b.EXEC_AMT)), \n";
			strSql += " 						2,Max(Decode(b.WORK_YM, ? ||'11',b.A_EXEC_AMT)))			EXEC_AMT_11, \n";
			strSql += " 			Decode(a.LV,1,Max(Decode(b.WORK_YM, ? ||'12',b.EXEC_AMT)), \n";
			strSql += " 						2,Max(Decode(b.WORK_YM, ? ||'12',b.A_EXEC_AMT)))			EXEC_AMT_12 \n";
			strSql += " 		From \n";
			strSql += " 			( \n";
			strSql += " 				Select \n";
			strSql += " 					a.COMP_CODE, \n";
			strSql += " 					a.DEPT_CODE, \n";
			strSql += " 					a.FLOW_CODE , \n";
			strSql += " 					a.P_NO , \n";
			strSql += " 					a.LEVELED_FLOW_ITEM_NAME, \n";
			strSql += " 					a.IS_LEAF_TAG, \n";
			strSql += " 					a.RN, \n";
			strSql += " 					x.LV, \n";
			strSql += " 					Decode(x.LV,1,'당월',2,'누계') SUBTITLE_NAME \n";
			strSql += " 				From \n";
			strSql += " 					( \n";
			strSql += " 						Select \n";
			strSql += " 							 ?  COMP_CODE, \n";
			strSql += " 							 ?  DEPT_CODE, \n";
			strSql += " 							a.CRTUSERNO , \n";
			strSql += " 							a.CRTDATE , \n";
			strSql += " 							a.MODUSERNO , \n";
			strSql += " 							a.MODDATE , \n";
			strSql += " 							a.FLOW_CODE , \n";
			strSql += " 							a.P_NO , \n";
			strSql += " 							RPad(' ',(Level - 1) * 2,' ') || a.FLOW_ITEM_NAME LEVELED_FLOW_ITEM_NAME, \n";
			strSql += " 							a.IS_LEAF_TAG, \n";
			strSql += " 							RowNum RN \n";
			strSql += " 						From	T_FL_FLOW_CODE a \n";
			strSql += " 						Start with a.P_NO = 0 \n";
			strSql += " 						Connect by \n";
			strSql += " 							Prior	a.FLOW_CODE = a.P_NO \n";
			strSql += " 						Order Siblings By \n";
			strSql += " 							a.LEVEL_SEQ \n";
			strSql += " 					) a, \n";
			strSql += " 					( \n";
			strSql += " 						Select \n";
			strSql += " 							LEVEL LV \n";
			strSql += " 						From	Dual \n";
			strSql += " 						Connect By \n";
			strSql += " 							LEVEL <= 2 \n";
			strSql += " 					) x \n";
			strSql += " 				Order By \n";
			strSql += " 					a.RN, \n";
			strSql += " 					x.LV \n";
			strSql += " 			) a, \n";
			strSql += " 			( \n";
			strSql += " 				Select \n";
			strSql += " 					b.COMP_CODE , \n";
			strSql += " 					b.DEPT_CODE , \n";
			strSql += " 					SubStrb(b.WORK_YM,-2) YM, \n";
			strSql += " 					b.WORK_YM , \n";
			strSql += " 					b.FLOW_CODE , \n";
			strSql += " 					b.PLAN_AMT, \n";
			strSql += " 					b.EXEC_AMT, \n";
			strSql += " 					Sum(b.PLAN_AMT) Over(Partition By b.COMP_CODE,b.DEPT_CODE,b.FLOW_CODE Order By b.COMP_CODE,b.DEPT_CODE,b.FLOW_CODE,b.WORK_YM) A_PLAN_AMT, \n";
			strSql += " 					Sum(b.EXEC_AMT) Over(Partition By b.COMP_CODE,b.DEPT_CODE,b.FLOW_CODE Order By b.COMP_CODE,b.DEPT_CODE,b.FLOW_CODE,b.WORK_YM) A_EXEC_AMT \n";
			strSql += " 				From	T_FL_MONTH_PLAN_EXEC b \n";
			strSql += " 				Where	b.COMP_CODE =  ?  \n";
			strSql += " 				And		b.DEPT_CODE =  ?  \n";
			strSql += " 				Order By \n";
			strSql += " 					b.COMP_CODE, \n";
			strSql += " 					b.DEPT_CODE, \n";
			strSql += " 					b.FLOW_CODE, \n";
			strSql += " 					b.WORK_YM \n";
			strSql += " 			) b \n";
			strSql += " 		Where	a.COMP_CODE = b.COMP_CODE (+) \n";
			strSql += " 		And		a.DEPT_CODE = b.DEPT_CODE (+) \n";
			strSql += " 		And		a.FLOW_CODE = b.FLOW_CODE (+) \n";
			strSql += " 		Group By \n";
			strSql += " 			a.COMP_CODE, \n";
			strSql += " 			a.DEPT_CODE, \n";
			strSql += " 			a.FLOW_CODE , \n";
			strSql += " 			a.P_NO , \n";
			strSql += " 			a.LEVELED_FLOW_ITEM_NAME, \n";
			strSql += " 			a.IS_LEAF_TAG, \n";
			strSql += " 			a.RN, \n";
			strSql += " 			a.LV, \n";
			strSql += " 			a.SUBTITLE_NAME \n";
			strSql += " 	) a \n";
			strSql += " Order By \n";
			strSql += " 	a.RN, \n";
			strSql += " 	a.LV \n";
			strSql += "  ";
			
			lrArgData.addColumn("CLSE_ACC_ID1", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID2", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID3", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID4", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID5", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID6", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID7", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID8", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID9", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID10", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID11", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID12", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID13", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID14", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID15", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID16", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID17", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID18", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID19", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID20", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID21", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID22", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID23", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID24", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID25", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID26", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID27", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID28", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID29", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID30", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID31", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID32", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID33", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID34", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID35", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID36", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID37", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID38", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID39", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID40", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID41", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID42", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID43", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID44", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID45", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID46", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID47", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID48", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID49", CITData.VARCHAR2);
			lrArgData.addColumn("COMP_CODE1", CITData.VARCHAR2);
			lrArgData.addColumn("DEPT_CODE1", CITData.VARCHAR2);
			lrArgData.addColumn("COMP_CODE2", CITData.VARCHAR2);
			lrArgData.addColumn("DEPT_CODE2", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("CLSE_ACC_ID1", strCLSE_ACC_ID);                            
			lrArgData.setValue("CLSE_ACC_ID2", strCLSE_ACC_ID);                            
			lrArgData.setValue("CLSE_ACC_ID3", strCLSE_ACC_ID);                            
			lrArgData.setValue("CLSE_ACC_ID4", strCLSE_ACC_ID);                            
			lrArgData.setValue("CLSE_ACC_ID5", strCLSE_ACC_ID);                            
			lrArgData.setValue("CLSE_ACC_ID6", strCLSE_ACC_ID);                            
			lrArgData.setValue("CLSE_ACC_ID7", strCLSE_ACC_ID);                            
			lrArgData.setValue("CLSE_ACC_ID8", strCLSE_ACC_ID);                            
			lrArgData.setValue("CLSE_ACC_ID9", strCLSE_ACC_ID);                            
			lrArgData.setValue("CLSE_ACC_ID10", strCLSE_ACC_ID);                           
			lrArgData.setValue("CLSE_ACC_ID11", strCLSE_ACC_ID);                           
			lrArgData.setValue("CLSE_ACC_ID12", strCLSE_ACC_ID);                           
			lrArgData.setValue("CLSE_ACC_ID13", strCLSE_ACC_ID);                           
			lrArgData.setValue("CLSE_ACC_ID14", strCLSE_ACC_ID);                           
			lrArgData.setValue("CLSE_ACC_ID15", strCLSE_ACC_ID);                           
			lrArgData.setValue("CLSE_ACC_ID16", strCLSE_ACC_ID);                           
			lrArgData.setValue("CLSE_ACC_ID17", strCLSE_ACC_ID);                           
			lrArgData.setValue("CLSE_ACC_ID18", strCLSE_ACC_ID);                           
			lrArgData.setValue("CLSE_ACC_ID19", strCLSE_ACC_ID);                           
			lrArgData.setValue("CLSE_ACC_ID20", strCLSE_ACC_ID);                           
			lrArgData.setValue("CLSE_ACC_ID21", strCLSE_ACC_ID);                           
			lrArgData.setValue("CLSE_ACC_ID22", strCLSE_ACC_ID);                           
			lrArgData.setValue("CLSE_ACC_ID23", strCLSE_ACC_ID);                           
			lrArgData.setValue("CLSE_ACC_ID24", strCLSE_ACC_ID);                           
			lrArgData.setValue("CLSE_ACC_ID25", strCLSE_ACC_ID);                           
			lrArgData.setValue("CLSE_ACC_ID26", strCLSE_ACC_ID);                           
			lrArgData.setValue("CLSE_ACC_ID27", strCLSE_ACC_ID);                           
			lrArgData.setValue("CLSE_ACC_ID28", strCLSE_ACC_ID);                           
			lrArgData.setValue("CLSE_ACC_ID29", strCLSE_ACC_ID);                           
			lrArgData.setValue("CLSE_ACC_ID30", strCLSE_ACC_ID);                           
			lrArgData.setValue("CLSE_ACC_ID31", strCLSE_ACC_ID);                           
			lrArgData.setValue("CLSE_ACC_ID32", strCLSE_ACC_ID);                           
			lrArgData.setValue("CLSE_ACC_ID33", strCLSE_ACC_ID);                           
			lrArgData.setValue("CLSE_ACC_ID34", strCLSE_ACC_ID);                           
			lrArgData.setValue("CLSE_ACC_ID35", strCLSE_ACC_ID);                           
			lrArgData.setValue("CLSE_ACC_ID36", strCLSE_ACC_ID);                           
			lrArgData.setValue("CLSE_ACC_ID37", strCLSE_ACC_ID);                           
			lrArgData.setValue("CLSE_ACC_ID38", strCLSE_ACC_ID);                           
			lrArgData.setValue("CLSE_ACC_ID39", strCLSE_ACC_ID);                           
			lrArgData.setValue("CLSE_ACC_ID40", strCLSE_ACC_ID);                            
			lrArgData.setValue("CLSE_ACC_ID41", strCLSE_ACC_ID);                            
			lrArgData.setValue("CLSE_ACC_ID42", strCLSE_ACC_ID);                            
			lrArgData.setValue("CLSE_ACC_ID43", strCLSE_ACC_ID);                            
			lrArgData.setValue("CLSE_ACC_ID44", strCLSE_ACC_ID);                            
			lrArgData.setValue("CLSE_ACC_ID45", strCLSE_ACC_ID);                            
			lrArgData.setValue("CLSE_ACC_ID46", strCLSE_ACC_ID);                            
			lrArgData.setValue("CLSE_ACC_ID47", strCLSE_ACC_ID);                            
			lrArgData.setValue("CLSE_ACC_ID48", strCLSE_ACC_ID);                            
			lrArgData.setValue("CLSE_ACC_ID49", strCLSE_ACC_ID);
			lrArgData.setValue("COMP_CODE1", strCOMP_CODE);
			lrArgData.setValue("DEPT_CODE1", strDEPT_CODE);
			lrArgData.setValue("COMP_CODE2", strCOMP_CODE);
			lrArgData.setValue("DEPT_CODE2", strDEPT_CODE);
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setScale("RATIO_01",2);
				lrReturnData.setScale("RATIO_02",2);
				lrReturnData.setScale("RATIO_03",2);
				lrReturnData.setScale("RATIO_04",2);
				lrReturnData.setScale("RATIO_05",2);
				lrReturnData.setScale("RATIO_06",2);
				lrReturnData.setScale("RATIO_07",2);
				lrReturnData.setScale("RATIO_08",2);
				lrReturnData.setScale("RATIO_09",2);
				lrReturnData.setScale("RATIO_10",2);
				lrReturnData.setScale("RATIO_11",2);
				lrReturnData.setScale("RATIO_12",2);
				lrReturnData.setScale("RATIO_SUM",2);
			
				
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
			
			strSql  = " Select 'XXXXXXXXXX' COMP_CODE,'XXXXXXXXXX' CLSE_ACC_ID,'XXXXXXXXXXXXXXXXXXXX' DEPT_CODE From Dual\n";
			
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
			
			strSql  = " Select 'XXXXXXXXXX' COMP_CODE,'XXXXXXXXXX' CLSE_ACC_ID,'XXXXXXXXXXXXXXXXXXXX' DEPT_CODE From Dual\n";
			
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
			String strDEPT_CODE = CITCommon.toKOR(request.getParameter("DEPT_CODE"));
			
			strSql  = " Select F_T_FL_Is_Close_Dept( ? , ? , ? ) PLAN_CONFIRM_TAG \n";
			strSql += " from dual ";
			
			lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("DEPT_CODE", strDEPT_CODE);
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