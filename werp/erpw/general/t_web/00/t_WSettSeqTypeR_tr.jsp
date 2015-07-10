<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Update Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 홍길동 작성(2005-11-17)
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
						strSql = "{call SP_T_SHEET_SEQ_TYPE_I(?,?,?)}";
						
						lrArgData.addColumn("SEQ_TYPE", CITData.VARCHAR2);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("SEQ_TYPE_NAME", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("SEQ_TYPE", rows[i].getString(dsMAIN.indexOfColumn("SEQ_TYPE")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("SEQ_TYPE_NAME", rows[i].getString(dsMAIN.indexOfColumn("SEQ_TYPE_NAME")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_SHEET_SEQ_TYPE_U(?,?,?)}";
						
						lrArgData.addColumn("SEQ_TYPE", CITData.VARCHAR2);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("SEQ_TYPE_NAME", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("SEQ_TYPE", rows[i].getString(dsMAIN.indexOfColumn("SEQ_TYPE")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("SEQ_TYPE_NAME", rows[i].getString(dsMAIN.indexOfColumn("SEQ_TYPE_NAME")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_SHEET_SEQ_TYPE_D(?)}";
						
						lrArgData.addColumn("SEQ_TYPE", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("SEQ_TYPE", rows[i].getString(dsMAIN.indexOfColumn("SEQ_TYPE")));
					}
					else
					{
						continue;
					}
					
					CITDatabase.executeProcedure(strSql, lrArgData,conn);
				}
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001", "T_SHEET_SEQ_TYPE 테이블 데이타 갱신 에러" + ex.getMessage());
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
						strSql = "{call SP_T_SHEET_SEQ_TYPE_NAME_I(?,?,?,?)}";
						
						lrArgData.addColumn("SEQ_TYPE", CITData.VARCHAR2);
						lrArgData.addColumn("SEQ_SEQ", CITData.NUMBER);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("SEQ_TYPE_NAME", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("SEQ_TYPE", rows[i].getString(dsSUB01.indexOfColumn("SEQ_TYPE")));
						lrArgData.setValue("SEQ_SEQ", rows[i].getString(dsSUB01.indexOfColumn("SEQ_SEQ")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("SEQ_TYPE_NAME", rows[i].getString(dsSUB01.indexOfColumn("SEQ_TYPE_NAME")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_SHEET_SEQ_TYPE_NAME_U(?,?,?,?)}";
						
						lrArgData.addColumn("SEQ_TYPE", CITData.VARCHAR2);
						lrArgData.addColumn("SEQ_SEQ", CITData.NUMBER);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("SEQ_TYPE_NAME", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("SEQ_TYPE", rows[i].getString(dsSUB01.indexOfColumn("SEQ_TYPE")));
						lrArgData.setValue("SEQ_SEQ", rows[i].getString(dsSUB01.indexOfColumn("SEQ_SEQ")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("SEQ_TYPE_NAME", rows[i].getString(dsSUB01.indexOfColumn("SEQ_TYPE_NAME")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_SHEET_SEQ_TYPE_NAME_D(?,?)}";
						
						lrArgData.addColumn("SEQ_TYPE", CITData.VARCHAR2);
						lrArgData.addColumn("SEQ_SEQ", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("SEQ_TYPE", rows[i].getString(dsSUB01.indexOfColumn("SEQ_TYPE")));
						lrArgData.setValue("SEQ_SEQ", rows[i].getString(dsSUB01.indexOfColumn("SEQ_SEQ")));
					}
					else
					{
						continue;
					}
					
					CITDatabase.executeProcedure(strSql, lrArgData,conn);
				}
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001", "T_SHEET_SEQ_TYPE_NAME 테이블 데이타 갱신 에러" + ex.getMessage());
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
