<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : 
/* 2. ����(�ó�����) : Update Page
/* 3. ��  ��  ��  �� : 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-11)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
	CITGauceInfo GauceInfo = null;
	
	GauceDataSet dsMAIN = null;
	GauceDataSet dsCOPY = null;
	GauceDataSet dsREMOVE = null;
	
	GauceDataRow[] rows = null;
	
	String strSql = "";
	String strAct = "";
	String strUserNo = "";
	int		iCount = 0;
	Connection conn = null;
	
	String		strCOMP_CODE = "";
	String		strCLSE_ACC_ID = "";
	String		strDEPT_CODE = "";
	
	try
	{
		GauceInfo = CITCommon.initServerPage(request, response, session);
		/* �������� */
		strUserNo = CITCommon.toKOR((String)session.getAttribute("emp_no"));
		conn = CITConnectionManager.getConnection(false);
		
		strAct = GauceInfo.request.getParameter("ACT");
		if(!CITCommon.isNull(strAct) && strAct.equals("COPY"))
		{
			dsCOPY = GauceInfo.request.getGauceDataSet("dsCOPY");
			rows = dsCOPY.getDataRows();
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					strSql = "{call SP_T_PL_GET_PLAN_SALE_DATA(?,?,?,?)}";
					
					lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
					lrArgData.addColumn("CLSE_ACC_ID", CITData.VARCHAR2);
					lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
					lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);

					lrArgData.addRow();
					lrArgData.setValue("COMP_CODE", rows[i].getString(dsCOPY.indexOfColumn("COMP_CODE")));
					lrArgData.setValue("CLSE_ACC_ID", rows[i].getString(dsCOPY.indexOfColumn("CLSE_ACC_ID")));
					lrArgData.setValue("DEPT_CODE", rows[i].getString(dsCOPY.indexOfColumn("DEPT_CODE")));
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
		else if(!CITCommon.isNull(strAct) && strAct.equals("REMOVE"))
		{
			dsREMOVE = GauceInfo.request.getGauceDataSet("dsREMOVE");
			rows = dsREMOVE.getDataRows();
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					strSql = "{call SP_T_PL_REMOVE_PROJ_PLAN(?,?,?)}";
					
					lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
					lrArgData.addColumn("CLSE_ACC_ID", CITData.VARCHAR2);
					lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);

					lrArgData.addRow();
					lrArgData.setValue("COMP_CODE", rows[i].getString(dsREMOVE.indexOfColumn("COMP_CODE")));
					lrArgData.setValue("CLSE_ACC_ID", rows[i].getString(dsREMOVE.indexOfColumn("CLSE_ACC_ID")));
					lrArgData.setValue("DEPT_CODE", rows[i].getString(dsREMOVE.indexOfColumn("DEPT_CODE")));
					
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
					
					if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						iCount ++;
						strCOMP_CODE = rows[i].getString(dsMAIN.indexOfColumn("COMP_CODE"));
						strCLSE_ACC_ID = rows[i].getString(dsMAIN.indexOfColumn("CLSE_ACC_ID"));
						strDEPT_CODE = rows[i].getString(dsMAIN.indexOfColumn("DEPT_CODE"));


						strSql = "{call SP_T_PL_DEPT_SALE_PLAN(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CLSE_ACC_ID", CITData.VARCHAR2);
						lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("LV", CITData.NUMBER);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("AMT_00", CITData.NUMBER);
						lrArgData.addColumn("AMT_01", CITData.NUMBER);
						lrArgData.addColumn("AMT_02", CITData.NUMBER);
						lrArgData.addColumn("AMT_03", CITData.NUMBER);
						lrArgData.addColumn("AMT_04", CITData.NUMBER);
						lrArgData.addColumn("AMT_05", CITData.NUMBER);
						lrArgData.addColumn("AMT_06", CITData.NUMBER);
						lrArgData.addColumn("AMT_07", CITData.NUMBER);
						lrArgData.addColumn("AMT_08", CITData.NUMBER);
						lrArgData.addColumn("AMT_09", CITData.NUMBER);
						lrArgData.addColumn("AMT_10", CITData.NUMBER);
						lrArgData.addColumn("AMT_11", CITData.NUMBER);
						lrArgData.addColumn("AMT_12", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsMAIN.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("CLSE_ACC_ID", rows[i].getString(dsMAIN.indexOfColumn("CLSE_ACC_ID")));
						lrArgData.setValue("DEPT_CODE", rows[i].getString(dsMAIN.indexOfColumn("DEPT_CODE")));
						lrArgData.setValue("LV", rows[i].getString(dsMAIN.indexOfColumn("LV")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("AMT_00", rows[i].getString(dsMAIN.indexOfColumn("AMT_00")));
						lrArgData.setValue("AMT_01", rows[i].getString(dsMAIN.indexOfColumn("AMT_01")));
						lrArgData.setValue("AMT_02", rows[i].getString(dsMAIN.indexOfColumn("AMT_02")));
						lrArgData.setValue("AMT_03", rows[i].getString(dsMAIN.indexOfColumn("AMT_03")));
						lrArgData.setValue("AMT_04", rows[i].getString(dsMAIN.indexOfColumn("AMT_04")));
						lrArgData.setValue("AMT_05", rows[i].getString(dsMAIN.indexOfColumn("AMT_05")));
						lrArgData.setValue("AMT_06", rows[i].getString(dsMAIN.indexOfColumn("AMT_06")));
						lrArgData.setValue("AMT_07", rows[i].getString(dsMAIN.indexOfColumn("AMT_07")));
						lrArgData.setValue("AMT_08", rows[i].getString(dsMAIN.indexOfColumn("AMT_08")));
						lrArgData.setValue("AMT_09", rows[i].getString(dsMAIN.indexOfColumn("AMT_09")));
						lrArgData.setValue("AMT_10", rows[i].getString(dsMAIN.indexOfColumn("AMT_10")));
						lrArgData.setValue("AMT_11", rows[i].getString(dsMAIN.indexOfColumn("AMT_11")));
						lrArgData.setValue("AMT_12", rows[i].getString(dsMAIN.indexOfColumn("AMT_12")));
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
