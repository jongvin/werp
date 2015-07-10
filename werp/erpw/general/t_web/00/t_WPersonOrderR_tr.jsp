<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : 
/* 2. ����(�ó�����) : Update Page
/* 3. ��  ��  ��  �� : 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-04-03)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
	CITGauceInfo GauceInfo = null;
	
	//Dataset�� �������̸� �̺κ��� ���翡 ���̼ſ�(����)
	GauceDataSet dsMAIN = null;
	GauceDataSet dsEMP_LIST = null;
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
						strSql = "{call SP_T_FIN_EMP_ORDER_I(?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("EMP_NO", CITData.VARCHAR2);
						lrArgData.addColumn("ORDER_SEQ", CITData.NUMBER);
						lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("ORDER_DT", CITData.VARCHAR2);
						lrArgData.addColumn("SAFE_MNG_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("WORK_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("REMARKS", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("EMP_NO", rows[i].getString(dsMAIN.indexOfColumn("EMP_NO")));
						lrArgData.setValue("ORDER_SEQ", rows[i].getString(dsMAIN.indexOfColumn("ORDER_SEQ")));
						lrArgData.setValue("DEPT_CODE", rows[i].getString(dsMAIN.indexOfColumn("DEPT_CODE")));
						lrArgData.setValue("ORDER_DT", rows[i].getString(dsMAIN.indexOfColumn("ORDER_DT")));
						lrArgData.setValue("SAFE_MNG_TAG", rows[i].getString(dsMAIN.indexOfColumn("SAFE_MNG_TAG")));
						lrArgData.setValue("WORK_TAG", rows[i].getString(dsMAIN.indexOfColumn("WORK_TAG")));
						lrArgData.setValue("REMARKS", rows[i].getString(dsMAIN.indexOfColumn("REMARKS")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_FIN_EMP_ORDER_U(?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("EMP_NO", CITData.VARCHAR2);
						lrArgData.addColumn("ORDER_SEQ", CITData.NUMBER);
						lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("ORDER_DT", CITData.VARCHAR2);
						lrArgData.addColumn("SAFE_MNG_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("WORK_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("REMARKS", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("EMP_NO", rows[i].getString(dsMAIN.indexOfColumn("EMP_NO")));
						lrArgData.setValue("ORDER_SEQ", rows[i].getString(dsMAIN.indexOfColumn("ORDER_SEQ")));
						lrArgData.setValue("DEPT_CODE", rows[i].getString(dsMAIN.indexOfColumn("DEPT_CODE")));
						lrArgData.setValue("ORDER_DT", rows[i].getString(dsMAIN.indexOfColumn("ORDER_DT")));
						lrArgData.setValue("SAFE_MNG_TAG", rows[i].getString(dsMAIN.indexOfColumn("SAFE_MNG_TAG")));
						lrArgData.setValue("WORK_TAG", rows[i].getString(dsMAIN.indexOfColumn("WORK_TAG")));
						lrArgData.setValue("REMARKS", rows[i].getString(dsMAIN.indexOfColumn("REMARKS")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_FIN_EMP_ORDER_D(?,?)}";
						
						lrArgData.addColumn("EMP_NO", CITData.VARCHAR2);
						lrArgData.addColumn("ORDER_SEQ", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("EMP_NO", rows[i].getString(dsMAIN.indexOfColumn("EMP_NO")));
						lrArgData.setValue("ORDER_SEQ", rows[i].getString(dsMAIN.indexOfColumn("ORDER_SEQ")));
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
				GauceInfo.response.writeException("USER", "900001", "T_FIN_EMP_ORDER ���̺� ����Ÿ ���� ����" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
	//���糡
	//���⿡ �ٿ���������
		}
		else if(!CITCommon.isNull(strAct) && strAct.equals("EMP_LIST"))
		{
			dsEMP_LIST = GauceInfo.request.getGauceDataSet("dsEMP_LIST");
			rows = dsEMP_LIST.getDataRows();
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					strSql = "{call SP_T_APPL_ORDER(?,?)}";
					
					lrArgData.addColumn("EMP_NO", CITData.VARCHAR2);
					lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);

					lrArgData.addRow();
					lrArgData.setValue("EMP_NO", rows[i].getString(dsEMP_LIST.indexOfColumn("EMP_NO")));
					lrArgData.setValue("CRTUSERNO", strUserNo);
					
					CITDatabase.executeProcedure(strSql, lrArgData, conn);
				}
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001", "SP_T_APPL_ORDER ���̺� ����Ÿ ���� ����" + ex.getMessage());
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
