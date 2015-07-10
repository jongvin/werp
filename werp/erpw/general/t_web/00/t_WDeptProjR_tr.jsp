<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : 
/* 2. ����(�ó�����) : Update Page
/* 3. ��  ��  ��  �� : 
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2006-01-06)
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
						strSql = "{call SP_T_DEPT_CODE_PROJ_I(?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("ACC_CLOSE_DT", CITData.VARCHAR2);
						lrArgData.addColumn("BUDG_APPL_DT", CITData.VARCHAR2);
						lrArgData.addColumn("CONS_AMT", CITData.NUMBER);
						lrArgData.addColumn("BUDG_AMT", CITData.NUMBER);
						lrArgData.addColumn("AS_AMT", CITData.NUMBER);
						lrArgData.addColumn("COST_DESC_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("COST_GUESS_AMT", CITData.NUMBER);
						lrArgData.addColumn("F_CONS_AMT", CITData.NUMBER);
						lrArgData.addColumn("F_BUDG_AMT", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("DEPT_CODE", rows[i].getString(dsMAIN.indexOfColumn("DEPT_CODE")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("ACC_CLOSE_DT", rows[i].getString(dsMAIN.indexOfColumn("ACC_CLOSE_DT")));
						lrArgData.setValue("BUDG_APPL_DT", rows[i].getString(dsMAIN.indexOfColumn("BUDG_APPL_DT")));
						lrArgData.setValue("CONS_AMT", rows[i].getString(dsMAIN.indexOfColumn("CONS_AMT")));
						lrArgData.setValue("BUDG_AMT", rows[i].getString(dsMAIN.indexOfColumn("BUDG_AMT")));
						lrArgData.setValue("AS_AMT", rows[i].getString(dsMAIN.indexOfColumn("AS_AMT")));
						lrArgData.setValue("COST_DESC_TAG", rows[i].getString(dsMAIN.indexOfColumn("COST_DESC_TAG")));
						lrArgData.setValue("COST_GUESS_AMT", rows[i].getString(dsMAIN.indexOfColumn("COST_GUESS_AMT")));
						lrArgData.setValue("F_CONS_AMT", rows[i].getString(dsMAIN.indexOfColumn("F_CONS_AMT")));
						lrArgData.setValue("F_BUDG_AMT", rows[i].getString(dsMAIN.indexOfColumn("F_BUDG_AMT")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_DEPT_CODE_PROJ_U(?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("ACC_CLOSE_DT", CITData.VARCHAR2);
						lrArgData.addColumn("BUDG_APPL_DT", CITData.VARCHAR2);
						lrArgData.addColumn("CONS_AMT", CITData.NUMBER);
						lrArgData.addColumn("BUDG_AMT", CITData.NUMBER);
						lrArgData.addColumn("AS_AMT", CITData.NUMBER);
						lrArgData.addColumn("COST_DESC_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("COST_GUESS_AMT", CITData.NUMBER);
						lrArgData.addColumn("F_CONS_AMT", CITData.NUMBER);
						lrArgData.addColumn("F_BUDG_AMT", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("DEPT_CODE", rows[i].getString(dsMAIN.indexOfColumn("DEPT_CODE")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("ACC_CLOSE_DT", rows[i].getString(dsMAIN.indexOfColumn("ACC_CLOSE_DT")));
						lrArgData.setValue("BUDG_APPL_DT", rows[i].getString(dsMAIN.indexOfColumn("BUDG_APPL_DT")));
						lrArgData.setValue("CONS_AMT", rows[i].getString(dsMAIN.indexOfColumn("CONS_AMT")));
						lrArgData.setValue("BUDG_AMT", rows[i].getString(dsMAIN.indexOfColumn("BUDG_AMT")));
						lrArgData.setValue("AS_AMT", rows[i].getString(dsMAIN.indexOfColumn("AS_AMT")));
						lrArgData.setValue("COST_DESC_TAG", rows[i].getString(dsMAIN.indexOfColumn("COST_DESC_TAG")));
						lrArgData.setValue("COST_GUESS_AMT", rows[i].getString(dsMAIN.indexOfColumn("COST_GUESS_AMT")));
						lrArgData.setValue("F_CONS_AMT", rows[i].getString(dsMAIN.indexOfColumn("F_CONS_AMT")));
						lrArgData.setValue("F_BUDG_AMT", rows[i].getString(dsMAIN.indexOfColumn("F_BUDG_AMT")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_DEPT_CODE_PROJ_D(?)}";
						
						lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);

						lrArgData.addRow();
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
				GauceInfo.response.writeException("USER", "900001", "T_DEPT_CODE_ORG ���̺� ����Ÿ ���� ����" + ex.getMessage());
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
