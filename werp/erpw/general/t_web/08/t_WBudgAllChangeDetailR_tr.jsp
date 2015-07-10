<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Update Page
/* 3. 기  능  정  의   : 
/* 4. 변  경  이  력   : 한재원 작성(2006-01-05)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
	CITGauceInfo GauceInfo = null;
	
	GauceDataSet dsBUDG_ALL_CHANGE = null;
	
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
		
		if(!CITCommon.isNull(strAct) && strAct.equals("BUDG_ALL_CHANGE"))
		{
			dsBUDG_ALL_CHANGE = GauceInfo.request.getGauceDataSet("dsBUDG_ALL_CHANGE");
			
			if (dsBUDG_ALL_CHANGE == null) throw new Exception("dsBUDG_ALL_CHANGE이(가) 널(Null)입니다.");
			
			rows = dsBUDG_ALL_CHANGE.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					
					strSql = "{call SP_T_BUDG_ALL_CHANGE_APPLY(?,?,?,?,?)}";
						
					lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
					lrArgData.addColumn("CLSE_ACC_ID", CITData.VARCHAR2);
					lrArgData.addColumn("ALL_CHG_SEQ", CITData.NUMBER);
					lrArgData.addColumn("APPLY_YN", CITData.VARCHAR2);
					lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
					

					lrArgData.addRow();
					lrArgData.setValue("COMP_CODE", rows[i].getString(dsBUDG_ALL_CHANGE.indexOfColumn("COMP_CODE")));
					lrArgData.setValue("CLSE_ACC_ID", rows[i].getString(dsBUDG_ALL_CHANGE.indexOfColumn("CLSE_ACC_ID")));
					lrArgData.setValue("ALL_CHG_SEQ", rows[i].getString(dsBUDG_ALL_CHANGE.indexOfColumn("ALL_CHG_SEQ")));
					lrArgData.setValue("APPLY_YN", rows[i].getString(dsBUDG_ALL_CHANGE.indexOfColumn("APPLY_YN")));
					lrArgData.setValue("CRTUSERNO", strUserNo);
					
					
	
					CITDatabase.executeProcedure(strSql, lrArgData, conn);
				}
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001", "T_BUDG_ALL_CHANGE 테이블 데이타 갱신 에러" + ex.getMessage());
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
