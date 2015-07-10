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
	GauceDataSet dsLIST = null;
	
	GauceDataRow[] rows = null;
	GauceDataRow[] rowsLIST = null;
	
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
			dsLIST = GauceInfo.request.getGauceDataSet("dsLIST");
			
			if (dsMAIN == null) throw new Exception("dsMAIN이(가) 널(Null)입니다.");
			if (dsLIST == null) throw new Exception("dsLIST이(가) 널(Null)입니다.");
			
			rows = dsMAIN.getDataRows();
			rowsLIST = dsLIST.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					if (rows[i].getJobType() == GauceDataRow.TB_JOB_INSERT)
					{
						strSql = "{call SP_T_BRAIN_SLIP_I(?,?,?)}";
						
						lrArgData.addColumn("BRAIN_SLIP_SEQ1", CITData.NUMBER);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("BRAIN_SLIP_NAME1", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("BRAIN_SLIP_SEQ1", rows[i].getString(dsMAIN.indexOfColumn("BRAIN_SLIP_SEQ1")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("BRAIN_SLIP_NAME1", rows[i].getString(dsMAIN.indexOfColumn("BRAIN_SLIP_NAME1")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_BRAIN_SLIP_U(?,?,?)}";
						
						lrArgData.addColumn("BRAIN_SLIP_SEQ1", CITData.NUMBER);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("BRAIN_SLIP_NAME1", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("BRAIN_SLIP_SEQ1", rows[i].getString(dsMAIN.indexOfColumn("BRAIN_SLIP_SEQ1")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("BRAIN_SLIP_NAME1", rows[i].getString(dsMAIN.indexOfColumn("BRAIN_SLIP_NAME1")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_BRAIN_SLIP_D(?)}";
						
						lrArgData.addColumn("BRAIN_SLIP_SEQ1", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("BRAIN_SLIP_SEQ1", rows[i].getString(dsMAIN.indexOfColumn("BRAIN_SLIP_SEQ1")));
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
				GauceInfo.response.writeException("USER", "900001", "T_BRAIN_SLIP 테이블 데이타 갱신 에러" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
			
			try
			{
				for	(int i = 0;	i <	rowsLIST.length; i++)
				{
					CITData lrArgData = new CITData();
					
					if (rowsLIST[i].getJobType() == GauceDataRow.TB_JOB_INSERT)
					{
						strSql = "{call SP_T_BRAIN_SLIP_HEAD_I(?,?,?,?,?)}";
						
						lrArgData.addColumn("BRAIN_SLIP_SEQ1", CITData.NUMBER);
						lrArgData.addColumn("BRAIN_SLIP_SEQ2", CITData.NUMBER);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("BRAIN_SLIP_NAME2", CITData.VARCHAR2);
						lrArgData.addColumn("USE_CLS", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("BRAIN_SLIP_SEQ1", rowsLIST[i].getString(dsLIST.indexOfColumn("BRAIN_SLIP_SEQ1")));
						lrArgData.setValue("BRAIN_SLIP_SEQ2", rowsLIST[i].getString(dsLIST.indexOfColumn("BRAIN_SLIP_SEQ2")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("BRAIN_SLIP_NAME2", rowsLIST[i].getString(dsLIST.indexOfColumn("BRAIN_SLIP_NAME2")));
						lrArgData.setValue("USE_CLS", rowsLIST[i].getString(dsLIST.indexOfColumn("USE_CLS")));
					}
					else if (rowsLIST[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_BRAIN_SLIP_HEAD_U(?,?,?,?,?)}";
						
						lrArgData.addColumn("BRAIN_SLIP_SEQ1", CITData.NUMBER);
						lrArgData.addColumn("BRAIN_SLIP_SEQ2", CITData.NUMBER);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("BRAIN_SLIP_NAME2", CITData.VARCHAR2);
						lrArgData.addColumn("USE_CLS", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("BRAIN_SLIP_SEQ1", rowsLIST[i].getString(dsLIST.indexOfColumn("BRAIN_SLIP_SEQ1")));
						lrArgData.setValue("BRAIN_SLIP_SEQ2", rowsLIST[i].getString(dsLIST.indexOfColumn("BRAIN_SLIP_SEQ2")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("BRAIN_SLIP_NAME2", rowsLIST[i].getString(dsLIST.indexOfColumn("BRAIN_SLIP_NAME2")));
						lrArgData.setValue("USE_CLS", rowsLIST[i].getString(dsLIST.indexOfColumn("USE_CLS")));
					}
					else if (rowsLIST[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_BRAIN_SLIP_HEAD_D(?,?)}";
						
						lrArgData.addColumn("BRAIN_SLIP_SEQ1", CITData.NUMBER);
						lrArgData.addColumn("BRAIN_SLIP_SEQ2", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("BRAIN_SLIP_SEQ1", rowsLIST[i].getString(dsLIST.indexOfColumn("BRAIN_SLIP_SEQ1")));
						lrArgData.setValue("BRAIN_SLIP_SEQ2", rowsLIST[i].getString(dsLIST.indexOfColumn("BRAIN_SLIP_SEQ2")));
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
				GauceInfo.response.writeException("USER", "900001", "T_BRAIN_SLIP_HEAD 테이블 데이타 갱신 에러" + ex.getMessage());
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
