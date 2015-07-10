<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : 
/* 2. ����(�ó�����) : Update Page
/* 3. ��  ��  ��  �� : 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-03-30)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
	CITGauceInfo GauceInfo = null;
	
	//Dataset�� �������̸� �̺κ��� ���翡 ���̼ſ�(����)
	GauceDataSet dsMAIN = null;
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
						strSql = "{call SP_T_FIN_EMP_IN_ACC_NO_I(?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("ERMP_NO", CITData.VARCHAR2);
						lrArgData.addColumn("IN_BANK_MAIN_CODE_1", CITData.VARCHAR2);
						lrArgData.addColumn("IN_ACC_NO_1", CITData.VARCHAR2);
						lrArgData.addColumn("IN_BANK_MAIN_CODE_2", CITData.VARCHAR2);
						lrArgData.addColumn("IN_ACC_NO_2", CITData.VARCHAR2);
						lrArgData.addColumn("IN_BANK_MAIN_CODE_3", CITData.VARCHAR2);
						lrArgData.addColumn("IN_ACC_NO_3", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("ERMP_NO", rows[i].getString(dsMAIN.indexOfColumn("ERMP_NO")));
						lrArgData.setValue("IN_BANK_MAIN_CODE_1", rows[i].getString(dsMAIN.indexOfColumn("IN_BANK_MAIN_CODE_1")));
						lrArgData.setValue("IN_ACC_NO_1", rows[i].getString(dsMAIN.indexOfColumn("IN_ACC_NO_1")));
						lrArgData.setValue("IN_BANK_MAIN_CODE_2", rows[i].getString(dsMAIN.indexOfColumn("IN_BANK_MAIN_CODE_2")));
						lrArgData.setValue("IN_ACC_NO_2", rows[i].getString(dsMAIN.indexOfColumn("IN_ACC_NO_2")));
						lrArgData.setValue("IN_BANK_MAIN_CODE_3", rows[i].getString(dsMAIN.indexOfColumn("IN_BANK_MAIN_CODE_3")));
						lrArgData.setValue("IN_ACC_NO_3", rows[i].getString(dsMAIN.indexOfColumn("IN_ACC_NO_3")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_FIN_EMP_IN_ACC_NO_U(?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("ERMP_NO", CITData.VARCHAR2);
						lrArgData.addColumn("IN_BANK_MAIN_CODE_1", CITData.VARCHAR2);
						lrArgData.addColumn("IN_ACC_NO_1", CITData.VARCHAR2);
						lrArgData.addColumn("IN_BANK_MAIN_CODE_2", CITData.VARCHAR2);
						lrArgData.addColumn("IN_ACC_NO_2", CITData.VARCHAR2);
						lrArgData.addColumn("IN_BANK_MAIN_CODE_3", CITData.VARCHAR2);
						lrArgData.addColumn("IN_ACC_NO_3", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("ERMP_NO", rows[i].getString(dsMAIN.indexOfColumn("ERMP_NO")));
						lrArgData.setValue("IN_BANK_MAIN_CODE_1", rows[i].getString(dsMAIN.indexOfColumn("IN_BANK_MAIN_CODE_1")));
						lrArgData.setValue("IN_ACC_NO_1", rows[i].getString(dsMAIN.indexOfColumn("IN_ACC_NO_1")));
						lrArgData.setValue("IN_BANK_MAIN_CODE_2", rows[i].getString(dsMAIN.indexOfColumn("IN_BANK_MAIN_CODE_2")));
						lrArgData.setValue("IN_ACC_NO_2", rows[i].getString(dsMAIN.indexOfColumn("IN_ACC_NO_2")));
						lrArgData.setValue("IN_BANK_MAIN_CODE_3", rows[i].getString(dsMAIN.indexOfColumn("IN_BANK_MAIN_CODE_3")));
						lrArgData.setValue("IN_ACC_NO_3", rows[i].getString(dsMAIN.indexOfColumn("IN_ACC_NO_3")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_FIN_EMP_IN_ACC_NO_D(?)}";
						
						lrArgData.addColumn("ERMP_NO", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("ERMP_NO", rows[i].getString(dsMAIN.indexOfColumn("ERMP_NO")));
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
				GauceInfo.response.writeException("USER", "900001", "T_FIN_EMP_IN_ACC_NO ���̺� ����Ÿ ���� ����" + ex.getMessage());
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
