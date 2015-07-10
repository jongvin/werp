<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : 
/* 2. ����(�ó�����) : Update Page
/* 3. ��  ��  ��  �� : 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-24)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
	CITGauceInfo GauceInfo = null;
	
	GauceDataSet dsMAIN = null;
	GauceDataSet dsSUB01 = null;
	GauceDataSet dsMAKE = null;
	GauceDataSet dsMAKE2 = null;
	
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
		if(! CITCommon.isNull(strAct) && strAct.equals("MAKE"))
		{
			dsMAKE = GauceInfo.request.getGauceDataSet("dsMAKE");
			rows = dsMAKE.getDataRows();

			try
			{
				if(rows.length > 0)
				{
					CITData lrArgData = new CITData();

					strSql = "{call SP_T_AUTO_CALC_EXPR_SEQ1(?,?)}";

					lrArgData.addColumn("SHEET_CODE", CITData.VARCHAR2);
					lrArgData.addColumn("CRTUSERNO", CITData.NUMBER);

					lrArgData.addRow();
					lrArgData.setValue("SHEET_CODE",  rows[0].getString(dsMAKE.indexOfColumn("SHEET_CODE")));
					lrArgData.setValue("CRTUSERNO",  rows[0].getString(dsMAKE.indexOfColumn("CRTUSERNO")));

					CITDatabase.executeProcedure(strSql, lrArgData, conn);
				}
			}
			catch (Exception ex)
			{
				GauceInfo.response.writeException("USER", "900001", "����Ÿ ���� ���� dsMAKE" + ex.getMessage());
			}
		}
		else if(! CITCommon.isNull(strAct) && strAct.equals("MAKE2"))
		{
			dsMAKE2 = GauceInfo.request.getGauceDataSet("dsMAKE2");
			rows = dsMAKE2.getDataRows();

			try
			{
				if(rows.length > 0)
				{
					CITData lrArgData = new CITData();

					strSql = "{call SP_T_COPY_SHEET_EXPR(?,?,?)}";

					lrArgData.addColumn("SHEET_CODE_TARGET", CITData.VARCHAR2);
					lrArgData.addColumn("SHEET_CODE_SOURCE", CITData.VARCHAR2);
					lrArgData.addColumn("CRTUSERNO", CITData.NUMBER);

					lrArgData.addRow();
					lrArgData.setValue("SHEET_CODE_TARGET",  rows[0].getString(dsMAKE2.indexOfColumn("SHEET_CODE_TARGET")));
					lrArgData.setValue("SHEET_CODE_SOURCE",  rows[0].getString(dsMAKE2.indexOfColumn("SHEET_CODE_SOURCE")));
					lrArgData.setValue("CRTUSERNO",  rows[0].getString(dsMAKE2.indexOfColumn("CRTUSERNO")));

					CITDatabase.executeProcedure(strSql, lrArgData, conn);
				}
			}
			catch (Exception ex)
			{
				GauceInfo.response.writeException("USER", "900001", "����Ÿ ���� ���� dsMAKE2" + ex.getMessage());
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
					
					if (rows[i].getJobType() == GauceDataRow.TB_JOB_INSERT)
					{
						strSql = "{call SP_T_SHEET_EXPR_HEAD_I(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("SHEET_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("ITEM_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("ITEM_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("ITEM_LVL", CITData.NUMBER);
						lrArgData.addColumn("POSITION", CITData.VARCHAR2);
						lrArgData.addColumn("SEQ_TYPE", CITData.VARCHAR2);
						lrArgData.addColumn("BOLD_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("OUT_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("UPLINE_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("DOWNLINE_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("CURR_PROFIT_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("CURR_PAST_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("EXPR_SEQ1", CITData.VARCHAR2);
						lrArgData.addColumn("ITEM_ENG_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("COST_CODE", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("SHEET_CODE", rows[i].getString(dsMAIN.indexOfColumn("SHEET_CODE")));
						lrArgData.setValue("ITEM_CODE", rows[i].getString(dsMAIN.indexOfColumn("ITEM_CODE")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("ITEM_NAME", rows[i].getString(dsMAIN.indexOfColumn("ITEM_NAME")));
						lrArgData.setValue("ITEM_LVL", rows[i].getString(dsMAIN.indexOfColumn("ITEM_LVL")));
						lrArgData.setValue("POSITION", rows[i].getString(dsMAIN.indexOfColumn("POSITION")));
						lrArgData.setValue("SEQ_TYPE", rows[i].getString(dsMAIN.indexOfColumn("SEQ_TYPE")));
						lrArgData.setValue("BOLD_CLS", rows[i].getString(dsMAIN.indexOfColumn("BOLD_CLS")));
						lrArgData.setValue("OUT_CLS", rows[i].getString(dsMAIN.indexOfColumn("OUT_CLS")));
						lrArgData.setValue("UPLINE_CLS", rows[i].getString(dsMAIN.indexOfColumn("UPLINE_CLS")));
						lrArgData.setValue("DOWNLINE_CLS", rows[i].getString(dsMAIN.indexOfColumn("DOWNLINE_CLS")));
						lrArgData.setValue("CURR_PROFIT_CLS", rows[i].getString(dsMAIN.indexOfColumn("CURR_PROFIT_CLS")));
						lrArgData.setValue("CURR_PAST_CLS", rows[i].getString(dsMAIN.indexOfColumn("CURR_PAST_CLS")));
						lrArgData.setValue("EXPR_SEQ1", rows[i].getString(dsMAIN.indexOfColumn("EXPR_SEQ1")));
						lrArgData.setValue("ITEM_ENG_NAME", rows[i].getString(dsMAIN.indexOfColumn("ITEM_ENG_NAME")));
						lrArgData.setValue("COST_CODE", rows[i].getString(dsMAIN.indexOfColumn("COST_CODE")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_SHEET_EXPR_HEAD_U(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("SHEET_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("ITEM_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("ITEM_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("ITEM_LVL", CITData.NUMBER);
						lrArgData.addColumn("POSITION", CITData.VARCHAR2);
						lrArgData.addColumn("SEQ_TYPE", CITData.VARCHAR2);
						lrArgData.addColumn("BOLD_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("OUT_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("UPLINE_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("DOWNLINE_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("CURR_PROFIT_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("CURR_PAST_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("EXPR_SEQ1", CITData.VARCHAR2);
						lrArgData.addColumn("ITEM_ENG_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("COST_CODE", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("SHEET_CODE", rows[i].getString(dsMAIN.indexOfColumn("SHEET_CODE")));
						lrArgData.setValue("ITEM_CODE", rows[i].getString(dsMAIN.indexOfColumn("ITEM_CODE")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("ITEM_NAME", rows[i].getString(dsMAIN.indexOfColumn("ITEM_NAME")));
						lrArgData.setValue("ITEM_LVL", rows[i].getString(dsMAIN.indexOfColumn("ITEM_LVL")));
						lrArgData.setValue("POSITION", rows[i].getString(dsMAIN.indexOfColumn("POSITION")));
						lrArgData.setValue("SEQ_TYPE", rows[i].getString(dsMAIN.indexOfColumn("SEQ_TYPE")));
						lrArgData.setValue("BOLD_CLS", rows[i].getString(dsMAIN.indexOfColumn("BOLD_CLS")));
						lrArgData.setValue("OUT_CLS", rows[i].getString(dsMAIN.indexOfColumn("OUT_CLS")));
						lrArgData.setValue("UPLINE_CLS", rows[i].getString(dsMAIN.indexOfColumn("UPLINE_CLS")));
						lrArgData.setValue("DOWNLINE_CLS", rows[i].getString(dsMAIN.indexOfColumn("DOWNLINE_CLS")));
						lrArgData.setValue("CURR_PROFIT_CLS", rows[i].getString(dsMAIN.indexOfColumn("CURR_PROFIT_CLS")));
						lrArgData.setValue("CURR_PAST_CLS", rows[i].getString(dsMAIN.indexOfColumn("CURR_PAST_CLS")));
						lrArgData.setValue("EXPR_SEQ1", rows[i].getString(dsMAIN.indexOfColumn("EXPR_SEQ1")));
						lrArgData.setValue("ITEM_ENG_NAME", rows[i].getString(dsMAIN.indexOfColumn("ITEM_ENG_NAME")));
						lrArgData.setValue("COST_CODE", rows[i].getString(dsMAIN.indexOfColumn("COST_CODE")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_SHEET_EXPR_HEAD_D(?,?)}";
						
						lrArgData.addColumn("SHEET_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("ITEM_CODE", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("SHEET_CODE", rows[i].getString(dsMAIN.indexOfColumn("SHEET_CODE")));
						lrArgData.setValue("ITEM_CODE", rows[i].getString(dsMAIN.indexOfColumn("ITEM_CODE")));
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
				GauceInfo.response.writeException("USER", "900001", "T_SHEET_EXPR_HEAD ���̺� ����Ÿ ���� ����" + ex.getMessage());
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
						strSql = "{call SP_T_SHEET_EXPR_BODY_I(?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("SHEET_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("ITEM_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("SEQ", CITData.NUMBER);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("ACC_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("POSITION", CITData.VARCHAR2);
						lrArgData.addColumn("REMAIN_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("CALC_CLS", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("SHEET_CODE", rows[i].getString(dsSUB01.indexOfColumn("SHEET_CODE")));
						lrArgData.setValue("ITEM_CODE", rows[i].getString(dsSUB01.indexOfColumn("ITEM_CODE")));
						lrArgData.setValue("SEQ", rows[i].getString(dsSUB01.indexOfColumn("SEQ")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("ACC_CODE", rows[i].getString(dsSUB01.indexOfColumn("ACC_CODE")));
						lrArgData.setValue("POSITION", rows[i].getString(dsSUB01.indexOfColumn("POSITION")));
						lrArgData.setValue("REMAIN_CLS", rows[i].getString(dsSUB01.indexOfColumn("REMAIN_CLS")));
						lrArgData.setValue("CALC_CLS", rows[i].getString(dsSUB01.indexOfColumn("CALC_CLS")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_SHEET_EXPR_BODY_U(?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("SHEET_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("ITEM_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("SEQ", CITData.NUMBER);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("ACC_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("POSITION", CITData.VARCHAR2);
						lrArgData.addColumn("REMAIN_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("CALC_CLS", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("SHEET_CODE", rows[i].getString(dsSUB01.indexOfColumn("SHEET_CODE")));
						lrArgData.setValue("ITEM_CODE", rows[i].getString(dsSUB01.indexOfColumn("ITEM_CODE")));
						lrArgData.setValue("SEQ", rows[i].getString(dsSUB01.indexOfColumn("SEQ")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("ACC_CODE", rows[i].getString(dsSUB01.indexOfColumn("ACC_CODE")));
						lrArgData.setValue("POSITION", rows[i].getString(dsSUB01.indexOfColumn("POSITION")));
						lrArgData.setValue("REMAIN_CLS", rows[i].getString(dsSUB01.indexOfColumn("REMAIN_CLS")));
						lrArgData.setValue("CALC_CLS", rows[i].getString(dsSUB01.indexOfColumn("CALC_CLS")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_SHEET_EXPR_BODY_D(?,?,?)}";
						
						lrArgData.addColumn("SHEET_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("ITEM_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("SEQ", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("SHEET_CODE", rows[i].getString(dsSUB01.indexOfColumn("SHEET_CODE")));
						lrArgData.setValue("ITEM_CODE", rows[i].getString(dsSUB01.indexOfColumn("ITEM_CODE")));
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
				GauceInfo.response.writeException("USER", "900001", "T_SHEET_EXPR_BODY ���̺� ����Ÿ ���� ����" + ex.getMessage());
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
