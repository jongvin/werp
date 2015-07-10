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
			
			strSql  = " Select \n";
			strSql += " 	a.COMP_CODE, \n";
			strSql += " 	a.CLSE_ACC_ID, \n";
			strSql += " 	a.FLOW_CODE , \n";
			strSql += " 	a.CRTUSERNO , \n";
			strSql += " 	a.CRTDATE , \n";
			strSql += " 	a.MODUSERNO , \n";
			strSql += " 	a.MODDATE , \n";
			strSql += " 	a.P_NO , \n";
			strSql += " 	a.LEVELED_FLOW_ITEM_NAME, \n";
			strSql += " 	a.IS_LEAF_TAG, \n";
			strSql += " 	a.RN, \n";
			strSql += " 	a.LV, \n";
			strSql += " 	a.SUBTITLE_NAME , \n";
			strSql += " 	Decode(a.LV,1, Max(Decode(b.YM,'01',b.SUM_PLAN_AMT)), \n";
			strSql += " 			2,Max(Decode(b.YM,'01',b.B_MOD_PLAN_AMT))	, \n";
			strSql += " 			3,Max(Decode(b.YM,'01',b.PLAN_AMT)))			PLAN_AMT_01, \n";
			strSql += " 	Decode(a.LV,1, Max(Decode(b.YM,'02',b.SUM_PLAN_AMT)), \n";
			strSql += " 			2,Max(Decode(b.YM,'02',b.B_MOD_PLAN_AMT))	, \n";
			strSql += " 			3,Max(Decode(b.YM,'02',b.PLAN_AMT)))			PLAN_AMT_02, \n";
			strSql += " 	Decode(a.LV,1, Max(Decode(b.YM,'03',b.SUM_PLAN_AMT)), \n";
			strSql += " 			2,Max(Decode(b.YM,'03',b.B_MOD_PLAN_AMT))	, \n";
			strSql += " 			3,Max(Decode(b.YM,'03',b.PLAN_AMT)))			PLAN_AMT_03, \n";
			strSql += " 	Decode(a.LV,1, Max(Decode(b.YM,'04',b.SUM_PLAN_AMT)), \n";
			strSql += " 			2,Max(Decode(b.YM,'04',b.B_MOD_PLAN_AMT))	, \n";
			strSql += " 			3,Max(Decode(b.YM,'04',b.PLAN_AMT)))			PLAN_AMT_04, \n";
			strSql += " 	Decode(a.LV,1, Max(Decode(b.YM,'05',b.SUM_PLAN_AMT)), \n";
			strSql += " 			2,Max(Decode(b.YM,'05',b.B_MOD_PLAN_AMT))	, \n";
			strSql += " 			3,Max(Decode(b.YM,'05',b.PLAN_AMT)))			PLAN_AMT_05, \n";
			strSql += " 	Decode(a.LV,1, Max(Decode(b.YM,'06',b.SUM_PLAN_AMT)), \n";
			strSql += " 			2,Max(Decode(b.YM,'06',b.B_MOD_PLAN_AMT))	, \n";
			strSql += " 			3,Max(Decode(b.YM,'06',b.PLAN_AMT)))			PLAN_AMT_06, \n";
			strSql += " 	Decode(a.LV,1, Max(Decode(b.YM,'07',b.SUM_PLAN_AMT)), \n";
			strSql += " 			2,Max(Decode(b.YM,'07',b.B_MOD_PLAN_AMT))	, \n";
			strSql += " 			3,Max(Decode(b.YM,'07',b.PLAN_AMT)))			PLAN_AMT_07, \n";
			strSql += " 	Decode(a.LV,1, Max(Decode(b.YM,'08',b.SUM_PLAN_AMT)), \n";
			strSql += " 			2,Max(Decode(b.YM,'08',b.B_MOD_PLAN_AMT))	, \n";
			strSql += " 			3,Max(Decode(b.YM,'08',b.PLAN_AMT)))			PLAN_AMT_08, \n";
			strSql += " 	Decode(a.LV,1, Max(Decode(b.YM,'09',b.SUM_PLAN_AMT)), \n";
			strSql += " 			2,Max(Decode(b.YM,'09',b.B_MOD_PLAN_AMT))	, \n";
			strSql += " 			3,Max(Decode(b.YM,'09',b.PLAN_AMT)))			PLAN_AMT_09, \n";
			strSql += " 	Decode(a.LV,1, Max(Decode(b.YM,'10',b.SUM_PLAN_AMT)), \n";
			strSql += " 			2,Max(Decode(b.YM,'10',b.B_MOD_PLAN_AMT))	, \n";
			strSql += " 			3,Max(Decode(b.YM,'10',b.PLAN_AMT)))			PLAN_AMT_10, \n";
			strSql += " 	Decode(a.LV,1, Max(Decode(b.YM,'11',b.SUM_PLAN_AMT)), \n";
			strSql += " 			2,Max(Decode(b.YM,'11',b.B_MOD_PLAN_AMT))	, \n";
			strSql += " 			3,Max(Decode(b.YM,'11',b.PLAN_AMT)))			PLAN_AMT_11, \n";
			strSql += " 	Decode(a.LV,1, Max(Decode(b.YM,'12',b.SUM_PLAN_AMT)), \n";
			strSql += " 			2,Max(Decode(b.YM,'12',b.B_MOD_PLAN_AMT))	, \n";
			strSql += " 			3,Max(Decode(b.YM,'12',b.PLAN_AMT)))			PLAN_AMT_12 \n";
			strSql += " From \n";
			strSql += " 	( \n";
			strSql += " 		Select \n";
			strSql += " 			a.COMP_CODE, \n";
			strSql += " 			a.CLSE_ACC_ID, \n";
			strSql += " 			a.FLOW_CODE , \n";
			strSql += " 			a.CRTUSERNO , \n";
			strSql += " 			a.CRTDATE , \n";
			strSql += " 			a.MODUSERNO , \n";
			strSql += " 			a.MODDATE , \n";
			strSql += " 			a.P_NO , \n";
			strSql += " 			a.LEVELED_FLOW_ITEM_NAME, \n";
			strSql += " 			a.IS_LEAF_TAG, \n";
			strSql += " 			a.RN, \n";
			strSql += " 			x.LV, \n";
			strSql += " 			Decode(x.LV,1,'집계',2,'본사조정',3,'계') SUBTITLE_NAME \n";
			strSql += " 		From \n";
			strSql += " 			( \n";
			strSql += " 				Select \n";
			strSql += " 					 ?  COMP_CODE, \n";
			strSql += " 					 ?  CLSE_ACC_ID, \n";
			strSql += " 					a.CRTUSERNO , \n";
			strSql += " 					a.CRTDATE , \n";
			strSql += " 					a.MODUSERNO , \n";
			strSql += " 					a.MODDATE , \n";
			strSql += " 					a.BIZ_PLAN_ITEM_NO FLOW_CODE , \n";
			strSql += " 					a.P_NO , \n";
			strSql += " 					RPad(' ',(Level - 1) * 2,' ') || a.BIZ_PLAN_ITEM_NAME LEVELED_FLOW_ITEM_NAME, \n";
			strSql += " 					a.IS_LEAF_TAG, \n";
			strSql += " 					RowNum RN \n";
			strSql += " 				From	T_PL_ITEM a \n";
			strSql += " 				Start with a.P_NO = 0 \n";
			strSql += " 				Connect by \n";
			strSql += " 					Prior	a.BIZ_PLAN_ITEM_NO = a.P_NO \n";
			strSql += " 				Order Siblings By \n";
			strSql += " 					a.ITEM_LEVEL_SEQ \n";
			strSql += " 			) a, \n";
			strSql += " 			( \n";
			strSql += " 				Select \n";
			strSql += " 					LEVEL LV \n";
			strSql += " 				From	Dual \n";
			strSql += " 				Connect By \n";
			strSql += " 					LEVEL <= 3 \n";
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
			strSql += " 			b.BIZ_PLAN_ITEM_NO FLOW_CODE , \n";
			strSql += " 			b.SUM_PLAN_AMT , \n";
			strSql += " 			b.MOD_PLAN_AMT , \n";
			strSql += " 			b.B_MOD_PLAN_AMT, \n";
			strSql += " 			b.PLAN_AMT \n";
			strSql += " 		From	T_PL_COMP_PLAN_EXEC b \n";
			strSql += " 		Where	b.COMP_CODE =  ?  \n";
			strSql += " 		And		b.CLSE_ACC_ID =  ?  \n";
			strSql += " 	) b \n";
			strSql += " Where	a.COMP_CODE = b.COMP_CODE (+) \n";
			strSql += " And		a.CLSE_ACC_ID = b.CLSE_ACC_ID (+) \n";
			strSql += " And		a.FLOW_CODE = b.FLOW_CODE (+) \n";
			strSql += " Group By \n";
			strSql += " 	a.COMP_CODE, \n";
			strSql += " 	a.CLSE_ACC_ID, \n";
			strSql += " 	a.FLOW_CODE , \n";
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
			
			lrArgData.addColumn("1COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("2CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("3COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("4CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("2CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("3COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("4CLSE_ACC_ID", strCLSE_ACC_ID);
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
			
			strSql  = " Select F_T_FL_Is_Close_Comp( ? , ?  ) PLAN_CONFIRM_TAG \n";
			strSql += " from dual ";
			
			lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("COMP_CODE", strCOMP_CODE);
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