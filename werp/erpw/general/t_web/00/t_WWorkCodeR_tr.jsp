<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : 
/* 2. ����(�ó�����) : Update Page
/* 3. ��  ��  ��  �� : 
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2005-11-18)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
	CITGauceInfo GauceInfo = null;
	
	GauceDataSet dsMAIN = null;
	GauceDataSet dsSUB01 = null;
	GauceDataSet dsSUB02 = null;
	GauceDataSet dsSUB03 = null;

	
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
						strSql = "{call SP_T_WORK_CODE_I(?,?,?,?,?)}";
						
						lrArgData.addColumn("WORK_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("WORK_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("SLIP_UPDATE_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("CHARGE_PERS", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("WORK_CODE", rows[i].getString(dsMAIN.indexOfColumn("WORK_CODE")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("WORK_NAME", rows[i].getString(dsMAIN.indexOfColumn("WORK_NAME")));
						lrArgData.setValue("SLIP_UPDATE_CLS", rows[i].getString(dsMAIN.indexOfColumn("SLIP_UPDATE_CLS")));
						lrArgData.setValue("CHARGE_PERS", rows[i].getString(dsMAIN.indexOfColumn("CHARGE_PERS")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_WORK_CODE_U(?,?,?,?,?)}";
						
						lrArgData.addColumn("WORK_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("WORK_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("SLIP_UPDATE_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("CHARGE_PERS", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("WORK_CODE", rows[i].getString(dsMAIN.indexOfColumn("WORK_CODE")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("WORK_NAME", rows[i].getString(dsMAIN.indexOfColumn("WORK_NAME")));
						lrArgData.setValue("SLIP_UPDATE_CLS", rows[i].getString(dsMAIN.indexOfColumn("SLIP_UPDATE_CLS")));
						lrArgData.setValue("CHARGE_PERS", rows[i].getString(dsMAIN.indexOfColumn("CHARGE_PERS")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_WORK_CODE_D(?)}";
						
						lrArgData.addColumn("WORK_CODE", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("WORK_CODE", rows[i].getString(dsMAIN.indexOfColumn("WORK_CODE")));
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
				GauceInfo.response.writeException("USER", "900001", "T_WORK_CODE ���̺� ����Ÿ ���� ����" + ex.getMessage());
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
						strSql = "{call SP_T_WORK_ACC_CODE_I(?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("WORK_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("COST_DEPT_KND_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("ACC_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("ACC_POSITION", CITData.VARCHAR2);
						lrArgData.addColumn("SUMMARY_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("SUMMARY1", CITData.VARCHAR2);
						lrArgData.addColumn("SUMMARY2", CITData.VARCHAR2);
						lrArgData.addColumn("VAT_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("SEQ", CITData.NUMBER);
						lrArgData.addColumn("USE_TAG", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("WORK_CODE", rows[i].getString(dsSUB01.indexOfColumn("WORK_CODE")));
						lrArgData.setValue("COST_DEPT_KND_TAG", rows[i].getString(dsSUB01.indexOfColumn("COST_DEPT_KND_TAG")));
						lrArgData.setValue("ACC_CODE", rows[i].getString(dsSUB01.indexOfColumn("ACC_CODE")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("ACC_POSITION", rows[i].getString(dsSUB01.indexOfColumn("ACC_POSITION")));
						lrArgData.setValue("SUMMARY_CODE", rows[i].getString(dsSUB01.indexOfColumn("SUMMARY_CODE")));
						lrArgData.setValue("SUMMARY1", rows[i].getString(dsSUB01.indexOfColumn("SUMMARY1")));
						lrArgData.setValue("SUMMARY2", rows[i].getString(dsSUB01.indexOfColumn("SUMMARY2")));
						lrArgData.setValue("VAT_CODE", rows[i].getString(dsSUB01.indexOfColumn("VAT_CODE")));
						lrArgData.setValue("SEQ", rows[i].getString(dsSUB01.indexOfColumn("SEQ")));
						lrArgData.setValue("USE_TAG", rows[i].getString(dsSUB01.indexOfColumn("USE_TAG")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_WORK_ACC_CODE_U(?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("WORK_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("COST_DEPT_KND_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("ACC_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("ACC_POSITION", CITData.VARCHAR2);
						lrArgData.addColumn("SUMMARY_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("SUMMARY1", CITData.VARCHAR2);
						lrArgData.addColumn("SUMMARY2", CITData.VARCHAR2);
						lrArgData.addColumn("VAT_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("SEQ", CITData.NUMBER);
						lrArgData.addColumn("USE_TAG", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("WORK_CODE", rows[i].getString(dsSUB01.indexOfColumn("WORK_CODE")));
						lrArgData.setValue("COST_DEPT_KND_TAG", rows[i].getString(dsSUB01.indexOfColumn("COST_DEPT_KND_TAG")));
						lrArgData.setValue("ACC_CODE", rows[i].getString(dsSUB01.indexOfColumn("ACC_CODE")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("ACC_POSITION", rows[i].getString(dsSUB01.indexOfColumn("ACC_POSITION")));
						lrArgData.setValue("SUMMARY_CODE", rows[i].getString(dsSUB01.indexOfColumn("SUMMARY_CODE")));
						lrArgData.setValue("SUMMARY1", rows[i].getString(dsSUB01.indexOfColumn("SUMMARY1")));
						lrArgData.setValue("SUMMARY2", rows[i].getString(dsSUB01.indexOfColumn("SUMMARY2")));
						lrArgData.setValue("VAT_CODE", rows[i].getString(dsSUB01.indexOfColumn("VAT_CODE")));
						lrArgData.setValue("SEQ", rows[i].getString(dsSUB01.indexOfColumn("SEQ")));
						lrArgData.setValue("USE_TAG", rows[i].getString(dsSUB01.indexOfColumn("USE_TAG")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_WORK_ACC_CODE_D(?,?,?)}";
						
						lrArgData.addColumn("WORK_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("COST_DEPT_KND_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("ACC_CODE", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("WORK_CODE", rows[i].getString(dsSUB01.indexOfColumn("WORK_CODE")));
						lrArgData.setValue("COST_DEPT_KND_TAG", rows[i].getString(dsSUB01.indexOfColumn("COST_DEPT_KND_TAG")));
						lrArgData.setValue("ACC_CODE", rows[i].getString(dsSUB01.indexOfColumn("ACC_CODE")));
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
				GauceInfo.response.writeException("USER", "900001", "T_WORK_ACC_CODE ���̺� ����Ÿ ���� ����" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
			
			dsSUB02 = GauceInfo.request.getGauceDataSet("dsSUB02");
			
			if (dsSUB02 == null) throw new Exception("dsSUB02��(��) ��(Null)�Դϴ�.");
			
			rows = dsSUB02.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					if (rows[i].getJobType() == GauceDataRow.TB_JOB_INSERT)
					{
						strSql = "{call SP_T_WORK_VAT_CODE_I(?,?,?,?,?,?)}";
						
						lrArgData.addColumn("WORK_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("COST_DEPT_KND_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("VAT_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("SEQ", CITData.NUMBER);
						lrArgData.addColumn("USE_TAG", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("WORK_CODE", rows[i].getString(dsSUB02.indexOfColumn("WORK_CODE")));
						lrArgData.setValue("COST_DEPT_KND_TAG", rows[i].getString(dsSUB02.indexOfColumn("COST_DEPT_KND_TAG")));
						lrArgData.setValue("VAT_CODE", rows[i].getString(dsSUB02.indexOfColumn("VAT_CODE")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("SEQ", rows[i].getString(dsSUB02.indexOfColumn("SEQ")));
						lrArgData.setValue("USE_TAG", rows[i].getString(dsSUB02.indexOfColumn("USE_TAG")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_WORK_VAT_CODE_U(?,?,?,?,?,?)}";
						
						lrArgData.addColumn("WORK_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("COST_DEPT_KND_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("VAT_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("SEQ", CITData.NUMBER);
						lrArgData.addColumn("USE_TAG", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("WORK_CODE", rows[i].getString(dsSUB02.indexOfColumn("WORK_CODE")));
						lrArgData.setValue("COST_DEPT_KND_TAG", rows[i].getString(dsSUB02.indexOfColumn("COST_DEPT_KND_TAG")));
						lrArgData.setValue("VAT_CODE", rows[i].getString(dsSUB02.indexOfColumn("VAT_CODE")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("SEQ", rows[i].getString(dsSUB02.indexOfColumn("SEQ")));
						lrArgData.setValue("USE_TAG", rows[i].getString(dsSUB02.indexOfColumn("USE_TAG")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_WORK_VAT_CODE_D(?,?,?)}";
						
						lrArgData.addColumn("WORK_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("COST_DEPT_KND_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("VAT_CODE", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("WORK_CODE", rows[i].getString(dsSUB02.indexOfColumn("WORK_CODE")));
						lrArgData.setValue("COST_DEPT_KND_TAG", rows[i].getString(dsSUB02.indexOfColumn("COST_DEPT_KND_TAG")));
						lrArgData.setValue("VAT_CODE", rows[i].getString(dsSUB02.indexOfColumn("VAT_CODE")));
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
				GauceInfo.response.writeException("USER", "900001", "T_WORK_VAT_CODE ���̺� ����Ÿ ���� ����" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}

			dsSUB03 = GauceInfo.request.getGauceDataSet("dsSUB03");
			
			if (dsSUB03 == null) throw new Exception("dsSUB03��(��) ��(Null)�Դϴ�.");
			rows = dsSUB03.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					if (rows[i].getJobType() == GauceDataRow.TB_JOB_INSERT)
					{
						strSql = "{call SP_T_WORK_CHARGE_PERS_I(?,?,?,?)}";
						
						lrArgData.addColumn("WORK_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("CHARGE_PERS", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("WORK_CODE", rows[i].getString(dsSUB03.indexOfColumn("WORK_CODE")));
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsSUB03.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("CHARGE_PERS", rows[i].getString(dsSUB03.indexOfColumn("CHARGE_PERS")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_WORK_CHARGE_PERS_U(?,?,?,?)}";
						
						lrArgData.addColumn("WORK_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("CHARGE_PERS", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("WORK_CODE", rows[i].getString(dsSUB03.indexOfColumn("WORK_CODE")));
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsSUB03.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("CHARGE_PERS", rows[i].getString(dsSUB03.indexOfColumn("CHARGE_PERS")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_WORK_CHARGE_PERS_D(?,?)}";
						
						lrArgData.addColumn("WORK_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("WORK_CODE", rows[i].getString(dsSUB03.indexOfColumn("WORK_CODE")));
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsSUB03.indexOfColumn("COMP_CODE")));
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
				GauceInfo.response.writeException("USER", "900001", "T_WORK_CHARGE_PERS ���̺� ����Ÿ ���� ����" + ex.getMessage());
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
