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
	
	GauceDataSet dsLIST = null;
	
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
			dsLIST = GauceInfo.request.getGauceDataSet("dsLIST");
			
			if (dsLIST == null) throw new Exception("dsLIST��(��) ��(Null)�Դϴ�.");
			
			rows = dsLIST.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					if (rows[i].getJobType() == GauceDataRow.TB_JOB_INSERT)
					{
						strSql = "{call SP_T_CUST_ACCNO_CODE_I(?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("CUST_SEQ", CITData.NUMBER);
						lrArgData.addColumn("ACCNO", CITData.VARCHAR2);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("BANK_MAIN_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("ACCNO_OWNER", CITData.VARCHAR2);
						lrArgData.addColumn("ACCNO_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("USE_TG", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("CUST_SEQ", rows[i].getString(dsLIST.indexOfColumn("CUST_SEQ")));
						lrArgData.setValue("ACCNO", rows[i].getString(dsLIST.indexOfColumn("ACCNO")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("BANK_MAIN_CODE", rows[i].getString(dsLIST.indexOfColumn("BANK_MAIN_CODE")));
						lrArgData.setValue("ACCNO_OWNER", rows[i].getString(dsLIST.indexOfColumn("ACCNO_OWNER")));
						lrArgData.setValue("ACCNO_CLS", rows[i].getString(dsLIST.indexOfColumn("ACCNO_CLS")));
						lrArgData.setValue("USE_TG", rows[i].getString(dsLIST.indexOfColumn("USE_TG")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_CUST_ACCNO_CODE_U(?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("CUST_SEQ", CITData.NUMBER);
						lrArgData.addColumn("ACCNO", CITData.VARCHAR2);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("BANK_MAIN_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("ACCNO_OWNER", CITData.VARCHAR2);
						lrArgData.addColumn("ACCNO_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("USE_TG", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("CUST_SEQ", rows[i].getString(dsLIST.indexOfColumn("CUST_SEQ")));
						lrArgData.setValue("ACCNO", rows[i].getString(dsLIST.indexOfColumn("ACCNO")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("BANK_MAIN_CODE", rows[i].getString(dsLIST.indexOfColumn("BANK_MAIN_CODE")));
						lrArgData.setValue("ACCNO_OWNER", rows[i].getString(dsLIST.indexOfColumn("ACCNO_OWNER")));
						lrArgData.setValue("ACCNO_CLS", rows[i].getString(dsLIST.indexOfColumn("ACCNO_CLS")));
						lrArgData.setValue("USE_TG", rows[i].getString(dsLIST.indexOfColumn("USE_TG")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_CUST_ACCNO_CODE_D(?,?)}";
						
						lrArgData.addColumn("CUST_SEQ", CITData.NUMBER);
						lrArgData.addColumn("ACCNO", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("CUST_SEQ", rows[i].getString(dsLIST.indexOfColumn("CUST_SEQ")));
						lrArgData.setValue("ACCNO", rows[i].getString(dsLIST.indexOfColumn("ACCNO")));
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
				GauceInfo.response.writeException("USER", "900001", "T_CUST_ACCNO_CODE ���̺� ����Ÿ ���� ����" + ex.getMessage());
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
