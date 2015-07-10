<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Update Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 배민정 작성(2006-01-17)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
	CITGauceInfo GauceInfo = null;
	
	GauceDataSet dsMAIN = null;
	GauceDataSet dsCOPY = null;
	
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
					
					if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_FBS_ORDER_SAVE(?,?,?)}";
																	
						lrArgData.addColumn("ACCOUNT_NO", CITData.VARCHAR2);
						lrArgData.addColumn("FBS_DISPLAY_ORDER", CITData.NUMBER);
						lrArgData.addColumn("EMP_NO", CITData.VARCHAR2);
	
						lrArgData.addRow();
						lrArgData.setValue("ACCOUNT_NO", rows[i].getString(dsMAIN.indexOfColumn("ACCOUNT_NO")));
						lrArgData.setValue("FBS_DISPLAY_ORDER", rows[i].getString(dsMAIN.indexOfColumn("FBS_DISPLAY_ORDER")));
						lrArgData.setValue("EMP_NO", strUserNo);
	
						CITDatabase.executeProcedure(strSql, lrArgData, conn);
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
				GauceInfo.response.writeException("USER", "900001", "순서저장 에러" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
		}		
		
		else if(strAct.equals("COPY"))
		{
			dsCOPY = GauceInfo.request.getGauceDataSet("dsCOPY");
			
			if (dsCOPY == null) throw new Exception("dsCOPY이(가) 널(Null)입니다.");
			
			rows = dsCOPY.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					strSql = "{call sp_reselect_remains(?,?)}";
																
					lrArgData.addColumn("BANK_CODE", CITData.VARCHAR2);
					lrArgData.addColumn("ACCOUNT_NO", CITData.VARCHAR2);

					lrArgData.addRow();
					lrArgData.setValue("BANK_CODE", rows[i].getString(dsCOPY.indexOfColumn("BANK_CODE")));
					lrArgData.setValue("ACCOUNT_NO", rows[i].getString(dsCOPY.indexOfColumn("ACCOUNT_NO")));

					CITDatabase.executeProcedure(strSql, lrArgData, conn);
				}
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001", "신규잔액조회 에러" + ex.getMessage());
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
