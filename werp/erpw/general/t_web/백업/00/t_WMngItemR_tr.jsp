<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : t_WMngItemR_tr.jsp(�����׸���)
/* 2. ����(�ó�����) : Update Page
/* 3. ��  ��  ��  �� : 
/* 4. ��  ��  ��  �� : �־�ȸ �ۼ�(2005-11-15)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
	CITGauceInfo GauceInfo = null;
	
	GauceDataSet dsMAIN = null;
	
	GauceDataRow[] rows = null;
	
	String strSql = "";
	String strAct = "";
	String strUserNo = "";
	
	try
	{
		GauceInfo = CITCommon.initServerPage(request, response, session);
		/* �������� */
		strUserNo = CITCommon.toKOR((String)session.getAttribute("emp_no"));
		
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
						strSql = "{call SP_T_MNG_ITEM_CODE_I(?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("MNG_ITEM", CITData.VARCHAR2);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("MNG_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("DATA_TYPE", CITData.VARCHAR2);
						lrArgData.addColumn("SEQ", CITData.NUMBER);
						lrArgData.addColumn("POPUP", CITData.VARCHAR2);
						lrArgData.addColumn("REMARK", CITData.VARCHAR2);
						lrArgData.addColumn("USE_TG", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("MNG_ITEM", rows[i].getString(dsMAIN.indexOfColumn("MNG_ITEM")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("MNG_NAME", rows[i].getString(dsMAIN.indexOfColumn("MNG_NAME")));
						lrArgData.setValue("DATA_TYPE", rows[i].getString(dsMAIN.indexOfColumn("DATA_TYPE")));
						lrArgData.setValue("SEQ", rows[i].getString(dsMAIN.indexOfColumn("SEQ")));
						lrArgData.setValue("POPUP", rows[i].getString(dsMAIN.indexOfColumn("POPUP")));
						lrArgData.setValue("REMARK", rows[i].getString(dsMAIN.indexOfColumn("REMARK")));
						lrArgData.setValue("USE_TG", rows[i].getString(dsMAIN.indexOfColumn("USE_TG")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_MNG_ITEM_CODE_U(?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("MNG_ITEM", CITData.VARCHAR2);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("MNG_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("DATA_TYPE", CITData.VARCHAR2);
						lrArgData.addColumn("SEQ", CITData.NUMBER);
						lrArgData.addColumn("POPUP", CITData.VARCHAR2);
						lrArgData.addColumn("REMARK", CITData.VARCHAR2);
						lrArgData.addColumn("USE_TG", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("MNG_ITEM", rows[i].getString(dsMAIN.indexOfColumn("MNG_ITEM")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("MNG_NAME", rows[i].getString(dsMAIN.indexOfColumn("MNG_NAME")));
						lrArgData.setValue("DATA_TYPE", rows[i].getString(dsMAIN.indexOfColumn("DATA_TYPE")));
						lrArgData.setValue("SEQ", rows[i].getString(dsMAIN.indexOfColumn("SEQ")));
						lrArgData.setValue("POPUP", rows[i].getString(dsMAIN.indexOfColumn("POPUP")));
						lrArgData.setValue("REMARK", rows[i].getString(dsMAIN.indexOfColumn("REMARK")));
						lrArgData.setValue("USE_TG", rows[i].getString(dsMAIN.indexOfColumn("USE_TG")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_MNG_ITEM_CODE_D(?)}";
						
						lrArgData.addColumn("MNG_ITEM", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("MNG_ITEM", rows[i].getString(dsMAIN.indexOfColumn("MNG_ITEM")));
					}
					else
					{
						continue;
					}
					
					CITDatabase.executeProcedure(strSql, lrArgData);
				}
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001", "T_MNG_ITEM_CODE ���̺� ����Ÿ ���� ����" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
		}
	}
	catch (Exception ex)
	{
		if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
		GauceInfo.response.writeException("SYS", "100001", "������ �ʱ�ȭ ���� -> " + ex.getMessage());
	}
	finally
	{
		try
		{
			CITCommon.finalServerPage(GauceInfo);
		}
	    catch (Exception ex)
	    {
			if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
	    	GauceInfo.response.writeException("SYS", "100002", "������ ���� ���� -> " + ex.getMessage());
	    }
	}
%>
