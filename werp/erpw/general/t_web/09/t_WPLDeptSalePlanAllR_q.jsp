<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 김흥수 작성(2006-01-11)
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
			String strDEPT_NAME = CITCommon.toKOR(request.getParameter("DEPT_NAME"));
			
			strSql  = " Select \n";
			strSql += " 	a.COMP_CODE, \n";
			strSql += " 	a.CLSE_ACC_ID, \n";
			strSql += " 	a.DEPT_CODE, \n";
			strSql += " 	a.DEPT_NAME, \n";
			strSql += " 	a.LV, \n";
			strSql += " 	SubStrb(a.SUBTITLE_NAME,1,100) SUBTITLE_NAME, \n";
			strSql += " 	Decode(a.LV, \n";
			strSql += " 			1,Max(Decode(b.YM,'00',b.CONS_AMT)), \n";
			strSql += " 			2,Max(Decode(b.YM,'00',b.BUDG_AMT)), \n";
			strSql += " 			3,Max(Decode(b.YM,'00',b.COST_AMT)), \n";
			strSql += " 			4,Max(Decode(b.YM,'00',b.SALE_AMT)))	AMT_00, \n";
			strSql += " 	SubStrb(a.SUBTITLE_NAME2,1,100) SUBTITLE_NAME2, \n";
			strSql += " 	Decode(a.LV, \n";
			strSql += " 			1,Max(Decode(b.YM,'01',b.CONS_AMT)), \n";
			strSql += " 			2,Max(Decode(b.YM,'01',b.BUDG_AMT)), \n";
			strSql += " 			3,Max(Decode(b.YM,'01',b.COST_AMT)), \n";
			strSql += " 			4,Max(Decode(b.YM,'01',b.SALE_AMT)))	AMT_01, \n";
			strSql += " 	Decode(a.LV, \n";
			strSql += " 			1,Max(Decode(b.YM,'02',b.CONS_AMT)), \n";
			strSql += " 			2,Max(Decode(b.YM,'02',b.BUDG_AMT)), \n";
			strSql += " 			3,Max(Decode(b.YM,'02',b.COST_AMT)), \n";
			strSql += " 			4,Max(Decode(b.YM,'02',b.SALE_AMT)))	AMT_02, \n";
			strSql += " 	Decode(a.LV, \n";
			strSql += " 			1,Max(Decode(b.YM,'03',b.CONS_AMT)), \n";
			strSql += " 			2,Max(Decode(b.YM,'03',b.BUDG_AMT)), \n";
			strSql += " 			3,Max(Decode(b.YM,'03',b.COST_AMT)), \n";
			strSql += " 			4,Max(Decode(b.YM,'03',b.SALE_AMT)))	AMT_03, \n";
			strSql += " 	Decode(a.LV, \n";
			strSql += " 			1,Max(Decode(b.YM,'04',b.CONS_AMT)), \n";
			strSql += " 			2,Max(Decode(b.YM,'04',b.BUDG_AMT)), \n";
			strSql += " 			3,Max(Decode(b.YM,'04',b.COST_AMT)), \n";
			strSql += " 			4,Max(Decode(b.YM,'04',b.SALE_AMT)))	AMT_04, \n";
			strSql += " 	Decode(a.LV, \n";
			strSql += " 			1,Max(Decode(b.YM,'05',b.CONS_AMT)), \n";
			strSql += " 			2,Max(Decode(b.YM,'05',b.BUDG_AMT)), \n";
			strSql += " 			3,Max(Decode(b.YM,'05',b.COST_AMT)), \n";
			strSql += " 			4,Max(Decode(b.YM,'05',b.SALE_AMT)))	AMT_05, \n";
			strSql += " 	Decode(a.LV, \n";
			strSql += " 			1,Max(Decode(b.YM,'06',b.CONS_AMT)), \n";
			strSql += " 			2,Max(Decode(b.YM,'06',b.BUDG_AMT)), \n";
			strSql += " 			3,Max(Decode(b.YM,'06',b.COST_AMT)), \n";
			strSql += " 			4,Max(Decode(b.YM,'06',b.SALE_AMT)))	AMT_06, \n";
			strSql += " 	Decode(a.LV, \n";
			strSql += " 			1,Max(Decode(b.YM,'07',b.CONS_AMT)), \n";
			strSql += " 			2,Max(Decode(b.YM,'07',b.BUDG_AMT)), \n";
			strSql += " 			3,Max(Decode(b.YM,'07',b.COST_AMT)), \n";
			strSql += " 			4,Max(Decode(b.YM,'07',b.SALE_AMT)))	AMT_07, \n";
			strSql += " 	Decode(a.LV, \n";
			strSql += " 			1,Max(Decode(b.YM,'08',b.CONS_AMT)), \n";
			strSql += " 			2,Max(Decode(b.YM,'08',b.BUDG_AMT)), \n";
			strSql += " 			3,Max(Decode(b.YM,'08',b.COST_AMT)), \n";
			strSql += " 			4,Max(Decode(b.YM,'08',b.SALE_AMT)))	AMT_08, \n";
			strSql += " 	Decode(a.LV, \n";
			strSql += " 			1,Max(Decode(b.YM,'09',b.CONS_AMT)), \n";
			strSql += " 			2,Max(Decode(b.YM,'09',b.BUDG_AMT)), \n";
			strSql += " 			3,Max(Decode(b.YM,'09',b.COST_AMT)), \n";
			strSql += " 			4,Max(Decode(b.YM,'09',b.SALE_AMT)))	AMT_09, \n";
			strSql += " 	Decode(a.LV, \n";
			strSql += " 			1,Max(Decode(b.YM,'10',b.CONS_AMT)), \n";
			strSql += " 			2,Max(Decode(b.YM,'10',b.BUDG_AMT)), \n";
			strSql += " 			3,Max(Decode(b.YM,'10',b.COST_AMT)), \n";
			strSql += " 			4,Max(Decode(b.YM,'10',b.SALE_AMT)))	AMT_10, \n";
			strSql += " 	Decode(a.LV, \n";
			strSql += " 			1,Max(Decode(b.YM,'11',b.CONS_AMT)), \n";
			strSql += " 			2,Max(Decode(b.YM,'11',b.BUDG_AMT)), \n";
			strSql += " 			3,Max(Decode(b.YM,'11',b.COST_AMT)), \n";
			strSql += " 			4,Max(Decode(b.YM,'11',b.SALE_AMT)))	AMT_11, \n";
			strSql += " 	Decode(a.LV, \n";
			strSql += " 			1,Max(Decode(b.YM,'12',b.CONS_AMT)), \n";
			strSql += " 			2,Max(Decode(b.YM,'12',b.BUDG_AMT)), \n";
			strSql += " 			3,Max(Decode(b.YM,'12',b.COST_AMT)), \n";
			strSql += " 			4,Max(Decode(b.YM,'12',b.SALE_AMT)))	AMT_12 \n";
			strSql += " From \n";
			strSql += " 	( \n";
			strSql += " 		Select \n";
			strSql += " 			y.COMP_CODE, \n";
			strSql += " 			y.CLSE_ACC_ID, \n";
			strSql += " 			y.DEPT_CODE, \n";
			strSql += " 			y.DEPT_NAME, \n";
			strSql += " 			x.LV, \n";
			strSql += " 			Decode(x.LV,1,'년초도급금액',2,'년초실행금액',3,'년초누적원가',4,'년초누적매출') SUBTITLE_NAME, \n";
			strSql += " 			Decode(x.LV,1,'수주증감액',2,'실행증감액',3,'월발생원가',4,'월매출액') SUBTITLE_NAME2 \n";
			strSql += " 		From \n";
			strSql += " 			( \n";
			strSql += " 				Select \n";
			strSql += " 					LEVEL LV \n";
			strSql += " 				From	Dual \n";
			strSql += " 				Connect By \n";
			strSql += " 					LEVEL <= 4 \n";
			strSql += " 			) x, \n";
			strSql += " 			( \n";
			strSql += " 				Select \n";
			strSql += " 					y.COMP_CODE , \n";
			strSql += " 					y.CLSE_ACC_ID , \n";
			strSql += " 					y.DEPT_CODE , \n";
			strSql += " 					z.DEPT_NAME \n";
			strSql += " 				From	T_PL_PLAN_DEPT y, \n";
			strSql += " 						T_PL_REAL_N_VIR_DEPT z \n";
			strSql += " 				Where	y.DEPT_CODE = z.DEPT_CODE \n";
			strSql += " 				And		y.COMP_CODE =  ?  \n";
			strSql += " 				And		y.CLSE_ACC_ID =  ?  \n";
			strSql += " 			) y \n";
			strSql += " 	) a, \n";
			strSql += " 	( \n";
			strSql += " 		Select \n";
			strSql += " 			a.COMP_CODE , \n";
			strSql += " 			a.CLSE_ACC_ID , \n";
			strSql += " 			a.DEPT_CODE, \n";
			strSql += " 			'00' YM, \n";
			strSql += " 			 ?  || '00' WORK_YM, \n";
			strSql += " 			a.CONS_AMT , \n";
			strSql += " 			a.BUDG_AMT , \n";
			strSql += " 			a.PY_COST_SUM COST_AMT, \n";
			strSql += " 			a.PY_SALE_SUM SALE_AMT \n";
			strSql += " 		From	T_PL_SALE_PLAN a \n";
			strSql += " 		Where	a.COMP_CODE =  ?  \n";
			strSql += " 		And		a.CLSE_ACC_ID =  ?  \n";
			strSql += " 		Union All \n";
			strSql += " 		Select \n";
			strSql += " 			a.COMP_CODE , \n";
			strSql += " 			a.CLSE_ACC_ID , \n";
			strSql += " 			a.DEPT_CODE, \n";
			strSql += " 			SubStrb(a.WORK_YM,-2) YM, \n";
			strSql += " 			a.WORK_YM, \n";
			strSql += " 			a.CONS_INC_AMT , \n";
			strSql += " 			a.BUDG_INC_AMT , \n";
			strSql += " 			a.NM_COST_AMT , \n";
			strSql += " 			a.NM_SALE_AMT \n";
			strSql += " 		From	T_PL_SALE_PLAN_YM a \n";
			strSql += " 		Where	a.COMP_CODE =  ?  \n";
			strSql += " 		And		a.CLSE_ACC_ID =  ?  \n";
			strSql += " 	) b \n";
			strSql += " Where	a.COMP_CODE = b.COMP_CODE (+) \n";
			strSql += " And		a.CLSE_ACC_ID = b.CLSE_ACC_ID (+) \n";
			strSql += " And		a.DEPT_CODE = b.DEPT_CODE (+) \n";
			strSql += " And		a.DEPT_NAME Like '%' || ?  || '%' \n";
			strSql += " Group By \n";
			strSql += " 	a.COMP_CODE, \n";
			strSql += " 	a.CLSE_ACC_ID, \n";
			strSql += " 	a.DEPT_CODE, \n";
			strSql += " 	a.DEPT_NAME, \n";
			strSql += " 	a.LV, \n";
			strSql += " 	a.SUBTITLE_NAME, \n";
			strSql += " 	a.SUBTITLE_NAME2 \n";
			strSql += "  ";
