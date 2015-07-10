<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : t_PLovFilterR_q.jsp(공통팝업의 필터등록)
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 강덕율 작성(2005-11-17)
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
		
		if (strAct.equals("FILTERS"))
		{
			String strLOV_NO = CITCommon.toKOR(request.getParameter("LOV_NO"));
			
			strSql  = " Select * \n";
			strSql += " From   T_LOV_FILTERS \n";
			strSql += " Where  LOV_NO =  ? \n";
			strSql += " Order by DIS_SEQ \n";
			
			lrArgData.addColumn("LOV_NO", CITData.NUMBER);
			lrArgData.addRow();
			lrArgData.setValue("LOV_NO", strLOV_NO);
			
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("LOV_NO", true);
				lrReturnData.setKey("FILTER_SEQ", true);
				
				lrReturnData.setNotNull("DIS_SEQ", true);
				lrReturnData.setNotNull("FILTER_NAME", true);
				
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001","T_LOV_FILTERS Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("FILTER_ARGS"))
		{
			String strLOV_NO = CITCommon.toKOR(request.getParameter("LOV_NO"));
			String strFILTER_SEQ = CITCommon.toKOR(request.getParameter("FILTER_SEQ"));
			
			strSql  = " Select * \n";
			strSql += " From   T_LOV_FILTER_ARGS \n";
			strSql += " Where  LOV_NO =  ? \n";
			strSql += "  And   FILTER_SEQ =  ? \n";
			strSql += " Order by DIS_SEQ \n";
			
			lrArgData.addColumn("LOV_NO", CITData.NUMBER);
			lrArgData.addColumn("FILTER_SEQ", CITData.NUMBER);
			lrArgData.addRow();
			lrArgData.setValue("LOV_NO", strLOV_NO);
			lrArgData.setValue("FILTER_SEQ", strFILTER_SEQ);
			
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("LOV_NO", true);
				lrReturnData.setKey("FILTER_SEQ", true);
				lrReturnData.setKey("FILTER_ARG_SEQ", true);
				
				lrReturnData.setNotNull("DIS_SEQ", true);
				
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001","T_LOV_FILTER_ARGS Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("FILTER_SEQ"))
		{
			strSql  = " Select SQ_T_LOV_FILTERS.nextval as FILTER_SEQ \n";
			strSql += " From   DUAL ";
			
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
				GauceInfo.response.writeException("USER", "900001", "SQ_T_LOV_FILTERS Sequence Select 오류 -> " + ex.getMessage());
			}
		}
		else if (strAct.equals("FILTER_ARG_SEQ"))
		{
			strSql  = " Select SQ_T_LOV_FILTER_ARGS.nextval as FILTER_ARG_SEQ \n";
			strSql += " From   DUAL ";
				
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
				GauceInfo.response.writeException("USER", "900001", "SQ_T_LOV_FILTER_ARGS Sequence Select 오류 -> " + ex.getMessage());
			}
		}
		else if (strAct.equals("ARGS_LIST"))
		{
			String strLOV_NO = CITCommon.toKOR(request.getParameter("LOV_NO"));
			
			strSql  = " Select 0 as DIS_SEQ, \n";
			strSql += "        '' as CODE, \n";
			strSql += "        '' as NAME \n";
			strSql += " From   Dual \n";
			strSql += " Union \n";
			strSql += " Select DIS_SEQ as DIS_SEQ, \n";
			strSql += "        NAME as NAME, \n";
			strSql += "        NAME as NAME \n";
			strSql += " From   T_LOV_ARGS \n";
			strSql += " Where  LOV_NO = ? \n";
			strSql += " Order by 1 \n";
			
			lrArgData.addColumn("LOV_NO", CITData.NUMBER);
			lrArgData.addRow();
			lrArgData.setValue("LOV_NO", strLOV_NO);
			
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
				GauceInfo.response.writeException("USER", "900001","T_LOV_ARGS Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("SQL"))
		{
			String strLOV_NO = CITCommon.toKOR(request.getParameter("LOV_NO"));
			String strFILTER_SEQ = CITCommon.toKOR(request.getParameter("FILTER_SEQ"));
			
			CITData lrFilter = null;
			CITData lrFilterArgs = null;
			CITData lrTemp = null;
			
			lrArgData.addColumn("LOV_NO", CITData.NUMBER);
			lrArgData.addColumn("FILTER_SEQ", CITData.NUMBER);
			lrArgData.addRow();
			lrArgData.setValue("LOV_NO", strLOV_NO);
			lrArgData.setValue("FILTER_SEQ", strFILTER_SEQ);
			
			// 필터 Select
			strSql  = " Select * \n";
			strSql += " From   T_LOV_FILTERS \n";
			strSql += " Where  LOV_NO = ? \n";
			strSql += "  And   FILTER_SEQ = ? \n";
			
			lrFilter = CITDatabase.selectQuery(strSql, lrArgData);
			
			// 필터인자 Select
			strSql  = " Select * \n";
			strSql += " From   T_LOV_FILTER_ARGS \n";
			strSql += " Where  LOV_NO = ? \n";
			strSql += "  And   FILTER_SEQ = ? \n";
			strSql += " Order by DIS_SEQ \n";
			
			lrFilterArgs = CITDatabase.selectQuery(strSql, lrArgData);
			
			// SQL 인자 설정
			lrArgData.removeAll();
			
			if (lrFilterArgs.getRowsCount() > 0)
			{
				for (int i = 0; i < lrFilterArgs.getRowsCount(); i++)
				{
					lrArgData.addColumn(lrFilterArgs.toString(i, "FILTER_ARG_SEQ"), CITData.VARCHAR2);
				}
				
				lrArgData.addRow();
				
				for (int i = 0; i < lrFilterArgs.getRowsCount(); i++)
				{
					lrArgData.setValue(lrFilterArgs.toString(i, "FILTER_ARG_SEQ"), lrFilterArgs.toString(i, "DEFAULT_VALUE"));
				}
			}
			
			CITData lrResult = new CITData();
			
			lrResult.addColumn("RESULT", CITData.VARCHAR2);
			lrResult.addColumn("MESSAGE", CITData.VARCHAR2);
			lrResult.addRow();
			
			try
			{
				// SQL 실행
				lrTemp = CITDatabase.selectQuery(lrFilter.toString(0, "SQL"), lrArgData);
				
				lrResult.setValue("RESULT", "OK");
				lrResult.setValue("MESSAGE", "No Error");
			}
			catch (Exception ex)
			{
				lrResult.setValue("RESULT", "ERROR");
				lrResult.setValue("MESSAGE", ex.getMessage());
			}
			
			lrDataset = CITCommon.toGauceDataSet(lrResult);
			GauceInfo.response.enableFirstRow(lrDataset);
			lrDataset.flush();
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