<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : t_WSessionStateR_tr.jsp(���Ǻ��� ���)
/* 2. ����(�ó�����) : Update Page
/* 3. ��  ��  ��  �� : 
/* 4. ��  ��  ��  �� : ������ �ۼ�(2005-11-25)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
	CITGauceInfo GauceInfo = null;
	
	GauceDataSet dsSession = null;
	
	GauceDataRow[] rowsSession = null;
	
	Connection conn = null;
	
	String strSql = "";
	String strAct = "";
	String strUserNo = "";
	
	try
	{
		GauceInfo = CITCommon.initServerPage(request, response, session);
		
		conn = CITConnectionManager.getConnection(false);
		
		/* �������� */
		strUserNo = CITCommon.toKOR((String)session.getAttribute("emp_no"));
		
		strAct = GauceInfo.request.getParameter("ACT");
		
		if (CITCommon.isNull(strAct))
		{
			dsSession = GauceInfo.request.getGauceDataSet("dsSession");
			
			if (dsSession == null) throw new Exception("dsSession��(��) ��(Null)�Դϴ�.");
			
			rowsSession = dsSession.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	rowsSession.length; i++)
				{
					String lsKey = rowsSession[i].getString(dsSession.indexOfColumn("SESSION_NAME"));
					String lsValue = rowsSession[i].getString(dsSession.indexOfColumn("SESSION_VALUE"));
					
					if (rowsSession[i].getJobType() == GauceDataRow.TB_JOB_INSERT)
					{
						session.setAttribute(lsKey, lsValue);
					}
					else if (rowsSession[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						session.setAttribute(lsKey, lsValue);
					}
					else if (rowsSession[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						session.removeAttribute(lsKey);
					}
					else
					{
						continue;
					}
				}
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001", "Session ���� ���� ����" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
		}
	}
	catch (Exception ex)
	{
		if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
		GauceInfo.response.writeException("SYS", "100001", "������ �ʱ�ȭ ���� -> " + ex.getMessage());
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
	    	GauceInfo.response.writeException("SYS", "100002", "������ ���� ���� -> " + ex.getMessage());
	    }
	}
%>
