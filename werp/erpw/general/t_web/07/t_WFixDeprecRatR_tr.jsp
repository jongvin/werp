<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : 
/* 2. ����(�ó�����) : Update Page
/* 3. ��  ��  ��  �� : 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-16)
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
						strSql = "{call SP_T_FIX_DEPREC_RAT_I(?,?,?,?,?)}";
						
						lrArgData.addColumn("SRVLIFE", CITData.NUMBER);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("DEPREC_RAT5", CITData.NUMBER);
						lrArgData.addColumn("DEPREC_RAT10", CITData.NUMBER);
						lrArgData.addColumn("DEPREC_AMT", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("SRVLIFE", rows[i].getString(dsMAIN.indexOfColumn("SRVLIFE")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("DEPREC_RAT5", rows[i].getString(dsMAIN.indexOfColumn("DEPREC_RAT5")));
						lrArgData.setValue("DEPREC_RAT10", rows[i].getString(dsMAIN.indexOfColumn("DEPREC_RAT10")));
						lrArgData.setValue("DEPREC_AMT", rows[i].getString(dsMAIN.indexOfColumn("DEPREC_AMT")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_FIX_DEPREC_RAT_U(?,?,?,?,?)}";
						
						lrArgData.addColumn("SRVLIFE", CITData.NUMBER);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("DEPREC_RAT5", CITData.NUMBER);
						lrArgData.addColumn("DEPREC_RAT10", CITData.NUMBER);
						lrArgData.addColumn("DEPREC_AMT", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("SRVLIFE", rows[i].getString(dsMAIN.indexOfColumn("SRVLIFE")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("DEPREC_RAT5", rows[i].getString(dsMAIN.indexOfColumn("DEPREC_RAT5")));
						lrArgData.setValue("DEPREC_RAT10", rows[i].getString(dsMAIN.indexOfColumn("DEPREC_RAT10")));
						lrArgData.setValue("DEPREC_AMT", rows[i].getString(dsMAIN.indexOfColumn("DEPREC_AMT")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_FIX_DEPREC_RAT_D(?)}";
						
						lrArgData.addColumn("SRVLIFE", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("SRVLIFE", rows[i].getString(dsMAIN.indexOfColumn("SRVLIFE")));
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
				GauceInfo.response.writeException("USER", "900001", "T_FIX_DEPREC_RAT ���̺� ����Ÿ ���� ����" + ex.getMessage());
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
