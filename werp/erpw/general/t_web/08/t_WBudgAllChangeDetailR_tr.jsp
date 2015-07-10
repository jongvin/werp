<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : 
/* 2. ����(�ó�����) : Update Page
/* 3. ��  ��  ��  ��   : 
/* 4. ��  ��  ��  ��   : ����� �ۼ�(2006-01-05)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
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
		/* �������� */
		strUserNo = CITCommon.toKOR((String)session.getAttribute("emp_no"));
		conn = CITConnectionManager.getConnection(false);
		
		strAct = GauceInfo.request.getParameter("ACT");
		
		if(!CITCommon.isNull(strAct) && strAct.equals("BUDG_ALL_CHANGE"))
		{
			dsBUDG_ALL_CHANGE = GauceInfo.request.getGauceDataSet("dsBUDG_ALL_CHANGE");
			
			if (dsBUDG_ALL_CHANGE == null) throw new Exception("dsBUDG_ALL_CHANGE��(��) ��(Null)�Դϴ�.");
			
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
				GauceInfo.response.writeException("USER", "900001", "T_BUDG_ALL_CHANGE ���̺� ����Ÿ ���� ����" + ex.getMessage());
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
