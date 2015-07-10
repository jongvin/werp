<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : 
/* 2. ����(�ó�����) : Update Page
/* 3. ��  ��  ��  �� : 
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2006-03-06)
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
						strSql = "{call SP_T_ACCNO_CODE_I(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("ACCNO", CITData.VARCHAR2);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("BANK_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("ACCT_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("ACCT_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("PAY_ACCNO_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("CHK_ACCNO_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("CHK_MAX_AMT", CITData.NUMBER);
						lrArgData.addColumn("CONT_DT", CITData.VARCHAR2);
						lrArgData.addColumn("EXPR_DT", CITData.VARCHAR2);
						lrArgData.addColumn("EXPR_CHG_DT", CITData.VARCHAR2);
						lrArgData.addColumn("MIDD_CANCEL_DT", CITData.VARCHAR2);
						lrArgData.addColumn("ORG_AMT", CITData.NUMBER);
						lrArgData.addColumn("EXPR_AMT", CITData.NUMBER);
						lrArgData.addColumn("MONTH_INTR_AMT", CITData.NUMBER);
						lrArgData.addColumn("INTR_RATE", CITData.NUMBER);
						lrArgData.addColumn("PAYMENT_SEQ_AMT", CITData.NUMBER);
						lrArgData.addColumn("PAYMENT_SEQ_DAY", CITData.VARCHAR2);
						lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("ACC_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("HSMS_USE_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("REMARKS", CITData.VARCHAR2);
						lrArgData.addColumn("USE_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("FBS_ACCOUNT_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("FBS_TRANSFER_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("VIRTUAL_ACCOUNT_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("FBS_DISPLAY_ORDER", CITData.NUMBER);
						lrArgData.addColumn("ACCOUNT_NO", CITData.VARCHAR2);
						lrArgData.addColumn("ITR_ACC_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("ACC_OWNER", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("ACCNO", rows[i].getString(dsMAIN.indexOfColumn("ACCNO")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("BANK_CODE", rows[i].getString(dsMAIN.indexOfColumn("BANK_CODE")));
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsMAIN.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("ACCT_NAME", rows[i].getString(dsMAIN.indexOfColumn("ACCT_NAME")));
						lrArgData.setValue("ACCT_CLS", rows[i].getString(dsMAIN.indexOfColumn("ACCT_CLS")));
						lrArgData.setValue("PAY_ACCNO_CLS", rows[i].getString(dsMAIN.indexOfColumn("PAY_ACCNO_CLS")));
						lrArgData.setValue("CHK_ACCNO_CLS", rows[i].getString(dsMAIN.indexOfColumn("CHK_ACCNO_CLS")));
						lrArgData.setValue("CHK_MAX_AMT", rows[i].getString(dsMAIN.indexOfColumn("CHK_MAX_AMT")));
						lrArgData.setValue("CONT_DT", rows[i].getString(dsMAIN.indexOfColumn("CONT_DT")));
						lrArgData.setValue("EXPR_DT", rows[i].getString(dsMAIN.indexOfColumn("EXPR_DT")));
						lrArgData.setValue("EXPR_CHG_DT", rows[i].getString(dsMAIN.indexOfColumn("EXPR_CHG_DT")));
						lrArgData.setValue("MIDD_CANCEL_DT", rows[i].getString(dsMAIN.indexOfColumn("MIDD_CANCEL_DT")));
						lrArgData.setValue("ORG_AMT", rows[i].getString(dsMAIN.indexOfColumn("ORG_AMT")));
						lrArgData.setValue("EXPR_AMT", rows[i].getString(dsMAIN.indexOfColumn("EXPR_AMT")));
						lrArgData.setValue("MONTH_INTR_AMT", rows[i].getString(dsMAIN.indexOfColumn("MONTH_INTR_AMT")));
						lrArgData.setValue("INTR_RATE", rows[i].getString(dsMAIN.indexOfColumn("INTR_RATE")));
						lrArgData.setValue("PAYMENT_SEQ_AMT", rows[i].getString(dsMAIN.indexOfColumn("PAYMENT_SEQ_AMT")));
						lrArgData.setValue("PAYMENT_SEQ_DAY", rows[i].getString(dsMAIN.indexOfColumn("PAYMENT_SEQ_DAY")));
						lrArgData.setValue("DEPT_CODE", rows[i].getString(dsMAIN.indexOfColumn("DEPT_CODE")));
						lrArgData.setValue("ACC_CODE", rows[i].getString(dsMAIN.indexOfColumn("ACC_CODE")));
						lrArgData.setValue("HSMS_USE_CLS", rows[i].getString(dsMAIN.indexOfColumn("HSMS_USE_CLS")));
						lrArgData.setValue("REMARKS", rows[i].getString(dsMAIN.indexOfColumn("REMARKS")));
						lrArgData.setValue("USE_CLS", rows[i].getString(dsMAIN.indexOfColumn("USE_CLS")));
						lrArgData.setValue("FBS_ACCOUNT_CLS", rows[i].getString(dsMAIN.indexOfColumn("FBS_ACCOUNT_CLS")));
						lrArgData.setValue("FBS_TRANSFER_CLS", rows[i].getString(dsMAIN.indexOfColumn("FBS_TRANSFER_CLS")));
						lrArgData.setValue("VIRTUAL_ACCOUNT_CLS", rows[i].getString(dsMAIN.indexOfColumn("VIRTUAL_ACCOUNT_CLS")));
						lrArgData.setValue("FBS_DISPLAY_ORDER", rows[i].getString(dsMAIN.indexOfColumn("FBS_DISPLAY_ORDER")));
						lrArgData.setValue("ACCOUNT_NO", rows[i].getString(dsMAIN.indexOfColumn("ACCOUNT_NO")));
						lrArgData.setValue("ITR_ACC_CODE", rows[i].getString(dsMAIN.indexOfColumn("ITR_ACC_CODE")));
						lrArgData.setValue("ACC_OWNER", rows[i].getString(dsMAIN.indexOfColumn("ACC_OWNER")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_ACCNO_CODE_U(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("ACCNO", CITData.VARCHAR2);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("BANK_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("ACCT_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("ACCT_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("PAY_ACCNO_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("CHK_ACCNO_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("CHK_MAX_AMT", CITData.NUMBER);
						lrArgData.addColumn("CONT_DT", CITData.VARCHAR2);
						lrArgData.addColumn("EXPR_DT", CITData.VARCHAR2);
						lrArgData.addColumn("EXPR_CHG_DT", CITData.VARCHAR2);
						lrArgData.addColumn("MIDD_CANCEL_DT", CITData.VARCHAR2);
						lrArgData.addColumn("ORG_AMT", CITData.NUMBER);
						lrArgData.addColumn("EXPR_AMT", CITData.NUMBER);
						lrArgData.addColumn("MONTH_INTR_AMT", CITData.NUMBER);
						lrArgData.addColumn("INTR_RATE", CITData.NUMBER);
						lrArgData.addColumn("PAYMENT_SEQ_AMT", CITData.NUMBER);
						lrArgData.addColumn("PAYMENT_SEQ_DAY", CITData.VARCHAR2);
						lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("ACC_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("HSMS_USE_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("REMARKS", CITData.VARCHAR2);
						lrArgData.addColumn("USE_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("FBS_ACCOUNT_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("FBS_TRANSFER_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("VIRTUAL_ACCOUNT_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("FBS_DISPLAY_ORDER", CITData.NUMBER);
						lrArgData.addColumn("ACCOUNT_NO", CITData.VARCHAR2);
						lrArgData.addColumn("ITR_ACC_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("ACC_OWNER", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("ACCNO", rows[i].getString(dsMAIN.indexOfColumn("ACCNO")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("BANK_CODE", rows[i].getString(dsMAIN.indexOfColumn("BANK_CODE")));
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsMAIN.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("ACCT_NAME", rows[i].getString(dsMAIN.indexOfColumn("ACCT_NAME")));
						lrArgData.setValue("ACCT_CLS", rows[i].getString(dsMAIN.indexOfColumn("ACCT_CLS")));
						lrArgData.setValue("PAY_ACCNO_CLS", rows[i].getString(dsMAIN.indexOfColumn("PAY_ACCNO_CLS")));
						lrArgData.setValue("CHK_ACCNO_CLS", rows[i].getString(dsMAIN.indexOfColumn("CHK_ACCNO_CLS")));
						lrArgData.setValue("CHK_MAX_AMT", rows[i].getString(dsMAIN.indexOfColumn("CHK_MAX_AMT")));
						lrArgData.setValue("CONT_DT", rows[i].getString(dsMAIN.indexOfColumn("CONT_DT")));
						lrArgData.setValue("EXPR_DT", rows[i].getString(dsMAIN.indexOfColumn("EXPR_DT")));
						lrArgData.setValue("EXPR_CHG_DT", rows[i].getString(dsMAIN.indexOfColumn("EXPR_CHG_DT")));
						lrArgData.setValue("MIDD_CANCEL_DT", rows[i].getString(dsMAIN.indexOfColumn("MIDD_CANCEL_DT")));
						lrArgData.setValue("ORG_AMT", rows[i].getString(dsMAIN.indexOfColumn("ORG_AMT")));
						lrArgData.setValue("EXPR_AMT", rows[i].getString(dsMAIN.indexOfColumn("EXPR_AMT")));
						lrArgData.setValue("MONTH_INTR_AMT", rows[i].getString(dsMAIN.indexOfColumn("MONTH_INTR_AMT")));
						lrArgData.setValue("INTR_RATE", rows[i].getString(dsMAIN.indexOfColumn("INTR_RATE")));
						lrArgData.setValue("PAYMENT_SEQ_AMT", rows[i].getString(dsMAIN.indexOfColumn("PAYMENT_SEQ_AMT")));
						lrArgData.setValue("PAYMENT_SEQ_DAY", rows[i].getString(dsMAIN.indexOfColumn("PAYMENT_SEQ_DAY")));
						lrArgData.setValue("DEPT_CODE", rows[i].getString(dsMAIN.indexOfColumn("DEPT_CODE")));
						lrArgData.setValue("ACC_CODE", rows[i].getString(dsMAIN.indexOfColumn("ACC_CODE")));
						lrArgData.setValue("HSMS_USE_CLS", rows[i].getString(dsMAIN.indexOfColumn("HSMS_USE_CLS")));
						lrArgData.setValue("REMARKS", rows[i].getString(dsMAIN.indexOfColumn("REMARKS")));
						lrArgData.setValue("USE_CLS", rows[i].getString(dsMAIN.indexOfColumn("USE_CLS")));
						lrArgData.setValue("FBS_ACCOUNT_CLS", rows[i].getString(dsMAIN.indexOfColumn("FBS_ACCOUNT_CLS")));
						lrArgData.setValue("FBS_TRANSFER_CLS", rows[i].getString(dsMAIN.indexOfColumn("FBS_TRANSFER_CLS")));
						lrArgData.setValue("VIRTUAL_ACCOUNT_CLS", rows[i].getString(dsMAIN.indexOfColumn("VIRTUAL_ACCOUNT_CLS")));
						lrArgData.setValue("FBS_DISPLAY_ORDER", rows[i].getString(dsMAIN.indexOfColumn("FBS_DISPLAY_ORDER")));
						lrArgData.setValue("ACCOUNT_NO", rows[i].getString(dsMAIN.indexOfColumn("ACCOUNT_NO")));
						lrArgData.setValue("ITR_ACC_CODE", rows[i].getString(dsMAIN.indexOfColumn("ITR_ACC_CODE")));
						lrArgData.setValue("ACC_OWNER", rows[i].getString(dsMAIN.indexOfColumn("ACC_OWNER")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_ACCNO_CODE_D(?)}";
						
						lrArgData.addColumn("ACCNO", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("ACCNO", rows[i].getString(dsMAIN.indexOfColumn("ACCNO")));
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
				GauceInfo.response.writeException("USER", "900001", "T_ACCNO_CODE ���̺� ����Ÿ ���� ����" + ex.getMessage());
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
