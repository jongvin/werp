<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Update Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 한재원 작성(2006-01-19)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
	CITGauceInfo GauceInfo = null;
	
	GauceDataSet dsMAIN2 = null;
	
	GauceDataRow[] rows = null;
	
	String strSql = "";
	String strAct = "";
	String strUserNo = "";
	Connection conn = null;
	
	try
	{
		GauceInfo = CITCommon.initServerPage(request, response, session);
		/* 세션정보 */
		strUserNo = CITCommon.toKOR((String)session.getAttribute("emp_no"));
		conn = CITConnectionManager.getConnection(false);
		
		strAct = GauceInfo.request.getParameter("ACT");
		
		if (CITCommon.isNull(strAct))
		{
			dsMAIN2 = GauceInfo.request.getGauceDataSet("dsMAIN2");
			
			if (dsMAIN2 == null) throw new Exception("dsMAIN2이(가) 널(Null)입니다.");
			
			rows = dsMAIN2.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					if (rows[i].getJobType() == GauceDataRow.TB_JOB_INSERT)
					{
						strSql = "{call SP_T_FIX_MOVE_TEMP_I(?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("FIX_ASSET_SEQ", CITData.NUMBER);
						lrArgData.addColumn("MOVE_SEQ", CITData.NUMBER);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("MOVE_DT_FROM", CITData.VARCHAR2);
						lrArgData.addColumn("MOVE_DT_TO", CITData.VARCHAR2);
						lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("EMP_NO", CITData.VARCHAR2);
						lrArgData.addColumn("MNG_MAIN", CITData.VARCHAR2);
						lrArgData.addColumn("MNG_SUB", CITData.VARCHAR2);
						lrArgData.addColumn("REAL_MOVE_SEQ", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("FIX_ASSET_SEQ", rows[i].getString(dsMAIN2.indexOfColumn("FIX_ASSET_SEQ")));
						lrArgData.setValue("MOVE_SEQ", rows[i].getString(dsMAIN2.indexOfColumn("MOVE_SEQ")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("MOVE_DT_FROM", rows[i].getString(dsMAIN2.indexOfColumn("MOVE_DT_FROM")));
						lrArgData.setValue("MOVE_DT_TO", rows[i].getString(dsMAIN2.indexOfColumn("MOVE_DT_TO")));
						lrArgData.setValue("DEPT_CODE", rows[i].getString(dsMAIN2.indexOfColumn("DEPT_CODE")));
						lrArgData.setValue("EMP_NO", rows[i].getString(dsMAIN2.indexOfColumn("EMP_NO")));
						lrArgData.setValue("MNG_MAIN", rows[i].getString(dsMAIN2.indexOfColumn("MNG_MAIN")));
						lrArgData.setValue("MNG_SUB", rows[i].getString(dsMAIN2.indexOfColumn("MNG_SUB")));
						lrArgData.setValue("REAL_MOVE_SEQ", rows[i].getString(dsMAIN2.indexOfColumn("REAL_MOVE_SEQ")));
						
						CITDatabase.executeProcedure(strSql, lrArgData, conn);
						 lrArgData = new CITData();
						 
						strSql = "{call SP_T_FIX_MOVE_TEMP_U(?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("FIX_ASSET_SEQ", CITData.NUMBER);
						lrArgData.addColumn("MOVE_SEQ", CITData.NUMBER);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("MOVE_DT_FROM", CITData.VARCHAR2);
						lrArgData.addColumn("MOVE_DT_TO", CITData.VARCHAR2);
						lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("EMP_NO", CITData.VARCHAR2);
						lrArgData.addColumn("MNG_MAIN", CITData.VARCHAR2);
						lrArgData.addColumn("MNG_SUB", CITData.VARCHAR2);
						lrArgData.addColumn("REAL_MOVE_SEQ", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("FIX_ASSET_SEQ", rows[i].getString(dsMAIN2.indexOfColumn("FIX_ASSET_SEQ")));
						lrArgData.setValue("MOVE_SEQ", rows[i].getString(dsMAIN2.indexOfColumn("MOVE_SEQ")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("MOVE_DT_FROM", rows[i].getString(dsMAIN2.indexOfColumn("MOVE_DT_FROM")));
						lrArgData.setValue("MOVE_DT_TO", rows[i].getString(dsMAIN2.indexOfColumn("MOVE_DT_TO")));
						lrArgData.setValue("DEPT_CODE", rows[i].getString(dsMAIN2.indexOfColumn("DEPT_CODE")));
						lrArgData.setValue("EMP_NO", rows[i].getString(dsMAIN2.indexOfColumn("EMP_NO")));
						lrArgData.setValue("MNG_MAIN", rows[i].getString(dsMAIN2.indexOfColumn("MNG_MAIN")));
						lrArgData.setValue("MNG_SUB", rows[i].getString(dsMAIN2.indexOfColumn("MNG_SUB")));
						lrArgData.setValue("REAL_MOVE_SEQ", rows[i].getString(dsMAIN2.indexOfColumn("REAL_MOVE_SEQ")));
						CITDatabase.executeProcedure(strSql, lrArgData, conn);
						conn.commit();
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_FIX_MOVE_TEMP_U(?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("FIX_ASSET_SEQ", CITData.NUMBER);
						lrArgData.addColumn("MOVE_SEQ", CITData.NUMBER);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("MOVE_DT_FROM", CITData.VARCHAR2);
						lrArgData.addColumn("MOVE_DT_TO", CITData.VARCHAR2);
						lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("EMP_NO", CITData.VARCHAR2);
						lrArgData.addColumn("MNG_MAIN", CITData.VARCHAR2);
						lrArgData.addColumn("MNG_SUB", CITData.VARCHAR2);
						lrArgData.addColumn("REAL_MOVE_SEQ", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("FIX_ASSET_SEQ", rows[i].getString(dsMAIN2.indexOfColumn("FIX_ASSET_SEQ")));
						lrArgData.setValue("MOVE_SEQ", rows[i].getString(dsMAIN2.indexOfColumn("MOVE_SEQ")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("MOVE_DT_FROM", rows[i].getString(dsMAIN2.indexOfColumn("MOVE_DT_FROM")));
						lrArgData.setValue("MOVE_DT_TO", rows[i].getString(dsMAIN2.indexOfColumn("MOVE_DT_TO")));
						lrArgData.setValue("DEPT_CODE", rows[i].getString(dsMAIN2.indexOfColumn("DEPT_CODE")));
						lrArgData.setValue("EMP_NO", rows[i].getString(dsMAIN2.indexOfColumn("EMP_NO")));
						lrArgData.setValue("MNG_MAIN", rows[i].getString(dsMAIN2.indexOfColumn("MNG_MAIN")));
						lrArgData.setValue("MNG_SUB", rows[i].getString(dsMAIN2.indexOfColumn("MNG_SUB")));
						lrArgData.setValue("REAL_MOVE_SEQ", rows[i].getString(dsMAIN2.indexOfColumn("REAL_MOVE_SEQ")));
						
						CITDatabase.executeProcedure(strSql, lrArgData, conn);
						conn.commit();
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_FIX_MOVE_TEMP_D(?,?)}";
						
						lrArgData.addColumn("FIX_ASSET_SEQ", CITData.NUMBER);
						lrArgData.addColumn("MOVE_SEQ", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("FIX_ASSET_SEQ", rows[i].getString(dsMAIN2.indexOfColumn("FIX_ASSET_SEQ")));
						lrArgData.setValue("MOVE_SEQ", rows[i].getString(dsMAIN2.indexOfColumn("MOVE_SEQ")));
						
						CITDatabase.executeProcedure(strSql, lrArgData, conn);
						conn.commit();
					}
					else
					{
						continue;
					}
					
					//CITDatabase.executeProcedure(strSql, lrArgData, conn);
				}
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001", "T_FIX_MOVE 테이블 데이타 갱신 에러" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
		}
		//conn.commit();
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
