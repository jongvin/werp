<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 김흥수 작성(2006-01-18)
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
			strSql += " 	a.FLOW_CODE_B , \n";
			strSql += " 	a.P_NO , \n";
			strSql += " 	a.LEVELED_FLOW_ITEM_NAME, \n";
			strSql += " 	a.IS_LEAF_TAG, \n";
			strSql += " 	a.RN, \n";
			strSql += " 	a.LV, \n";
			strSql += " 	a.SUBTITLE_NAME , \n";
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
			strSql += " 	Round((Nvl(a.EXEC_AMT_12,0) * 100) / NullIf(a.PLAN_AMT_12, 0),2) RATIO_12 \n";
			strSql += " From \n";
			strSql += " 	( \n";
			strSql += " 		Select \n";
			strSql += " 			a.COMP_CODE, \n";
			strSql += " 			a.DEPT_CODE, \n";
			strSql += " 			a.FLOW_CODE_B , \n";
			strSql += " 			a.P_NO , \n";
			strSql += " 			a.LEVELED_FLOW_ITEM_NAME, \n";
			strSql += " 			a.IS_LEAF_TAG, \n";
			strSql += " 			a.RN, \n";
			strSql += " 			a.LV, \n";
			strSql += " 			a.SUBTITLE_NAME , \n";
			strSql += " 			Decode(a.LV,1,Max(Decode(b.WORK_YM, ?  ||'01',b.PLAN_AMT)), \n";
			strSql += " 						2,Max(Decode(b.WORK_YM, ?  ||'01',b.A_PLAN_AMT)))			PLAN_AMT_01, \n";
			strSql += " 			Decode(a.LV,1,Max(Decode(b.WORK_YM, ?  ||'02',b.PLAN_AMT)), \n";
			strSql += " 						2,Max(Decode(b.WORK_YM, ?  ||'02',b.A_PLAN_AMT)))			PLAN_AMT_02, \n";
			strSql += " 			Decode(a.LV,1,Max(Decode(b.WORK_YM, ?  ||'03',b.PLAN_AMT)), \n";
			strSql += " 						2,Max(Decode(b.WORK_YM, ?  ||'03',b.A_PLAN_AMT)))			PLAN_AMT_03, \n";
			strSql += " 			Decode(a.LV,1,Max(Decode(b.WORK_YM, ?  ||'04',b.PLAN_AMT)), \n";
			strSql += " 						2,Max(Decode(b.WORK_YM, ?  ||'04',b.A_PLAN_AMT)))			PLAN_AMT_04, \n";
			strSql += " 			Decode(a.LV,1,Max(Decode(b.WORK_YM, ?  ||'05',b.PLAN_AMT)), \n";
			strSql += " 						2,Max(Decode(b.WORK_YM, ?  ||'05',b.A_PLAN_AMT)))			PLAN_AMT_05, \n";
			strSql += " 			Decode(a.LV,1,Max(Decode(b.WORK_YM, ?  ||'06',b.PLAN_AMT)), \n";
			strSql += " 						2,Max(Decode(b.WORK_YM, ?  ||'06',b.A_PLAN_AMT)))			PLAN_AMT_06, \n";
			strSql += " 			Decode(a.LV,1,Max(Decode(b.WORK_YM, ?  ||'07',b.PLAN_AMT)), \n";
			strSql += " 						2,Max(Decode(b.WORK_YM, ?  ||'07',b.A_PLAN_AMT)))			PLAN_AMT_07, \n";
			strSql += " 			Decode(a.LV,1,Max(Decode(b.WORK_YM, ?  ||'08',b.PLAN_AMT)), \n";
			strSql += " 						2,Max(Decode(b.WORK_YM, ?  ||'08',b.A_PLAN_AMT)))			PLAN_AMT_08, \n";
			strSql += " 			Decode(a.LV,1,Max(Decode(b.WORK_YM, ?  ||'09',b.PLAN_AMT)), \n";
			strSql += " 						2,Max(Decode(b.WORK_YM, ?  ||'09',b.A_PLAN_AMT)))			PLAN_AMT_09, \n";
			strSql += " 			Decode(a.LV,1,Max(Decode(b.WORK_YM, ?  ||'10',b.PLAN_AMT)), \n";
			strSql += " 						2,Max(Decode(b.WORK_YM, ?  ||'10',b.A_PLAN_AMT)))			PLAN_AMT_10, \n";
			strSql += " 			Decode(a.LV,1,Max(Decode(b.WORK_YM, ?  ||'11',b.PLAN_AMT)), \n";
			strSql += " 						2,Max(Decode(b.WORK_YM, ?  ||'11',b.A_PLAN_AMT)))			PLAN_AMT_11, \n";
			strSql += " 			Decode(a.LV,1,Max(Decode(b.WORK_YM, ?  ||'12',b.PLAN_AMT)), \n";
			strSql += " 						2,Max(Decode(b.WORK_YM, ?  ||'12',b.A_PLAN_AMT)))			PLAN_AMT_12, \n";
			strSql += " 			Decode(a.LV,1,Max(Decode(b.WORK_YM, ?  ||'01',b.EXEC_AMT)), \n";
			strSql += " 						2,Max(Decode(b.WORK_YM, ?  ||'01',b.A_EXEC_AMT)))			EXEC_AMT_01, \n";
			strSql += " 			Decode(a.LV,1,Max(Decode(b.WORK_YM, ?  ||'02',b.EXEC_AMT)), \n";
			strSql += " 						2,Max(Decode(b.WORK_YM, ?  ||'02',b.A_EXEC_AMT)))			EXEC_AMT_02, \n";
			strSql += " 			Decode(a.LV,1,Max(Decode(b.WORK_YM, ?  ||'03',b.EXEC_AMT)), \n";
			strSql += " 						2,Max(Decode(b.WORK_YM, ?  ||'03',b.A_EXEC_AMT)))			EXEC_AMT_03, \n";
			strSql += " 			Decode(a.LV,1,Max(Decode(b.WORK_YM, ?  ||'04',b.EXEC_AMT)), \n";
			strSql += " 						2,Max(Decode(b.WORK_YM, ?  ||'04',b.A_EXEC_AMT)))			EXEC_AMT_04, \n";
			strSql += " 			Decode(a.LV,1,Max(Decode(b.WORK_YM, ?  ||'05',b.EXEC_AMT)), \n";
			strSql += " 						2,Max(Decode(b.WORK_YM, ?  ||'05',b.A_EXEC_AMT)))			EXEC_AMT_05, \n";
			strSql += " 			Decode(a.LV,1,Max(Decode(b.WORK_YM, ?  ||'06',b.EXEC_AMT)), \n";
			strSql += " 						2,Max(Decode(b.WORK_YM, ?  ||'06',b.A_EXEC_AMT)))			EXEC_AMT_06, \n";
			strSql += " 			Decode(a.LV,1,Max(Decode(b.WORK_YM, ?  ||'07',b.EXEC_AMT)), \n";
			strSql += " 						2,Max(Decode(b.WORK_YM, ?  ||'07',b.A_EXEC_AMT)))			EXEC_AMT_07, \n";
			strSql += " 			Decode(a.LV,1,Max(Decode(b.WORK_YM, ?  ||'08',b.EXEC_AMT)), \n";
			strSql += " 						2,Max(Decode(b.WORK_YM, ?  ||'08',b.A_EXEC_AMT)))			EXEC_AMT_08, \n";
			strSql += " 			Decode(a.LV,1,Max(Decode(b.WORK_YM, ?  ||'09',b.EXEC_AMT)), \n";
			strSql += " 						2,Max(Decode(b.WORK_YM, ?  ||'09',b.A_EXEC_AMT)))			EXEC_AMT_09, \n";
			strSql += " 			Decode(a.LV,1,Max(Decode(b.WORK_YM, ?  ||'10',b.EXEC_AMT)), \n";
			strSql += " 						2,Max(Decode(b.WORK_YM, ?  ||'10',b.A_EXEC_AMT)))			EXEC_AMT_10, \n";
			strSql += " 			Decode(a.LV,1,Max(Decode(b.WORK_YM, ?  ||'11',b.EXEC_AMT)), \n";
			strSql += " 						2,Max(Decode(b.WORK_YM, ?  ||'11',b.A_EXEC_AMT)))			EXEC_AMT_11, \n";
			strSql += " 			Decode(a.LV,1,Max(Decode(b.WORK_YM, ?  ||'12',b.EXEC_AMT)), \n";
			strSql += " 						2,Max(Decode(b.WORK_YM, ?  ||'12',b.A_EXEC_AMT)))			EXEC_AMT_12 \n";
			strSql += " 		From \n";
			strSql += " 			( \n";
			strSql += " 				Select \n";
			strSql += " 					a.COMP_CODE, \n";
			strSql += " 					a.DEPT_CODE, \n";
			strSql += " 					a.FLOW_CODE_B , \n";
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
			strSql += " 							a.FLOW_CODE_B , \n";
			strSql += " 							a.P_NO , \n";
			strSql += " 							RPad(' ',(Level - 1) * 2,' ') || a.FLOW_ITEM_NAME LEVELED_FLOW_ITEM_NAME, \n";
			strSql += " 							a.IS_LEAF_TAG, \n";
			strSql += " 							RowNum RN \n";
			strSql += " 						From	T_FL_FLOW_CODE_B a \n";
			strSql += " 						Start with a.P_NO = 0 \n";
			strSql += " 						Connect by \n";
			strSql += " 							Prior	a.FLOW_CODE_B = a.P_NO \n";
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
			strSql += " 					b.WORK_YM , \n";
			strSql += " 					b.FLOW_CODE_B , \n";
			strSql += " 					Sum(b.PLAN_AMT) PLAN_AMT, \n";
			strSql += " 					Sum(b.A_PLAN_AMT) A_PLAN_AMT, \n";
			strSql += " 					Sum(b.EXEC_AMT) EXEC_AMT, \n";
			strSql += " 					Sum(b.A_EXEC_AMT) A_EXEC_AMT \n";
			strSql += " 				From \n";
			strSql += " 					( \n";
			strSql += " 						Select \n";
			strSql += " 							b.COMP_CODE , \n";
			strSql += " 							b.DEPT_CODE , \n";
			strSql += " 							b.WORK_YM , \n";
			strSql += " 							b.FLOW_CODE_B , \n";
			strSql += " 							b.PLAN_AMT, \n";
			strSql += " 							Sum(b.PLAN_AMT) Over(Partition By b.COMP_CODE,b.DEPT_CODE,b.FLOW_CODE_B Order By b.COMP_CODE,b.DEPT_CODE,b.FLOW_CODE_B,b.WORK_YM) A_PLAN_AMT, \n";
			strSql += " 							0 EXEC_AMT, \n";
			strSql += " 							0 A_EXEC_AMT \n";
			strSql += " 						From	T_FL_MONTH_PLAN_EXEC_PROJ_B b \n";
			strSql += " 						Where	b.COMP_CODE =  ?  \n";
			strSql += " 						And		b.DEPT_CODE =  ?  \n";
			strSql += " 						And		b.CLSE_ACC_ID =  ?  \n";
			strSql += " 						Union All \n";
			strSql += " 						Select \n";
			strSql += " 							c.COMP_CODE , \n";
			strSql += " 							c.DEPT_CODE , \n";
			strSql += " 							c.WORK_YM, \n";
			strSql += " 							c.FLOW_CODE_B, \n";
			strSql += " 							0 PLAN_AMT, \n";
			strSql += " 							0 A_PLAN_AMT, \n";
			strSql += " 							c.EXEC_AMT, \n";
			strSql += " 							Sum(c.EXEC_AMT) Over(Partition By c.COMP_CODE,c.DEPT_CODE,c.FLOW_CODE_B Order By c.COMP_CODE,c.DEPT_CODE,c.FLOW_CODE_B,c.WORK_YM) A_EXEC_AMT \n";
			strSql += " 						From \n";
			strSql += " 							( \n";
			strSql += " 								Select \n";
			strSql += " 									x.V_DEPT_CODE DEPT_CODE , \n";
			strSql += " 									x.COMP_CODE , \n";
			strSql += " 									c.WORK_YM, \n";
			strSql += " 									c.FLOW_CODE_B, \n";
			strSql += " 									Sum(c.EXEC_AMT) EXEC_AMT \n";
			strSql += " 								From	T_PL_VIRTUAL_REAL_DEPT x, \n";
			strSql += " 										T_FL_MONTH_PLAN_EXEC_PROJ_B c \n";
			strSql += " 								Where	x.V_DEPT_CODE =  ?  \n";
			strSql += " 								And		x.COMP_CODE =  ?  \n";
			strSql += " 								And		x.CLSE_ACC_ID =  ?  \n";
			strSql += " 								And		x.COMP_CODE = c.COMP_CODE \n";
			strSql += " 								And		x.CLSE_ACC_ID = c.CLSE_ACC_ID \n";
			strSql += " 								And		x.R_DEPT_CODE = c.DEPT_CODE \n";
			strSql += " 								Group By \n";
			strSql += " 									x.V_DEPT_CODE , \n";
			strSql += " 									x.COMP_CODE , \n";
			strSql += " 									c.WORK_YM, \n";
			strSql += " 									c.FLOW_CODE_B \n";
			strSql += " 							) c \n";
			strSql += " 					) b \n";
			strSql += " 				Group By \n";
			strSql += " 					b.COMP_CODE , \n";
			strSql += " 					b.DEPT_CODE , \n";
			strSql += " 					b.WORK_YM , \n";
			strSql += " 					b.FLOW_CODE_B \n";
			strSql += " 				) b \n";
			strSql += " 		Where	a.COMP_CODE = b.COMP_CODE (+) \n";
			strSql += " 		And		a.DEPT_CODE = b.DEPT_CODE (+) \n";
			strSql += " 		And		a.FLOW_CODE_B = b.FLOW_CODE_B (+) \n";
			strSql += " 		Group By \n";
			strSql += " 			a.COMP_CODE, \n";
			strSql += " 			a.DEPT_CODE, \n";
			strSql += " 			a.FLOW_CODE_B , \n";
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
			
			lrArgData.addColumn("1CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("2CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("3CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("4CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("5CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("6CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("7CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("8CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("9CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("10CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("11CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("12CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("13CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("14CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("15CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("16CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("17CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("18CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("19CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("20CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("21CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("22CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("23CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("24CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("25CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("26CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("27CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("28CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("29CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("30CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("31CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("32CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("33CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("34CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("35CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("36CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("37CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("38CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("39CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("40CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("41CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("42CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("43CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("44CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("45CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("46CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("47CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("48CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("49COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("50DEPT_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("51COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("52DEPT_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("53CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("54DEPT_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("55COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("56CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("2CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("3CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("4CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("5CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("6CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("7CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("8CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("9CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("10CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("11CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("12CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("13CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("14CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("15CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("16CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("17CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("18CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("19CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("20CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("21CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("22CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("23CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("24CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("25CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("26CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("27CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("28CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("29CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("30CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("31CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("32CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("33CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("34CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("35CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("36CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("37CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("38CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("39CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("40CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("41CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("42CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("43CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("44CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("45CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("46CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("47CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("48CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("49COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("50DEPT_CODE", strDEPT_CODE);
			lrArgData.setValue("51COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("52DEPT_CODE", strDEPT_CODE);
			lrArgData.setValue("53CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("54DEPT_CODE", strDEPT_CODE);
			lrArgData.setValue("55COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("56CLSE_ACC_ID", strCLSE_ACC_ID);
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
			String strCLSE_ACC_ID = CITCommon.toKOR(request.getParameter("CLSE_ACC_ID"));
			String strDEPT_CODE = CITCommon.toKOR(request.getParameter("DEPT_CODE"));
			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String strFLOW_CODE_B = CITCommon.toKOR(request.getParameter("FLOW_CODE_B"));
			
			strSql  = " Select \n";
			strSql += " 	a.COMP_CODE , \n";
			strSql += " 	a.DEPT_CODE , \n";
			strSql += " 	a.DEPT_NAME, \n";
			strSql += " 	SubStrb(Decode(b.LV,1,'당월',2,'누계'),1,50) SUBTITLE_NAME, \n";
			strSql += " 	Decode(b.LV,1,Max(Decode(a.WORK_YM, ?   ||'01',a.EXEC_AMT)), \n";
			strSql += " 				2,Max(Decode(a.WORK_YM, ?   ||'01',a.A_EXEC_AMT)))			EXEC_AMT_01, \n";
			strSql += " 	Decode(b.LV,1,Max(Decode(a.WORK_YM, ?   ||'02',a.EXEC_AMT)), \n";
			strSql += " 				2,Max(Decode(a.WORK_YM, ?   ||'02',a.A_EXEC_AMT)))			EXEC_AMT_02, \n";
			strSql += " 	Decode(b.LV,1,Max(Decode(a.WORK_YM, ?   ||'03',a.EXEC_AMT)), \n";
			strSql += " 				2,Max(Decode(a.WORK_YM, ?   ||'03',a.A_EXEC_AMT)))			EXEC_AMT_03, \n";
			strSql += " 	Decode(b.LV,1,Max(Decode(a.WORK_YM, ?   ||'04',a.EXEC_AMT)), \n";
			strSql += " 				2,Max(Decode(a.WORK_YM, ?   ||'04',a.A_EXEC_AMT)))			EXEC_AMT_04, \n";
			strSql += " 	Decode(b.LV,1,Max(Decode(a.WORK_YM, ?   ||'05',a.EXEC_AMT)), \n";
			strSql += " 				2,Max(Decode(a.WORK_YM, ?   ||'05',a.A_EXEC_AMT)))			EXEC_AMT_05, \n";
			strSql += " 	Decode(b.LV,1,Max(Decode(a.WORK_YM, ?   ||'06',a.EXEC_AMT)), \n";
			strSql += " 				2,Max(Decode(a.WORK_YM, ?   ||'06',a.A_EXEC_AMT)))			EXEC_AMT_06, \n";
			strSql += " 	Decode(b.LV,1,Max(Decode(a.WORK_YM, ?   ||'07',a.EXEC_AMT)), \n";
			strSql += " 				2,Max(Decode(a.WORK_YM, ?   ||'07',a.A_EXEC_AMT)))			EXEC_AMT_07, \n";
			strSql += " 	Decode(b.LV,1,Max(Decode(a.WORK_YM, ?   ||'08',a.EXEC_AMT)), \n";
			strSql += " 				2,Max(Decode(a.WORK_YM, ?   ||'08',a.A_EXEC_AMT)))			EXEC_AMT_08, \n";
			strSql += " 	Decode(b.LV,1,Max(Decode(a.WORK_YM, ?   ||'09',a.EXEC_AMT)), \n";
			strSql += " 				2,Max(Decode(a.WORK_YM, ?   ||'09',a.A_EXEC_AMT)))			EXEC_AMT_09, \n";
			strSql += " 	Decode(b.LV,1,Max(Decode(a.WORK_YM, ?   ||'10',a.EXEC_AMT)), \n";
			strSql += " 				2,Max(Decode(a.WORK_YM, ?   ||'10',a.A_EXEC_AMT)))			EXEC_AMT_10, \n";
			strSql += " 	Decode(b.LV,1,Max(Decode(a.WORK_YM, ?   ||'11',a.EXEC_AMT)), \n";
			strSql += " 				2,Max(Decode(a.WORK_YM, ?   ||'11',a.A_EXEC_AMT)))			EXEC_AMT_11, \n";
			strSql += " 	Decode(b.LV,1,Max(Decode(a.WORK_YM, ?   ||'12',a.EXEC_AMT)), \n";
			strSql += " 				2,Max(Decode(a.WORK_YM, ?   ||'12',a.A_EXEC_AMT)))			EXEC_AMT_12 \n";
			strSql += " From \n";
			strSql += " 	( \n";
			strSql += " 		Select \n";
			strSql += " 			c.COMP_CODE , \n";
			strSql += " 			c.DEPT_CODE , \n";
			strSql += " 			t.DEPT_NAME, \n";
			strSql += " 			c.WORK_YM, \n";
			strSql += " 			c.FLOW_CODE_B, \n";
			strSql += " 			c.EXEC_AMT, \n";
			strSql += " 			Sum(c.EXEC_AMT) Over(Partition By c.COMP_CODE,c.DEPT_CODE,c.FLOW_CODE_B Order By c.COMP_CODE,c.DEPT_CODE,c.FLOW_CODE_B,c.WORK_YM) A_EXEC_AMT \n";
			strSql += " 		From \n";
			strSql += " 			( \n";
			strSql += " 				Select \n";
			strSql += " 					x.V_DEPT_CODE DEPT_CODE , \n";
			strSql += " 					x.COMP_CODE , \n";
			strSql += " 					c.WORK_YM, \n";
			strSql += " 					c.FLOW_CODE_B, \n";
			strSql += " 					Sum(c.EXEC_AMT) EXEC_AMT \n";
			strSql += " 				From	T_PL_VIRTUAL_REAL_DEPT x, \n";
			strSql += " 						T_FL_MONTH_PLAN_EXEC_PROJ_B c \n";
			strSql += " 				Where	x.V_DEPT_CODE =  ?  \n";
			strSql += " 				And		x.COMP_CODE =  ?  \n";
			strSql += " 				And		x.CLSE_ACC_ID =  ?  \n";
			strSql += " 				And		c.FLOW_CODE_B =  ?  \n";
			strSql += " 				And		x.COMP_CODE = c.COMP_CODE \n";
			strSql += " 				And		x.CLSE_ACC_ID = c.CLSE_ACC_ID \n";
			strSql += " 				And		x.R_DEPT_CODE = c.DEPT_CODE \n";
			strSql += " 				Group By \n";
			strSql += " 					x.V_DEPT_CODE , \n";
			strSql += " 					x.COMP_CODE , \n";
			strSql += " 					c.WORK_YM, \n";
			strSql += " 					c.FLOW_CODE_B \n";
			strSql += " 			) c, \n";
			strSql += " 			T_DEPT_CODE_ORG t \n";
			strSql += " 		Where	c.DEPT_CODE = t.DEPT_CODE (+) \n";
			strSql += " 	) a, \n";
			strSql += " 	( \n";
			strSql += " 		Select \n";
			strSql += " 			Level lv \n";
			strSql += " 		From	Dual \n";
			strSql += " 		Connect By Level <= 2 \n";
			strSql += " 	) b \n";
			strSql += " Group by \n";
			strSql += " 	a.COMP_CODE , \n";
			strSql += " 	a.DEPT_CODE , \n";
			strSql += " 	a.DEPT_NAME, \n";
			strSql += " 	b.lv \n";
			strSql += " Order By \n";
			strSql += " 	a.DEPT_CODE, \n";
			strSql += " 	b.lv \n";
			strSql += " 	 ";
			
			lrArgData.addColumn("1CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("2CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("3CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("4CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("5CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("6CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("7CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("8CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("9CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("10CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("11CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("12CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("13CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("14CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("15CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("16CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("17CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("18CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("19CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("20CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("21CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("22CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("23CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("24CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("25DEPT_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("26COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("27CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("28FLOW_CODE_B", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("2CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("3CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("4CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("5CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("6CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("7CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("8CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("9CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("10CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("11CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("12CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("13CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("14CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("15CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("16CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("17CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("18CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("19CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("20CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("21CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("22CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("23CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("24CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("25DEPT_CODE", strDEPT_CODE);
			lrArgData.setValue("26COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("27CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("28FLOW_CODE_B", strFLOW_CODE_B);
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