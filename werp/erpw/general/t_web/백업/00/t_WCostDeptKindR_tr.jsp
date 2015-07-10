<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : 
/* 2. ����(�ó�����) : Update Page
/* 3. ��  ��  ��  �� : 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-12-21)
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
						strSql = "{call SP_T_COST_DEPT_KIND_I(?,?,?,?)}";
						
						lrArgData.addColumn("COST_DEPT_KND_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("COST_DEPT_KND_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("PRT_SEQ", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("COST_DEPT_KND_TAG", rows[i].getString(dsMAIN.indexOfColumn("COST_DEPT_KND_TAG")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("COST_DEPT_KND_NAME", rows[i].getString(dsMAIN.indexOfColumn("COST_DEPT_KND_NAME")));
						lrArgData.setValue("PRT_SEQ", rows[i].getString(dsMAIN.indexOfColumn("PRT_SEQ")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_COST_DEPT_KIND_U(?,?,?,?)}";
						
						lrArgData.addColumn("COST_DEPT_KND_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("COST_DEPT_KND_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("PRT_SEQ", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("COST_DEPT_KND_TAG", rows[i].getString(dsMAIN.indexOfColumn("COST_DEPT_KND_TAG")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("COST_DEPT_KND_NAME", rows[i].getString(dsMAIN.indexOfColumn("COST_DEPT_KND_NAME")));
						lrArgData.setValue("PRT_SEQ", rows[i].getString(dsMAIN.indexOfColumn("PRT_SEQ")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_COST_DEPT_KIND_D(?)}";
						
						lrArgData.addColumn("COST_DEPT_KND_TAG", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("COST_DEPT_KND_TAG", rows[i].getString(dsMAIN.indexOfColumn("COST_DEPT_KND_TAG")));
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
				GauceInfo.response.writeException("USER", "900001", "T_COST_DEPT_KIND ���̺� ����Ÿ ���� ����" + ex.getMessage());
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
