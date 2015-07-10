<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/***************************************************/
/* �� ���α׷��� �뺸�ý���(��) �� ����Դϴ�.
/* �����ۼ��� : ������
/* �����ۼ��� : 2005-01-14
/* ���������� : 
/* ���������� : 
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
		/* �������� */
		strUserNo = session.getAttribute("emp_no") == null ? "" : session.getAttribute("emp_no").toString();
		strUserName = session.getAttribute("user_nm") == null ? "" : session.getAttribute("user_nm").toString();
		
		conn = CITConnectionManager.getConnection(false);

		dsRequest = GauceInfo.request.getGauceDataSet("dsRequest");
		
		if (dsRequest == null) throw new Exception("dsRequest��(��) ��(Null)�Դϴ�.");

		rowsRequest = dsRequest.getDataRows();
	

		// dsRequest�� Insert, Update, Delete
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
			if (GauceInfo != null) GauceInfo.response.writeException("USER", "900002", "TCC_USER_REPORT_REQUEST ���̺� ����Ÿ ���� ����" + ex.getMessage());
			throw new Exception("USER-900002:TCC_USER_REPORT_REQUEST ���̺� ����Ÿ ���� ���� -> " + ex.getMessage());
		}
		
		conn.commit();
	}
	catch (Exception ex)
	{
		if (conn != null) conn.rollback();
		
		if (GauceInfo != null) GauceInfo.response.writeException("SYS", "100001", "������ �ʱ�ȭ ���� -> " + ex.getMessage());
		throw new Exception("SYS-100001:������ �ʱ�ȭ ���� -> " + ex.getMessage());
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
	    	GauceInfo.response.writeException("SYS", "100002", "������ ���� ���� -> " + ex.getMessage());
	    	throw new Exception("SYS-100002:������ ���� ���� -> " + ex.getMessage());
	    }
	}
%>