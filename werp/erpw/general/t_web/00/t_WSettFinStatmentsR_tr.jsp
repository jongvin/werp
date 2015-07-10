<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : 
/* 2. ����(�ó�����) : Update Page
/* 3. ��  ��  ��  �� : �����Ѵ�... �츮 ���α׷��� ��Ŀ� ������ �� �������� �ڵ� ������ ���̴�.
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-11-16)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
	CITGauceInfo GauceInfo = null;
	
	GauceDataSet dsMAIN = null;
	GauceDataSet dsSUB01 = null;
	
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
						strSql = "{call SP_T_SHEET_CODE_I(?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("SHEET_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("SHEET_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("SHEET_PRINT_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("SHEET_ENG_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("SHEET_TYPE", CITData.VARCHAR2);
						lrArgData.addColumn("AMTUNIT", CITData.NUMBER);
						lrArgData.addColumn("INDENTCNT", CITData.NUMBER);
						lrArgData.addColumn("ROUND_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("COST_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("ZERO_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("MONTH_SUM_TAG", CITData.VARCHAR2);
						

						lrArgData.addRow();
						lrArgData.setValue("SHEET_CODE", rows[i].getString(dsMAIN.indexOfColumn("SHEET_CODE")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("SHEET_NAME", rows[i].getString(dsMAIN.indexOfColumn("SHEET_NAME")));
						lrArgData.setValue("SHEET_PRINT_NAME", rows[i].getString(dsMAIN.indexOfColumn("SHEET_PRINT_NAME")));
						lrArgData.setValue("SHEET_ENG_NAME", rows[i].getString(dsMAIN.indexOfColumn("SHEET_ENG_NAME")));
						lrArgData.setValue("SHEET_TYPE", rows[i].getString(dsMAIN.indexOfColumn("SHEET_TYPE")));
						lrArgData.setValue("AMTUNIT", rows[i].getString(dsMAIN.indexOfColumn("AMTUNIT")));
						lrArgData.setValue("INDENTCNT", rows[i].getString(dsMAIN.indexOfColumn("INDENTCNT")));
						lrArgData.setValue("ROUND_CLS", rows[i].getString(dsMAIN.indexOfColumn("ROUND_CLS")));
						lrArgData.setValue("COST_CODE", rows[i].getString(dsMAIN.indexOfColumn("COST_CODE")));
						lrArgData.setValue("ZERO_CLS", rows[i].getString(dsMAIN.indexOfColumn("ZERO_CLS")));
						lrArgData.setValue("MONTH_SUM_TAG", rows[i].getString(dsMAIN.indexOfColumn("MONTH_SUM_TAG")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_SHEET_CODE_U(?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("SHEET_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("SHEET_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("SHEET_PRINT_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("SHEET_ENG_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("SHEET_TYPE", CITData.VARCHAR2);
						lrArgData.addColumn("AMTUNIT", CITData.NUMBER);
						lrArgData.addColumn("INDENTCNT", CITData.NUMBER);
						lrArgData.addColumn("ROUND_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("COST_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("ZERO_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("MONTH_SUM_TAG", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("SHEET_CODE", rows[i].getString(dsMAIN.indexOfColumn("SHEET_CODE")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("SHEET_NAME", rows[i].getString(dsMAIN.indexOfColumn("SHEET_NAME")));
						lrArgData.setValue("SHEET_PRINT_NAME", rows[i].getString(dsMAIN.indexOfColumn("SHEET_PRINT_NAME")));
						lrArgData.setValue("SHEET_ENG_NAME", rows[i].getString(dsMAIN.indexOfColumn("SHEET_ENG_NAME")));
						lrArgData.setValue("SHEET_TYPE", rows[i].getString(dsMAIN.indexOfColumn("SHEET_TYPE")));
						lrArgData.setValue("AMTUNIT", rows[i].getString(dsMAIN.indexOfColumn("AMTUNIT")));
						lrArgData.setValue("INDENTCNT", rows[i].getString(dsMAIN.indexOfColumn("INDENTCNT")));
						lrArgData.setValue("ROUND_CLS", rows[i].getString(dsMAIN.indexOfColumn("ROUND_CLS")));
						lrArgData.setValue("COST_CODE", rows[i].getString(dsMAIN.indexOfColumn("COST_CODE")));
						lrArgData.setValue("ZERO_CLS", rows[i].getString(dsMAIN.indexOfColumn("ZERO_CLS")));
						lrArgData.setValue("MONTH_SUM_TAG", rows[i].getString(dsMAIN.indexOfColumn("MONTH_SUM_TAG")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_SHEET_CODE_D(?)}";
						
						lrArgData.addColumn("SHEET_CODE", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("SHEET_CODE", rows[i].getString(dsMAIN.indexOfColumn("SHEET_CODE")));
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
				GauceInfo.response.writeException("USER", "900001", "T_SHEET_CODE ���̺� ����Ÿ ���� ����" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
			
			dsSUB01 = GauceInfo.request.getGauceDataSet("dsSUB01");
			
			if (dsSUB01 == null) throw new Exception("dsSUB01��(��) ��(Null)�Դϴ�.");
			
			rows = dsSUB01.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					if (rows[i].getJobType() == GauceDataRow.TB_JOB_INSERT)
					{
						strSql = "{call SP_T_SHEET_CODE_LVL_I(?,?,?,?)}";
						
						lrArgData.addColumn("SHEET_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("ITEM_LVL", CITData.VARCHAR2);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("SEQ_TYPE", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("SHEET_CODE", rows[i].getString(dsSUB01.indexOfColumn("SHEET_CODE")));
						lrArgData.setValue("ITEM_LVL", rows[i].getString(dsSUB01.indexOfColumn("ITEM_LVL")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("SEQ_TYPE", rows[i].getString(dsSUB01.indexOfColumn("SEQ_TYPE")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_SHEET_CODE_LVL_U(?,?,?,?)}";
						
						lrArgData.addColumn("SHEET_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("ITEM_LVL", CITData.VARCHAR2);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("SEQ_TYPE", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("SHEET_CODE", rows[i].getString(dsSUB01.indexOfColumn("SHEET_CODE")));
						lrArgData.setValue("ITEM_LVL", rows[i].getString(dsSUB01.indexOfColumn("ITEM_LVL")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("SEQ_TYPE", rows[i].getString(dsSUB01.indexOfColumn("SEQ_TYPE")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_SHEET_CODE_LVL_D(?,?)}";
						
						lrArgData.addColumn("SHEET_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("ITEM_LVL", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("SHEET_CODE", rows[i].getString(dsSUB01.indexOfColumn("SHEET_CODE")));
						lrArgData.setValue("ITEM_LVL", rows[i].getString(dsSUB01.indexOfColumn("ITEM_LVL")));
					}
					else
					{
						continue;
					}
					
					CITDatabase.executeProcedure(strSql, lrArgData,conn);
				}
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001", "T_SHEET_CODE ���̺� ����Ÿ ���� ����" + ex.getMessage());
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
