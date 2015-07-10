<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : 
/* 2. ����(�ó�����) : Update Page
/* 3. ��  ��  ��  �� : 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-03-07)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
	CITGauceInfo GauceInfo = null;
	
	//Dataset�� �������̸� �̺κ��� ���翡 ���̼ſ�(����)
	GauceDataSet dsMAIN = null;
	GauceDataSet dsSUB01 = null;
	GauceDataSet dsSUM = null;
	GauceDataSet dsREMOVE = null;
	//Dataset�� �������̸� �̺κ��� ���翡 ���̼ſ�(��)
	//Dataset�� �������̸� �Ʒ� ��Ÿ���� �κ��� '//�������' ���� '//���糡' ������ ���� ���� �������� '//���⿡ �ٿ���������' �ڸ��� �ٿ���������
	
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
		
		if(!CITCommon.isNull(strAct) && strAct.equals("SUM"))
		{
			dsSUM = GauceInfo.request.getGauceDataSet("dsSUM");
			
			if (dsSUM == null) throw new Exception("dsSUM��(��) ��(Null)�Դϴ�.");
			
			rows = dsSUM.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					strSql = "{call SP_T_SUM_FL_DAY_SUM(?,?)}";
					
					lrArgData.addColumn("WORK_DT", CITData.VARCHAR2);
					lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);

					lrArgData.addRow();
					lrArgData.setValue("WORK_DT", rows[i].getString(dsSUM.indexOfColumn("WORK_DT")));
					lrArgData.setValue("CRTUSERNO", strUserNo);
					
					CITDatabase.executeProcedure(strSql, lrArgData, conn);
				}
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001", "SP_T_MAKE_PERS_COST ���̺� ����Ÿ ���� ����" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
		}
		else if (CITCommon.isNull(strAct))
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
						strSql = "{call SP_T_FL_SUM_HISTORY_I(?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("WORK_DT", CITData.VARCHAR2);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("START_DT_TIME", CITData.VARCHAR2);
						lrArgData.addColumn("END_DT_TIME", CITData.VARCHAR2);
						lrArgData.addColumn("EMP_NO", CITData.VARCHAR2);
						lrArgData.addColumn("NAME", CITData.VARCHAR2);
						lrArgData.addColumn("ERRM", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("WORK_DT", rows[i].getString(dsMAIN.indexOfColumn("WORK_DT")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("START_DT_TIME", rows[i].getString(dsMAIN.indexOfColumn("START_DT_TIME")));
						lrArgData.setValue("END_DT_TIME", rows[i].getString(dsMAIN.indexOfColumn("END_DT_TIME")));
						lrArgData.setValue("EMP_NO", rows[i].getString(dsMAIN.indexOfColumn("EMP_NO")));
						lrArgData.setValue("NAME", rows[i].getString(dsMAIN.indexOfColumn("NAME")));
						lrArgData.setValue("ERRM", rows[i].getString(dsMAIN.indexOfColumn("ERRM")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_FL_SUM_HISTORY_U(?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("WORK_DT", CITData.VARCHAR2);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("START_DT_TIME", CITData.VARCHAR2);
						lrArgData.addColumn("END_DT_TIME", CITData.VARCHAR2);
						lrArgData.addColumn("EMP_NO", CITData.VARCHAR2);
						lrArgData.addColumn("NAME", CITData.VARCHAR2);
						lrArgData.addColumn("ERRM", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("WORK_DT", rows[i].getString(dsMAIN.indexOfColumn("WORK_DT")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("START_DT_TIME", rows[i].getString(dsMAIN.indexOfColumn("START_DT_TIME")));
						lrArgData.setValue("END_DT_TIME", rows[i].getString(dsMAIN.indexOfColumn("END_DT_TIME")));
						lrArgData.setValue("EMP_NO", rows[i].getString(dsMAIN.indexOfColumn("EMP_NO")));
						lrArgData.setValue("NAME", rows[i].getString(dsMAIN.indexOfColumn("NAME")));
						lrArgData.setValue("ERRM", rows[i].getString(dsMAIN.indexOfColumn("ERRM")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_FL_SUM_HISTORY_D(?)}";
						
						lrArgData.addColumn("WORK_DT", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("WORK_DT", rows[i].getString(dsMAIN.indexOfColumn("WORK_DT")));
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
				GauceInfo.response.writeException("USER", "900001", "T_FL_SUM_HISTORY ���̺� ����Ÿ ���� ����" + ex.getMessage());
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