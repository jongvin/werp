<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : 
/* 2. ����(�ó�����) : Select Page
/* 3. ��  ��  ��  �� : 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-11)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
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
			strSql += " 	a.BIZ_PLAN_ITEM_NO , \n";
			strSql += " 	a.CRTUSERNO , \n";
			strSql += " 	a.CRTDATE , \n";
			strSql += " 	a.MODUSERNO , \n";
			strSql += " 	a.MODDATE , \n";
			strSql += " 	a.P_NO , \n";
			strSql += " 	a.LEVELED_NAME, \n";
			strSql += " 	a.IS_LEAF_TAG, \n";
			strSql += " 	a.RN, \n";
			strSql += " 	a.LV, \n";
			strSql += " 	a.SUBTITLE_NAME , \n";
			strSql += " 	Decode(a.LV,1, Max(Decode(b.YM,'01',b.SUM_PLAN_AMT)), \n";
			strSql += " 			2,Max(Decode(b.YM,'01',b.MOD_PLAN_AMT))	, \n";
			strSql += " 			3,Max(Decode(b.YM,'01',b.PLAN_AMT)))			PLAN_AMT_01, \n";
			strSql += " 	Decode(a.LV,1, Max(Decode(b.YM,'02',b.SUM_PLAN_AMT)), \n";
			strSql += " 			2,Max(Decode(b.YM,'02',b.MOD_PLAN_AMT))	, \n";
			strSql += " 			3,Max(Decode(b.YM,'02',b.PLAN_AMT)))			PLAN_AMT_02, \n";
			strSql += " 	Decode(a.LV,1, Max(Decode(b.YM,'03',b.SUM_PLAN_AMT)), \n";
			strSql += " 			2,Max(Decode(b.YM,'03',b.MOD_PLAN_AMT)), \n";
			strSql += " 			3,Max(Decode(b.YM,'03',b.PLAN_AMT)))			PLAN_AMT_03, \n";
			strSql += " 	Decode(a.LV,1, Max(Decode(b.YM,'04',b.SUM_PLAN_AMT)), \n";
			strSql += " 			2,Max(Decode(b.YM,'04',b.MOD_PLAN_AMT)), \n";
			strSql += " 			3,Max(Decode(b.YM,'04',b.PLAN_AMT)))			PLAN_AMT_04, \n";
			strSql += " 	Decode(a.LV,1, Max(Decode(b.YM,'05',b.SUM_PLAN_AMT)), \n";
			strSql += " 			2,Max(Decode(b.YM,'05',b.MOD_PLAN_AMT)), \n";
			strSql += " 			3,Max(Decode(b.YM,'05',b.PLAN_AMT)))			PLAN_AMT_05, \n";
			strSql += " 	Decode(a.LV,1, Max(Decode(b.YM,'06',b.SUM_PLAN_AMT)), \n";
			strSql += " 			2,Max(Decode(b.YM,'06',b.MOD_PLAN_AMT)), \n";
			strSql += " 			3,Max(Decode(b.YM,'06',b.PLAN_AMT)))			PLAN_AMT_06, \n";
			strSql += " 	Decode(a.LV,1, Max(Decode(b.YM,'07',b.SUM_PLAN_AMT)), \n";
			strSql += " 			2,Max(Decode(b.YM,'07',b.MOD_PLAN_AMT)), \n";
			strSql += " 			3,Max(Decode(b.YM,'07',b.PLAN_AMT)))			PLAN_AMT_07, \n";
			strSql += " 	Decode(a.LV,1, Max(Decode(b.YM,'08',b.SUM_PLAN_AMT)), \n";
			strSql += " 			2,Max(Decode(b.YM,'08',b.MOD_PLAN_AMT)), \n";
			strSql += " 			3,Max(Decode(b.YM,'08',b.PLAN_AMT)))			PLAN_AMT_08, \n";
			strSql += " 	Decode(a.LV,1, Max(Decode(b.YM,'09',b.SUM_PLAN_AMT)), \n";
			strSql += " 			2,Max(Decode(b.YM,'09',b.MOD_PLAN_AMT)), \n";
			strSql += " 			3,Max(Decode(b.YM,'09',b.PLAN_AMT)))			PLAN_AMT_09, \n";
			strSql += " 	Decode(a.LV,1, Max(Decode(b.YM,'10',b.SUM_PLAN_AMT)), \n";
			strSql += " 			2,Max(Decode(b.YM,'10',b.MOD_PLAN_AMT)), \n";
			strSql += " 			3,Max(Decode(b.YM,'10',b.PLAN_AMT)))			PLAN_AMT_10, \n";
			strSql += " 	Decode(a.LV,1, Max(Decode(b.YM,'11',b.SUM_PLAN_AMT)), \n";
			strSql += " 			2,Max(Decode(b.YM,'11',b.MOD_PLAN_AMT)), \n";
			strSql += " 			3,Max(Decode(b.YM,'11',b.PLAN_AMT)))			PLAN_AMT_11, \n";
			strSql += " 	Decode(a.LV,1, Max(Decode(b.YM,'12',b.SUM_PLAN_AMT)), \n";
			strSql += " 			2,Max(Decode(b.YM,'12',b.MOD_PLAN_AMT)), \n";
			strSql += " 			3,Max(Decode(b.YM,'12',b.PLAN_AMT)))			PLAN_AMT_12 \n";
			strSql += " From \n";
			strSql += " 	( \n";
			strSql += " 		Select \n";
			strSql += " 			y.COMP_CODE, \n";
			strSql += " 			y.CLSE_ACC_ID, \n";
			strSql += " 			y.DEPT_CODE, \n";
			strSql += " 			y.DEPT_NAME, \n";
			strSql += " 			a.BIZ_PLAN_ITEM_NO , \n";
			strSql += " 			a.CRTUSERNO , \n";
			strSql += " 			a.CRTDATE , \n";
			strSql += " 			a.MODUSERNO , \n";
			strSql += " 			a.MODDATE , \n";
			strSql += " 			a.P_NO , \n";
			strSql += " 			a.LEVELED_NAME, \n";
			strSql += " 			a.IS_LEAF_TAG, \n";
			strSql += " 			a.RN, \n";
			strSql += " 			x.LV, \n";
			strSql += " 			Decode(x.LV,1,'����',2,'����',3,'��') SUBTITLE_NAME \n";
			strSql += " 		From \n";
			strSql += " 			( \n";
			strSql += " 				Select \n";
			strSql += " 					a.CRTUSERNO , \n";
			strSql += " 					a.CRTDATE , \n";
			strSql += " 					a.MODUSERNO , \n";
			strSql += " 					a.MODDATE , \n";
			strSql += " 					a.BIZ_PLAN_ITEM_NO , \n";
			strSql += " 					a.P_NO , \n";
			strSql += " 					RPad(' ',(Level - 1) * 2,' ') || a.BIZ_PLAN_ITEM_NAME LEVELED_NAME, \n";
			strSql += " 					a.IS_LEAF_TAG, \n";
			strSql += " 					RowNum RN \n";
			strSql += " 				From	T_PL_ITEM a \n";
			strSql += " 				Where	a.DEPT_TAG = 'T'  \n";
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
			strSql += " 			b.COMP_CODE , \n";
			strSql += " 			b.CLSE_ACC_ID , \n";
			strSql += " 			b.DEPT_CODE , \n";
			strSql += " 			SubStrb(b.WORK_YM,-2) YM, \n";
			strSql += " 			b.WORK_YM , \n";
			strSql += " 			b.BIZ_PLAN_ITEM_NO , \n";
			strSql += " 			b.SUM_PLAN_AMT , \n";
			strSql += " 			b.MOD_PLAN_AMT , \n";
			strSql += " 			b.PLAN_AMT \n";
			strSql += " 		From	T_PL_PLAN_DEPT X, \n";
			strSql += " 				T_PL_COMP_DEPT_PLAN_EXEC b \n";
			strSql += " 		Where	X.COMP_CODE =  ?  \n";
			strSql += " 		And		X.CLSE_ACC_ID =  ?  \n";
			strSql += " 		And		X.COMP_CODE = b.COMP_CODE (+) \n";
			strSql += " 		And		X.CLSE_ACC_ID = b.CLSE_ACC_ID (+) \n";
			strSql += " 		And		X.DEPT_CODE = b.DEPT_CODE (+) \n";
			strSql += " 		And		b.CHG_SEQ (+) = 0 \n";
			strSql += " 	) b \n";
			strSql += " Where	a.COMP_CODE = b.COMP_CODE (+) \n";
			strSql += " And		a.CLSE_ACC_ID = b.CLSE_ACC_ID (+) \n";
			strSql += " And		a.DEPT_CODE = b.DEPT_CODE (+) \n";
			strSql += " And		a.BIZ_PLAN_ITEM_NO = b.BIZ_PLAN_ITEM_NO (+) \n";
			strSql += " And		a.DEPT_NAME Like '%' || ?  || '%' \n";
			strSql += " Group By \n";
			strSql += " 	a.COMP_CODE, \n";
			strSql += " 	a.DEPT_CODE, \n";
			strSql += " 	a.DEPT_NAME, \n";
			strSql += " 	a.CLSE_ACC_ID, \n";
			strSql += " 	a.DEPT_CODE, \n";
			strSql += " 	a.BIZ_PLAN_ITEM_NO , \n";
			strSql += " 	a.CRTUSERNO , \n";
			strSql += " 	a.CRTDATE , \n";
			strSql += " 	a.MODUSERNO , \n";
			strSql += " 	a.MODDATE , \n";
			strSql += " 	a.P_NO , \n";
			strSql += " 	a.LEVELED_NAME, \n";
			strSql += " 	a.IS_LEAF_TAG, \n";
			strSql += " 	a.RN, \n";
			strSql += " 	a.LV, \n";
			strSql += " 	a.SUBTITLE_NAME \n";
			strSql += " Order By \n";
			strSql += " 	a.DEPT_CODE, \n";
			strSql += " 	a.RN, \n";
			strSql += " 	a.LV \n";
			strSql += "  ";
			
			lrArgData.addColumn("1COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("2CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("3COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("4CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("5DEPT_NAME", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("2CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("3COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("4CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("5DEPT_NAME", strDEPT_NAME);
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
				GauceInfo.response.writeException("USER", "900001","MAIN Select ����-> "+ ex.getMessage());
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
				GauceInfo.response.writeException("USER", "900001","COPY Select ����-> "+ ex.getMessage());
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
				GauceInfo.response.writeException("USER", "900001","COPY Select ����-> "+ ex.getMessage());
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
				GauceInfo.response.writeException("USER", "900001","CLOSE Select ����-> "+ ex.getMessage());
			}
		}
	}
	catch (Exception ex)
	{
		if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
		GauceInfo.response.writeException("SYS", "100001", "������ �ʱ�ȭ ���� -> " + ex.getMessage());
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
			GauceInfo.response.writeException("SYS", "100002", "������ ���� ���� -> " + ex.getMessage());
		}
	}
%>