/*
Select
	a.COMP_CODE,
	a.CLSE_ACC_ID,
	a.DEPT_CODE,
	a.DEPT_NAME,
	a.LV,
	SubStrb(a.SUBTITLE_NAME,1,100) SUBTITLE_NAME,
	Decode(a.LV,
			1,Max(Decode(b.YM,'00',b.CONS_AMT)),
			2,Max(Decode(b.YM,'00',b.BUDG_AMT)),
			3,Max(Decode(b.YM,'00',b.COST_AMT)),
			5,Max(Decode(b.YM,'00',b.PROGRESS_RATIO)),
			4,Max(Decode(b.YM,'00',b.SALE_AMT)))	AMT_00,
	SubStrb(a.SUBTITLE_NAME2,1,100) SUBTITLE_NAME2,
	Decode(a.LV,
			1,Max(Decode(b.YM,'01',b.CONS_AMT)),
			2,Max(Decode(b.YM,'01',b.BUDG_AMT)),
			3,Max(Decode(b.YM,'01',b.COST_AMT)),
			5,Max(Decode(b.YM,'01',b.PROGRESS_RATIO)),
			4,Max(Decode(b.YM,'01',b.SALE_AMT)))	AMT_01,
	Decode(a.LV,
			1,Max(Decode(b.YM,'02',b.CONS_AMT)),
			2,Max(Decode(b.YM,'02',b.BUDG_AMT)),
			3,Max(Decode(b.YM,'02',b.COST_AMT)),
			5,Max(Decode(b.YM,'02',b.PROGRESS_RATIO)),
			4,Max(Decode(b.YM,'02',b.SALE_AMT)))	AMT_02,
	Decode(a.LV,
			1,Max(Decode(b.YM,'03',b.CONS_AMT)),
			2,Max(Decode(b.YM,'03',b.BUDG_AMT)),
			3,Max(Decode(b.YM,'03',b.COST_AMT)),
			5,Max(Decode(b.YM,'03',b.PROGRESS_RATIO)),
			4,Max(Decode(b.YM,'03',b.SALE_AMT)))	AMT_03,
	Decode(a.LV,
			1,Max(Decode(b.YM,'04',b.CONS_AMT)),
			2,Max(Decode(b.YM,'04',b.BUDG_AMT)),
			3,Max(Decode(b.YM,'04',b.COST_AMT)),
			5,Max(Decode(b.YM,'04',b.PROGRESS_RATIO)),
			4,Max(Decode(b.YM,'04',b.SALE_AMT)))	AMT_04,
	Decode(a.LV,
			1,Max(Decode(b.YM,'05',b.CONS_AMT)),
			2,Max(Decode(b.YM,'05',b.BUDG_AMT)),
			3,Max(Decode(b.YM,'05',b.COST_AMT)),
			5,Max(Decode(b.YM,'05',b.PROGRESS_RATIO)),
			4,Max(Decode(b.YM,'05',b.SALE_AMT)))	AMT_05,
	Decode(a.LV,
			1,Max(Decode(b.YM,'06',b.CONS_AMT)),
			2,Max(Decode(b.YM,'06',b.BUDG_AMT)),
			3,Max(Decode(b.YM,'06',b.COST_AMT)),
			5,Max(Decode(b.YM,'06',b.PROGRESS_RATIO)),
			4,Max(Decode(b.YM,'06',b.SALE_AMT)))	AMT_06,
	Decode(a.LV,
			1,Max(Decode(b.YM,'07',b.CONS_AMT)),
			2,Max(Decode(b.YM,'07',b.BUDG_AMT)),
			3,Max(Decode(b.YM,'07',b.COST_AMT)),
			5,Max(Decode(b.YM,'07',b.PROGRESS_RATIO)),
			4,Max(Decode(b.YM,'07',b.SALE_AMT)))	AMT_07,
	Decode(a.LV,
			1,Max(Decode(b.YM,'08',b.CONS_AMT)),
			2,Max(Decode(b.YM,'08',b.BUDG_AMT)),
			3,Max(Decode(b.YM,'08',b.COST_AMT)),
			5,Max(Decode(b.YM,'08',b.PROGRESS_RATIO)),
			4,Max(Decode(b.YM,'08',b.SALE_AMT)))	AMT_08,
	Decode(a.LV,
			1,Max(Decode(b.YM,'09',b.CONS_AMT)),
			2,Max(Decode(b.YM,'09',b.BUDG_AMT)),
			3,Max(Decode(b.YM,'09',b.COST_AMT)),
			5,Max(Decode(b.YM,'09',b.PROGRESS_RATIO)),
			4,Max(Decode(b.YM,'09',b.SALE_AMT)))	AMT_09,
	Decode(a.LV,
			1,Max(Decode(b.YM,'10',b.CONS_AMT)),
			2,Max(Decode(b.YM,'10',b.BUDG_AMT)),
			3,Max(Decode(b.YM,'10',b.COST_AMT)),
			5,Max(Decode(b.YM,'10',b.PROGRESS_RATIO)),
			4,Max(Decode(b.YM,'10',b.SALE_AMT)))	AMT_10,
	Decode(a.LV,
			1,Max(Decode(b.YM,'11',b.CONS_AMT)),
			2,Max(Decode(b.YM,'11',b.BUDG_AMT)),
			3,Max(Decode(b.YM,'11',b.COST_AMT)),
			5,Max(Decode(b.YM,'11',b.PROGRESS_RATIO)),
			4,Max(Decode(b.YM,'11',b.SALE_AMT)))	AMT_11,
	Decode(a.LV,
			1,Max(Decode(b.YM,'12',b.CONS_AMT)),
			2,Max(Decode(b.YM,'12',b.BUDG_AMT)),
			3,Max(Decode(b.YM,'12',b.COST_AMT)),
			5,Max(Decode(b.YM,'12',b.PROGRESS_RATIO)),
			4,Max(Decode(b.YM,'12',b.SALE_AMT)))	AMT_12
From
	(
		Select
			y.COMP_CODE,
			y.CLSE_ACC_ID,
			y.DEPT_CODE,
			y.DEPT_NAME,
			x.LV,
			Decode(x.LV,1,'년초도급금액',2,'년초실행금액',3,'년초누적원가',4,'년초누적매출') SUBTITLE_NAME,
			Decode(x.LV,1,'수주증감액',2,'실행증감액',3,'월발생원가',4,'월매출액',5,'진행율') SUBTITLE_NAME2
		From
			(
				Select
					LEVEL LV
				From	Dual
				Connect By
					LEVEL <= 5
			) x,
			(
				Select
					y.COMP_CODE ,
					y.CLSE_ACC_ID ,
					y.DEPT_CODE ,
					z.DEPT_NAME
				From	T_PL_PLAN_DEPT y,
						T_PL_REAL_N_VIR_DEPT z
				Where	y.DEPT_CODE = z.DEPT_CODE
				And		y.COMP_CODE = :COMP_CODE
				And		y.CLSE_ACC_ID = :CLSE_ACC_ID
			) y
	) a,
	(
		Select
			a.COMP_CODE ,
			a.CLSE_ACC_ID ,
			a.DEPT_CODE,
			a.YM,
			a.WORK_YM,
			a.CONS_AMT,
			a.BUDG_AMT,
			a.COST_AMT,
			a.SALE_AMT,
			100 * Sum(a.COST_AMT) Over ( Partition By a.DEPT_CODE Order By a.WORK_YM) / NullIf(Sum(a.BUDG_AMT) Over ( Partition By a.DEPT_CODE Order By a.WORK_YM),0) PROGRESS_RATIO
		From
			(
				Select
					a.COMP_CODE ,
					a.CLSE_ACC_ID ,
					a.DEPT_CODE,
					'00' YM,
					:CLSE_ACC_ID  || '00' WORK_YM,
					a.CONS_AMT ,
					a.BUDG_AMT ,
					a.PY_COST_SUM COST_AMT,
					a.PY_SALE_SUM SALE_AMT
				From	T_PL_SALE_PLAN a
				Where	a.COMP_CODE = :COMP_CODE
				And		a.CLSE_ACC_ID = :CLSE_ACC_ID
				Union All
				Select
					a.COMP_CODE ,
					a.CLSE_ACC_ID ,
					a.DEPT_CODE,
					SubStrb(a.WORK_YM,-2) YM,
					a.WORK_YM,
					a.CONS_INC_AMT ,
					a.BUDG_INC_AMT ,
					a.NM_COST_AMT ,
					a.NM_SALE_AMT
				From	T_PL_SALE_PLAN_YM a
				Where	a.COMP_CODE = :COMP_CODE
				And		a.CLSE_ACC_ID = :CLSE_ACC_ID
			) a
		Order By
			a.DEPT_CODE,
			a.WORK_YM
	) b
Where	a.COMP_CODE = b.COMP_CODE (+)
And		a.CLSE_ACC_ID = b.CLSE_ACC_ID (+)
And		a.DEPT_CODE = b.DEPT_CODE (+)
And		a.DEPT_NAME Like '%' || :DEPT_NAME || '%'
Group By
	a.COMP_CODE,
	a.CLSE_ACC_ID,
	a.DEPT_CODE,
	a.DEPT_NAME,
	a.LV,
	a.SUBTITLE_NAME,
	a.SUBTITLE_NAME2
*/			
			lrArgData.addColumn("1COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("2CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("3CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("4COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("5CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("6COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("7CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("8DEPT_NAME", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("2CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("3CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("4COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("5CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("6COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("7CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("8DEPT_NAME", strDEPT_NAME);
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
			
			strSql  = " Select 'XXXXXXXXXX' COMP_CODE,'XXXXXXXXXX' CLSE_ACC_ID,'XXXXXXXXXXXXXXXXXXXX' DEPT_CODE From Dual where 1 = 0 \n";
			
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
			
			strSql  = " Select 'XXXXXXXXXX' COMP_CODE,'XXXXXXXXXX' CLSE_ACC_ID,'XXXXXXXXXXXXXXXXXXXX' DEPT_CODE From Dual where 1 = 0 \n";
			
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
			
			strSql  = " Select F_T_PL_Is_Close_Dept( ? , ? , ? ) PLAN_CONFIRM_TAG \n";
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