<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 김흥수 작성(2006-03-29)
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
			strSql += " 	a.KIND_CODE , \n";
			strSql += " 	a.COMP_CODE, \n";
			strSql += " 	a.CLSE_ACC_ID, \n";
			strSql += " 	a.CRTUSERNO , \n";
			strSql += " 	a.CRTDATE , \n";
			strSql += " 	a.MODUSERNO , \n";
			strSql += " 	a.MODDATE , \n";
			strSql += " 	a.INV_TAG , \n";
			strSql += " 	a.INV_TAG_NAME, \n";
			strSql += " 	a.KIND_NAME, \n";
			strSql += " 	a.LV, \n";
			strSql += " 	a.LV_NAME, \n";
			strSql += " 	Decode(a.LV,1,Max(Decode(d.YM,'01',d.CONS_PLAN_AMT)), \n";
			strSql += " 				2,Max(Decode(d.YM,'01',d.FIN_PLAN_AMT))) PLAN_AMT_01, \n";
			strSql += " 	Decode(a.LV,1,Max(Decode(d.YM,'02',d.CONS_PLAN_AMT)), \n";
			strSql += " 				2,Max(Decode(d.YM,'02',d.FIN_PLAN_AMT))) PLAN_AMT_02, \n";
			strSql += " 	Decode(a.LV,1,Max(Decode(d.YM,'03',d.CONS_PLAN_AMT)), \n";
			strSql += " 				2,Max(Decode(d.YM,'03',d.FIN_PLAN_AMT))) PLAN_AMT_03, \n";
			strSql += " 	Decode(a.LV,1,Max(Decode(d.YM,'04',d.CONS_PLAN_AMT)), \n";
			strSql += " 				2,Max(Decode(d.YM,'04',d.FIN_PLAN_AMT))) PLAN_AMT_04, \n";
			strSql += " 	Decode(a.LV,1,Max(Decode(d.YM,'05',d.CONS_PLAN_AMT)), \n";
			strSql += " 				2,Max(Decode(d.YM,'05',d.FIN_PLAN_AMT))) PLAN_AMT_05, \n";
			strSql += " 	Decode(a.LV,1,Max(Decode(d.YM,'06',d.CONS_PLAN_AMT)), \n";
			strSql += " 				2,Max(Decode(d.YM,'06',d.FIN_PLAN_AMT))) PLAN_AMT_06, \n";
			strSql += " 	Decode(a.LV,1,Max(Decode(d.YM,'07',d.CONS_PLAN_AMT)), \n";
			strSql += " 				2,Max(Decode(d.YM,'07',d.FIN_PLAN_AMT))) PLAN_AMT_07, \n";
			strSql += " 	Decode(a.LV,1,Max(Decode(d.YM,'08',d.CONS_PLAN_AMT)), \n";
			strSql += " 				2,Max(Decode(d.YM,'08',d.FIN_PLAN_AMT))) PLAN_AMT_08, \n";
			strSql += " 	Decode(a.LV,1,Max(Decode(d.YM,'09',d.CONS_PLAN_AMT)), \n";
			strSql += " 				2,Max(Decode(d.YM,'09',d.FIN_PLAN_AMT))) PLAN_AMT_09, \n";
			strSql += " 	Decode(a.LV,1,Max(Decode(d.YM,'10',d.CONS_PLAN_AMT)), \n";
			strSql += " 				2,Max(Decode(d.YM,'10',d.FIN_PLAN_AMT))) PLAN_AMT_10, \n";
			strSql += " 	Decode(a.LV,1,Max(Decode(d.YM,'11',d.CONS_PLAN_AMT)), \n";
			strSql += " 				2,Max(Decode(d.YM,'11',d.FIN_PLAN_AMT))) PLAN_AMT_11, \n";
			strSql += " 	Decode(a.LV,1,Max(Decode(d.YM,'12',d.CONS_PLAN_AMT)), \n";
			strSql += " 				2,Max(Decode(d.YM,'12',d.FIN_PLAN_AMT))) PLAN_AMT_12, \n";
			strSql += " 	Decode(a.LV,1,Max(Decode(d.YM,'01',d.CONS_FORECAST_AMT)), \n";
			strSql += " 				2,Max(Decode(d.YM,'01',d.FIN_FORECAST_AMT))) FORECAST_AMT_01, \n";
			strSql += " 	Decode(a.LV,1,Max(Decode(d.YM,'02',d.CONS_FORECAST_AMT)), \n";
			strSql += " 				2,Max(Decode(d.YM,'02',d.FIN_FORECAST_AMT))) FORECAST_AMT_02, \n";
			strSql += " 	Decode(a.LV,1,Max(Decode(d.YM,'03',d.CONS_FORECAST_AMT)), \n";
			strSql += " 				2,Max(Decode(d.YM,'03',d.FIN_FORECAST_AMT))) FORECAST_AMT_03, \n";
			strSql += " 	Decode(a.LV,1,Max(Decode(d.YM,'04',d.CONS_FORECAST_AMT)), \n";
			strSql += " 				2,Max(Decode(d.YM,'04',d.FIN_FORECAST_AMT))) FORECAST_AMT_04, \n";
			strSql += " 	Decode(a.LV,1,Max(Decode(d.YM,'05',d.CONS_FORECAST_AMT)), \n";
			strSql += " 				2,Max(Decode(d.YM,'05',d.FIN_FORECAST_AMT))) FORECAST_AMT_05, \n";
			strSql += " 	Decode(a.LV,1,Max(Decode(d.YM,'06',d.CONS_FORECAST_AMT)), \n";
			strSql += " 				2,Max(Decode(d.YM,'06',d.FIN_FORECAST_AMT))) FORECAST_AMT_06, \n";
			strSql += " 	Decode(a.LV,1,Max(Decode(d.YM,'07',d.CONS_FORECAST_AMT)), \n";
			strSql += " 				2,Max(Decode(d.YM,'07',d.FIN_FORECAST_AMT))) FORECAST_AMT_07, \n";
			strSql += " 	Decode(a.LV,1,Max(Decode(d.YM,'08',d.CONS_FORECAST_AMT)), \n";
			strSql += " 				2,Max(Decode(d.YM,'08',d.FIN_FORECAST_AMT))) FORECAST_AMT_08, \n";
			strSql += " 	Decode(a.LV,1,Max(Decode(d.YM,'09',d.CONS_FORECAST_AMT)), \n";
			strSql += " 				2,Max(Decode(d.YM,'09',d.FIN_FORECAST_AMT))) FORECAST_AMT_09, \n";
			strSql += " 	Decode(a.LV,1,Max(Decode(d.YM,'10',d.CONS_FORECAST_AMT)), \n";
			strSql += " 				2,Max(Decode(d.YM,'10',d.FIN_FORECAST_AMT))) FORECAST_AMT_10, \n";
			strSql += " 	Decode(a.LV,1,Max(Decode(d.YM,'11',d.CONS_FORECAST_AMT)), \n";
			strSql += " 				2,Max(Decode(d.YM,'11',d.FIN_FORECAST_AMT))) FORECAST_AMT_11, \n";
			strSql += " 	Decode(a.LV,1,Max(Decode(d.YM,'12',d.CONS_FORECAST_AMT)), \n";
			strSql += " 				2,Max(Decode(d.YM,'12',d.FIN_FORECAST_AMT))) FORECAST_AMT_12, \n";
			strSql += " 	Decode(a.LV,1,Max(Decode(d.YM,'01',d.CONS_EXEC_AMT)), \n";
			strSql += " 				2,Max(Decode(d.YM,'01',d.FIN_EXEC_AMT))) EXEC_AMT_01, \n";
			strSql += " 	Decode(a.LV,1,Max(Decode(d.YM,'02',d.CONS_EXEC_AMT)), \n";
			strSql += " 				2,Max(Decode(d.YM,'02',d.FIN_EXEC_AMT))) EXEC_AMT_02, \n";
			strSql += " 	Decode(a.LV,1,Max(Decode(d.YM,'03',d.CONS_EXEC_AMT)), \n";
			strSql += " 				2,Max(Decode(d.YM,'03',d.FIN_EXEC_AMT))) EXEC_AMT_03, \n";
			strSql += " 	Decode(a.LV,1,Max(Decode(d.YM,'04',d.CONS_EXEC_AMT)), \n";
			strSql += " 				2,Max(Decode(d.YM,'04',d.FIN_EXEC_AMT))) EXEC_AMT_04, \n";
			strSql += " 	Decode(a.LV,1,Max(Decode(d.YM,'05',d.CONS_EXEC_AMT)), \n";
			strSql += " 				2,Max(Decode(d.YM,'05',d.FIN_EXEC_AMT))) EXEC_AMT_05, \n";
			strSql += " 	Decode(a.LV,1,Max(Decode(d.YM,'06',d.CONS_EXEC_AMT)), \n";
			strSql += " 				2,Max(Decode(d.YM,'06',d.FIN_EXEC_AMT))) EXEC_AMT_06, \n";
			strSql += " 	Decode(a.LV,1,Max(Decode(d.YM,'07',d.CONS_EXEC_AMT)), \n";
			strSql += " 				2,Max(Decode(d.YM,'07',d.FIN_EXEC_AMT))) EXEC_AMT_07, \n";
			strSql += " 	Decode(a.LV,1,Max(Decode(d.YM,'08',d.CONS_EXEC_AMT)), \n";
			strSql += " 				2,Max(Decode(d.YM,'08',d.FIN_EXEC_AMT))) EXEC_AMT_08, \n";
			strSql += " 	Decode(a.LV,1,Max(Decode(d.YM,'09',d.CONS_EXEC_AMT)), \n";
			strSql += " 				2,Max(Decode(d.YM,'09',d.FIN_EXEC_AMT))) EXEC_AMT_09, \n";
			strSql += " 	Decode(a.LV,1,Max(Decode(d.YM,'10',d.CONS_EXEC_AMT)), \n";
			strSql += " 				2,Max(Decode(d.YM,'10',d.FIN_EXEC_AMT))) EXEC_AMT_10, \n";
			strSql += " 	Decode(a.LV,1,Max(Decode(d.YM,'11',d.CONS_EXEC_AMT)), \n";
			strSql += " 				2,Max(Decode(d.YM,'11',d.FIN_EXEC_AMT))) EXEC_AMT_11, \n";
			strSql += " 	Decode(a.LV,1,Max(Decode(d.YM,'12',d.CONS_EXEC_AMT)), \n";
			strSql += " 				2,Max(Decode(d.YM,'12',d.FIN_EXEC_AMT))) EXEC_AMT_12 \n";
			strSql += " From \n";
			strSql += " 	( \n";
			strSql += " 		Select \n";
			strSql += " 			a.KIND_CODE , \n";
			strSql += " 			a.COMP_CODE, \n";
			strSql += " 			a.CLSE_ACC_ID, \n";
			strSql += " 			a.CRTUSERNO , \n";
			strSql += " 			a.CRTDATE , \n";
			strSql += " 			a.MODUSERNO , \n";
			strSql += " 			a.MODDATE , \n";
			strSql += " 			a.INV_TAG , \n";
			strSql += " 			a.INV_TAG_NAME, \n";
			strSql += " 			a.KIND_NAME, \n";
			strSql += " 			c.LV, \n";
			strSql += " 			DECODE(c.LV,1,'공사','자금') LV_NAME \n";
			strSql += " 		From \n";
			strSql += " 			( \n";
			strSql += " 				Select \n";
			strSql += " 					a.KIND_CODE , \n";
			strSql += " 					 ?  COMP_CODE, \n";
			strSql += " 					 ?  CLSE_ACC_ID, \n";
			strSql += " 					a.CRTUSERNO , \n";
			strSql += " 					a.CRTDATE , \n";
			strSql += " 					a.MODUSERNO , \n";
			strSql += " 					a.MODDATE , \n";
			strSql += " 					a.INV_TAG , \n";
			strSql += " 					b.CODE_LIST_NAME INV_TAG_NAME, \n";
			strSql += " 					a.KIND_NAME \n";
			strSql += " 				From	T_PL_INV_PLAN_KIND_CODE a, \n";
			strSql += " 						( \n";
			strSql += " 							Select \n";
			strSql += " 								b.CODE_LIST_ID , \n";
			strSql += " 								b.CODE_LIST_NAME \n";
			strSql += " 							From	V_T_CODE_LIST b \n";
			strSql += " 							Where	b.CODE_GROUP_ID = 'INV_TAG' \n";
			strSql += " 						) b \n";
			strSql += " 				Where	a.INV_TAG = b.CODE_LIST_ID \n";
			strSql += " 			) a, \n";
			strSql += " 			( \n";
			strSql += " 				Select \n";
			strSql += " 					LEVEL LV \n";
			strSql += " 				From	dual \n";
			strSql += " 				Connect By \n";
			strSql += " 					LEVEL <= 2 \n";
			strSql += " 			) c \n";
			strSql += " 	) a, \n";
			strSql += " 	( \n";
			strSql += " 		Select \n";
			strSql += " 			d.KIND_CODE , \n";
			strSql += " 			d.COMP_CODE , \n";
			strSql += " 			d.CLSE_ACC_ID , \n";
			strSql += " 			d.WORK_YM , \n";
			strSql += " 			SubStrb(d.WORK_YM,-2) YM, \n";
			strSql += " 			d.CRTUSERNO , \n";
			strSql += " 			d.CRTDATE , \n";
			strSql += " 			d.MODUSERNO , \n";
			strSql += " 			d.MODDATE , \n";
			strSql += " 			d.CONS_PLAN_AMT , \n";
			strSql += " 			d.CONS_FORECAST_AMT , \n";
			strSql += " 			d.CONS_EXEC_AMT , \n";
			strSql += " 			d.FIN_PLAN_AMT , \n";
			strSql += " 			d.FIN_FORECAST_AMT , \n";
			strSql += " 			d.FIN_EXEC_AMT \n";
			strSql += " 		From	T_PL_INV_EXEC_MONTH d \n";
			strSql += " 		Where	d.COMP_CODE =  ?  \n";
			strSql += " 		And		d.CLSE_ACC_ID =  ?  \n";
			strSql += " 	) d \n";
			strSql += " Where	a.KIND_CODE = d.KIND_CODE (+) \n";
			strSql += " And		a.COMP_CODE = d.COMP_CODE (+) \n";
			strSql += " And		a.CLSE_ACC_ID = d.CLSE_ACC_ID (+) \n";
			strSql += " Group By \n";
			strSql += " 	a.COMP_CODE, \n";
			strSql += " 	a.CLSE_ACC_ID, \n";
			strSql += " 	a.KIND_CODE , \n";
			strSql += " 	a.CRTUSERNO , \n";
			strSql += " 	a.CRTDATE , \n";
			strSql += " 	a.MODUSERNO , \n";
			strSql += " 	a.MODDATE , \n";
			strSql += " 	a.INV_TAG , \n";
			strSql += " 	a.INV_TAG_NAME, \n";
			strSql += " 	a.KIND_NAME, \n";
			strSql += " 	a.LV, \n";
			strSql += " 	a.LV_NAME \n";
			strSql += " Order By \n";
			strSql += " 	a.INV_TAG, \n";
			strSql += " 	a.KIND_CODE, \n";
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