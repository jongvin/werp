<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : 
/* 2. ����(�ó�����) : Update Page
/* 3. ��  ��  ��  �� : 
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2006-02-07)
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

		CITData lrArgData = new CITData();

		strSql = "{call SP_T_WORK_REPORT_D_ALL(?)}";

		lrArgData.addColumn("PAGE_ID", CITData.VARCHAR2);

		lrArgData.addRow();
		lrArgData.setValue("PAGE_ID",  "t_RSheetReport0006");

		CITDatabase.executeProcedure(strSql, lrArgData);
		
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
					lrArgData = new CITData();
					
					if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_WORK_REPORT_I(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("PAGE_ID", CITData.VARCHAR2);
						lrArgData.addColumn("JOB_SEQ", CITData.NUMBER);
						lrArgData.addColumn("COL_NAME01", CITData.VARCHAR2);
						lrArgData.addColumn("COL_VALUE01", CITData.VARCHAR2);
						lrArgData.addColumn("COL_NAME02", CITData.VARCHAR2);
						lrArgData.addColumn("COL_VALUE02", CITData.VARCHAR2);
						lrArgData.addColumn("COL_NAME03", CITData.VARCHAR2);
						lrArgData.addColumn("COL_VALUE03", CITData.VARCHAR2);
						lrArgData.addColumn("COL_NAME04", CITData.VARCHAR2);
						lrArgData.addColumn("COL_VALUE04", CITData.VARCHAR2);
						lrArgData.addColumn("COL_NAME05", CITData.VARCHAR2);
						lrArgData.addColumn("COL_VALUE05", CITData.VARCHAR2);
						lrArgData.addColumn("COL_NAME06", CITData.VARCHAR2);
						lrArgData.addColumn("COL_VALUE06", CITData.VARCHAR2);
						lrArgData.addColumn("COL_NAME07", CITData.VARCHAR2);
						lrArgData.addColumn("COL_VALUE07", CITData.VARCHAR2);
						lrArgData.addColumn("COL_NAME08", CITData.VARCHAR2);
						lrArgData.addColumn("COL_VALUE08", CITData.VARCHAR2);
						lrArgData.addColumn("COL_NAME09", CITData.VARCHAR2);
						lrArgData.addColumn("COL_VALUE09", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("PAGE_ID", "t_RSheetReport0006");
						lrArgData.setValue("JOB_SEQ", "-1");
						lrArgData.setValue("COL_NAME01", "ACC_CODE");
						lrArgData.setValue("COL_VALUE01", rows[i].getString(dsMAIN.indexOfColumn("ACC_CODE")));
						lrArgData.setValue("COL_NAME02", "");
						lrArgData.setValue("COL_VALUE02", "");
						lrArgData.setValue("COL_NAME03", "");
						lrArgData.setValue("COL_VALUE03", "");
						lrArgData.setValue("COL_NAME04", "");
						lrArgData.setValue("COL_VALUE04", "");
						lrArgData.setValue("COL_NAME05", "");
						lrArgData.setValue("COL_VALUE05", "");
						lrArgData.setValue("COL_NAME06", "");
						lrArgData.setValue("COL_VALUE06", "");
						lrArgData.setValue("COL_NAME07", "");
						lrArgData.setValue("COL_VALUE07", "");
						lrArgData.setValue("COL_NAME08", "");
						lrArgData.setValue("COL_VALUE08", "");
						lrArgData.setValue("COL_NAME09", "");
						lrArgData.setValue("COL_VALUE09", "");
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_WORK_REPORT_D(?,?)}";
						
						lrArgData.addColumn("PAGE_ID", CITData.VARCHAR2);
						lrArgData.addColumn("JOB_SEQ", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("PAGE_ID", rows[i].getString(dsMAIN.indexOfColumn("PAGE_ID")));
						lrArgData.setValue("JOB_SEQ", rows[i].getString(dsMAIN.indexOfColumn("JOB_SEQ")));
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
				GauceInfo.response.writeException("USER", "900001", "T_WORK_REPORT ���̺� ����Ÿ ���� ����" + ex.getMessage());
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
