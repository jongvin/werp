<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Update Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 한재원 작성(2005-12-06)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
	CITGauceInfo GauceInfo = null;
	
	GauceDataSet dsMAIN = null;
	
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
			dsMAIN = GauceInfo.request.getGauceDataSet("dsMAIN");
			
			if (dsMAIN == null) throw new Exception("dsMAIN이(가) 널(Null)입니다.");
			
			rows = dsMAIN.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					if (rows[i].getJobType() == GauceDataRow.TB_JOB_INSERT)
					{
						strSql = "{call SP_T_BRAIN_SLIP_BODY_I(?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("BRAIN_SLIP_SEQ1", CITData.NUMBER);
						lrArgData.addColumn("BRAIN_SLIP_SEQ2", CITData.NUMBER);
						lrArgData.addColumn("BRAIN_SLIP_LINE", CITData.NUMBER);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("BRAIN_SORT_SEQ", CITData.NUMBER);
						lrArgData.addColumn("ACC_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("ACC_POSITION", CITData.VARCHAR2);
						lrArgData.addColumn("SUMMARY_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("SUMMARY1", CITData.VARCHAR2);
						lrArgData.addColumn("SUMMARY2", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("BRAIN_SLIP_SEQ1", rows[i].getString(dsMAIN.indexOfColumn("BRAIN_SLIP_SEQ1")));
						lrArgData.setValue("BRAIN_SLIP_SEQ2", rows[i].getString(dsMAIN.indexOfColumn("BRAIN_SLIP_SEQ2")));
						lrArgData.setValue("BRAIN_SLIP_LINE", rows[i].getString(dsMAIN.indexOfColumn("BRAIN_SLIP_LINE")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("BRAIN_SORT_SEQ", rows[i].getString(dsMAIN.indexOfColumn("BRAIN_SORT_SEQ")));
						lrArgData.setValue("ACC_CODE", rows[i].getString(dsMAIN.indexOfColumn("ACC_CODE")));
						lrArgData.setValue("ACC_POSITION", rows[i].getString(dsMAIN.indexOfColumn("ACC_POSITION")));
						lrArgData.setValue("SUMMARY_CODE", rows[i].getString(dsMAIN.indexOfColumn("SUMMARY_CODE")));
						lrArgData.setValue("SUMMARY1", rows[i].getString(dsMAIN.indexOfColumn("SUMMARY1")));
						lrArgData.setValue("SUMMARY2", rows[i].getString(dsMAIN.indexOfColumn("SUMMARY2")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_BRAIN_SLIP_BODY_U(?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("BRAIN_SLIP_SEQ1", CITData.NUMBER);
						lrArgData.addColumn("BRAIN_SLIP_SEQ2", CITData.NUMBER);
						lrArgData.addColumn("BRAIN_SLIP_LINE", CITData.NUMBER);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("BRAIN_SORT_SEQ", CITData.NUMBER);
						lrArgData.addColumn("ACC_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("ACC_POSITION", CITData.VARCHAR2);
						lrArgData.addColumn("SUMMARY_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("SUMMARY1", CITData.VARCHAR2);
						lrArgData.addColumn("SUMMARY2", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("BRAIN_SLIP_SEQ1", rows[i].getString(dsMAIN.indexOfColumn("BRAIN_SLIP_SEQ1")));
						lrArgData.setValue("BRAIN_SLIP_SEQ2", rows[i].getString(dsMAIN.indexOfColumn("BRAIN_SLIP_SEQ2")));
						lrArgData.setValue("BRAIN_SLIP_LINE", rows[i].getString(dsMAIN.indexOfColumn("BRAIN_SLIP_LINE")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("BRAIN_SORT_SEQ", rows[i].getString(dsMAIN.indexOfColumn("BRAIN_SORT_SEQ")));
						lrArgData.setValue("ACC_CODE", rows[i].getString(dsMAIN.indexOfColumn("ACC_CODE")));
						lrArgData.setValue("ACC_POSITION", rows[i].getString(dsMAIN.indexOfColumn("ACC_POSITION")));
						lrArgData.setValue("SUMMARY_CODE", rows[i].getString(dsMAIN.indexOfColumn("SUMMARY_CODE")));
						lrArgData.setValue("SUMMARY1", rows[i].getString(dsMAIN.indexOfColumn("SUMMARY1")));
						lrArgData.setValue("SUMMARY2", rows[i].getString(dsMAIN.indexOfColumn("SUMMARY2")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_BRAIN_SLIP_BODY_D(?,?,?)}";
						
						lrArgData.addColumn("BRAIN_SLIP_SEQ1", CITData.NUMBER);
						lrArgData.addColumn("BRAIN_SLIP_SEQ2", CITData.NUMBER);
						lrArgData.addColumn("BRAIN_SLIP_LINE", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("BRAIN_SLIP_SEQ1", rows[i].getString(dsMAIN.indexOfColumn("BRAIN_SLIP_SEQ1")));
						lrArgData.setValue("BRAIN_SLIP_SEQ2", rows[i].getString(dsMAIN.indexOfColumn("BRAIN_SLIP_SEQ2")));
						lrArgData.setValue("BRAIN_SLIP_LINE", rows[i].getString(dsMAIN.indexOfColumn("BRAIN_SLIP_LINE")));
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
				GauceInfo.response.writeException("USER", "900001", "T_BRAIN_SLIP_BODY 테이블 데이타 갱신 에러" + ex.getMessage());
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
