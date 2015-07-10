<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : 
/* 2. ����(�ó�����) : Update Page
/* 3. ��  ��  ��  �� : 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-11-24)
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
						strSql = "{call SP_T_PAY_STOP_HISTORY_I(?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("CUST_SEQ", CITData.NUMBER);
						lrArgData.addColumn("PAY_STOP_SEQ", CITData.NUMBER);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("PAY_STOP_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("PAY_STOPSTR_DT", CITData.VARCHAR2);
						lrArgData.addColumn("PAY_STOPEND_DT", CITData.VARCHAR2);
						lrArgData.addColumn("PAY_STOPSTR_MEMO", CITData.VARCHAR2);
						lrArgData.addColumn("PAY_STOPEND_MEMO", CITData.VARCHAR2);
						lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("PAY_STOP_AMT", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("CUST_SEQ", rows[i].getString(dsMAIN.indexOfColumn("CUST_SEQ")));
						lrArgData.setValue("PAY_STOP_SEQ", rows[i].getString(dsMAIN.indexOfColumn("PAY_STOP_SEQ")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("PAY_STOP_CLS", rows[i].getString(dsMAIN.indexOfColumn("PAY_STOP_CLS")));
						lrArgData.setValue("PAY_STOPSTR_DT", rows[i].getString(dsMAIN.indexOfColumn("PAY_STOPSTR_DT")));
						lrArgData.setValue("PAY_STOPEND_DT", rows[i].getString(dsMAIN.indexOfColumn("PAY_STOPEND_DT")));
						lrArgData.setValue("PAY_STOPSTR_MEMO", rows[i].getString(dsMAIN.indexOfColumn("PAY_STOPSTR_MEMO")));
						lrArgData.setValue("PAY_STOPEND_MEMO", rows[i].getString(dsMAIN.indexOfColumn("PAY_STOPEND_MEMO")));
						lrArgData.setValue("DEPT_CODE", rows[i].getString(dsMAIN.indexOfColumn("DEPT_CODE")));
						lrArgData.setValue("PAY_STOP_AMT", rows[i].getString(dsMAIN.indexOfColumn("PAY_STOP_AMT")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_PAY_STOP_HISTORY_U(?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("CUST_SEQ", CITData.NUMBER);
						lrArgData.addColumn("PAY_STOP_SEQ", CITData.NUMBER);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("PAY_STOP_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("PAY_STOPSTR_DT", CITData.VARCHAR2);
						lrArgData.addColumn("PAY_STOPEND_DT", CITData.VARCHAR2);
						lrArgData.addColumn("PAY_STOPSTR_MEMO", CITData.VARCHAR2);
						lrArgData.addColumn("PAY_STOPEND_MEMO", CITData.VARCHAR2);
						lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("PAY_STOP_AMT", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("CUST_SEQ", rows[i].getString(dsMAIN.indexOfColumn("CUST_SEQ")));
						lrArgData.setValue("PAY_STOP_SEQ", rows[i].getString(dsMAIN.indexOfColumn("PAY_STOP_SEQ")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("PAY_STOP_CLS", rows[i].getString(dsMAIN.indexOfColumn("PAY_STOP_CLS")));
						lrArgData.setValue("PAY_STOPSTR_DT", rows[i].getString(dsMAIN.indexOfColumn("PAY_STOPSTR_DT")));
						lrArgData.setValue("PAY_STOPEND_DT", rows[i].getString(dsMAIN.indexOfColumn("PAY_STOPEND_DT")));
						lrArgData.setValue("PAY_STOPSTR_MEMO", rows[i].getString(dsMAIN.indexOfColumn("PAY_STOPSTR_MEMO")));
						lrArgData.setValue("PAY_STOPEND_MEMO", rows[i].getString(dsMAIN.indexOfColumn("PAY_STOPEND_MEMO")));
						lrArgData.setValue("DEPT_CODE", rows[i].getString(dsMAIN.indexOfColumn("DEPT_CODE")));
						lrArgData.setValue("PAY_STOP_AMT", rows[i].getString(dsMAIN.indexOfColumn("PAY_STOP_AMT")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_PAY_STOP_HISTORY_D(?,?)}";
						
						lrArgData.addColumn("CUST_SEQ", CITData.NUMBER);
						lrArgData.addColumn("PAY_STOP_SEQ", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("CUST_SEQ", rows[i].getString(dsMAIN.indexOfColumn("CUST_SEQ")));
						lrArgData.setValue("PAY_STOP_SEQ", rows[i].getString(dsMAIN.indexOfColumn("PAY_STOP_SEQ")));
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
				GauceInfo.response.writeException("USER", "900001", "T_PAY_STOP_HISTORY ���̺� ����Ÿ ���� ����" + ex.getMessage());
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
