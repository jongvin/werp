<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : t_PLovFilterR_tr.jsp(공통팝업의 필터등록)
/* 2. 유형(시나리오) : Update Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 강덕율 작성(2005-11-17)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
	CITGauceInfo GauceInfo = null;
	
	GauceDataSet dsFilters = null;
	GauceDataSet dsFilterArgs = null;
	
	GauceDataRow[] rowsFilters = null;
	GauceDataRow[] rowsFilterArgs = null;
	
	Connection conn = null;
	
	String strSql = "";
	String strAct = "";
	String strUserNo = "";
	
	try
	{
		GauceInfo = CITCommon.initServerPage(request, response, session);
		
		conn = CITConnectionManager.getConnection(false);
		
		/* 세션정보 */
		strUserNo = CITCommon.toKOR((String)session.getAttribute("emp_no"));
		
		strAct = GauceInfo.request.getParameter("ACT");
		
		if (CITCommon.isNull(strAct))
		{
			dsFilters = GauceInfo.request.getGauceDataSet("dsFilters");
			
			if (dsFilters == null) throw new Exception("dsFilters이(가) 널(Null)입니다.");
			
			rowsFilters = dsFilters.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	rowsFilters.length; i++)
				{
					CITData lrArgData = new CITData();
					
					if (rowsFilters[i].getJobType() == GauceDataRow.TB_JOB_INSERT)
					{
						strSql = "{call SP_T_LOV_FILTERS_I(?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("LOV_NO", CITData.NUMBER);
						lrArgData.addColumn("FILTER_SEQ", CITData.NUMBER);
						lrArgData.addColumn("DIS_SEQ", CITData.NUMBER);
						lrArgData.addColumn("FILTER_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("TYPE", CITData.VARCHAR2);
						lrArgData.addColumn("DATE_TYPE", CITData.VARCHAR2);
						lrArgData.addColumn("DEFAULT_ARG_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("RETURN_ARG_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("LABEL_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("LABEL_WIDTH", CITData.NUMBER);
						lrArgData.addColumn("WIDTH", CITData.NUMBER);
						lrArgData.addColumn("SQL", CITData.VARCHAR2);
						lrArgData.addColumn("TEXT_COL", CITData.VARCHAR2);
						lrArgData.addColumn("VALUE_COL", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("LOV_NO", rowsFilters[i].getString(dsFilters.indexOfColumn("LOV_NO")));
						lrArgData.setValue("FILTER_SEQ", rowsFilters[i].getString(dsFilters.indexOfColumn("FILTER_SEQ")));
						lrArgData.setValue("DIS_SEQ", rowsFilters[i].getString(dsFilters.indexOfColumn("DIS_SEQ")));
						lrArgData.setValue("FILTER_NAME", rowsFilters[i].getString(dsFilters.indexOfColumn("FILTER_NAME")));
						lrArgData.setValue("TYPE", rowsFilters[i].getString(dsFilters.indexOfColumn("TYPE")));
						lrArgData.setValue("DATE_TYPE", rowsFilters[i].getString(dsFilters.indexOfColumn("DATE_TYPE")));
						lrArgData.setValue("DEFAULT_ARG_NAME", rowsFilters[i].getString(dsFilters.indexOfColumn("DEFAULT_ARG_NAME")));
						lrArgData.setValue("RETURN_ARG_NAME", rowsFilters[i].getString(dsFilters.indexOfColumn("RETURN_ARG_NAME")));
						lrArgData.setValue("LABEL_NAME", rowsFilters[i].getString(dsFilters.indexOfColumn("LABEL_NAME")));
						lrArgData.setValue("LABEL_WIDTH", rowsFilters[i].getString(dsFilters.indexOfColumn("LABEL_WIDTH")));
						lrArgData.setValue("WIDTH", rowsFilters[i].getString(dsFilters.indexOfColumn("WIDTH")));
						lrArgData.setValue("SQL", rowsFilters[i].getString(dsFilters.indexOfColumn("SQL")));
						lrArgData.setValue("TEXT_COL", rowsFilters[i].getString(dsFilters.indexOfColumn("TEXT_COL")));
						lrArgData.setValue("VALUE_COL", rowsFilters[i].getString(dsFilters.indexOfColumn("VALUE_COL")));
					}
					else if (rowsFilters[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_LOV_FILTERS_U(?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("LOV_NO", CITData.NUMBER);
						lrArgData.addColumn("FILTER_SEQ", CITData.NUMBER);
						lrArgData.addColumn("DIS_SEQ", CITData.NUMBER);
						lrArgData.addColumn("FILTER_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("TYPE", CITData.VARCHAR2);
						lrArgData.addColumn("DATE_TYPE", CITData.VARCHAR2);
						lrArgData.addColumn("DEFAULT_ARG_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("RETURN_ARG_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("LABEL_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("LABEL_WIDTH", CITData.NUMBER);
						lrArgData.addColumn("WIDTH", CITData.NUMBER);
						lrArgData.addColumn("SQL", CITData.VARCHAR2);
						lrArgData.addColumn("TEXT_COL", CITData.VARCHAR2);
						lrArgData.addColumn("VALUE_COL", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("LOV_NO", rowsFilters[i].getString(dsFilters.indexOfColumn("LOV_NO")));
						lrArgData.setValue("FILTER_SEQ", rowsFilters[i].getString(dsFilters.indexOfColumn("FILTER_SEQ")));
						lrArgData.setValue("DIS_SEQ", rowsFilters[i].getString(dsFilters.indexOfColumn("DIS_SEQ")));
						lrArgData.setValue("FILTER_NAME", rowsFilters[i].getString(dsFilters.indexOfColumn("FILTER_NAME")));
						lrArgData.setValue("TYPE", rowsFilters[i].getString(dsFilters.indexOfColumn("TYPE")));
						lrArgData.setValue("DATE_TYPE", rowsFilters[i].getString(dsFilters.indexOfColumn("DATE_TYPE")));
						lrArgData.setValue("DEFAULT_ARG_NAME", rowsFilters[i].getString(dsFilters.indexOfColumn("DEFAULT_ARG_NAME")));
						lrArgData.setValue("RETURN_ARG_NAME", rowsFilters[i].getString(dsFilters.indexOfColumn("RETURN_ARG_NAME")));
						lrArgData.setValue("LABEL_NAME", rowsFilters[i].getString(dsFilters.indexOfColumn("LABEL_NAME")));
						lrArgData.setValue("LABEL_WIDTH", rowsFilters[i].getString(dsFilters.indexOfColumn("LABEL_WIDTH")));
						lrArgData.setValue("WIDTH", rowsFilters[i].getString(dsFilters.indexOfColumn("WIDTH")));
						lrArgData.setValue("SQL", rowsFilters[i].getString(dsFilters.indexOfColumn("SQL")));
						lrArgData.setValue("TEXT_COL", rowsFilters[i].getString(dsFilters.indexOfColumn("TEXT_COL")));
						lrArgData.setValue("VALUE_COL", rowsFilters[i].getString(dsFilters.indexOfColumn("VALUE_COL")));
					}
					else if (rowsFilters[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_LOV_FILTERS_D(?,?)}";
						
						lrArgData.addColumn("LOV_NO", CITData.NUMBER);
						lrArgData.addColumn("FILTER_SEQ", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("LOV_NO", rowsFilters[i].getString(dsFilters.indexOfColumn("LOV_NO")));
						lrArgData.setValue("FILTER_SEQ", rowsFilters[i].getString(dsFilters.indexOfColumn("FILTER_SEQ")));
					}
					else
					{
						continue;
					}
					
					CITDatabase.executeProcedure(strSql, lrArgData, conn);
				}
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001", "T_LOV_FILTERS 테이블 데이타 갱신 에러" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
			
			dsFilterArgs = GauceInfo.request.getGauceDataSet("dsFilterArgs");
			
			if (dsFilterArgs == null) throw new Exception("dsFilterArgs이(가) 널(Null)입니다.");
			
			rowsFilterArgs = dsFilterArgs.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	rowsFilterArgs.length; i++)
				{
					CITData lrArgData = new CITData();
					
					if (rowsFilterArgs[i].getJobType() == GauceDataRow.TB_JOB_INSERT)
					{
						strSql = "{call SP_T_LOV_FILTER_ARGS_I(?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("LOV_NO", CITData.NUMBER);
						lrArgData.addColumn("FILTER_SEQ", CITData.NUMBER);
						lrArgData.addColumn("FILTER_ARG_SEQ", CITData.NUMBER);
						lrArgData.addColumn("DIS_SEQ", CITData.NUMBER);
						lrArgData.addColumn("TYPE", CITData.VARCHAR2);
						lrArgData.addColumn("FILTER_ARG_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("DEFAULT_VALUE", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("LOV_NO", rowsFilterArgs[i].getString(dsFilterArgs.indexOfColumn("LOV_NO")));
						lrArgData.setValue("FILTER_SEQ", rowsFilterArgs[i].getString(dsFilterArgs.indexOfColumn("FILTER_SEQ")));
						lrArgData.setValue("FILTER_ARG_SEQ", rowsFilterArgs[i].getString(dsFilterArgs.indexOfColumn("FILTER_ARG_SEQ")));
						lrArgData.setValue("DIS_SEQ", rowsFilterArgs[i].getString(dsFilterArgs.indexOfColumn("DIS_SEQ")));
						lrArgData.setValue("TYPE", rowsFilterArgs[i].getString(dsFilterArgs.indexOfColumn("TYPE")));
						lrArgData.setValue("FILTER_ARG_NAME", rowsFilterArgs[i].getString(dsFilterArgs.indexOfColumn("FILTER_ARG_NAME")));
						lrArgData.setValue("DEFAULT_VALUE", rowsFilterArgs[i].getString(dsFilterArgs.indexOfColumn("DEFAULT_VALUE")));
					}
					else if (rowsFilterArgs[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_LOV_FILTER_ARGS_U(?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("LOV_NO", CITData.NUMBER);
						lrArgData.addColumn("FILTER_SEQ", CITData.NUMBER);
						lrArgData.addColumn("FILTER_ARG_SEQ", CITData.NUMBER);
						lrArgData.addColumn("DIS_SEQ", CITData.NUMBER);
						lrArgData.addColumn("TYPE", CITData.VARCHAR2);
						lrArgData.addColumn("FILTER_ARG_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("DEFAULT_VALUE", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("LOV_NO", rowsFilterArgs[i].getString(dsFilterArgs.indexOfColumn("LOV_NO")));
						lrArgData.setValue("FILTER_SEQ", rowsFilterArgs[i].getString(dsFilterArgs.indexOfColumn("FILTER_SEQ")));
						lrArgData.setValue("FILTER_ARG_SEQ", rowsFilterArgs[i].getString(dsFilterArgs.indexOfColumn("FILTER_ARG_SEQ")));
						lrArgData.setValue("DIS_SEQ", rowsFilterArgs[i].getString(dsFilterArgs.indexOfColumn("DIS_SEQ")));
						lrArgData.setValue("TYPE", rowsFilterArgs[i].getString(dsFilterArgs.indexOfColumn("TYPE")));
						lrArgData.setValue("FILTER_ARG_NAME", rowsFilterArgs[i].getString(dsFilterArgs.indexOfColumn("FILTER_ARG_NAME")));
						lrArgData.setValue("DEFAULT_VALUE", rowsFilterArgs[i].getString(dsFilterArgs.indexOfColumn("DEFAULT_VALUE")));
					}
					else if (rowsFilterArgs[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_LOV_FILTER_ARGS_D(?,?,?)}";
						
						lrArgData.addColumn("LOV_NO", CITData.NUMBER);
						lrArgData.addColumn("FILTER_SEQ", CITData.NUMBER);
						lrArgData.addColumn("FILTER_ARG_SEQ", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("LOV_NO", rowsFilterArgs[i].getString(dsFilterArgs.indexOfColumn("LOV_NO")));
						lrArgData.setValue("FILTER_SEQ", rowsFilterArgs[i].getString(dsFilterArgs.indexOfColumn("FILTER_SEQ")));
						lrArgData.setValue("FILTER_ARG_SEQ", rowsFilterArgs[i].getString(dsFilterArgs.indexOfColumn("FILTER_ARG_SEQ")));
					}
					else
					{
						continue;
					}
					
					CITDatabase.executeProcedure(strSql, lrArgData, conn);
				}
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001", "T_LOV_FILTER_ARGS 테이블 데이타 갱신 에러" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
		}
		conn.commit();
	}
	catch (Exception ex)
	{
		if (conn != null) conn.rollback();
		if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
		GauceInfo.response.writeException("SYS", "100001", "페이지 초기화 오류 -> " + ex.getMessage());
	}
	finally
	{
		try
		{
			CITConnectionManager.freeConnection(conn);
			CITCommon.finalServerPage(GauceInfo);
		}
	    catch (Exception ex)
	    {
			if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
	    	GauceInfo.response.writeException("SYS", "100002", "페이지 종료 오류 -> " + ex.getMessage());
	    }
	}
%>
