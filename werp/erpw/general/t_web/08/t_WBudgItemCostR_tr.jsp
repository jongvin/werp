<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : 
/* 2. ����(�ó�����) : Update Page
/* 3. ��  ��  ��  �� : 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-12-08)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
	CITGauceInfo GauceInfo = null;
	
	GauceDataSet dsMAIN = null;
	GauceDataSet dsSUB01 = null;
	GauceDataSet dsGRADE_COPY = null;
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
		if(!CITCommon.isNull(strAct) && strAct.equals("GRADE_COPY"))
		{
			dsGRADE_COPY = GauceInfo.request.getGauceDataSet("dsGRADE_COPY");
			rows = dsGRADE_COPY.getDataRows();
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					strSql = "{call SP_T_BUDG_GRADE_COPY(?,?,?,?)}";
					
					lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
					lrArgData.addColumn("CLSE_ACC_ID", CITData.VARCHAR2);
					lrArgData.addColumn("BUDG_CODE_NO", CITData.NUMBER);
					lrArgData.addColumn("ITEM_NO", CITData.NUMBER);

					lrArgData.addRow();
					lrArgData.setValue("COMP_CODE", rows[i].getString(dsGRADE_COPY.indexOfColumn("COMP_CODE")));
					lrArgData.setValue("CLSE_ACC_ID", rows[i].getString(dsGRADE_COPY.indexOfColumn("CLSE_ACC_ID")));
					lrArgData.setValue("BUDG_CODE_NO", rows[i].getString(dsGRADE_COPY.indexOfColumn("BUDG_CODE_NO")));
					lrArgData.setValue("ITEM_NO", rows[i].getString(dsGRADE_COPY.indexOfColumn("ITEM_NO")));
					
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
			dsSUB01 = GauceInfo.request.getGauceDataSet("dsSUB01");
			
			if (dsMAIN == null) throw new Exception("dsMAIN��(��) ��(Null)�Դϴ�.");
			if (dsSUB01 == null) throw new Exception("dsSUB01(��) ��(Null)�Դϴ�.");
			
			
			
			rows  = dsMAIN.getDataRows();
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					
					CITData lrArgData = new CITData();
					
					if (rows[i].getJobType() == GauceDataRow.TB_JOB_INSERT)
					{
						strSql = "{call SP_T_BUDG_ITEM_COST_I(?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CLSE_ACC_ID", CITData.VARCHAR2);
						lrArgData.addColumn("BUDG_CODE_NO", CITData.NUMBER);
						lrArgData.addColumn("ITEM_NO", CITData.NUMBER);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("ITEM_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("DAY_CALC_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("UNIT_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("GRADE_UNIT_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("UNIT_COST", CITData.NUMBER);
						lrArgData.addColumn("ALL_CHG_TAG", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsMAIN.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("CLSE_ACC_ID", rows[i].getString(dsMAIN.indexOfColumn("CLSE_ACC_ID")));
						lrArgData.setValue("BUDG_CODE_NO", rows[i].getString(dsMAIN.indexOfColumn("BUDG_CODE_NO")));
						lrArgData.setValue("ITEM_NO", rows[i].getString(dsMAIN.indexOfColumn("ITEM_NO")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("ITEM_NAME", rows[i].getString(dsMAIN.indexOfColumn("ITEM_NAME")));
						lrArgData.setValue("DAY_CALC_TAG", rows[i].getString(dsMAIN.indexOfColumn("DAY_CALC_TAG")));
						lrArgData.setValue("UNIT_TAG", rows[i].getString(dsMAIN.indexOfColumn("UNIT_TAG")));
						lrArgData.setValue("GRADE_UNIT_TAG", rows[i].getString(dsMAIN.indexOfColumn("GRADE_UNIT_TAG")));
						lrArgData.setValue("UNIT_COST", rows[i].getString(dsMAIN.indexOfColumn("UNIT_COST")));
						lrArgData.setValue("ALL_CHG_TAG", rows[i].getString(dsMAIN.indexOfColumn("ALL_CHG_TAG")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_BUDG_ITEM_COST_U(?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CLSE_ACC_ID", CITData.VARCHAR2);
						lrArgData.addColumn("BUDG_CODE_NO", CITData.NUMBER);
						lrArgData.addColumn("ITEM_NO", CITData.NUMBER);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("ITEM_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("DAY_CALC_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("UNIT_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("GRADE_UNIT_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("UNIT_COST", CITData.NUMBER);
						lrArgData.addColumn("ALL_CHG_TAG", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsMAIN.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("CLSE_ACC_ID", rows[i].getString(dsMAIN.indexOfColumn("CLSE_ACC_ID")));
						lrArgData.setValue("BUDG_CODE_NO", rows[i].getString(dsMAIN.indexOfColumn("BUDG_CODE_NO")));
						lrArgData.setValue("ITEM_NO", rows[i].getString(dsMAIN.indexOfColumn("ITEM_NO")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("ITEM_NAME", rows[i].getString(dsMAIN.indexOfColumn("ITEM_NAME")));
						lrArgData.setValue("DAY_CALC_TAG", rows[i].getString(dsMAIN.indexOfColumn("DAY_CALC_TAG")));
						lrArgData.setValue("UNIT_TAG", rows[i].getString(dsMAIN.indexOfColumn("UNIT_TAG")));
						lrArgData.setValue("GRADE_UNIT_TAG", rows[i].getString(dsMAIN.indexOfColumn("GRADE_UNIT_TAG")));
						lrArgData.setValue("UNIT_COST", rows[i].getString(dsMAIN.indexOfColumn("UNIT_COST")));
						lrArgData.setValue("ALL_CHG_TAG", rows[i].getString(dsMAIN.indexOfColumn("ALL_CHG_TAG")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_BUDG_ITEM_COST_D(?,?,?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CLSE_ACC_ID", CITData.VARCHAR2);
						lrArgData.addColumn("BUDG_CODE_NO", CITData.NUMBER);
						lrArgData.addColumn("ITEM_NO", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsMAIN.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("CLSE_ACC_ID", rows[i].getString(dsMAIN.indexOfColumn("CLSE_ACC_ID")));
						lrArgData.setValue("BUDG_CODE_NO", rows[i].getString(dsMAIN.indexOfColumn("BUDG_CODE_NO")));
						lrArgData.setValue("ITEM_NO", rows[i].getString(dsMAIN.indexOfColumn("ITEM_NO")));
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
				GauceInfo.response.writeException("USER", "900001", "T_BUDG_ITEM_COST ���̺� ����Ÿ ���� ����" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
			
			rows = dsSUB01.getDataRows();
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					
					if (rows[i].getJobType() == GauceDataRow.TB_JOB_INSERT)
					{
						strSql = "{call SP_T_BUDG_ITEM_GRADE_COST_I(?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CLSE_ACC_ID", CITData.VARCHAR2);
						lrArgData.addColumn("BUDG_CODE_NO", CITData.NUMBER);
						lrArgData.addColumn("ITEM_NO", CITData.NUMBER);
						lrArgData.addColumn("GRADE_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("UNIT_COST", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsSUB01.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("CLSE_ACC_ID", rows[i].getString(dsSUB01.indexOfColumn("CLSE_ACC_ID")));
						lrArgData.setValue("BUDG_CODE_NO", rows[i].getString(dsSUB01.indexOfColumn("BUDG_CODE_NO")));
						lrArgData.setValue("ITEM_NO", rows[i].getString(dsSUB01.indexOfColumn("ITEM_NO")));
						lrArgData.setValue("GRADE_CODE", rows[i].getString(dsSUB01.indexOfColumn("GRADE_CODE")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("UNIT_COST", rows[i].getString(dsSUB01.indexOfColumn("UNIT_COST")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_BUDG_ITEM_GRADE_COST_U(?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CLSE_ACC_ID", CITData.VARCHAR2);
						lrArgData.addColumn("BUDG_CODE_NO", CITData.NUMBER);
						lrArgData.addColumn("ITEM_NO", CITData.NUMBER);
						lrArgData.addColumn("GRADE_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("UNIT_COST", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsSUB01.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("CLSE_ACC_ID", rows[i].getString(dsSUB01.indexOfColumn("CLSE_ACC_ID")));
						lrArgData.setValue("BUDG_CODE_NO", rows[i].getString(dsSUB01.indexOfColumn("BUDG_CODE_NO")));
						lrArgData.setValue("ITEM_NO", rows[i].getString(dsSUB01.indexOfColumn("ITEM_NO")));
						lrArgData.setValue("GRADE_CODE", rows[i].getString(dsSUB01.indexOfColumn("GRADE_CODE")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("UNIT_COST", rows[i].getString(dsSUB01.indexOfColumn("UNIT_COST")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_BUDG_ITEM_GRADE_COST_D(?,?,?,?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CLSE_ACC_ID", CITData.VARCHAR2);
						lrArgData.addColumn("BUDG_CODE_NO", CITData.NUMBER);
						lrArgData.addColumn("ITEM_NO", CITData.NUMBER);
						lrArgData.addColumn("GRADE_CODE", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsSUB01.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("CLSE_ACC_ID", rows[i].getString(dsSUB01.indexOfColumn("CLSE_ACC_ID")));
						lrArgData.setValue("BUDG_CODE_NO", rows[i].getString(dsSUB01.indexOfColumn("BUDG_CODE_NO")));
						lrArgData.setValue("ITEM_NO", rows[i].getString(dsSUB01.indexOfColumn("ITEM_NO")));
						lrArgData.setValue("GRADE_CODE", rows[i].getString(dsSUB01.indexOfColumn("GRADE_CODE")));
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
				GauceInfo.response.writeException("USER", "900001", "T_BUDG_ITEM_GRADE_COST ���̺� ����Ÿ ���� ����" + ex.getMessage());
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
