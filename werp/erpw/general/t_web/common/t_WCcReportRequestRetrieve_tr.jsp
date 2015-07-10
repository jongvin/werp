<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/***************************************************/
/* 이 프로그램은 대보시스템(주) 의 재산입니다.
/* 최초작성자 : 강덕율
/* 최초작성일 : 2005-01-14
/* 최종수정자 : 
/* 최종수정일 : 
/***************************************************/
 
	CITGauceInfo GauceInfo = null;
	
	GauceDataSet dsRequest = null;
	
	GauceDataRow[] rowsRequest = null;
	
	Connection conn = null;
	
	String strSql = "";
	String strUserNo = "";
	String strUserName = "";
	
	try
	{
		GauceInfo = CITCommon.initServerPage(request, response, session);
		/* 세션정보 */
		strUserNo = session.getAttribute("emp_no") == null ? "" : session.getAttribute("emp_no").toString();
		strUserName = session.getAttribute("user_nm") == null ? "" : session.getAttribute("user_nm").toString();
		
		conn = CITConnectionManager.getConnection(false);

		dsRequest = GauceInfo.request.getGauceDataSet("dsRequest");
		
		if (dsRequest == null) throw new Exception("dsRequest이(가) 널(Null)입니다.");

		rowsRequest = dsRequest.getDataRows();
	

		// dsRequest의 Insert, Update, Delete
		try
		{
			for	(int i = 0;	i <	rowsRequest.length; i++)
			{
				CITData lrArgData = new CITData();
				
				if(rowsRequest[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
				{
					strSql = "{call SP_T_USER_REPORT_REQUEST_D(?,?,?)}";
					
					lrArgData.addColumn("REPORT_REQUEST_NO", CITData.NUMBER);
					lrArgData.addColumn("USER_NO", CITData.VARCHAR2);
					lrArgData.addColumn("REPORT_NO", CITData.NUMBER);

					lrArgData.addRow();
					lrArgData.setValue("REPORT_REQUEST_NO",  rowsRequest[i].getString(dsRequest.indexOfColumn("REPORT_REQUEST_NO")));
					lrArgData.setValue("USER_NO",  rowsRequest[i].getString(dsRequest.indexOfColumn("USER_NO")));
					lrArgData.setValue("REPORT_NO",  rowsRequest[i].getString(dsRequest.indexOfColumn("REPORT_NO")));
				}
				else
				{
					continue;
				}
				CITDebug.PrintMessages(CITXml.CITData2XML_CR(lrArgData));
				CITDatabase.executeProcedure(strSql, lrArgData, conn);
			}
		}
		catch (Exception ex)
		{
			if (GauceInfo != null) GauceInfo.response.writeException("USER", "900002", "TCC_USER_REPORT_REQUEST 테이블 데이타 갱신 오류" + ex.getMessage());
			throw new Exception("USER-900002:TCC_USER_REPORT_REQUEST 테이블 데이타 갱신 오류 -> " + ex.getMessage());
		}
		
		conn.commit();
	}
	catch (Exception ex)
	{
		if (conn != null) conn.rollback();
		
		if (GauceInfo != null) GauceInfo.response.writeException("SYS", "100001", "페이지 초기화 오류 -> " + ex.getMessage());
		throw new Exception("SYS-100001:페이지 초기화 오류 -> " + ex.getMessage());
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
	    	GauceInfo.response.writeException("SYS", "100002", "페이지 종료 오류 -> " + ex.getMessage());
	    	throw new Exception("SYS-100002:페이지 종료 오류 -> " + ex.getMessage());
	    }
	}
%>