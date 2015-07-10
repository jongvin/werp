<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : 
/* 2. ����(�ó�����) : Update Page
/* 3. ��  ��  ��  �� : 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-04-10)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
	CITGauceInfo GauceInfo = null;
	
	//Dataset�� �������̸� �̺κ��� ���翡 ���̼ſ�(����)
	GauceDataSet dsMAIN = null;
	GauceDataSet dsSUB01 = null;
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
						strSql = "{call SP_T_SET_COST_CONV_CODE_I(?,?,?,?)}";
						
						lrArgData.addColumn("COST_CONV_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("COST_CONV_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("SALE_ACC_CODE", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("COST_CONV_CODE", rows[i].getString(dsMAIN.indexOfColumn("COST_CONV_CODE")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("COST_CONV_NAME", rows[i].getString(dsMAIN.indexOfColumn("COST_CONV_NAME")));
						lrArgData.setValue("SALE_ACC_CODE", rows[i].getString(dsMAIN.indexOfColumn("SALE_ACC_CODE")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_SET_COST_CONV_CODE_U(?,?,?,?)}";
						
						lrArgData.addColumn("COST_CONV_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("COST_CONV_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("SALE_ACC_CODE", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("COST_CONV_CODE", rows[i].getString(dsMAIN.indexOfColumn("COST_CONV_CODE")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("COST_CONV_NAME", rows[i].getString(dsMAIN.indexOfColumn("COST_CONV_NAME")));
						lrArgData.setValue("SALE_ACC_CODE", rows[i].getString(dsMAIN.indexOfColumn("SALE_ACC_CODE")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_SET_COST_CONV_CODE_D(?)}";
						
						lrArgData.addColumn("COST_CONV_CODE", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("COST_CONV_CODE", rows[i].getString(dsMAIN.indexOfColumn("COST_CONV_CODE")));
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
				GauceInfo.response.writeException("USER", "900001", "T_SET_COST_CONV_CODE ���̺� ����Ÿ ���� ����" + ex.getMessage());
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
						strSql = "{call SP_T_SET_COST_CONV_ACC_I(?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("COST_CONV_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("ACC_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("R_ACC_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("R_ACC_CODE2", CITData.VARCHAR2);
						lrArgData.addColumn("R_ACC_CODE3", CITData.VARCHAR2);
						lrArgData.addColumn("R_ACC_CODE4", CITData.VARCHAR2);
						lrArgData.addColumn("R_ACC_CODE5", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("COST_CONV_CODE", rows[i].getString(dsSUB01.indexOfColumn("COST_CONV_CODE")));
						lrArgData.setValue("ACC_CODE", rows[i].getString(dsSUB01.indexOfColumn("ACC_CODE")));
						lrArgData.setValue("R_ACC_CODE", rows[i].getString(dsSUB01.indexOfColumn("R_ACC_CODE")));
						lrArgData.setValue("R_ACC_CODE2", rows[i].getString(dsSUB01.indexOfColumn("R_ACC_CODE2")));
						lrArgData.setValue("R_ACC_CODE3", rows[i].getString(dsSUB01.indexOfColumn("R_ACC_CODE3")));
						lrArgData.setValue("R_ACC_CODE4", rows[i].getString(dsSUB01.indexOfColumn("R_ACC_CODE4")));
						lrArgData.setValue("R_ACC_CODE5", rows[i].getString(dsSUB01.indexOfColumn("R_ACC_CODE5")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_SET_COST_CONV_ACC_U(?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("COST_CONV_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("ACC_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("R_ACC_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("R_ACC_CODE2", CITData.VARCHAR2);
						lrArgData.addColumn("R_ACC_CODE3", CITData.VARCHAR2);
						lrArgData.addColumn("R_ACC_CODE4", CITData.VARCHAR2);
						lrArgData.addColumn("R_ACC_CODE5", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("COST_CONV_CODE", rows[i].getString(dsSUB01.indexOfColumn("COST_CONV_CODE")));
						lrArgData.setValue("ACC_CODE", rows[i].getString(dsSUB01.indexOfColumn("ACC_CODE")));
						lrArgData.setValue("R_ACC_CODE", rows[i].getString(dsSUB01.indexOfColumn("R_ACC_CODE")));
						lrArgData.setValue("R_ACC_CODE2", rows[i].getString(dsSUB01.indexOfColumn("R_ACC_CODE2")));
						lrArgData.setValue("R_ACC_CODE3", rows[i].getString(dsSUB01.indexOfColumn("R_ACC_CODE3")));
						lrArgData.setValue("R_ACC_CODE4", rows[i].getString(dsSUB01.indexOfColumn("R_ACC_CODE4")));
						lrArgData.setValue("R_ACC_CODE5", rows[i].getString(dsSUB01.indexOfColumn("R_ACC_CODE5")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_SET_COST_CONV_ACC_D(?,?)}";
						
						lrArgData.addColumn("COST_CONV_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("ACC_CODE", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("COST_CONV_CODE", rows[i].getString(dsSUB01.indexOfColumn("COST_CONV_CODE")));
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
				GauceInfo.response.writeException("USER", "900001", "T_SET_COST_CONV_ACC ���̺� ����Ÿ ���� ����" + ex.getMessage());
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
