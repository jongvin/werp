<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : 
/* 2. ����(�ó�����) : Update Page
/* 3. ��  ��  ��  �� : 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-03-22)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
	CITGauceInfo GauceInfo = null;
	
	//Dataset�� �������̸� �̺κ��� ���翡 ���̼ſ�(����)
	GauceDataSet dsMAIN = null;
	GauceDataSet dsSUB01 = null;
	GauceDataSet dsMAKE_DATA = null;
	GauceDataSet dsMAKE_SLIP = null;
	GauceDataSet dsREMOVE_SLIP = null;
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
		if(!CITCommon.isNull(strAct) && strAct.equals("MAKE_DATA"))
		{
	//�������
			dsMAKE_DATA = GauceInfo.request.getGauceDataSet("dsMAKE_DATA");
			
			if (dsMAKE_DATA == null) throw new Exception("dsMAKE_DATA��(��) ��(Null)�Դϴ�.");
			
			rows = dsMAKE_DATA.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_SET_MAKE_CONS_DEC_DATA(?,?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("WORK_NO", CITData.NUMBER);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsMAKE_DATA.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("WORK_NO", rows[i].getString(dsMAKE_DATA.indexOfColumn("WORK_NO")));
						lrArgData.setValue("MODUSERNO", strUserNo);
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
				GauceInfo.response.writeException("USER", "900001", "SP_T_SET_MAKE_CONS_DEC_DATA ���̺� ����Ÿ ���� ����" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
	//���糡
		}
		else if(!CITCommon.isNull(strAct) && strAct.equals("MAKE_SLIP"))
		{
	//�������
			dsMAKE_SLIP = GauceInfo.request.getGauceDataSet("dsMAKE_SLIP");
			
			if (dsMAKE_SLIP == null) throw new Exception("dsMAKE_SLIP��(��) ��(Null)�Դϴ�.");
			
			rows = dsMAKE_SLIP.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_SET_MAKE_CONS_DEC_SLIP(?,?,?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("WORK_NO", CITData.NUMBER);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsMAKE_SLIP.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("DEPT_CODE", rows[i].getString(dsMAKE_SLIP.indexOfColumn("DEPT_CODE")));
						lrArgData.setValue("WORK_NO", rows[i].getString(dsMAKE_SLIP.indexOfColumn("WORK_NO")));
						lrArgData.setValue("MODUSERNO", strUserNo);
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
				GauceInfo.response.writeException("USER", "900001", "SP_T_SET_MAKE_CONS_DEC_DATA ���̺� ����Ÿ ���� ����" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
	//���糡
		}
		else if(!CITCommon.isNull(strAct) && strAct.equals("REMOVE_SLIP"))
		{
	//�������
			dsREMOVE_SLIP = GauceInfo.request.getGauceDataSet("dsREMOVE_SLIP");
			
			if (dsREMOVE_SLIP == null) throw new Exception("dsREMOVE_SLIP��(��) ��(Null)�Դϴ�.");
			
			rows = dsREMOVE_SLIP.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_SET_REMOVE_CONS_DEC_SLIP(?,?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("WORK_NO", CITData.NUMBER);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsREMOVE_SLIP.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("WORK_NO", rows[i].getString(dsREMOVE_SLIP.indexOfColumn("WORK_NO")));
						lrArgData.setValue("MODUSERNO", strUserNo);
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
				GauceInfo.response.writeException("USER", "900001", "SP_T_SET_MAKE_CONS_DEC_DATA ���̺� ����Ÿ ���� ����" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
	//���糡
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
						strSql = "{call SP_T_SET_CONS_INSUR_DEC_WORK_I(?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("WORK_NO", CITData.NUMBER);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("WORK_DT", CITData.VARCHAR2);
						lrArgData.addColumn("CONTENTS", CITData.VARCHAR2);
						lrArgData.addColumn("SLIP_ID", CITData.NUMBER);
						lrArgData.addColumn("SLIP_IDSEQ", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsMAIN.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("WORK_NO", rows[i].getString(dsMAIN.indexOfColumn("WORK_NO")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("WORK_DT", rows[i].getString(dsMAIN.indexOfColumn("WORK_DT")));
						lrArgData.setValue("CONTENTS", rows[i].getString(dsMAIN.indexOfColumn("CONTENTS")));
						lrArgData.setValue("SLIP_ID", rows[i].getString(dsMAIN.indexOfColumn("SLIP_ID")));
						lrArgData.setValue("SLIP_IDSEQ", rows[i].getString(dsMAIN.indexOfColumn("SLIP_IDSEQ")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_SET_CONS_INSUR_DEC_WORK_U(?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("WORK_NO", CITData.NUMBER);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("WORK_DT", CITData.VARCHAR2);
						lrArgData.addColumn("CONTENTS", CITData.VARCHAR2);
						lrArgData.addColumn("SLIP_ID", CITData.NUMBER);
						lrArgData.addColumn("SLIP_IDSEQ", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsMAIN.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("WORK_NO", rows[i].getString(dsMAIN.indexOfColumn("WORK_NO")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("WORK_DT", rows[i].getString(dsMAIN.indexOfColumn("WORK_DT")));
						lrArgData.setValue("CONTENTS", rows[i].getString(dsMAIN.indexOfColumn("CONTENTS")));
						lrArgData.setValue("SLIP_ID", rows[i].getString(dsMAIN.indexOfColumn("SLIP_ID")));
						lrArgData.setValue("SLIP_IDSEQ", rows[i].getString(dsMAIN.indexOfColumn("SLIP_IDSEQ")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_SET_CONS_INSUR_DEC_WORK_D(?,?)}";
						
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
				GauceInfo.response.writeException("USER", "900001", "T_SET_CONS_INSUR_DEC_WORK ���̺� ����Ÿ ���� ����" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
	//���糡
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
						continue;
						//�����ϱ׷����� ������ �Ұ��մϴ�.
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_SET_CONS_INSUR_DEC_AMT_U(?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("INSUR_NO", CITData.NUMBER);
						lrArgData.addColumn("DEC_NO", CITData.NUMBER);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("DEC_AMT", CITData.NUMBER);
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("WORK_NO", CITData.NUMBER);
						lrArgData.addColumn("SLIP_ID", CITData.NUMBER);
						lrArgData.addColumn("SLIP_IDSEQ", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("DEPT_CODE", rows[i].getString(dsSUB01.indexOfColumn("DEPT_CODE")));
						lrArgData.setValue("INSUR_NO", rows[i].getString(dsSUB01.indexOfColumn("INSUR_NO")));
						lrArgData.setValue("DEC_NO", rows[i].getString(dsSUB01.indexOfColumn("DEC_NO")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("DEC_AMT", rows[i].getString(dsSUB01.indexOfColumn("DEC_AMT")));
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsSUB01.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("WORK_NO", rows[i].getString(dsSUB01.indexOfColumn("WORK_NO")));
						lrArgData.setValue("SLIP_ID", rows[i].getString(dsSUB01.indexOfColumn("SLIP_ID")));
						lrArgData.setValue("SLIP_IDSEQ", rows[i].getString(dsSUB01.indexOfColumn("SLIP_IDSEQ")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_SET_CONS_INSUR_DEC_AMT_D(?,?,?)}";
						
						lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("INSUR_NO", CITData.NUMBER);
						lrArgData.addColumn("DEC_NO", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("DEPT_CODE", rows[i].getString(dsSUB01.indexOfColumn("DEPT_CODE")));
						lrArgData.setValue("INSUR_NO", rows[i].getString(dsSUB01.indexOfColumn("INSUR_NO")));
						lrArgData.setValue("DEC_NO", rows[i].getString(dsSUB01.indexOfColumn("DEC_NO")));
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
				GauceInfo.response.writeException("USER", "900001", "T_SET_CONS_INSUR_DEC_AMT ���̺� ����Ÿ ���� ����" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
	//���糡
	//���⿡ �ٿ���������
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
