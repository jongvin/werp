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
	
	GauceDataSet dsHEAD = null;
	GauceDataSet dsMAKE = null;
	
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
		if(!CITCommon.isNull(strAct) && strAct.equals("MAKE"))
		{
			dsMAKE = GauceInfo.request.getGauceDataSet("dsMAKE");

			rows = dsMAKE.getDataRows();

			try
			{
				if(rows.length > 0)
				{
					CITData lrArgData = new CITData();

					strSql = "{call SP_T_MAKE_SHEET_SUM_START_CLS(?,?,?,?,?)}";

					lrArgData.addColumn("SHEET_CODE", CITData.VARCHAR2);
					lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
					lrArgData.addColumn("CLASS_CODE", CITData.VARCHAR2);
					lrArgData.addColumn("CRTUSERNO", CITData.NUMBER);
					lrArgData.addColumn("PROJ_TAG", CITData.VARCHAR2);

					lrArgData.addRow();
					lrArgData.setValue("SHEET_CODE",  rows[0].getString(dsMAKE.indexOfColumn("SHEET_CODE")));
					lrArgData.setValue("COMP_CODE",  rows[0].getString(dsMAKE.indexOfColumn("COMP_CODE")));
					lrArgData.setValue("CLASS_CODE",  rows[0].getString(dsMAKE.indexOfColumn("CLASS_CODE")));
					lrArgData.setValue("CRTUSERNO",  rows[0].getString(dsMAKE.indexOfColumn("CRTUSERNO")));
					lrArgData.setValue("PROJ_TAG",  rows[0].getString(dsMAKE.indexOfColumn("PROJ_TAG")));

					CITDatabase.executeProcedure(strSql, lrArgData,conn);
				}
			}
			catch (Exception ex)
			{
				GauceInfo.response.writeException("USER", "900001", "����Ÿ ���� ����" + ex.getMessage());
			}
		}
		else if (CITCommon.isNull(strAct))
		{
			dsHEAD = GauceInfo.request.getGauceDataSet("dsHEAD");
			
			if (dsHEAD == null) throw new Exception("dsHEAD��(��) ��(Null)�Դϴ�.");
			
			rows = dsHEAD.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					if (rows[i].getJobType() == GauceDataRow.TB_JOB_INSERT)
					{
						strSql = "{call SP_T_SHEET_SUM_HEAD_CLASS_I(?,?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("SHEET_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CLASS_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("PAST_ACC_ID", CITData.VARCHAR2);
						lrArgData.addColumn("PAST_ACC_FDT", CITData.VARCHAR2);
						lrArgData.addColumn("PAST_ACC_EDT", CITData.VARCHAR2);
						lrArgData.addColumn("CURR_ACC_ID", CITData.VARCHAR2);
						lrArgData.addColumn("CURR_ACC_FDT", CITData.VARCHAR2);
						lrArgData.addColumn("CURR_ACC_EDT", CITData.VARCHAR2);
						lrArgData.addColumn("AMTUNIT", CITData.NUMBER);
						lrArgData.addColumn("EDIT_DT", CITData.VARCHAR2);
						lrArgData.addColumn("EDIT_USERNO", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("SHEET_CODE", rows[i].getString(dsHEAD.indexOfColumn("SHEET_CODE")));
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsHEAD.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("CLASS_CODE", rows[i].getString(dsHEAD.indexOfColumn("CLASS_CODE")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("PAST_ACC_ID", rows[i].getString(dsHEAD.indexOfColumn("PAST_ACC_ID")));
						lrArgData.setValue("PAST_ACC_FDT", rows[i].getString(dsHEAD.indexOfColumn("PAST_ACC_FDT")));
						lrArgData.setValue("PAST_ACC_EDT", rows[i].getString(dsHEAD.indexOfColumn("PAST_ACC_EDT")));
						lrArgData.setValue("CURR_ACC_ID", rows[i].getString(dsHEAD.indexOfColumn("CURR_ACC_ID")));
						lrArgData.setValue("CURR_ACC_FDT", rows[i].getString(dsHEAD.indexOfColumn("CURR_ACC_FDT")));
						lrArgData.setValue("CURR_ACC_EDT", rows[i].getString(dsHEAD.indexOfColumn("CURR_ACC_EDT")));
						lrArgData.setValue("AMTUNIT", rows[i].getString(dsHEAD.indexOfColumn("AMTUNIT")));
						lrArgData.setValue("EDIT_DT", rows[i].getString(dsHEAD.indexOfColumn("EDIT_DT")));
						lrArgData.setValue("EDIT_USERNO", rows[i].getString(dsHEAD.indexOfColumn("EDIT_USERNO")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_SHEET_SUM_HEAD_CLASS_U(?,?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("SHEET_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CLASS_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("PAST_ACC_ID", CITData.VARCHAR2);
						lrArgData.addColumn("PAST_ACC_FDT", CITData.VARCHAR2);
						lrArgData.addColumn("PAST_ACC_EDT", CITData.VARCHAR2);
						lrArgData.addColumn("CURR_ACC_ID", CITData.VARCHAR2);
						lrArgData.addColumn("CURR_ACC_FDT", CITData.VARCHAR2);
						lrArgData.addColumn("CURR_ACC_EDT", CITData.VARCHAR2);
						lrArgData.addColumn("AMTUNIT", CITData.NUMBER);
						lrArgData.addColumn("EDIT_DT", CITData.VARCHAR2);
						lrArgData.addColumn("EDIT_USERNO", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("SHEET_CODE", rows[i].getString(dsHEAD.indexOfColumn("SHEET_CODE")));
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsHEAD.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("CLASS_CODE", rows[i].getString(dsHEAD.indexOfColumn("CLASS_CODE")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("PAST_ACC_ID", rows[i].getString(dsHEAD.indexOfColumn("PAST_ACC_ID")));
						lrArgData.setValue("PAST_ACC_FDT", rows[i].getString(dsHEAD.indexOfColumn("PAST_ACC_FDT")));
						lrArgData.setValue("PAST_ACC_EDT", rows[i].getString(dsHEAD.indexOfColumn("PAST_ACC_EDT")));
						lrArgData.setValue("CURR_ACC_ID", rows[i].getString(dsHEAD.indexOfColumn("CURR_ACC_ID")));
						lrArgData.setValue("CURR_ACC_FDT", rows[i].getString(dsHEAD.indexOfColumn("CURR_ACC_FDT")));
						lrArgData.setValue("CURR_ACC_EDT", rows[i].getString(dsHEAD.indexOfColumn("CURR_ACC_EDT")));
						lrArgData.setValue("AMTUNIT", rows[i].getString(dsHEAD.indexOfColumn("AMTUNIT")));
						lrArgData.setValue("EDIT_DT", rows[i].getString(dsHEAD.indexOfColumn("EDIT_DT")));
						lrArgData.setValue("EDIT_USERNO", rows[i].getString(dsHEAD.indexOfColumn("EDIT_USERNO")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_SHEET_SUM_HEAD_CLASS_D(?,?,?)}";
						
						lrArgData.addColumn("SHEET_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CLASS_CODE", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("SHEET_CODE", rows[i].getString(dsHEAD.indexOfColumn("SHEET_CODE")));
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsHEAD.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("CLASS_CODE", rows[i].getString(dsHEAD.indexOfColumn("CLASS_CODE")));
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
				GauceInfo.response.writeException("USER", "900001", "T_SHEET_SUM_HEAD ���̺� ����Ÿ ���� ����" + ex.getMessage());
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
