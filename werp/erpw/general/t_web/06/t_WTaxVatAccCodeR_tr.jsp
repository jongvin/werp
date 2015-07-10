<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : 
/* 2. ����(�ó�����) : Update Page
/* 3. ��  ��  ��  �� : 
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2006-02-14)
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
						strSql = "{call SP_T_ACC_CODE_EXT01_I(?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("ACC_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("SALEBUY_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("RCPTBILL_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("SUBTR_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("VATOCCUR_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("SLIP_DETAIL_LIST", CITData.VARCHAR2);
						lrArgData.addColumn("REMARK", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("ACC_CODE", rows[i].getString(dsMAIN.indexOfColumn("ACC_CODE")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("SALEBUY_CLS", rows[i].getString(dsMAIN.indexOfColumn("SALEBUY_CLS")));
						lrArgData.setValue("RCPTBILL_CLS", rows[i].getString(dsMAIN.indexOfColumn("RCPTBILL_CLS")));
						lrArgData.setValue("SUBTR_CLS", rows[i].getString(dsMAIN.indexOfColumn("SUBTR_CLS")));
						lrArgData.setValue("VATOCCUR_CLS", rows[i].getString(dsMAIN.indexOfColumn("VATOCCUR_CLS")));
						lrArgData.setValue("SLIP_DETAIL_LIST", rows[i].getString(dsMAIN.indexOfColumn("SLIP_DETAIL_LIST")));
						lrArgData.setValue("REMARK", rows[i].getString(dsMAIN.indexOfColumn("REMARK")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_ACC_CODE_EXT01_U(?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("ACC_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("SALEBUY_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("RCPTBILL_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("SUBTR_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("VATOCCUR_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("SLIP_DETAIL_LIST", CITData.VARCHAR2);
						lrArgData.addColumn("REMARK", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("ACC_CODE", rows[i].getString(dsMAIN.indexOfColumn("ACC_CODE")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("SALEBUY_CLS", rows[i].getString(dsMAIN.indexOfColumn("SALEBUY_CLS")));
						lrArgData.setValue("RCPTBILL_CLS", rows[i].getString(dsMAIN.indexOfColumn("RCPTBILL_CLS")));
						lrArgData.setValue("SUBTR_CLS", rows[i].getString(dsMAIN.indexOfColumn("SUBTR_CLS")));
						lrArgData.setValue("VATOCCUR_CLS", rows[i].getString(dsMAIN.indexOfColumn("VATOCCUR_CLS")));
						lrArgData.setValue("SLIP_DETAIL_LIST", rows[i].getString(dsMAIN.indexOfColumn("SLIP_DETAIL_LIST")));
						lrArgData.setValue("REMARK", rows[i].getString(dsMAIN.indexOfColumn("REMARK")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_ACC_CODE_EXT01_D(?)}";
						
						lrArgData.addColumn("ACC_CODE", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("ACC_CODE", rows[i].getString(dsMAIN.indexOfColumn("ACC_CODE")));
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
				GauceInfo.response.writeException("USER", "900001", "T_ACC_CODE_EXT01 ���̺� ����Ÿ ���� ����" + ex.getMessage());
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
