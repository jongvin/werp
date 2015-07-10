<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Update Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 김흥수 작성(2005-12-05)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
	CITGauceInfo GauceInfo = null;
	
	GauceDataSet dsMAIN = null;
	
	GauceDataRow[] rows = null;
	
	String strSql = "";
	String strAct = "";
	String strKeepDt = "";
	String strUserNo = "";
	String strDeptCode = "";
	Connection conn = null;
	
	try
	{
		GauceInfo = CITCommon.initServerPage(request, response, session);
		/* 세션정보 */
		strUserNo = CITCommon.toKOR((String)session.getAttribute("emp_no"));
		strDeptCode = CITCommon.NvlString(session.getAttribute("dept_code"));
		conn = CITConnectionManager.getConnection(false);

		CITData lrArgData = new CITData();

		strSql = "{call SP_T_WORK_REPORT_D_ALL(?)}";

		lrArgData.addColumn("PAGE_ID", CITData.VARCHAR2);

		lrArgData.addRow();
		lrArgData.setValue("PAGE_ID",  "t_WSlipSelPrintR");

		CITDatabase.executeProcedure(strSql, lrArgData);

		strAct = GauceInfo.request.getParameter("ACT");
		
		if(strAct.equals("SLIP_PRINT"))
		{
			dsMAIN = GauceInfo.request.getGauceDataSet("dsMAIN");
			
			if (dsMAIN == null) throw new Exception("dsMAIN이(가) 널(Null)입니다.");
			
			rows = dsMAIN.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					lrArgData = new CITData();
					
					if ( (rows[i].getJobType() == GauceDataRow.TB_JOB_INSERT) || (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE) )
					{
						strSql = "{call SP_T_WORK_REPORT_I(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("PAGE_ID", CITData.VARCHAR2);
						lrArgData.addColumn("JOB_SEQ", CITData.NUMBER);
						lrArgData.addColumn("COL_NAME01", CITData.VARCHAR2);
						lrArgData.addColumn("COL_VALUE01", CITData.VARCHAR2);
						lrArgData.addColumn("COL_NAME02", CITData.VARCHAR2);
						lrArgData.addColumn("COL_VALUE02", CITData.VARCHAR2);
						lrArgData.addColumn("COL_NAME03", CITData.VARCHAR2);
						lrArgData.addColumn("COL_VALUE03", CITData.VARCHAR2);
						lrArgData.addColumn("COL_NAME04", CITData.VARCHAR2);
						lrArgData.addColumn("COL_VALUE04", CITData.VARCHAR2);
						lrArgData.addColumn("COL_NAME05", CITData.VARCHAR2);
						lrArgData.addColumn("COL_VALUE05", CITData.VARCHAR2);
						lrArgData.addColumn("COL_NAME06", CITData.VARCHAR2);
						lrArgData.addColumn("COL_VALUE06", CITData.VARCHAR2);
						lrArgData.addColumn("COL_NAME07", CITData.VARCHAR2);
						lrArgData.addColumn("COL_VALUE07", CITData.VARCHAR2);
						lrArgData.addColumn("COL_NAME08", CITData.VARCHAR2);
						lrArgData.addColumn("COL_VALUE08", CITData.VARCHAR2);
						lrArgData.addColumn("COL_NAME09", CITData.VARCHAR2);
						lrArgData.addColumn("COL_VALUE09", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("PAGE_ID", "t_WSlipSelPrintR");
						lrArgData.setValue("JOB_SEQ", "-1");
						lrArgData.setValue("COL_NAME01", "SLIP_ID");
						lrArgData.setValue("COL_VALUE01", rows[i].getString(dsMAIN.indexOfColumn("SLIP_ID")));
						lrArgData.setValue("COL_NAME02", "");
						lrArgData.setValue("COL_VALUE02", "");
						lrArgData.setValue("COL_NAME03", "");
						lrArgData.setValue("COL_VALUE03", "");
						lrArgData.setValue("COL_NAME04", "");
						lrArgData.setValue("COL_VALUE04", "");
						lrArgData.setValue("COL_NAME05", "");
						lrArgData.setValue("COL_VALUE05", "");
						lrArgData.setValue("COL_NAME06", "");
						lrArgData.setValue("COL_VALUE06", "");
						lrArgData.setValue("COL_NAME07", "");
						lrArgData.setValue("COL_VALUE07", "");
						lrArgData.setValue("COL_NAME08", "");
						lrArgData.setValue("COL_VALUE08", "");
						lrArgData.setValue("COL_NAME09", "");
						lrArgData.setValue("COL_VALUE09", "");
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_WORK_REPORT_D(?,?)}";
						
						lrArgData.addColumn("PAGE_ID", CITData.VARCHAR2);
						lrArgData.addColumn("JOB_SEQ", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("PAGE_ID", rows[i].getString(dsMAIN.indexOfColumn("PAGE_ID")));
						lrArgData.setValue("JOB_SEQ", rows[i].getString(dsMAIN.indexOfColumn("JOB_SEQ")));
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
				GauceInfo.response.writeException("USER", "900001", "T_WORK_REPORT 테이블 데이타 갱신 에러" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
		} else {
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
