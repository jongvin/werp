<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : t_WLovR_tr(공통팝업 등록의 Update Query 페이지)
/* 2. 유형(시나리오) : Update Query
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 강덕율 작성(2005-10-31)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 :
/**************************************************************************/
 
	CITGauceInfo GauceInfo = null;
	
	GauceDataSet dsLov = null;
	GauceDataSet dsLovArgs = null;
	GauceDataSet dsLovCols = null;
	GauceDataSet dsCOPY_LOV = null;
	
	GauceDataRow[] rowsLov = null;
	GauceDataRow[] rowsLovArgs = null;
	GauceDataRow[] rowsLovCols = null;
	GauceDataRow[] rowsCopyLov = null;
	
	Connection conn = null;
	
	String strSql = "";
	
	try
	{
		GauceInfo = CITCommon.initServerPage(request, response, session);
		
		conn = CITConnectionManager.getConnection(false);
		
		dsCOPY_LOV = GauceInfo.request.getGauceDataSet("dsCOPY_LOV");
		if(dsCOPY_LOV != null)
		{
			rowsCopyLov = dsCOPY_LOV.getDataRows();
			try
			{
				for	(int i = 0;	i <	rowsCopyLov.length; i++)
				{
					CITData lrArgData = new CITData();
					
					strSql = "{call SP_T_LOV_COPY(?,?)}";
					
					lrArgData.addColumn("LOV_NO_F", CITData.NUMBER);
					lrArgData.addColumn("LOV_NO_T", CITData.NUMBER);
					lrArgData.addRow();
					lrArgData.setValue("LOV_NO_F",  rowsCopyLov[i].getString(dsCOPY_LOV.indexOfColumn("F")));
					lrArgData.setValue("LOV_NO_T",  rowsCopyLov[i].getString(dsCOPY_LOV.indexOfColumn("T")));
					
					CITDatabase.executeProcedure(strSql, lrArgData, conn);
				}
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001", "T_LOV 테이블 데이타 갱신 오류" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
		}
		else
		{
			dsLov = GauceInfo.request.getGauceDataSet("dsLov");
			dsLovArgs = GauceInfo.request.getGauceDataSet("dsLovArgs");
			dsLovCols = GauceInfo.request.getGauceDataSet("dsLovCols");
			
			if (dsLov == null) throw new Exception("dsLov이(가) 널(Null)입니다.");
			if (dsLovArgs == null) throw new Exception("dsLovArgs이(가) 널(Null)입니다.");
			if (dsLovCols == null) throw new Exception("dsLovCols이(가) 널(Null)입니다.");
	
			rowsLov = dsLov.getDataRows();
			rowsLovArgs = dsLovArgs.getDataRows();
			rowsLovCols = dsLovCols.getDataRows();
			
	
			// dsLov의 Insert, Update, Delete
			try
			{
				for	(int i = 0;	i <	rowsLov.length; i++)
				{
					CITData lrArgData = new CITData();
					
					if(rowsLov[i].getJobType()== GauceDataRow.TB_JOB_INSERT)
					{
						strSql = "{call SP_T_LOV_I(?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("LOV_NO", CITData.NUMBER);
						lrArgData.addColumn("NAME", CITData.VARCHAR2);
						lrArgData.addColumn("TITLE", CITData.VARCHAR2);
						lrArgData.addColumn("WIDTH", CITData.NUMBER);
						lrArgData.addColumn("HEIGHT", CITData.NUMBER);
						lrArgData.addColumn("LOCATION_X", CITData.NUMBER);
						lrArgData.addColumn("LOCATION_Y", CITData.NUMBER);
						lrArgData.addColumn("SQL", CITData.VARCHAR2);
						lrArgData.addColumn("AUTO_LOAD", CITData.VARCHAR2);
						lrArgData.addColumn("REMARK", CITData.VARCHAR2);
						lrArgData.addRow();
						lrArgData.setValue("LOV_NO",  rowsLov[i].getString(dsLov.indexOfColumn("LOV_NO")));
						lrArgData.setValue("NAME",  rowsLov[i].getString(dsLov.indexOfColumn("NAME")));
						lrArgData.setValue("TITLE",  rowsLov[i].getString(dsLov.indexOfColumn("TITLE")));
						lrArgData.setValue("WIDTH",  rowsLov[i].getString(dsLov.indexOfColumn("WIDTH")));
						lrArgData.setValue("HEIGHT",  rowsLov[i].getString(dsLov.indexOfColumn("HEIGHT")));
						lrArgData.setValue("LOCATION_X",  rowsLov[i].getString(dsLov.indexOfColumn("LOCATION_X")));
						lrArgData.setValue("LOCATION_Y",  rowsLov[i].getString(dsLov.indexOfColumn("LOCATION_Y")));
						lrArgData.setValue("SQL",  rowsLov[i].getString(dsLov.indexOfColumn("SQL")));
						lrArgData.setValue("AUTO_LOAD",  rowsLov[i].getString(dsLov.indexOfColumn("AUTO_LOAD")));
						lrArgData.setValue("REMARK",  rowsLov[i].getString(dsLov.indexOfColumn("REMARK")));
					}
					else if(rowsLov[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_LOV_U(?,?,?,?,?,?,?,?,?,?)}";
	
						lrArgData.addColumn("LOV_NO", CITData.NUMBER);
						lrArgData.addColumn("NAME", CITData.VARCHAR2);
						lrArgData.addColumn("TITLE", CITData.VARCHAR2);
						lrArgData.addColumn("WIDTH", CITData.NUMBER);
						lrArgData.addColumn("HEIGHT", CITData.NUMBER);
						lrArgData.addColumn("LOCATION_X", CITData.NUMBER);
						lrArgData.addColumn("LOCATION_Y", CITData.NUMBER);
						lrArgData.addColumn("SQL", CITData.VARCHAR2);
						lrArgData.addColumn("AUTO_LOAD", CITData.VARCHAR2);
						lrArgData.addColumn("REMARK", CITData.VARCHAR2);
						lrArgData.addRow();
						lrArgData.setValue("LOV_NO",  rowsLov[i].getString(dsLov.indexOfColumn("LOV_NO")));
						lrArgData.setValue("NAME",  rowsLov[i].getString(dsLov.indexOfColumn("NAME")));
						lrArgData.setValue("TITLE",  rowsLov[i].getString(dsLov.indexOfColumn("TITLE")));
						lrArgData.setValue("WIDTH",  rowsLov[i].getString(dsLov.indexOfColumn("WIDTH")));
						lrArgData.setValue("HEIGHT",  rowsLov[i].getString(dsLov.indexOfColumn("HEIGHT")));
						lrArgData.setValue("LOCATION_X",  rowsLov[i].getString(dsLov.indexOfColumn("LOCATION_X")));
						lrArgData.setValue("LOCATION_Y",  rowsLov[i].getString(dsLov.indexOfColumn("LOCATION_Y")));
						lrArgData.setValue("SQL",  rowsLov[i].getString(dsLov.indexOfColumn("SQL")));
						lrArgData.setValue("AUTO_LOAD",  rowsLov[i].getString(dsLov.indexOfColumn("AUTO_LOAD")));
						lrArgData.setValue("REMARK",  rowsLov[i].getString(dsLov.indexOfColumn("REMARK")));
					}
					else if(rowsLov[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_LOV_D(?)}";
						
						lrArgData.addColumn("LOV_NO", CITData.NUMBER);
						lrArgData.addRow();
						lrArgData.setValue("LOV_NO",  rowsLov[i].getString(dsLov.indexOfColumn("LOV_NO")));
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
				GauceInfo.response.writeException("USER", "900001", "T_LOV 테이블 데이타 갱신 오류" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
			
			// dsLovArgs의 Insert, Update, Delete
			try
			{
				for	(int i = 0;	i <	rowsLovArgs.length; i++)
				{
					CITData lrArgData = new CITData();
					
					if(rowsLovArgs[i].getJobType() == GauceDataRow.TB_JOB_INSERT)
					{
						strSql = "{call SP_T_LOV_ARGS_I(?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("LOV_NO", CITData.NUMBER);
						lrArgData.addColumn("ARG_SEQ", CITData.NUMBER);
						lrArgData.addColumn("DIS_SEQ", CITData.NUMBER);
						lrArgData.addColumn("NAME", CITData.VARCHAR2);
						lrArgData.addColumn("TYPE", CITData.VARCHAR2);
						lrArgData.addColumn("DEFAULT_VALUE", CITData.VARCHAR2);
						lrArgData.addColumn("SESSION_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("SESSION_NAME", CITData.VARCHAR2);
						lrArgData.addRow();
						lrArgData.setValue("LOV_NO",  rowsLovArgs[i].getString(dsLovArgs.indexOfColumn("LOV_NO")));
						lrArgData.setValue("ARG_SEQ",  rowsLovArgs[i].getString(dsLovArgs.indexOfColumn("ARG_SEQ")));
						lrArgData.setValue("DIS_SEQ",  rowsLovArgs[i].getString(dsLovArgs.indexOfColumn("DIS_SEQ")));
						lrArgData.setValue("NAME",  rowsLovArgs[i].getString(dsLovArgs.indexOfColumn("NAME")));
						lrArgData.setValue("TYPE",  rowsLovArgs[i].getString(dsLovArgs.indexOfColumn("TYPE")));
						lrArgData.setValue("DEFAULT_VALUE",  rowsLovArgs[i].getString(dsLovArgs.indexOfColumn("DEFAULT_VALUE")));
						lrArgData.setValue("SESSION_TAG",  rowsLovArgs[i].getString(dsLovArgs.indexOfColumn("SESSION_TAG")));
						lrArgData.setValue("SESSION_NAME",  rowsLovArgs[i].getString(dsLovArgs.indexOfColumn("SESSION_NAME")));
					}
					else if(rowsLovArgs[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_LOV_ARGS_U(?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("LOV_NO", CITData.NUMBER);
						lrArgData.addColumn("ARG_SEQ", CITData.NUMBER);
						lrArgData.addColumn("DIS_SEQ", CITData.NUMBER);
						lrArgData.addColumn("NAME", CITData.VARCHAR2);
						lrArgData.addColumn("TYPE", CITData.VARCHAR2);
						lrArgData.addColumn("DEFAULT_VALUE", CITData.VARCHAR2);
						lrArgData.addColumn("SESSION_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("SESSION_NAME", CITData.VARCHAR2);
						lrArgData.addRow();
						lrArgData.setValue("LOV_NO",  rowsLovArgs[i].getString(dsLovArgs.indexOfColumn("LOV_NO")));
						lrArgData.setValue("ARG_SEQ",  rowsLovArgs[i].getString(dsLovArgs.indexOfColumn("ARG_SEQ")));
						lrArgData.setValue("DIS_SEQ",  rowsLovArgs[i].getString(dsLovArgs.indexOfColumn("DIS_SEQ")));
						lrArgData.setValue("NAME",  rowsLovArgs[i].getString(dsLovArgs.indexOfColumn("NAME")));
						lrArgData.setValue("TYPE",  rowsLovArgs[i].getString(dsLovArgs.indexOfColumn("TYPE")));
						lrArgData.setValue("DEFAULT_VALUE",  rowsLovArgs[i].getString(dsLovArgs.indexOfColumn("DEFAULT_VALUE")));
						lrArgData.setValue("SESSION_TAG",  rowsLovArgs[i].getString(dsLovArgs.indexOfColumn("SESSION_TAG")));
						lrArgData.setValue("SESSION_NAME",  rowsLovArgs[i].getString(dsLovArgs.indexOfColumn("SESSION_NAME")));
					}
					else if(rowsLovArgs[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_LOV_ARGS_D(?,?)}";
						
						lrArgData.addColumn("LOV_NO", CITData.NUMBER);
						lrArgData.addColumn("ARG_SEQ", CITData.NUMBER);
						lrArgData.addRow();
						lrArgData.setValue("LOV_NO",  rowsLovArgs[i].getString(dsLovArgs.indexOfColumn("LOV_NO")));
						lrArgData.setValue("ARG_SEQ",  rowsLovArgs[i].getString(dsLovArgs.indexOfColumn("ARG_SEQ")));
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
				GauceInfo.response.writeException("USER", "900001", "T_LOV_ARGS 테이블 데이타 갱신 오류" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
			
			// dsLovCols의 Insert, Update, Delete
			try
			{
				for	(int i = 0;	i <	rowsLovCols.length; i++)
				{
					CITData lrArgData = new CITData();
					
					if(rowsLovCols[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_LOV_COLS_U(?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("LOV_NO", CITData.NUMBER);
						lrArgData.addColumn("COL_SEQ", CITData.NUMBER);
						lrArgData.addColumn("DIS_SEQ", CITData.NUMBER);
						lrArgData.addColumn("NAME", CITData.VARCHAR2);
						lrArgData.addColumn("TITLE", CITData.VARCHAR2);
						lrArgData.addColumn("WIDTH", CITData.NUMBER);
						lrArgData.addColumn("ALIGN", CITData.VARCHAR2);
						lrArgData.addColumn("MASK", CITData.VARCHAR2);
						lrArgData.addColumn("VISIBLE", CITData.VARCHAR2);
						lrArgData.addRow();
						lrArgData.setValue("LOV_NO",  rowsLovCols[i].getString(dsLovCols.indexOfColumn("LOV_NO")));
						lrArgData.setValue("COL_SEQ",  rowsLovCols[i].getString(dsLovCols.indexOfColumn("COL_SEQ")));
						lrArgData.setValue("DIS_SEQ",  rowsLovCols[i].getString(dsLovCols.indexOfColumn("DIS_SEQ")));
						lrArgData.setValue("NAME",  rowsLovCols[i].getString(dsLovCols.indexOfColumn("NAME")));
						lrArgData.setValue("TITLE",  rowsLovCols[i].getString(dsLovCols.indexOfColumn("TITLE")));
						lrArgData.setValue("WIDTH",  rowsLovCols[i].getString(dsLovCols.indexOfColumn("WIDTH")));
						lrArgData.setValue("ALIGN",  rowsLovCols[i].getString(dsLovCols.indexOfColumn("ALIGN")));
						lrArgData.setValue("MASK",  rowsLovCols[i].getString(dsLovCols.indexOfColumn("MASK")));
						lrArgData.setValue("VISIBLE",  rowsLovCols[i].getString(dsLovCols.indexOfColumn("VISIBLE")));
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
				GauceInfo.response.writeException("USER", "900001", "T_LOV_COLS 테이블 데이타 갱신 오류" + ex.getMessage());
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