<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : 
/* 2. ����(�ó�����) : Update Page
/* 3. ��  ��  ��  �� : 
/* 4. ��  ��  ��  �� : �־�ȸ �ۼ�(2005-11-23)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
	CITGauceInfo GauceInfo = null;
	
	GauceDataSet dsMAIN = null;
	
	GauceDataRow[] rows = null;
	
	String strSql = "";
	String strAct = "";
	String strUserNo = "";
	Connection conn = null;
	
	try
	{
		GauceInfo = CITCommon.initServerPage(request, response, session);
		/* �������� */
		strUserNo = CITCommon.toKOR((String)session.getAttribute("emp_no"));
		conn = CITConnectionManager.getConnection(false);
		
		strAct = GauceInfo.request.getParameter("ACT");
		
		if (CITCommon.isNull(strAct))
		{
			dsMAIN = GauceInfo.request.getGauceDataSet("dsMAIN");
			
			if (dsMAIN == null) throw new Exception("dsMAIN��(��) ��(Null)�Դϴ�.");
			
			rows = dsMAIN.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					if (rows[i].getJobType() == GauceDataRow.TB_JOB_INSERT)
					{
						strSql = "{call SP_TB_WT_ITEM_I(?,?,?,?,?,?)}";

						lrArgData.addColumn("COM_ID", 			CITData.VARCHAR2);
						lrArgData.addColumn("ITEM_CODE", 		CITData.VARCHAR2);
						lrArgData.addColumn("ITEM_NAME", 		CITData.VARCHAR2);
						lrArgData.addColumn("ITEM_SIZE", 		CITData.VARCHAR2);
						lrArgData.addColumn("INSERT_EMP", 	CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("COM_ID", 				rows[i].getString(dsMAIN.indexOfColumn("COM_ID")));
						lrArgData.setValue("ITEM_CODE", 		rows[i].getString(dsMAIN.indexOfColumn("ITEM_CODE")));
						lrArgData.setValue("ITEM_NAME", 		rows[i].getString(dsMAIN.indexOfColumn("ITEM_NAME")));
						lrArgData.setValue("ITEM_SIZE", 		rows[i].getString(dsMAIN.indexOfColumn("ITEM_SIZE")));
						lrArgData.setValue("INSERT_EMP", 		strUserNo);
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_TB_WT_ITEM_U(?,?,?,?,?,?)}";
						
						lrArgData.addColumn("COM_ID", 			CITData.VARCHAR2);
						lrArgData.addColumn("ITEM_CODE", 		CITData.VARCHAR2);
						lrArgData.addColumn("ITEM_NAME", 		CITData.VARCHAR2);
						lrArgData.addColumn("ITEM_SIZE", 		CITData.VARCHAR2);
						lrArgData.addColumn("UPDATE_EMP", 	CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("COM_ID", 				rows[i].getString(dsMAIN.indexOfColumn("COM_ID")));
						lrArgData.setValue("ITEM_CODE", 		rows[i].getString(dsMAIN.indexOfColumn("ITEM_CODE")));
						lrArgData.setValue("ITEM_NAME", 		rows[i].getString(dsMAIN.indexOfColumn("ITEM_NAME")));
						lrArgData.setValue("ITEM_SIZE", 		rows[i].getString(dsMAIN.indexOfColumn("ITEM_SIZE")));
						lrArgData.setValue("UPDATE_EMP", 		strUserNo);
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_TB_WT_ITEM_D(?,?)}";
						
						lrArgData.addColumn("COM_ID", 		CITData.VARCHAR2);
						lrArgData.addColumn("ITEM_CODE", 	CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("COM_ID", 			rows[i].getString(dsMAIN.indexOfColumn("COM_ID")));
						lrArgData.setValue("ITEM_CODE", 	rows[i].getString(dsMAIN.indexOfColumn("ITEM_CODE")));
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
				GauceInfo.response.writeException("USER", "900001", "TB_WT_SECT ���̺� ����Ÿ ���� ����" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
		}
		conn.commit();
	}
	catch (Exception ex)
	{
		if (conn != null) conn.rollback();
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
