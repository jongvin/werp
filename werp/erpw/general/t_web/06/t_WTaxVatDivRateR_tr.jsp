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
	GauceDataSet dsBATCH01 = null;
	
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
	//�������
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
						strSql = "{call SP_T_ACC_SLIP_BILL_HEAD_I(?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("WORK_NO", CITData.NUMBER);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("WORK_DATE", CITData.VARCHAR2);
						lrArgData.addColumn("TAX_YEAR", CITData.VARCHAR2);
						lrArgData.addColumn("TAX_GI", CITData.VARCHAR2);
						lrArgData.addColumn("TAX_CONF", CITData.VARCHAR2);
						lrArgData.addColumn("BASE_DT_F", CITData.VARCHAR2);
						lrArgData.addColumn("BASE_DT_T", CITData.VARCHAR2);
						lrArgData.addColumn("MISSING_PROCESS_DT_F", CITData.VARCHAR2);
						lrArgData.addColumn("APPLY_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("REMARKS", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsMAIN.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("WORK_NO", rows[i].getString(dsMAIN.indexOfColumn("WORK_NO")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("WORK_DATE", rows[i].getString(dsMAIN.indexOfColumn("WORK_DATE")));
						lrArgData.setValue("TAX_YEAR", rows[i].getString(dsMAIN.indexOfColumn("TAX_YEAR")));
						lrArgData.setValue("TAX_GI", rows[i].getString(dsMAIN.indexOfColumn("TAX_GI")));
						lrArgData.setValue("TAX_CONF", rows[i].getString(dsMAIN.indexOfColumn("TAX_CONF")));
						lrArgData.setValue("BASE_DT_F", rows[i].getString(dsMAIN.indexOfColumn("BASE_DT_F")));
						lrArgData.setValue("BASE_DT_T", rows[i].getString(dsMAIN.indexOfColumn("BASE_DT_T")));
						lrArgData.setValue("MISSING_PROCESS_DT_F", rows[i].getString(dsMAIN.indexOfColumn("MISSING_PROCESS_DT_F")));
						lrArgData.setValue("APPLY_TAG", rows[i].getString(dsMAIN.indexOfColumn("APPLY_TAG")));
						lrArgData.setValue("REMARKS", rows[i].getString(dsMAIN.indexOfColumn("REMARKS")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_ACC_SLIP_BILL_HEAD_U(?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("WORK_NO", CITData.NUMBER);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("WORK_DATE", CITData.VARCHAR2);
						lrArgData.addColumn("TAX_YEAR", CITData.VARCHAR2);
						lrArgData.addColumn("TAX_GI", CITData.VARCHAR2);
						lrArgData.addColumn("TAX_CONF", CITData.VARCHAR2);
						lrArgData.addColumn("BASE_DT_F", CITData.VARCHAR2);
						lrArgData.addColumn("BASE_DT_T", CITData.VARCHAR2);
						lrArgData.addColumn("MISSING_PROCESS_DT_F", CITData.VARCHAR2);
						lrArgData.addColumn("APPLY_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("REMARKS", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsMAIN.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("WORK_NO", rows[i].getString(dsMAIN.indexOfColumn("WORK_NO")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("WORK_DATE", rows[i].getString(dsMAIN.indexOfColumn("WORK_DATE")));
						lrArgData.setValue("TAX_YEAR", rows[i].getString(dsMAIN.indexOfColumn("TAX_YEAR")));
						lrArgData.setValue("TAX_GI", rows[i].getString(dsMAIN.indexOfColumn("TAX_GI")));
						lrArgData.setValue("TAX_CONF", rows[i].getString(dsMAIN.indexOfColumn("TAX_CONF")));
						lrArgData.setValue("BASE_DT_F", rows[i].getString(dsMAIN.indexOfColumn("BASE_DT_F")));
						lrArgData.setValue("BASE_DT_T", rows[i].getString(dsMAIN.indexOfColumn("BASE_DT_T")));
						lrArgData.setValue("MISSING_PROCESS_DT_F", rows[i].getString(dsMAIN.indexOfColumn("MISSING_PROCESS_DT_F")));
						lrArgData.setValue("APPLY_TAG", rows[i].getString(dsMAIN.indexOfColumn("APPLY_TAG")));
						lrArgData.setValue("REMARKS", rows[i].getString(dsMAIN.indexOfColumn("REMARKS")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_ACC_SLIP_BILL_HEAD_D(?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("WORK_NO", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsMAIN.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("WORK_NO", rows[i].getString(dsMAIN.indexOfColumn("WORK_NO")));
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
				GauceInfo.response.writeException("USER", "900001", "T_ACC_SLIP_BILL_HEAD ���̺� ����Ÿ ���� ����" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
	//���糡
	//���⿡ �ٿ���������
			
	//�������
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
						strSql = "{call SP_T_ACC_VAT_DIV_HIST_I(?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("WORK_NO", CITData.NUMBER);
						lrArgData.addColumn("SEQ", CITData.NUMBER);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("DIV_COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("DIV_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("DIV_RATIO", CITData.NUMBER);
						lrArgData.addColumn("CUR_DIV_RATIO", CITData.NUMBER);
						lrArgData.addColumn("GONG_DIV_RATIO", CITData.NUMBER);
						lrArgData.addColumn("PRE_DIV_RATIO", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsSUB01.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("WORK_NO", rows[i].getString(dsSUB01.indexOfColumn("WORK_NO")));
						lrArgData.setValue("SEQ", rows[i].getString(dsSUB01.indexOfColumn("SEQ")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("DIV_COMP_CODE", rows[i].getString(dsSUB01.indexOfColumn("DIV_COMP_CODE")));
						lrArgData.setValue("DIV_CODE", rows[i].getString(dsSUB01.indexOfColumn("DIV_CODE")));
						lrArgData.setValue("DIV_RATIO", rows[i].getString(dsSUB01.indexOfColumn("DIV_RATIO")));
						lrArgData.setValue("CUR_DIV_RATIO", rows[i].getString(dsSUB01.indexOfColumn("CUR_DIV_RATIO")));
						lrArgData.setValue("GONG_DIV_RATIO", rows[i].getString(dsSUB01.indexOfColumn("GONG_DIV_RATIO")));
						lrArgData.setValue("PRE_DIV_RATIO", rows[i].getString(dsSUB01.indexOfColumn("PRE_DIV_RATIO")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_ACC_VAT_DIV_HIST_U(?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("WORK_NO", CITData.NUMBER);
						lrArgData.addColumn("SEQ", CITData.NUMBER);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("DIV_COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("DIV_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("DIV_RATIO", CITData.NUMBER);
						lrArgData.addColumn("CUR_DIV_RATIO", CITData.NUMBER);
						lrArgData.addColumn("GONG_DIV_RATIO", CITData.NUMBER);
						lrArgData.addColumn("PRE_DIV_RATIO", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsSUB01.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("WORK_NO", rows[i].getString(dsSUB01.indexOfColumn("WORK_NO")));
						lrArgData.setValue("SEQ", rows[i].getString(dsSUB01.indexOfColumn("SEQ")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("DIV_COMP_CODE", rows[i].getString(dsSUB01.indexOfColumn("DIV_COMP_CODE")));
						lrArgData.setValue("DIV_CODE", rows[i].getString(dsSUB01.indexOfColumn("DIV_CODE")));
						lrArgData.setValue("DIV_RATIO", rows[i].getString(dsSUB01.indexOfColumn("DIV_RATIO")));
						lrArgData.setValue("CUR_DIV_RATIO", rows[i].getString(dsSUB01.indexOfColumn("CUR_DIV_RATIO")));
						lrArgData.setValue("GONG_DIV_RATIO", rows[i].getString(dsSUB01.indexOfColumn("GONG_DIV_RATIO")));
						lrArgData.setValue("PRE_DIV_RATIO", rows[i].getString(dsSUB01.indexOfColumn("PRE_DIV_RATIO")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_ACC_VAT_DIV_HIST_D(?,?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("WORK_NO", CITData.NUMBER);
						lrArgData.addColumn("SEQ", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsSUB01.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("WORK_NO", rows[i].getString(dsSUB01.indexOfColumn("WORK_NO")));
						lrArgData.setValue("SEQ", rows[i].getString(dsSUB01.indexOfColumn("SEQ")));
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
				GauceInfo.response.writeException("USER", "900001", "T_ACC_VAT_DIV_HIST ���̺� ����Ÿ ���� ����" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
	//���糡
	//���⿡ �ٿ���������
			
		}

		else if(strAct.equals("BATCH01"))
		{
			dsBATCH01 = GauceInfo.request.getGauceDataSet("dsBATCH01");
			
			if (dsBATCH01 == null) throw new Exception("dsBATCH01��(��) ��(Null)�Դϴ�.");
			
			rows = dsBATCH01.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					if ( (rows[i].getJobType() == GauceDataRow.TB_JOB_INSERT) || (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE) )
					{
						strSql = "{call SP_T_ACC_VAT_DIV_BATCH01(?,?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("WORK_NO", CITData.NUMBER);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addRow();
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsBATCH01.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("WORK_NO", rows[i].getString(dsBATCH01.indexOfColumn("WORK_NO")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
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
				GauceInfo.response.writeException("USER", "900001", "T_WORK_REPORT ���̺� ����Ÿ ���� ����" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
		} else {
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
