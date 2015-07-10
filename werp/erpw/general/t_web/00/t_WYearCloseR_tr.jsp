<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Update Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 한재원 작성(2005-11-25)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
	CITGauceInfo GauceInfo = null;
	
	GauceDataSet dsLIST = null;
	
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
			dsLIST = GauceInfo.request.getGauceDataSet("dsLIST");
			
			if (dsLIST == null) throw new Exception("dsLIST이(가) 널(Null)입니다.");
			
			rows = dsLIST.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					if (rows[i].getJobType() == GauceDataRow.TB_JOB_INSERT)
					{
						strSql = "{call SP_T_YEAR_CLOSE_I(?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CLSE_ACC_ID", CITData.VARCHAR2);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("ACC_ID", CITData.VARCHAR2);
						lrArgData.addColumn("ACCOUNT_FDT", CITData.VARCHAR2);
						lrArgData.addColumn("ACCOUNT_EDT", CITData.VARCHAR2);
						lrArgData.addColumn("CLSE_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("CLSE_DT", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsLIST.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("CLSE_ACC_ID", rows[i].getString(dsLIST.indexOfColumn("CLSE_ACC_ID")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("ACC_ID", rows[i].getString(dsLIST.indexOfColumn("ACC_ID")));
						lrArgData.setValue("ACCOUNT_FDT", rows[i].getString(dsLIST.indexOfColumn("ACCOUNT_FDT")));
						lrArgData.setValue("ACCOUNT_EDT", rows[i].getString(dsLIST.indexOfColumn("ACCOUNT_EDT")));
						lrArgData.setValue("CLSE_CLS", rows[i].getString(dsLIST.indexOfColumn("CLSE_CLS")));
						lrArgData.setValue("CLSE_DT", rows[i].getString(dsLIST.indexOfColumn("CLSE_DT")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_YEAR_CLOSE_U(?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CLSE_ACC_ID", CITData.VARCHAR2);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("ACC_ID", CITData.VARCHAR2);
						lrArgData.addColumn("ACCOUNT_FDT", CITData.VARCHAR2);
						lrArgData.addColumn("ACCOUNT_EDT", CITData.VARCHAR2);
						lrArgData.addColumn("CLSE_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("CLSE_DT", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsLIST.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("CLSE_ACC_ID", rows[i].getString(dsLIST.indexOfColumn("CLSE_ACC_ID")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("ACC_ID", rows[i].getString(dsLIST.indexOfColumn("ACC_ID")));
						lrArgData.setValue("ACCOUNT_FDT", rows[i].getString(dsLIST.indexOfColumn("ACCOUNT_FDT")));
						lrArgData.setValue("ACCOUNT_EDT", rows[i].getString(dsLIST.indexOfColumn("ACCOUNT_EDT")));
						lrArgData.setValue("CLSE_CLS", rows[i].getString(dsLIST.indexOfColumn("CLSE_CLS")));
						lrArgData.setValue("CLSE_DT", rows[i].getString(dsLIST.indexOfColumn("CLSE_DT")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_YEAR_CLOSE_D(?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CLSE_ACC_ID", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsLIST.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("CLSE_ACC_ID", rows[i].getString(dsLIST.indexOfColumn("CLSE_ACC_ID")));
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
				GauceInfo.response.writeException("USER", "900001", "T_YEAR_CLOSE 테이블 데이타 갱신 에러" + ex.getMessage());
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
