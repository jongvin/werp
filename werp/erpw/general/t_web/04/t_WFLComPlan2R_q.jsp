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
			
			strSql = 
				"Select"+"\n"+
				"	a.COMP_CODE,"+"\n"+
				"	a.CLSE_ACC_ID,"+"\n"+
				"	a.FLOW_CODE ,"+"\n"+
				"	a.CRTUSERNO ,"+"\n"+
				"	a.CRTDATE ,"+"\n"+
				"	a.MODUSERNO ,"+"\n"+
				"	a.MODDATE ,"+"\n"+
				"	a.P_NO ,"+"\n"+
				"	a.LEVELED_FLOW_ITEM_NAME,"+"\n"+
				"	a.IS_LEAF_TAG,"+"\n"+
				"	a.RN,"+"\n"+
				"	a.LV,"+"\n"+
				"	a.SUBTITLE_NAME ,"+"\n"+
				"	Decode(a.LV,1, Max(Decode(b.YM,'01',b.SUM_PLAN_AMT)),"+"\n"+
				"			2,Max(Decode(b.YM,'01',b.B_MOD_PLAN_AMT))	,"+"\n"+
				"			3,Max(Decode(b.YM,'01',b.PLAN_AMT)))			PLAN_AMT_01,"+"\n"+
				"	Decode(a.LV,1, Max(Decode(b.YM,'02',b.SUM_PLAN_AMT)),"+"\n"+
				"			2,Max(Decode(b.YM,'02',b.B_MOD_PLAN_AMT))	,"+"\n"+
				"			3,Max(Decode(b.YM,'02',b.PLAN_AMT)))			PLAN_AMT_02,"+"\n"+
				"	Decode(a.LV,1, Max(Decode(b.YM,'03',b.SUM_PLAN_AMT)),"+"\n"+
				"			2,Max(Decode(b.YM,'03',b.B_MOD_PLAN_AMT))	,"+"\n"+
				"			3,Max(Decode(b.YM,'03',b.PLAN_AMT)))			PLAN_AMT_03,"+"\n"+
				"	Decode(a.LV,1, Max(Decode(b.YM,'04',b.SUM_PLAN_AMT)),"+"\n"+
				"			2,Max(Decode(b.YM,'04',b.B_MOD_PLAN_AMT))	,"+"\n"+
				"			3,Max(Decode(b.YM,'04',b.PLAN_AMT)))			PLAN_AMT_04,"+"\n"+
				"	Decode(a.LV,1, Max(Decode(b.YM,'05',b.SUM_PLAN_AMT)),"+"\n"+
				"			2,Max(Decode(b.YM,'05',b.B_MOD_PLAN_AMT))	,"+"\n"+
				"			3,Max(Decode(b.YM,'05',b.PLAN_AMT)))			PLAN_AMT_05,"+"\n"+
				"	Decode(a.LV,1, Max(Decode(b.YM,'06',b.SUM_PLAN_AMT)),"+"\n"+
				"			2,Max(Decode(b.YM,'06',b.B_MOD_PLAN_AMT))	,"+"\n"+
				"			3,Max(Decode(b.YM,'06',b.PLAN_AMT)))			PLAN_AMT_06,"+"\n"+
				"	Decode(a.LV,1, Max(Decode(b.YM,'07',b.SUM_PLAN_AMT)),"+"\n"+
				"			2,Max(Decode(b.YM,'07',b.B_MOD_PLAN_AMT))	,"+"\n"+
				"			3,Max(Decode(b.YM,'07',b.PLAN_AMT)))			PLAN_AMT_07,"+"\n"+
				"	Decode(a.LV,1, Max(Decode(b.YM,'08',b.SUM_PLAN_AMT)),"+"\n"+
				"			2,Max(Decode(b.YM,'08',b.B_MOD_PLAN_AMT))	,"+"\n"+
				"			3,Max(Decode(b.YM,'08',b.PLAN_AMT)))			PLAN_AMT_08,"+"\n"+
				"	Decode(a.LV,1, Max(Decode(b.YM,'09',b.SUM_PLAN_AMT)),"+"\n"+
				"			2,Max(Decode(b.YM,'09',b.B_MOD_PLAN_AMT))	,"+"\n"+
				"			3,Max(Decode(b.YM,'09',b.PLAN_AMT)))			PLAN_AMT_09,"+"\n"+
				"	Decode(a.LV,1, Max(Decode(b.YM,'10',b.SUM_PLAN_AMT)),"+"\n"+
				"			2,Max(Decode(b.YM,'10',b.B_MOD_PLAN_AMT))	,"+"\n"+
				"			3,Max(Decode(b.YM,'10',b.PLAN_AMT)))			PLAN_AMT_10,"+"\n"+
				"	Decode(a.LV,1, Max(Decode(b.YM,'11',b.SUM_PLAN_AMT)),"+"\n"+
				"			2,Max(Decode(b.YM,'11',b.B_MOD_PLAN_AMT))	,"+"\n"+
				"			3,Max(Decode(b.YM,'11',b.PLAN_AMT)))			PLAN_AMT_11,"+"\n"+
				"	Decode(a.LV,1, Max(Decode(b.YM,'12',b.SUM_PLAN_AMT)),"+"\n"+
				"			2,Max(Decode(b.YM,'12',b.B_MOD_PLAN_AMT))	,"+"\n"+
				"			3,Max(Decode(b.YM,'12',b.PLAN_AMT)))			PLAN_AMT_12"+"\n"+
				"From"+"\n"+
				"	("+"\n"+
				"		Select"+"\n"+
				"			a.COMP_CODE,"+"\n"+
				"			a.CLSE_ACC_ID,"+"\n"+
				"			a.FLOW_CODE ,"+"\n"+
				"			a.CRTUSERNO ,"+"\n"+
				"			a.CRTDATE ,"+"\n"+
				"			a.MODUSERNO ,"+"\n"+
				"			a.MODDATE ,"+"\n"+
				"			a.P_NO ,"+"\n"+
				"			a.LEVELED_FLOW_ITEM_NAME,"+"\n"+
				"			a.IS_LEAF_TAG,"+"\n"+
				"			a.RN,"+"\n"+
				"			x.LV,"+"\n"+
				"			Decode(x.LV,1,'집계',2,'본사조정',3,'계') SUBTITLE_NAME"+"\n"+
				"		From"+"\n"+
				"			("+"\n"+
				"				Select"+"\n"+
				"					?  COMP_CODE,"+"\n"+
				"					?  CLSE_ACC_ID,"+"\n"+
				"					a.CRTUSERNO ,"+"\n"+
				"					a.CRTDATE ,"+"\n"+
				"					a.MODUSERNO ,"+"\n"+
				"					a.MODDATE ,"+"\n"+
				"					a.FLOW_CODE_B FLOW_CODE ,"+"\n"+
				"					a.P_NO ,"+"\n"+
				"					RPad(' ',(Level - 1) * 2,' ') || a.FLOW_ITEM_NAME LEVELED_FLOW_ITEM_NAME,"+"\n"+
				"					a.IS_LEAF_TAG,"+"\n"+
				"					RowNum RN"+"\n"+
				"				From	T_FL_FLOW_CODE_B a"+"\n"+
				"				Start with a.P_NO = 0"+"\n"+
				"				Connect by"+"\n"+
				"					Prior	a.FLOW_CODE_B = a.P_NO"+"\n"+
				"				Order Siblings By"+"\n"+
				"					a.LEVEL_SEQ"+"\n"+
				"			) a,"+"\n"+
				"			("+"\n"+
				"				Select"+"\n"+
				"					LEVEL LV"+"\n"+
				"				From	Dual"+"\n"+
				"				Connect By"+"\n"+
				"					LEVEL <= 3"+"\n"+
				"			) x"+"\n"+
				"		Order By"+"\n"+
				"			a.RN,"+"\n"+
				"			x.LV"+"\n"+
				"	) a,"+"\n"+
				"	("+"\n"+
				"		Select"+"\n"+
				"			b.COMP_CODE ,"+"\n"+
				"			b.CLSE_ACC_ID ,"+"\n"+
				"			SubStrb(b.WORK_YM,-2) YM,"+"\n"+
				"			b.WORK_YM ,"+"\n"+
				"			b.FLOW_CODE_B FLOW_CODE ,"+"\n"+
				"			b.SUM_PLAN_AMT ,"+"\n"+
				"			b.MOD_PLAN_AMT ,"+"\n"+
				"			b.B_MOD_PLAN_AMT,"+"\n"+
				"			b.PLAN_AMT"+"\n"+
				"		From	T_FL_MONTH_PLAN_EXEC_B b"+"\n"+
				"		Where	b.COMP_CODE = ?"+"\n"+
				"		And		b.CLSE_ACC_ID = ?"+"\n"+
				"	) b"+"\n"+
				"Where	a.COMP_CODE = b.COMP_CODE (+)"+"\n"+
				"And		a.CLSE_ACC_ID = b.CLSE_ACC_ID (+)"+"\n"+
				"And		a.FLOW_CODE = b.FLOW_CODE (+)"+"\n"+
				"Group By"+"\n"+
				"	a.COMP_CODE,"+"\n"+
				"	a.CLSE_ACC_ID,"+"\n"+
				"	a.FLOW_CODE ,"+"\n"+
				"	a.CRTUSERNO ,"+"\n"+
				"	a.CRTDATE ,"+"\n"+
				"	a.MODUSERNO ,"+"\n"+
				"	a.MODDATE ,"+"\n"+
				"	a.P_NO ,"+"\n"+
				"	a.LEVELED_FLOW_ITEM_NAME,"+"\n"+
				"	a.IS_LEAF_TAG,"+"\n"+
				"	a.RN,"+"\n"+
				"	a.LV,"+"\n"+
				"	a.SUBTITLE_NAME"+"\n"+
				"Order By"+"\n"+
				"	a.RN,"+"\n"+
				"	a.LV"+"\n";
			
			lrArgData.addColumn("COMP_CODE1", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID1", CITData.VARCHAR2);
			lrArgData.addColumn("COMP_CODE2", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID2", CITData.VARCHAR2);
			lrArgData.addRow();
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