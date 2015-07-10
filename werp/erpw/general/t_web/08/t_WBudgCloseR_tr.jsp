<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : 
/* 2. ����(�ó�����) : Update Page
/* 3. ��  ��  ��  �� : 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-12-13)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
	CITGauceInfo GauceInfo = null;
	
	GauceDataSet dsMAIN = null;
	GauceDataSet dsCLSE_REQ_ALL = null;
	GauceDataSet dsCLSE_REQ_ALL_CANCEL = null;
	GauceDataSet dsCLSE = null;
	GauceDataSet dsCLSE_ALL = null;
	
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
		if(!CITCommon.isNull(strAct) && strAct.equals("CLSE_REQ_ALL"))
		{
			dsCLSE_REQ_ALL = GauceInfo.request.getGauceDataSet("dsCLSE_REQ_ALL");
			rows = dsCLSE_REQ_ALL.getDataRows();
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					strSql = "{call SP_T_BUDG_CLSE_REQ_ALL(?,?,?,?)}";
					
					lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
					lrArgData.addColumn("CLSE_ACC_ID", CITData.VARCHAR2);
					lrArgData.addColumn("REQ_CLSE_DT", CITData.VARCHAR2);
					lrArgData.addColumn("CRTUSERNO", CITData.NUMBER);
					
					lrArgData.addRow();
					lrArgData.setValue("COMP_CODE", rows[i].getString(dsCLSE_REQ_ALL.indexOfColumn("COMP_CODE")));
					lrArgData.setValue("CLSE_ACC_ID", rows[i].getString(dsCLSE_REQ_ALL.indexOfColumn("CLSE_ACC_ID")));
					lrArgData.setValue("REQ_CLSE_DT", rows[i].getString(dsCLSE_REQ_ALL.indexOfColumn("REQ_CLSE_DT")));
					lrArgData.setValue("CRTUSERNO", strUserNo);
					
					CITDatabase.executeProcedure(strSql, lrArgData, conn);
				}
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001", "T_BUDG_MONTH_AMT_H ���̺� ����Ÿ ���� ����" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
		}
		else if(!CITCommon.isNull(strAct) && strAct.equals("CLSE_REQ_ALL_CANCEL"))
		{
			dsCLSE_REQ_ALL_CANCEL = GauceInfo.request.getGauceDataSet("dsCLSE_REQ_ALL_CANCEL");
			rows = dsCLSE_REQ_ALL_CANCEL.getDataRows();
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					strSql = "{call SP_T_BUDG_CLSE_REQ_ALL_CANCEL(?,?)}";
					
					lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
					lrArgData.addColumn("CLSE_ACC_ID", CITData.VARCHAR2);
					
					lrArgData.addRow();
					lrArgData.setValue("COMP_CODE", rows[i].getString(dsCLSE_REQ_ALL_CANCEL.indexOfColumn("COMP_CODE")));
					lrArgData.setValue("CLSE_ACC_ID", rows[i].getString(dsCLSE_REQ_ALL_CANCEL.indexOfColumn("CLSE_ACC_ID")));
				
					CITDatabase.executeProcedure(strSql, lrArgData, conn);
				}
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001", "T_BUDG_MONTH_AMT_H ���̺� ����Ÿ ���� ����" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
		}
		else if(!CITCommon.isNull(strAct) && strAct.equals("CLSE"))
		{
			dsCLSE = GauceInfo.request.getGauceDataSet("dsCLSE");
			rows = dsCLSE.getDataRows();
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					strSql = "{call SP_T_BUDG_CLSE(?, ?, ?, ?, ?, ?)}";
					
					lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
					lrArgData.addColumn("CLSE_ACC_ID", CITData.VARCHAR2);
					lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
					lrArgData.addColumn("REQ_CLSE_DT", CITData.VARCHAR2);
					lrArgData.addColumn("REQ_CLSE_CLS", CITData.VARCHAR2);
					lrArgData.addColumn("CRTUSERNO", CITData.NUMBER);
					
					lrArgData.addRow();
					
					lrArgData.setValue("COMP_CODE", rows[i].getString(dsCLSE.indexOfColumn("COMP_CODE")));
					lrArgData.setValue("CLSE_ACC_ID", rows[i].getString(dsCLSE.indexOfColumn("CLSE_ACC_ID")));
					lrArgData.setValue("DEPT_CODE", 	rows[i].getString(dsCLSE.indexOfColumn("DEPT_CODE")));
					lrArgData.setValue("REQ_CLSE_DT", rows[i].getString(dsCLSE.indexOfColumn("REQ_CLSE_DT")));
					lrArgData.setValue("REQ_CLSE_CLS", rows[i].getString(dsCLSE.indexOfColumn("REQ_CLSE_CLS")));
					lrArgData.setValue("CRTUSERNO", strUserNo);
					
					CITDatabase.executeProcedure(strSql, lrArgData, conn);
				}
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001", "T_BUDG_MONTH_AMT_H ���̺� ����Ÿ ���� ����" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
		}
		//�ϰ�����/���
		if(!CITCommon.isNull(strAct) && strAct.equals("CLSE_ALL"))
		{
			dsCLSE_ALL = GauceInfo.request.getGauceDataSet("dsCLSE_ALL");
			rows = dsCLSE_ALL.getDataRows();
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					strSql = "{call SP_T_BUDG_CLSE_ALL(?,?,?,?,?)}";
					
					lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
					lrArgData.addColumn("CLSE_ACC_ID", CITData.VARCHAR2);
					lrArgData.addColumn("REQ_CLSE_DT", CITData.VARCHAR2);
					lrArgData.addColumn("REQ_CLSE_CLS", CITData.VARCHAR2);
					lrArgData.addColumn("CRTUSERNO", CITData.NUMBER);
					
					lrArgData.addRow();
					lrArgData.setValue("COMP_CODE", rows[i].getString(dsCLSE_ALL.indexOfColumn("COMP_CODE")));
					lrArgData.setValue("CLSE_ACC_ID", rows[i].getString(dsCLSE_ALL.indexOfColumn("CLSE_ACC_ID")));
					lrArgData.setValue("REQ_CLSE_DT", rows[i].getString(dsCLSE_ALL.indexOfColumn("REQ_CLSE_DT")));
					lrArgData.setValue("REQ_CLSE_CLS", rows[i].getString(dsCLSE_ALL.indexOfColumn("REQ_CLSE_CLS")));
					lrArgData.setValue("CRTUSERNO", strUserNo);
					
					CITDatabase.executeProcedure(strSql, lrArgData, conn);
				}
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001", "T_BUDG_MONTH_AMT_H ���̺� ����Ÿ ���� ����" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
		}
		else if (CITCommon.isNull(strAct))
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
						strSql = "{call SP_T_BUDG_CLOSE_I(?,?,?,?,?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CLSE_ACC_ID", CITData.VARCHAR2);
						lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CRTUSERNO", CITData.NUMBER);
						lrArgData.addColumn("REQ_CLSE_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("REQ_CLSE_DT", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsMAIN.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("CLSE_ACC_ID", rows[i].getString(dsMAIN.indexOfColumn("CLSE_ACC_ID")));
						lrArgData.setValue("DEPT_CODE", rows[i].getString(dsMAIN.indexOfColumn("DEPT_CODE")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("REQ_CLSE_CLS", rows[i].getString(dsMAIN.indexOfColumn("REQ_CLSE_CLS")));
						lrArgData.setValue("REQ_CLSE_DT", rows[i].getString(dsMAIN.indexOfColumn("REQ_CLSE_DT")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_BUDG_CLOSE_U(?,?,?,?,?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CLSE_ACC_ID", CITData.VARCHAR2);
						lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("MODUSERNO", CITData.NUMBER);
						lrArgData.addColumn("REQ_CLSE_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("REQ_CLSE_DT", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsMAIN.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("CLSE_ACC_ID", rows[i].getString(dsMAIN.indexOfColumn("CLSE_ACC_ID")));
						lrArgData.setValue("DEPT_CODE", rows[i].getString(dsMAIN.indexOfColumn("DEPT_CODE")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("REQ_CLSE_CLS", rows[i].getString(dsMAIN.indexOfColumn("REQ_CLSE_CLS")));
						lrArgData.setValue("REQ_CLSE_DT", rows[i].getString(dsMAIN.indexOfColumn("REQ_CLSE_DT")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_BUDG_CLOSE_D(?,?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CLSE_ACC_ID", CITData.VARCHAR2);
						lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsMAIN.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("CLSE_ACC_ID", rows[i].getString(dsMAIN.indexOfColumn("CLSE_ACC_ID")));
						lrArgData.setValue("DEPT_CODE", rows[i].getString(dsMAIN.indexOfColumn("DEPT_CODE")));
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
				GauceInfo.response.writeException("USER", "900001", "t_budg_close ���̺� ����Ÿ ���� ����" + ex.getMessage());
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
