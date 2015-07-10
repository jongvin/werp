<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : t_PLovFilterRelR_tr.jsp(공통팝업의 필터관계등록)
/* 2. 유형(시나리오) : Update Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 강덕율 작성(2005-11-24)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
	CITGauceInfo GauceInfo = null;
	
	GauceDataSet dsFilterRels = null;
	
	GauceDataRow[] rowsFilterRels = null;
	
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
			dsFilterRels = GauceInfo.request.getGauceDataSet("dsFilterRels");
			
			if (dsFilterRels == null) throw new Exception("dsFilterRels이(가) 널(Null)입니다.");
			
			rowsFilterRels = dsFilterRels.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	rowsFilterRels.length; i++)
				{
					CITData lrArgData = new CITData();
					
					if (rowsFilterRels[i].getJobType() == GauceDataRow.TB_JOB_INSERT)
					{
						strSql = "{call SP_T_LOV_FILTER_RELS_I(?,?,?,?,?)}";
						
						lrArgData.addColumn("LOV_NO", CITData.NUMBER);
						lrArgData.addColumn("FILTER_REL_SEQ", CITData.NUMBER);
						lrArgData.addColumn("DIS_SEQ", CITData.NUMBER);
						lrArgData.addColumn("M_FILTER_SEQ", CITData.NUMBER);
						lrArgData.addColumn("D_FILTER_SEQ", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("LOV_NO", rowsFilterRels[i].getString(dsFilterRels.indexOfColumn("LOV_NO")));
						lrArgData.setValue("FILTER_REL_SEQ", rowsFilterRels[i].getString(dsFilterRels.indexOfColumn("FILTER_REL_SEQ")));
						lrArgData.setValue("DIS_SEQ", rowsFilterRels[i].getString(dsFilterRels.indexOfColumn("DIS_SEQ")));
						lrArgData.setValue("M_FILTER_SEQ", rowsFilterRels[i].getString(dsFilterRels.indexOfColumn("M_FILTER_SEQ")));
						lrArgData.setValue("D_FILTER_SEQ", rowsFilterRels[i].getString(dsFilterRels.indexOfColumn("D_FILTER_SEQ")));
					}
					else if (rowsFilterRels[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_LOV_FILTER_RELS_U(?,?,?,?,?)}";
						
						lrArgData.addColumn("LOV_NO", CITData.NUMBER);
						lrArgData.addColumn("FILTER_REL_SEQ", CITData.NUMBER);
						lrArgData.addColumn("DIS_SEQ", CITData.NUMBER);
						lrArgData.addColumn("M_FILTER_SEQ", CITData.NUMBER);
						lrArgData.addColumn("D_FILTER_SEQ", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("LOV_NO", rowsFilterRels[i].getString(dsFilterRels.indexOfColumn("LOV_NO")));
						lrArgData.setValue("FILTER_REL_SEQ", rowsFilterRels[i].getString(dsFilterRels.indexOfColumn("FILTER_REL_SEQ")));
						lrArgData.setValue("DIS_SEQ", rowsFilterRels[i].getString(dsFilterRels.indexOfColumn("DIS_SEQ")));
						lrArgData.setValue("M_FILTER_SEQ", rowsFilterRels[i].getString(dsFilterRels.indexOfColumn("M_FILTER_SEQ")));
						lrArgData.setValue("D_FILTER_SEQ", rowsFilterRels[i].getString(dsFilterRels.indexOfColumn("D_FILTER_SEQ")));
					}
					else if (rowsFilterRels[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_LOV_FILTER_RELS_D(?,?)}";
						
						lrArgData.addColumn("LOV_NO", CITData.NUMBER);
						lrArgData.addColumn("FILTER_REL_SEQ", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("LOV_NO", rowsFilterRels[i].getString(dsFilterRels.indexOfColumn("LOV_NO")));
						lrArgData.setValue("FILTER_REL_SEQ", rowsFilterRels[i].getString(dsFilterRels.indexOfColumn("FILTER_REL_SEQ")));
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
				GauceInfo.response.writeException("USER", "900001", "T_LOV_FILTER_RELS 테이블 데이타 갱신 에러" + ex.getMessage());
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
