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
						strSql = "{call SP_T_PL_MA_DVD_RAT_HIST_I(?,?,?,?)}";
						
						lrArgData.addColumn("HIST_SEQ", CITData.NUMBER);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("NAME", CITData.VARCHAR2);
						lrArgData.addColumn("APPL_DT", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("HIST_SEQ", rows[i].getString(dsMAIN.indexOfColumn("HIST_SEQ")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("NAME", rows[i].getString(dsMAIN.indexOfColumn("NAME")));
						lrArgData.setValue("APPL_DT", rows[i].getString(dsMAIN.indexOfColumn("APPL_DT")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_PL_MA_DVD_RAT_HIST_U(?,?,?,?)}";
						
						lrArgData.addColumn("HIST_SEQ", CITData.NUMBER);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("NAME", CITData.VARCHAR2);
						lrArgData.addColumn("APPL_DT", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("HIST_SEQ", rows[i].getString(dsMAIN.indexOfColumn("HIST_SEQ")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("NAME", rows[i].getString(dsMAIN.indexOfColumn("NAME")));
						lrArgData.setValue("APPL_DT", rows[i].getString(dsMAIN.indexOfColumn("APPL_DT")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_PL_MA_DVD_RAT_HIST_D(?)}";
						
						lrArgData.addColumn("HIST_SEQ", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("HIST_SEQ", rows[i].getString(dsMAIN.indexOfColumn("HIST_SEQ")));
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
				GauceInfo.response.writeException("USER", "900001", "T_PL_MA_DVD_RAT_HIST ���̺� ����Ÿ ���� ����" + ex.getMessage());
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
						strSql = "{call SP_T_PL_MA_DVD_RAT_LIST_I(?,?,?,?,?)}";
						
						lrArgData.addColumn("HIST_SEQ", CITData.NUMBER);
						lrArgData.addColumn("DVD_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("DVD_RAT_POSITION", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("HIST_SEQ", rows[i].getString(dsSUB01.indexOfColumn("HIST_SEQ")));
						lrArgData.setValue("DVD_CODE", rows[i].getString(dsSUB01.indexOfColumn("DVD_CODE")));
						lrArgData.setValue("DEPT_CODE", rows[i].getString(dsSUB01.indexOfColumn("DEPT_CODE")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("DVD_RAT_POSITION", rows[i].getString(dsSUB01.indexOfColumn("DVD_RAT_POSITION")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_PL_MA_DVD_RAT_LIST_U(?,?,?,?,?)}";
						
						lrArgData.addColumn("HIST_SEQ", CITData.NUMBER);
						lrArgData.addColumn("DVD_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("DVD_RAT_POSITION", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("HIST_SEQ", rows[i].getString(dsSUB01.indexOfColumn("HIST_SEQ")));
						lrArgData.setValue("DVD_CODE", rows[i].getString(dsSUB01.indexOfColumn("DVD_CODE")));
						lrArgData.setValue("DEPT_CODE", rows[i].getString(dsSUB01.indexOfColumn("DEPT_CODE")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("DVD_RAT_POSITION", rows[i].getString(dsSUB01.indexOfColumn("DVD_RAT_POSITION")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_PL_MA_DVD_RAT_LIST_D(?,?,?)}";
						
						lrArgData.addColumn("HIST_SEQ", CITData.NUMBER);
						lrArgData.addColumn("DVD_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("HIST_SEQ", rows[i].getString(dsSUB01.indexOfColumn("HIST_SEQ")));
						lrArgData.setValue("DVD_CODE", rows[i].getString(dsSUB01.indexOfColumn("DVD_CODE")));
						lrArgData.setValue("DEPT_CODE", rows[i].getString(dsSUB01.indexOfColumn("DEPT_CODE")));
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
				GauceInfo.response.writeException("USER", "900001", "T_PL_MA_DVD_RAT_LIST ���̺� ����Ÿ ���� ����" + ex.getMessage());
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
						strSql = "{call Pkg_Pl_Ma_Dvd_Rat_Exec.ProcessBatch(?,?,?)}";
						
						lrArgData.addColumn("HIST_SEQ", CITData.NUMBER);
						lrArgData.addColumn("DVD_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addRow();
						lrArgData.setValue("HIST_SEQ", rows[i].getString(dsBATCH01.indexOfColumn("HIST_SEQ")));
						lrArgData.setValue("DVD_CODE", rows[i].getString(dsBATCH01.indexOfColumn("DVD_CODE")));
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
