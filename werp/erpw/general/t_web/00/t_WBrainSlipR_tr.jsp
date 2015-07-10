<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : 
/* 2. ����(�ó�����) : Update Page
/* 3. ��  ��  ��  �� : 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-12-06)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
	CITGauceInfo GauceInfo = null;
	
	GauceDataSet dsMAIN = null;
	GauceDataSet dsLIST = null;
	
	GauceDataRow[] rows = null;
	GauceDataRow[] rowsLIST = null;
	
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
			dsLIST = GauceInfo.request.getGauceDataSet("dsLIST");
			
			if (dsMAIN == null) throw new Exception("dsMAIN��(��) ��(Null)�Դϴ�.");
			if (dsLIST == null) throw new Exception("dsLIST��(��) ��(Null)�Դϴ�.");
			
			rows = dsMAIN.getDataRows();
			rowsLIST = dsLIST.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					if (rows[i].getJobType() == GauceDataRow.TB_JOB_INSERT)
					{
						strSql = "{call SP_T_BRAIN_SLIP_I(?,?,?)}";
						
						lrArgData.addColumn("BRAIN_SLIP_SEQ1", CITData.NUMBER);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("BRAIN_SLIP_NAME1", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("BRAIN_SLIP_SEQ1", rows[i].getString(dsMAIN.indexOfColumn("BRAIN_SLIP_SEQ1")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("BRAIN_SLIP_NAME1", rows[i].getString(dsMAIN.indexOfColumn("BRAIN_SLIP_NAME1")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_BRAIN_SLIP_U(?,?,?)}";
						
						lrArgData.addColumn("BRAIN_SLIP_SEQ1", CITData.NUMBER);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("BRAIN_SLIP_NAME1", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("BRAIN_SLIP_SEQ1", rows[i].getString(dsMAIN.indexOfColumn("BRAIN_SLIP_SEQ1")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("BRAIN_SLIP_NAME1", rows[i].getString(dsMAIN.indexOfColumn("BRAIN_SLIP_NAME1")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_BRAIN_SLIP_D(?)}";
						
						lrArgData.addColumn("BRAIN_SLIP_SEQ1", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("BRAIN_SLIP_SEQ1", rows[i].getString(dsMAIN.indexOfColumn("BRAIN_SLIP_SEQ1")));
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
				GauceInfo.response.writeException("USER", "900001", "T_BRAIN_SLIP ���̺� ����Ÿ ���� ����" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
			
			try
			{
				for	(int i = 0;	i <	rowsLIST.length; i++)
				{
					CITData lrArgData = new CITData();
					
					if (rowsLIST[i].getJobType() == GauceDataRow.TB_JOB_INSERT)
					{
						strSql = "{call SP_T_BRAIN_SLIP_HEAD_I(?,?,?,?,?)}";
						
						lrArgData.addColumn("BRAIN_SLIP_SEQ1", CITData.NUMBER);
						lrArgData.addColumn("BRAIN_SLIP_SEQ2", CITData.NUMBER);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("BRAIN_SLIP_NAME2", CITData.VARCHAR2);
						lrArgData.addColumn("USE_CLS", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("BRAIN_SLIP_SEQ1", rowsLIST[i].getString(dsLIST.indexOfColumn("BRAIN_SLIP_SEQ1")));
						lrArgData.setValue("BRAIN_SLIP_SEQ2", rowsLIST[i].getString(dsLIST.indexOfColumn("BRAIN_SLIP_SEQ2")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("BRAIN_SLIP_NAME2", rowsLIST[i].getString(dsLIST.indexOfColumn("BRAIN_SLIP_NAME2")));
						lrArgData.setValue("USE_CLS", rowsLIST[i].getString(dsLIST.indexOfColumn("USE_CLS")));
					}
					else if (rowsLIST[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_BRAIN_SLIP_HEAD_U(?,?,?,?,?)}";
						
						lrArgData.addColumn("BRAIN_SLIP_SEQ1", CITData.NUMBER);
						lrArgData.addColumn("BRAIN_SLIP_SEQ2", CITData.NUMBER);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("BRAIN_SLIP_NAME2", CITData.VARCHAR2);
						lrArgData.addColumn("USE_CLS", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("BRAIN_SLIP_SEQ1", rowsLIST[i].getString(dsLIST.indexOfColumn("BRAIN_SLIP_SEQ1")));
						lrArgData.setValue("BRAIN_SLIP_SEQ2", rowsLIST[i].getString(dsLIST.indexOfColumn("BRAIN_SLIP_SEQ2")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("BRAIN_SLIP_NAME2", rowsLIST[i].getString(dsLIST.indexOfColumn("BRAIN_SLIP_NAME2")));
						lrArgData.setValue("USE_CLS", rowsLIST[i].getString(dsLIST.indexOfColumn("USE_CLS")));
					}
					else if (rowsLIST[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_BRAIN_SLIP_HEAD_D(?,?)}";
						
						lrArgData.addColumn("BRAIN_SLIP_SEQ1", CITData.NUMBER);
						lrArgData.addColumn("BRAIN_SLIP_SEQ2", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("BRAIN_SLIP_SEQ1", rowsLIST[i].getString(dsLIST.indexOfColumn("BRAIN_SLIP_SEQ1")));
						lrArgData.setValue("BRAIN_SLIP_SEQ2", rowsLIST[i].getString(dsLIST.indexOfColumn("BRAIN_SLIP_SEQ2")));
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
				GauceInfo.response.writeException("USER", "900001", "T_BRAIN_SLIP_HEAD ���̺� ����Ÿ ���� ����" + ex.getMessage());
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
