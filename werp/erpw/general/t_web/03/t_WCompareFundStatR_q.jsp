<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : t_WCompareProfitR.jsp(비교손익분석표)
/* 2. 유형(시나리오) : shared window 조회 및 입력
/* 3. 기  능  정  의 : 원가대체전표생성
/* 4. 변  경  이  력 : 김흥수 작성(2006-05-22)
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
			String strWORK_YM_N_T = CITCommon.toKOR(request.getParameter("WORK_YM_N_T"));
			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String strSHEET_CODE = CITCommon.toKOR(request.getParameter("SHEET_CODE"));
			
			strSql  = " Select \n";
			strSql += " 	b.SHEET_CODE, \n";
			strSql += " 	b.ITEM_CODE, \n";
			strSql += " 	SubStrb(RPad(' ',b.ITEM_LVL*2 -2 ) || b.ITEM_NAME,1,300) ITEM_NAME, \n";
			strSql += " 	a.P_Y_AMT, \n";
			strSql += " 	a.P_M_AMT, \n";
			strSql += " 	a.N_M_AMT \n";
			strSql += " From	T_SHEET_EXPR_HEAD b, \n";
			strSql += " 		( \n";
			strSql += " 			Select \n";
			strSql += " 				a.SHEET_CODE, \n";
			strSql += " 				a.ITEM_CODE, \n";
			strSql += " 				Sum( \n";
			strSql += " 						Case When a.WORK_YM Between To_Char(To_Number(SubStrb( ? ,1,4)) - 1) || '00' And To_Char(To_Number(SubStrb( ? ,1,4)) - 1) || '12' Then \n";
			strSql += " 							Nvl(a.CURR_LEFT,0) + Nvl(a.CURR_RIGHT,0) \n";
			strSql += " 						Else \n";
			strSql += " 							0 \n";
			strSql += " 						End \n";
			strSql += " 				) P_Y_AMT, \n";
			strSql += " 				Sum( \n";
			strSql += " 						Case When a.WORK_YM Between SubStrb( ? ,1,4) || '00' And F_T_AddMonths( ? ,-1) Then \n";
			strSql += " 							Nvl(a.CURR_LEFT,0) + Nvl(a.CURR_RIGHT,0) \n";
			strSql += " 						Else \n";
			strSql += " 							0 \n";
			strSql += " 						End \n";
			strSql += " 				) P_M_AMT, \n";
			strSql += " 				Sum( \n";
			strSql += " 						Case When a.WORK_YM Between SubStrb( ? ,1,4) || '00' And  ?  Then \n";
			strSql += " 							Nvl(a.CURR_LEFT,0) + Nvl(a.CURR_RIGHT,0) \n";
			strSql += " 						Else \n";
			strSql += " 							0 \n";
			strSql += " 						End \n";
			strSql += " 				) N_M_AMT \n";
			strSql += " 			From	T_SHEET_MONTH_SUM_BODY a \n";
			strSql += " 			Where	a.COMP_CODE Like  ?  \n";
			strSql += " 			And		a.SHEET_CODE =  ?  \n";
			strSql += " 			And		a.WORK_YM Between To_Char(To_Number(SubStrb( ? ,1,4)) - 1) || '00' And  ?  \n";
			strSql += " 			Group By \n";
			strSql += " 				a.SHEET_CODE, \n";
			strSql += " 				a.ITEM_CODE \n";
			strSql += " 		) a \n";
			strSql += " Where	a.SHEET_CODE (+) = b.SHEET_CODE \n";
			strSql += " And		a.ITEM_CODE (+) = b.ITEM_CODE \n";
			strSql += " And		b.SHEET_CODE =  ?  \n";
			strSql += " And		(b.ITEM_LVL In ( 1,2) Or  \n";
			strSql += " 	Abs(a.P_Y_AMT) + \n";
			strSql += " 	Abs(a.P_M_AMT) + \n";
			strSql += " 	Abs(a.N_M_AMT) <> 0) \n";
			strSql += " Order By \n";
			strSql += " 	b.SHEET_CODE, \n";
			strSql += " 	b.ITEM_CODE \n";
			strSql += "  ";
			
			lrArgData.addColumn("1WORK_YM_N_T", CITData.VARCHAR2);
			lrArgData.addColumn("2WORK_YM_N_T", CITData.VARCHAR2);
			lrArgData.addColumn("3WORK_YM_N_T", CITData.VARCHAR2);
			lrArgData.addColumn("4WORK_YM_N_T", CITData.VARCHAR2);
			lrArgData.addColumn("5WORK_YM_N_T", CITData.VARCHAR2);
			lrArgData.addColumn("6WORK_YM_N_T", CITData.VARCHAR2);
			lrArgData.addColumn("7COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("8SHEET_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("9WORK_YM_N_T", CITData.VARCHAR2);
			lrArgData.addColumn("10WORK_YM_N_T", CITData.VARCHAR2);
			lrArgData.addColumn("11SHEET_CODE", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1WORK_YM_N_T", strWORK_YM_N_T);
			lrArgData.setValue("2WORK_YM_N_T", strWORK_YM_N_T);
			lrArgData.setValue("3WORK_YM_N_T", strWORK_YM_N_T);
			lrArgData.setValue("4WORK_YM_N_T", strWORK_YM_N_T);
			lrArgData.setValue("5WORK_YM_N_T", strWORK_YM_N_T);
			lrArgData.setValue("6WORK_YM_N_T", strWORK_YM_N_T);
			lrArgData.setValue("7COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("8SHEET_CODE", strSHEET_CODE);
			lrArgData.setValue("9WORK_YM_N_T", strWORK_YM_N_T);
			lrArgData.setValue("10WORK_YM_N_T", strWORK_YM_N_T);
			lrArgData.setValue("11SHEET_CODE", strSHEET_CODE);
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
		else if (strAct.equals("SHEET_CODE"))
		{

			
			strSql  = " Select \n";
			strSql += " 	a.SHEET_CODE , \n";
			strSql += " 	a.SHEET_TYPE , \n";
			strSql += " 	a.SHEET_NAME \n";
			strSql += " From	T_SHEET_CODE a \n";
			strSql += " Where  MONTH_SUM_TAG = 'T' \n";
			strSql += " And		SHEET_TYPE = '1' \n";
			strSql += " Order By \n";
			strSql += " 	a.SHEET_CODE \n";
			strSql += "  ";
			

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
				GauceInfo.response.writeException("USER", "900001","SHEET_CODE Select 오류-> "+ ex.getMessage());
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
