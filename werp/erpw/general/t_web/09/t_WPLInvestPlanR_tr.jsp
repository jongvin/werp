<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : 
/* 2. ����(�ó�����) : Update Page
/* 3. ��  ��  ��  �� : 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-03-29)
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
	
	String		strCOMP_CODE = "";
	String		strCLSE_ACC_ID = "";
	
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
					
					if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{

						strSql = "{call SP_T_PL_INV_MONTH_AMT(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CLSE_ACC_ID", CITData.VARCHAR2);
						lrArgData.addColumn("KIND_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("LV", CITData.NUMBER);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("PLAN_AMT_01", CITData.NUMBER);
						lrArgData.addColumn("PLAN_AMT_02", CITData.NUMBER);
						lrArgData.addColumn("PLAN_AMT_03", CITData.NUMBER);
						lrArgData.addColumn("PLAN_AMT_04", CITData.NUMBER);
						lrArgData.addColumn("PLAN_AMT_05", CITData.NUMBER);
						lrArgData.addColumn("PLAN_AMT_06", CITData.NUMBER);
						lrArgData.addColumn("PLAN_AMT_07", CITData.NUMBER);
						lrArgData.addColumn("PLAN_AMT_08", CITData.NUMBER);
						lrArgData.addColumn("PLAN_AMT_09", CITData.NUMBER);
						lrArgData.addColumn("PLAN_AMT_10", CITData.NUMBER);
						lrArgData.addColumn("PLAN_AMT_11", CITData.NUMBER);
						lrArgData.addColumn("PLAN_AMT_12", CITData.NUMBER);
						lrArgData.addColumn("FORECAST_AMT_01", CITData.NUMBER);
						lrArgData.addColumn("FORECAST_AMT_02", CITData.NUMBER);
						lrArgData.addColumn("FORECAST_AMT_03", CITData.NUMBER);
						lrArgData.addColumn("FORECAST_AMT_04", CITData.NUMBER);
						lrArgData.addColumn("FORECAST_AMT_05", CITData.NUMBER);
						lrArgData.addColumn("FORECAST_AMT_06", CITData.NUMBER);
						lrArgData.addColumn("FORECAST_AMT_07", CITData.NUMBER);
						lrArgData.addColumn("FORECAST_AMT_08", CITData.NUMBER);
						lrArgData.addColumn("FORECAST_AMT_09", CITData.NUMBER);
						lrArgData.addColumn("FORECAST_AMT_10", CITData.NUMBER);
						lrArgData.addColumn("FORECAST_AMT_11", CITData.NUMBER);
						lrArgData.addColumn("FORECAST_AMT_12", CITData.NUMBER);
						lrArgData.addColumn("EXEC_AMT_01", CITData.NUMBER);
						lrArgData.addColumn("EXEC_AMT_02", CITData.NUMBER);
						lrArgData.addColumn("EXEC_AMT_03", CITData.NUMBER);
						lrArgData.addColumn("EXEC_AMT_04", CITData.NUMBER);
						lrArgData.addColumn("EXEC_AMT_05", CITData.NUMBER);
						lrArgData.addColumn("EXEC_AMT_06", CITData.NUMBER);
						lrArgData.addColumn("EXEC_AMT_07", CITData.NUMBER);
						lrArgData.addColumn("EXEC_AMT_08", CITData.NUMBER);
						lrArgData.addColumn("EXEC_AMT_09", CITData.NUMBER);
						lrArgData.addColumn("EXEC_AMT_10", CITData.NUMBER);
						lrArgData.addColumn("EXEC_AMT_11", CITData.NUMBER);
						lrArgData.addColumn("EXEC_AMT_12", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsMAIN.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("CLSE_ACC_ID", rows[i].getString(dsMAIN.indexOfColumn("CLSE_ACC_ID")));
						lrArgData.setValue("KIND_CODE", rows[i].getString(dsMAIN.indexOfColumn("KIND_CODE")));
						lrArgData.setValue("LV", rows[i].getString(dsMAIN.indexOfColumn("LV")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("PLAN_AMT_01", rows[i].getString(dsMAIN.indexOfColumn("PLAN_AMT_01")));
						lrArgData.setValue("PLAN_AMT_02", rows[i].getString(dsMAIN.indexOfColumn("PLAN_AMT_02")));
						lrArgData.setValue("PLAN_AMT_03", rows[i].getString(dsMAIN.indexOfColumn("PLAN_AMT_03")));
						lrArgData.setValue("PLAN_AMT_04", rows[i].getString(dsMAIN.indexOfColumn("PLAN_AMT_04")));
						lrArgData.setValue("PLAN_AMT_05", rows[i].getString(dsMAIN.indexOfColumn("PLAN_AMT_05")));
						lrArgData.setValue("PLAN_AMT_06", rows[i].getString(dsMAIN.indexOfColumn("PLAN_AMT_06")));
						lrArgData.setValue("PLAN_AMT_07", rows[i].getString(dsMAIN.indexOfColumn("PLAN_AMT_07")));
						lrArgData.setValue("PLAN_AMT_08", rows[i].getString(dsMAIN.indexOfColumn("PLAN_AMT_08")));
						lrArgData.setValue("PLAN_AMT_09", rows[i].getString(dsMAIN.indexOfColumn("PLAN_AMT_09")));
						lrArgData.setValue("PLAN_AMT_10", rows[i].getString(dsMAIN.indexOfColumn("PLAN_AMT_10")));
						lrArgData.setValue("PLAN_AMT_11", rows[i].getString(dsMAIN.indexOfColumn("PLAN_AMT_11")));
						lrArgData.setValue("PLAN_AMT_12", rows[i].getString(dsMAIN.indexOfColumn("PLAN_AMT_12")));
						lrArgData.setValue("FORECAST_AMT_01", rows[i].getString(dsMAIN.indexOfColumn("FORECAST_AMT_01")));
						lrArgData.setValue("FORECAST_AMT_02", rows[i].getString(dsMAIN.indexOfColumn("FORECAST_AMT_02")));
						lrArgData.setValue("FORECAST_AMT_03", rows[i].getString(dsMAIN.indexOfColumn("FORECAST_AMT_03")));
						lrArgData.setValue("FORECAST_AMT_04", rows[i].getString(dsMAIN.indexOfColumn("FORECAST_AMT_04")));
						lrArgData.setValue("FORECAST_AMT_05", rows[i].getString(dsMAIN.indexOfColumn("FORECAST_AMT_05")));
						lrArgData.setValue("FORECAST_AMT_06", rows[i].getString(dsMAIN.indexOfColumn("FORECAST_AMT_06")));
						lrArgData.setValue("FORECAST_AMT_07", rows[i].getString(dsMAIN.indexOfColumn("FORECAST_AMT_07")));
						lrArgData.setValue("FORECAST_AMT_08", rows[i].getString(dsMAIN.indexOfColumn("FORECAST_AMT_08")));
						lrArgData.setValue("FORECAST_AMT_09", rows[i].getString(dsMAIN.indexOfColumn("FORECAST_AMT_09")));
						lrArgData.setValue("FORECAST_AMT_10", rows[i].getString(dsMAIN.indexOfColumn("FORECAST_AMT_10")));
						lrArgData.setValue("FORECAST_AMT_11", rows[i].getString(dsMAIN.indexOfColumn("FORECAST_AMT_11")));
						lrArgData.setValue("FORECAST_AMT_12", rows[i].getString(dsMAIN.indexOfColumn("FORECAST_AMT_12")));
						lrArgData.setValue("EXEC_AMT_01", rows[i].getString(dsMAIN.indexOfColumn("EXEC_AMT_01")));
						lrArgData.setValue("EXEC_AMT_02", rows[i].getString(dsMAIN.indexOfColumn("EXEC_AMT_02")));
						lrArgData.setValue("EXEC_AMT_03", rows[i].getString(dsMAIN.indexOfColumn("EXEC_AMT_03")));
						lrArgData.setValue("EXEC_AMT_04", rows[i].getString(dsMAIN.indexOfColumn("EXEC_AMT_04")));
						lrArgData.setValue("EXEC_AMT_05", rows[i].getString(dsMAIN.indexOfColumn("EXEC_AMT_05")));
						lrArgData.setValue("EXEC_AMT_06", rows[i].getString(dsMAIN.indexOfColumn("EXEC_AMT_06")));
						lrArgData.setValue("EXEC_AMT_07", rows[i].getString(dsMAIN.indexOfColumn("EXEC_AMT_07")));
						lrArgData.setValue("EXEC_AMT_08", rows[i].getString(dsMAIN.indexOfColumn("EXEC_AMT_08")));
						lrArgData.setValue("EXEC_AMT_09", rows[i].getString(dsMAIN.indexOfColumn("EXEC_AMT_09")));
						lrArgData.setValue("EXEC_AMT_10", rows[i].getString(dsMAIN.indexOfColumn("EXEC_AMT_10")));
						lrArgData.setValue("EXEC_AMT_11", rows[i].getString(dsMAIN.indexOfColumn("EXEC_AMT_11")));
						lrArgData.setValue("EXEC_AMT_12", rows[i].getString(dsMAIN.indexOfColumn("EXEC_AMT_12")));
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
				GauceInfo.response.writeException("USER", "900001", "T_BUDG_DEPT_ITEM_H ���̺� ����Ÿ ���� ����" + ex.getMessage());
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
