<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*, java.util.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : t_WSessionStateR_q.jsp(���Ǻ��� ���)
/* 2. ����(�ó�����) : Select Page
/* 3. ��  ��  ��  �� : 
/* 4. ��  ��  ��  �� : ������ �ۼ�(2005-11-25)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
 
	CITGauceInfo GauceInfo = null;
	
	CITData lrReturnData = null;
	GauceDataSet lrDataset = null;

	String	strSql = "";
	String	strAct = "";
	
	try
	{
		GauceInfo = CITCommon.initServerPage(request, response, session);
		
		CITData lrArgData = new CITData();
		
		strAct = CITCommon.toKOR(request.getParameter("ACT"));
		
		if (strAct.equals("MAIN"))
		{
			String lsSESSION_NAME = CITCommon.toKOR(request.getParameter("SESSION_NAME"));
			Enumeration emKeys = session.getAttributeNames();
			String lsKey = "";
			Object loValue = null;
			
			try
			{
				lrArgData.addColumn("SESSION_NAME", CITData.VARCHAR2);
				lrArgData.addColumn("SESSION_VALUE", CITData.VARCHAR2);
				
				while (emKeys.hasMoreElements())
				{
					lsKey = emKeys.nextElement().toString();
					loValue = session.getAttribute(lsKey);
					
					if (!CITCommon.isNull(lsSESSION_NAME) && lsKey.indexOf(lsSESSION_NAME) < 0) continue;
					
					lrArgData.addRow();
					
					lrArgData.setValue("SESSION_NAME", lsKey);
					lrArgData.setValue("SESSION_VALUE", loValue == null ? "" : loValue.toString());
				}
				
				lrArgData.setKey("SESSION_NAME", true);
				
				lrDataset = CITCommon.toGauceDataSet(lrArgData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001","Session ���� List ����-> "+ ex.getMessage());
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
			CITCommon.finalServerPage(GauceInfo);
		}
		catch (Exception ex)
		{
			if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
			GauceInfo.response.writeException("SYS", "100002", "������ ���� ���� -> " + ex.getMessage());
		}
	}
%>