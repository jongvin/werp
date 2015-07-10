<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : 
/* 2. ����(�ó�����) : Update Page
/* 3. ��  ��  ��  �� : 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-11-28)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
	CITGauceInfo GauceInfo = null;
	
	GauceDataSet dsMAIN = null;
	GauceDataSet dsLIST = null;
	GauceDataRow[] rowsMAIN = null;
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
		
		///if (CITCommon.isNull(strAct))
		//{
			dsMAIN = GauceInfo.request.getGauceDataSet("dsMAIN");
			dsLIST = GauceInfo.request.getGauceDataSet("dsLIST");
			
			if (dsMAIN == null) throw new Exception("dsMAIN��(��) ��(Null)�Դϴ�.");
			if (dsLIST == null) throw new Exception("dsLIST��(��) ��(Null)�Դϴ�.");
			
			rowsMAIN = dsMAIN.getDataRows();
			rowsLIST = dsLIST.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	rowsMAIN.length; i++)
				{
					CITData lrArgData = new CITData();
					
					if (rowsMAIN[i].getJobType() == GauceDataRow.TB_JOB_INSERT)
					{
						strSql = "{call SP_T_MONTH_CLOSE_I(?,?,?,?,?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CLSE_ACC_ID", CITData.VARCHAR2);
						lrArgData.addColumn("CLSE_MONTH", CITData.VARCHAR2);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("CLSE_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("CLSE_DT", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("COMP_CODE", rowsMAIN[i].getString(dsMAIN.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("CLSE_ACC_ID", rowsMAIN[i].getString(dsMAIN.indexOfColumn("CLSE_ACC_ID")));
						lrArgData.setValue("CLSE_MONTH", rowsMAIN[i].getString(dsMAIN.indexOfColumn("CLSE_MONTH")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("CLSE_CLS", rowsMAIN[i].getString(dsMAIN.indexOfColumn("CLSE_CLS")));
						lrArgData.setValue("CLSE_DT", rowsMAIN[i].getString(dsMAIN.indexOfColumn("CLSE_DT")));
					}
					else if (rowsMAIN[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_MONTH_CLOSE_U(?,?,?,?,?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CLSE_ACC_ID", CITData.VARCHAR2);
						lrArgData.addColumn("CLSE_MONTH", CITData.VARCHAR2);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("CLSE_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("CLSE_DT", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("COMP_CODE", rowsMAIN[i].getString(dsMAIN.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("CLSE_ACC_ID", rowsMAIN[i].getString(dsMAIN.indexOfColumn("CLSE_ACC_ID")));
						lrArgData.setValue("CLSE_MONTH", rowsMAIN[i].getString(dsMAIN.indexOfColumn("CLSE_MONTH")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("CLSE_CLS", rowsMAIN[i].getString(dsMAIN.indexOfColumn("CLSE_CLS")));
						lrArgData.setValue("CLSE_DT", rowsMAIN[i].getString(dsMAIN.indexOfColumn("CLSE_DT")));
					}
					else if (rowsMAIN[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_MONTH_CLOSE_D(?,?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CLSE_ACC_ID", CITData.VARCHAR2);
						lrArgData.addColumn("CLSE_MONTH", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("COMP_CODE", rowsMAIN[i].getString(dsMAIN.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("CLSE_ACC_ID", rowsMAIN[i].getString(dsMAIN.indexOfColumn("CLSE_ACC_ID")));
						lrArgData.setValue("CLSE_MONTH", rowsMAIN[i].getString(dsMAIN.indexOfColumn("CLSE_MONTH")));
					}
					else
					{
						continue;
					}//end if
					
					CITDatabase.executeProcedure(strSql, lrArgData, conn);
				}//end for
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001", "T_MONTH_CLOSE ���̺� ����Ÿ ���� ����" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
		
		
			try
			{
				for	(int i = 0;	i <	rowsLIST.length; i++)
				{
					CITData lrArgData = new CITData();
					
					if (rowsLIST[i].getJobType() == GauceDataRow.TB_JOB_INSERT)
					{
						strSql = "{call SP_T_DAY_CLOSE_I(?,?,?,?,?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CLSE_ACC_ID", CITData.VARCHAR2);
						lrArgData.addColumn("CLSE_MONTH", CITData.VARCHAR2);
						lrArgData.addColumn("CLSE_DAY", CITData.VARCHAR2);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("CLSE_CLS", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("COMP_CODE", rowsLIST[i].getString(dsLIST.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("CLSE_ACC_ID", rowsLIST[i].getString(dsLIST.indexOfColumn("CLSE_ACC_ID")));
						lrArgData.setValue("CLSE_MONTH", rowsLIST[i].getString(dsLIST.indexOfColumn("CLSE_MONTH")));
						lrArgData.setValue("CLSE_DAY", rowsLIST[i].getString(dsLIST.indexOfColumn("CLSE_DAY")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("CLSE_CLS", rowsLIST[i].getString(dsLIST.indexOfColumn("CLSE_CLS")));
					}
					else if (rowsLIST[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_DAY_CLOSE_U(?,?,?,?,?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CLSE_ACC_ID", CITData.VARCHAR2);
						lrArgData.addColumn("CLSE_MONTH", CITData.VARCHAR2);
						lrArgData.addColumn("CLSE_DAY", CITData.VARCHAR2);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("CLSE_CLS", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("COMP_CODE", rowsLIST[i].getString(dsLIST.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("CLSE_ACC_ID", rowsLIST[i].getString(dsLIST.indexOfColumn("CLSE_ACC_ID")));
						lrArgData.setValue("CLSE_MONTH", rowsLIST[i].getString(dsLIST.indexOfColumn("CLSE_MONTH")));
						lrArgData.setValue("CLSE_DAY", rowsLIST[i].getString(dsLIST.indexOfColumn("CLSE_DAY")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("CLSE_CLS", rowsLIST[i].getString(dsLIST.indexOfColumn("CLSE_CLS")));
					}
					else if (rowsLIST[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_DAY_CLOSE_D(?,?,?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CLSE_ACC_ID", CITData.VARCHAR2);
						lrArgData.addColumn("CLSE_MONTH", CITData.VARCHAR2);
						lrArgData.addColumn("CLSE_DAY", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("COMP_CODE", rowsLIST[i].getString(dsLIST.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("CLSE_ACC_ID", rowsLIST[i].getString(dsLIST.indexOfColumn("CLSE_ACC_ID")));
						lrArgData.setValue("CLSE_MONTH", rowsLIST[i].getString(dsLIST.indexOfColumn("CLSE_MONTH")));
						lrArgData.setValue("CLSE_DAY", rowsLIST[i].getString(dsLIST.indexOfColumn("CLSE_DAY")));
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
				GauceInfo.response.writeException("USER", "900001", "T_DAY_CLOSE ���̺� ����Ÿ ���� ����" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
		//}
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
