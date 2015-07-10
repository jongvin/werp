<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : t_WPLMADeptR(현장별관리손익조회)
/* 2. 유형(시나리오) : 
/* 3. 기  능  정  의 : 프로그램 설명 
/* 4. 변  경  이  력 : 김흥수 작성(2006-04-25)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
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
			String strWORK_YM = CITCommon.toKOR(request.getParameter("WORK_YM"));
			String strDEPT_NAME = CITCommon.toKOR(request.getParameter("DEPT_NAME"));
			
			strSql  = " Select \n";
			strSql += " 	a.DEPT_CODE, \n";
			strSql += " 	b.DEPT_NAME \n";
			strSql += " From \n";
			strSql += " 	( \n";
			strSql += " 		Select \n";
			strSql += " 			distinct \n";
			strSql += " 			a.DEPT_CODE \n";
			strSql += " 		From	T_PL_MA_DEPT_LIST a \n";
			strSql += " 		Where	a.WORK_YM Like  ? ||'%' \n";
			strSql += " 	) a, \n";
			strSql += " 	T_DEPT_CODE b \n";
			strSql += " Where	a.DEPT_CODE = b.DEPT_CODE \n";
			strSql += " and		a.DEPT_CODE || b.DEPT_NAME Like '%' || Replace( ? ,' ','%') || '%' \n";
			strSql += " Order By \n";
			strSql += " 	a.DEPT_CODE ";
			
			lrArgData.addColumn("1WORK_YM", CITData.VARCHAR2);
			lrArgData.addColumn("2DEPT_NAME", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1WORK_YM", strWORK_YM);
			lrArgData.setValue("2DEPT_NAME", strDEPT_NAME);
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
			String strDEPT_CODE = CITCommon.toKOR(request.getParameter("DEPT_CODE"));
			String strWORK_YM = CITCommon.toKOR(request.getParameter("WORK_YM"));
			
			strSql  = " Select \n";
			strSql += " 	a.DEPT_CODE, \n";
			strSql += " 	a.ITEM_NO , \n";
			strSql += " 	a.P_NO , \n";
			strSql += " 	a.LEVELED_NAME, \n";
			strSql += " 	a.IS_LEAF_TAG, \n";
			strSql += " 	a.RN, \n";
			strSql += " 	Max(Decode(b.YM,'01',b.AMT)) AMT_01, \n";
			strSql += " 	Max(Decode(b.YM,'02',b.AMT)) AMT_02, \n";
			strSql += " 	Max(Decode(b.YM,'03',b.AMT)) AMT_03, \n";
			strSql += " 	Max(Decode(b.YM,'04',b.AMT)) AMT_04, \n";
			strSql += " 	Max(Decode(b.YM,'05',b.AMT)) AMT_05, \n";
			strSql += " 	Max(Decode(b.YM,'06',b.AMT)) AMT_06, \n";
			strSql += " 	Max(Decode(b.YM,'07',b.AMT)) AMT_07, \n";
			strSql += " 	Max(Decode(b.YM,'08',b.AMT)) AMT_08, \n";
			strSql += " 	Max(Decode(b.YM,'09',b.AMT)) AMT_09, \n";
			strSql += " 	Max(Decode(b.YM,'10',b.AMT)) AMT_10, \n";
			strSql += " 	Max(Decode(b.YM,'11',b.AMT)) AMT_11, \n";
			strSql += " 	Max(Decode(b.YM,'12',b.AMT)) AMT_12 \n";
			strSql += " From \n";
			strSql += " 	( \n";
			strSql += " 		Select \n";
			strSql += " 			 ?   DEPT_CODE, \n";
			strSql += " 			a.ITEM_NO , \n";
			strSql += " 			a.P_NO , \n";
			strSql += " 			RPad(' ',(Level - 1) * 2,' ') || a.BIZ_PLAN_ITEM_NAME LEVELED_NAME, \n";
			strSql += " 			a.IS_LEAF_TAG, \n";
			strSql += " 			RowNum RN \n";
			strSql += " 		From	T_PL_MA_ITEM a \n";
			strSql += " 		Start with a.P_NO = 0 \n";
			strSql += " 		Connect by \n";
			strSql += " 			Prior	a.ITEM_NO = a.P_NO \n";
			strSql += " 		Order Siblings By \n";
			strSql += " 			a.ITEM_LEVEL_SEQ \n";
			strSql += " 	) a, \n";
			strSql += " 	( \n";
			strSql += " 		Select \n";
			strSql += " 			b.DEPT_CODE , \n";
			strSql += " 			b.WORK_YM , \n";
			strSql += " 			SubStrb(b.WORK_YM,-2) YM, \n";
			strSql += " 			b.ITEM_NO , \n";
			strSql += " 			b.CRTUSERNO , \n";
			strSql += " 			b.CRTDATE , \n";
			strSql += " 			b.MODUSERNO , \n";
			strSql += " 			b.MODDATE , \n";
			strSql += " 			b.AMT \n";
			strSql += " 		From	T_PL_MA_DEPT_LIST b \n";
			strSql += " 		Where	b.DEPT_CODE =  ?  \n";
			strSql += " 		And		b.WORK_YM Like  ?  || '%' \n";
			strSql += " 	) b \n";
			strSql += " Where	a.DEPT_CODE = b.DEPT_CODE (+) \n";
			strSql += " And		a.ITEM_NO = b.ITEM_NO (+) \n";
			strSql += " Group By \n";
			strSql += " 	a.DEPT_CODE, \n";
			strSql += " 	a.ITEM_NO , \n";
			strSql += " 	a.P_NO , \n";
			strSql += " 	a.LEVELED_NAME, \n";
			strSql += " 	a.IS_LEAF_TAG, \n";
			strSql += " 	a.RN \n";
			strSql += " Order By \n";
			strSql += " 	a.RN \n";
			strSql += "  ";
			
			lrArgData.addColumn("1DEPT_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("2DEPT_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("3WORK_YM", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1DEPT_CODE", strDEPT_CODE);
			lrArgData.setValue("2DEPT_CODE", strDEPT_CODE);
			lrArgData.setValue("3WORK_YM", strWORK_YM);
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