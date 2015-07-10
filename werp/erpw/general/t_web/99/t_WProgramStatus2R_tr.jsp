<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Update Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 김흥수 작성(2006-01-06)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
	CITGauceInfo GauceInfo = null;
	
	GauceDataSet dsMAIN = null;
	GauceDataSet dsSUB01 = null;
	
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
						strSql = "{call SP_T_PROGRAM_STATUS_I(?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("MENU_NO", CITData.NUMBER);
						lrArgData.addColumn("PROGRAM_NO", CITData.NUMBER);
						lrArgData.addColumn("MAKE_PROGRAMMER", CITData.VARCHAR2);
						lrArgData.addColumn("TEST_USER_NAME_1", CITData.VARCHAR2);
						lrArgData.addColumn("TEST_USER_NAME_2", CITData.VARCHAR2);
						lrArgData.addColumn("COMFIRM_USER_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("CHANGE_PROGRAMMER", CITData.VARCHAR2);
						lrArgData.addColumn("MAKE_DT", CITData.VARCHAR2);
						lrArgData.addColumn("CHANGE_DT", CITData.VARCHAR2);
						lrArgData.addColumn("CONFIRM_DT", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("MENU_NO", rows[i].getString(dsMAIN.indexOfColumn("MENU_NO")));
						lrArgData.setValue("PROGRAM_NO", rows[i].getString(dsMAIN.indexOfColumn("PROGRAM_NO")));
						lrArgData.setValue("MAKE_PROGRAMMER", rows[i].getString(dsMAIN.indexOfColumn("MAKE_PROGRAMMER")));
						lrArgData.setValue("TEST_USER_NAME_1", rows[i].getString(dsMAIN.indexOfColumn("TEST_USER_NAME_1")));
						lrArgData.setValue("TEST_USER_NAME_2", rows[i].getString(dsMAIN.indexOfColumn("TEST_USER_NAME_2")));
						lrArgData.setValue("COMFIRM_USER_NAME", rows[i].getString(dsMAIN.indexOfColumn("COMFIRM_USER_NAME")));
						lrArgData.setValue("CHANGE_PROGRAMMER", rows[i].getString(dsMAIN.indexOfColumn("CHANGE_PROGRAMMER")));
						lrArgData.setValue("MAKE_DT", rows[i].getString(dsMAIN.indexOfColumn("MAKE_DT")));
						lrArgData.setValue("CHANGE_DT", rows[i].getString(dsMAIN.indexOfColumn("CHANGE_DT")));
						lrArgData.setValue("CONFIRM_DT", rows[i].getString(dsMAIN.indexOfColumn("CONFIRM_DT")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_PROGRAM_STATUS_U(?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("MENU_NO", CITData.NUMBER);
						lrArgData.addColumn("PROGRAM_NO", CITData.NUMBER);
						lrArgData.addColumn("MAKE_PROGRAMMER", CITData.VARCHAR2);
						lrArgData.addColumn("TEST_USER_NAME_1", CITData.VARCHAR2);
						lrArgData.addColumn("TEST_USER_NAME_2", CITData.VARCHAR2);
						lrArgData.addColumn("COMFIRM_USER_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("CHANGE_PROGRAMMER", CITData.VARCHAR2);
						lrArgData.addColumn("MAKE_DT", CITData.VARCHAR2);
						lrArgData.addColumn("CHANGE_DT", CITData.VARCHAR2);
						lrArgData.addColumn("CONFIRM_DT", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("MENU_NO", rows[i].getString(dsMAIN.indexOfColumn("MENU_NO")));
						lrArgData.setValue("PROGRAM_NO", rows[i].getString(dsMAIN.indexOfColumn("PROGRAM_NO")));
						lrArgData.setValue("MAKE_PROGRAMMER", rows[i].getString(dsMAIN.indexOfColumn("MAKE_PROGRAMMER")));
						lrArgData.setValue("TEST_USER_NAME_1", rows[i].getString(dsMAIN.indexOfColumn("TEST_USER_NAME_1")));
						lrArgData.setValue("TEST_USER_NAME_2", rows[i].getString(dsMAIN.indexOfColumn("TEST_USER_NAME_2")));
						lrArgData.setValue("COMFIRM_USER_NAME", rows[i].getString(dsMAIN.indexOfColumn("COMFIRM_USER_NAME")));
						lrArgData.setValue("CHANGE_PROGRAMMER", rows[i].getString(dsMAIN.indexOfColumn("CHANGE_PROGRAMMER")));
						lrArgData.setValue("MAKE_DT", rows[i].getString(dsMAIN.indexOfColumn("MAKE_DT")));
						lrArgData.setValue("CHANGE_DT", rows[i].getString(dsMAIN.indexOfColumn("CHANGE_DT")));
						lrArgData.setValue("CONFIRM_DT", rows[i].getString(dsMAIN.indexOfColumn("CONFIRM_DT")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_PROGRAM_STATUS_D(?,?)}";
						
						lrArgData.addColumn("MENU_NO", CITData.NUMBER);
						lrArgData.addColumn("PROGRAM_NO", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("MENU_NO", rows[i].getString(dsMAIN.indexOfColumn("MENU_NO")));
						lrArgData.setValue("PROGRAM_NO", rows[i].getString(dsMAIN.indexOfColumn("PROGRAM_NO")));
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
				GauceInfo.response.writeException("USER", "900001", "T_PROGRAM_STATUS 테이블 데이타 갱신 에러" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
			dsSUB01 = GauceInfo.request.getGauceDataSet("dsSUB01");
			if (dsSUB01 == null) throw new Exception("dsSUB01이(가) 널(Null)입니다.");
			
			rows = dsSUB01.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					if (rows[i].getJobType() == GauceDataRow.TB_JOB_INSERT)
					{
						strSql = "{call SP_T_PROGRAM_REQUEST_I(?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("MENU_NO", CITData.NUMBER);
						lrArgData.addColumn("PROGRAM_NO", CITData.NUMBER);
						lrArgData.addColumn("REQ_NO", CITData.NUMBER);
						lrArgData.addColumn("REQ_USER_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("REQ_CONTENTS", CITData.VARCHAR2);
						lrArgData.addColumn("REQ_DT", CITData.VARCHAR2);
						lrArgData.addColumn("PROCESS_DT", CITData.VARCHAR2);
						lrArgData.addColumn("PROCESS_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("CONFIRM_DT", CITData.VARCHAR2);
						lrArgData.addColumn("CONFIRM_TAG", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("MENU_NO", rows[i].getString(dsSUB01.indexOfColumn("MENU_NO")));
						lrArgData.setValue("PROGRAM_NO", rows[i].getString(dsSUB01.indexOfColumn("PROGRAM_NO")));
						lrArgData.setValue("REQ_NO", rows[i].getString(dsSUB01.indexOfColumn("REQ_NO")));
						lrArgData.setValue("REQ_USER_NAME", rows[i].getString(dsSUB01.indexOfColumn("REQ_USER_NAME")));
						lrArgData.setValue("REQ_CONTENTS", rows[i].getString(dsSUB01.indexOfColumn("REQ_CONTENTS")));
						lrArgData.setValue("REQ_DT", rows[i].getString(dsSUB01.indexOfColumn("REQ_DT")));
						lrArgData.setValue("PROCESS_DT", rows[i].getString(dsSUB01.indexOfColumn("PROCESS_DT")));
						lrArgData.setValue("PROCESS_TAG", rows[i].getString(dsSUB01.indexOfColumn("PROCESS_TAG")));
						lrArgData.setValue("CONFIRM_DT", rows[i].getString(dsSUB01.indexOfColumn("CONFIRM_DT")));
						lrArgData.setValue("CONFIRM_TAG", rows[i].getString(dsSUB01.indexOfColumn("CONFIRM_TAG")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_PROGRAM_REQUEST_U(?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("MENU_NO", CITData.NUMBER);
						lrArgData.addColumn("PROGRAM_NO", CITData.NUMBER);
						lrArgData.addColumn("REQ_NO", CITData.NUMBER);
						lrArgData.addColumn("REQ_USER_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("REQ_CONTENTS", CITData.VARCHAR2);
						lrArgData.addColumn("REQ_DT", CITData.VARCHAR2);
						lrArgData.addColumn("PROCESS_DT", CITData.VARCHAR2);
						lrArgData.addColumn("PROCESS_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("CONFIRM_DT", CITData.VARCHAR2);
						lrArgData.addColumn("CONFIRM_TAG", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("MENU_NO", rows[i].getString(dsSUB01.indexOfColumn("MENU_NO")));
						lrArgData.setValue("PROGRAM_NO", rows[i].getString(dsSUB01.indexOfColumn("PROGRAM_NO")));
						lrArgData.setValue("REQ_NO", rows[i].getString(dsSUB01.indexOfColumn("REQ_NO")));
						lrArgData.setValue("REQ_USER_NAME", rows[i].getString(dsSUB01.indexOfColumn("REQ_USER_NAME")));
						lrArgData.setValue("REQ_CONTENTS", rows[i].getString(dsSUB01.indexOfColumn("REQ_CONTENTS")));
						lrArgData.setValue("REQ_DT", rows[i].getString(dsSUB01.indexOfColumn("REQ_DT")));
						lrArgData.setValue("PROCESS_DT", rows[i].getString(dsSUB01.indexOfColumn("PROCESS_DT")));
						lrArgData.setValue("PROCESS_TAG", rows[i].getString(dsSUB01.indexOfColumn("PROCESS_TAG")));
						lrArgData.setValue("CONFIRM_DT", rows[i].getString(dsSUB01.indexOfColumn("CONFIRM_DT")));
						lrArgData.setValue("CONFIRM_TAG", rows[i].getString(dsSUB01.indexOfColumn("CONFIRM_TAG")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_PROGRAM_REQUEST_D(?,?,?)}";
						
						lrArgData.addColumn("MENU_NO", CITData.NUMBER);
						lrArgData.addColumn("PROGRAM_NO", CITData.NUMBER);
						lrArgData.addColumn("REQ_NO", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("MENU_NO", rows[i].getString(dsSUB01.indexOfColumn("MENU_NO")));
						lrArgData.setValue("PROGRAM_NO", rows[i].getString(dsSUB01.indexOfColumn("PROGRAM_NO")));
						lrArgData.setValue("REQ_NO", rows[i].getString(dsSUB01.indexOfColumn("REQ_NO")));
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
				GauceInfo.response.writeException("USER", "900001", "T_PROGRAM_REQUEST 테이블 데이타 갱신 에러" + ex.getMessage());
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
