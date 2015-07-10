<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*,java.math.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Update Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 한재원 작성(2005-12-18)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/


	CITGauceInfo GauceInfo = null;
	

	
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
		if(!CITCommon.isNull(strAct) && strAct.equals("COPY"))
		{
			dsCOPY = GauceInfo.request.getGauceDataSet("dsCOPY");
			rows = dsCOPY.getDataRows();
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					strSql = "{call SP_T_PL_REPORT_TEMP0011_COPY(?,?,?,?,?,?)}";
					
					lrArgData.addColumn("EMP_NO", CITData.VARCHAR2);
					lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
					lrArgData.addColumn("CLSE_ACC_ID", CITData.VARCHAR2);
					lrArgData.addColumn("MON1", CITData.VARCHAR2);
					lrArgData.addColumn("MON2", CITData.VARCHAR2);
					lrArgData.addColumn("MON3", CITData.VARCHAR2);

					lrArgData.addRow();
					lrArgData.setValue("EMP_NO", rows[i].getString(dsCOPY.indexOfColumn("EMP_NO")));
					lrArgData.setValue("COMP_CODE", rows[i].getString(dsCOPY.indexOfColumn("COMP_CODE")));
					lrArgData.setValue("CLSE_ACC_ID", rows[i].getString(dsCOPY.indexOfColumn("CLSE_ACC_ID")));
					lrArgData.setValue("MON1", rows[i].getString(dsCOPY.indexOfColumn("MON1")));
					lrArgData.setValue("MON2", rows[i].getString(dsCOPY.indexOfColumn("MON2")));
					lrArgData.setValue("MON3", rows[i].getString(dsCOPY.indexOfColumn("MON3")));
			
					CITDatabase.executeProcedure(strSql, lrArgData, conn);
					
					
				}
				
				conn.commit();
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001", "SP_T_PROF_LOSS_COPY 테이블 데이타 갱신 에러" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
		}
		
	
		
		
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
