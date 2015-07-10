<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : t_PLovFilterRelR_tr.jsp(�����˾��� ���Ͱ�����)
/* 2. ����(�ó�����) : Update Page
/* 3. ��  ��  ��  �� : 
/* 4. ��  ��  ��  �� : ������ �ۼ�(2005-11-24)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
	CITGauceInfo GauceInfo = null;
	
	GauceDataSet dsFilterRels = null;
	
	GauceDataRow[] rowsFilterRels = null;
	
	Connection conn = null;
	
	String strSql = "";
	String strAct = "";
	String strUserNo = "";
	
	try
	{
		GauceInfo = CITCommon.initServerPage(request, response, session);
		
		conn = CITConnectionManager.getConnection(false);
		
		/* �������� */
		strUserNo = CITCommon.toKOR((String)session.getAttribute("emp_no"));
		
		strAct = GauceInfo.request.getParameter("ACT");
		
		if (CITCommon.isNull(strAct))
		{
			dsFilterRels = GauceInfo.request.getGauceDataSet("dsFilterRels");
			
			if (dsFilterRels == null) throw new Exception("dsFilterRels��(��) ��(Null)�Դϴ�.");
			
			rowsFilterRels = dsFilterRels.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	rowsFilterRels.length; i++)
				{
					CITData lrArgData = new CITData();
					
					if (rowsFilterRels[i].getJobType() == GauceDataRow.TB_JOB_INSERT)
					{
						strSql = "{call SP_T_LOV_FILTER_RELS_I(?,?,?,?,?)}";
						
						lrArgData.addColumn("LOV_NO", CITData.NUMBER);
						lrArgData.addColumn("FILTER_REL_SEQ", CITData.NUMBER);
						lrArgData.addColumn("DIS_SEQ", CITData.NUMBER);
						lrArgData.addColumn("M_FILTER_SEQ", CITData.NUMBER);
						lrArgData.addColumn("D_FILTER_SEQ", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("LOV_NO", rowsFilterRels[i].getString(dsFilterRels.indexOfColumn("LOV_NO")));
						lrArgData.setValue("FILTER_REL_SEQ", rowsFilterRels[i].getString(dsFilterRels.indexOfColumn("FILTER_REL_SEQ")));
						lrArgData.setValue("DIS_SEQ", rowsFilterRels[i].getString(dsFilterRels.indexOfColumn("DIS_SEQ")));
						lrArgData.setValue("M_FILTER_SEQ", rowsFilterRels[i].getString(dsFilterRels.indexOfColumn("M_FILTER_SEQ")));
						lrArgData.setValue("D_FILTER_SEQ", rowsFilterRels[i].getString(dsFilterRels.indexOfColumn("D_FILTER_SEQ")));
					}
					else if (rowsFilterRels[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_LOV_FILTER_RELS_U(?,?,?,?,?)}";
						
						lrArgData.addColumn("LOV_NO", CITData.NUMBER);
						lrArgData.addColumn("FILTER_REL_SEQ", CITData.NUMBER);
						lrArgData.addColumn("DIS_SEQ", CITData.NUMBER);
						lrArgData.addColumn("M_FILTER_SEQ", CITData.NUMBER);
						lrArgData.addColumn("D_FILTER_SEQ", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("LOV_NO", rowsFilterRels[i].getString(dsFilterRels.indexOfColumn("LOV_NO")));
						lrArgData.setValue("FILTER_REL_SEQ", rowsFilterRels[i].getString(dsFilterRels.indexOfColumn("FILTER_REL_SEQ")));
						lrArgData.setValue("DIS_SEQ", rowsFilterRels[i].getString(dsFilterRels.indexOfColumn("DIS_SEQ")));
						lrArgData.setValue("M_FILTER_SEQ", rowsFilterRels[i].getString(dsFilterRels.indexOfColumn("M_FILTER_SEQ")));
						lrArgData.setValue("D_FILTER_SEQ", rowsFilterRels[i].getString(dsFilterRels.indexOfColumn("D_FILTER_SEQ")));
					}
					else if (rowsFilterRels[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_LOV_FILTER_RELS_D(?,?)}";
						
						lrArgData.addColumn("LOV_NO", CITData.NUMBER);
						lrArgData.addColumn("FILTER_REL_SEQ", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("LOV_NO", rowsFilterRels[i].getString(dsFilterRels.indexOfColumn("LOV_NO")));
						lrArgData.setValue("FILTER_REL_SEQ", rowsFilterRels[i].getString(dsFilterRels.indexOfColumn("FILTER_REL_SEQ")));
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
				GauceInfo.response.writeException("USER", "900001", "T_LOV_FILTER_RELS ���̺� ����Ÿ ���� ����" + ex.getMessage());
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
