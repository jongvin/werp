<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : 
/* 2. ����(�ó�����) : Update Page
/* 3. ��  ��  ��  �� : 
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2005-11-17)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
	CITGauceInfo GauceInfo = null;
	
	GauceDataSet dsMAIN = null;
	
	GauceDataRow[] rows = null;
	
	String strSql = "";
	String strAct = "";
	String strUserNo = "";
	
	try
	{
		GauceInfo = CITCommon.initServerPage(request, response, session);
		/* �������� */
		strUserNo = CITCommon.toKOR((String)session.getAttribute("emp_no"));
		
		strAct = GauceInfo.request.getParameter("ACT");
		
		if (CITCommon.isNull(strAct))
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
						strSql = "{call SP_T_BANK_CODE_I(?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("BANK_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("BANK_MAIN_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("BANK_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("CURACCT_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("BILL_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("CURACCT_MAX_AMT", CITData.NUMBER);
						lrArgData.addColumn("HSELL_USE_CLS", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("BANK_CODE", rows[i].getString(dsMAIN.indexOfColumn("BANK_CODE")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("BANK_MAIN_CODE", rows[i].getString(dsMAIN.indexOfColumn("BANK_MAIN_CODE")));
						lrArgData.setValue("BANK_NAME", rows[i].getString(dsMAIN.indexOfColumn("BANK_NAME")));
						lrArgData.setValue("CURACCT_CLS", rows[i].getString(dsMAIN.indexOfColumn("CURACCT_CLS")));
						lrArgData.setValue("BILL_CLS", rows[i].getString(dsMAIN.indexOfColumn("BILL_CLS")));
						lrArgData.setValue("CURACCT_MAX_AMT", rows[i].getString(dsMAIN.indexOfColumn("CURACCT_MAX_AMT")));
						lrArgData.setValue("HSELL_USE_CLS", rows[i].getString(dsMAIN.indexOfColumn("HSELL_USE_CLS")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_BANK_CODE_U(?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("BANK_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("BANK_MAIN_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("BANK_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("CURACCT_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("BILL_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("CURACCT_MAX_AMT", CITData.NUMBER);
						lrArgData.addColumn("HSELL_USE_CLS", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("BANK_CODE", rows[i].getString(dsMAIN.indexOfColumn("BANK_CODE")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("BANK_MAIN_CODE", rows[i].getString(dsMAIN.indexOfColumn("BANK_MAIN_CODE")));
						lrArgData.setValue("BANK_NAME", rows[i].getString(dsMAIN.indexOfColumn("BANK_NAME")));
						lrArgData.setValue("CURACCT_CLS", rows[i].getString(dsMAIN.indexOfColumn("CURACCT_CLS")));
						lrArgData.setValue("BILL_CLS", rows[i].getString(dsMAIN.indexOfColumn("BILL_CLS")));
						lrArgData.setValue("CURACCT_MAX_AMT", rows[i].getString(dsMAIN.indexOfColumn("CURACCT_MAX_AMT")));
						lrArgData.setValue("HSELL_USE_CLS", rows[i].getString(dsMAIN.indexOfColumn("HSELL_USE_CLS")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_BANK_CODE_D(?)}";
						
						lrArgData.addColumn("BANK_CODE", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("BANK_CODE", rows[i].getString(dsMAIN.indexOfColumn("BANK_CODE")));
					}
					else
					{
						continue;
					}
					
					CITDatabase.executeProcedure(strSql, lrArgData);
				}
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001", "T_BANK_CODE ���̺� ����Ÿ ���� ����" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
		}
	}
	catch (Exception ex)
	{
		if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
		GauceInfo.response.writeException("SYS", "100001", "������ �ʱ�ȭ ���� -> " + ex.getMessage());
	}
	finally
	{
		try
		{
			CITCommon.finalServerPage(GauceInfo);
		}
	    catch (Exception ex)
	    {
			if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
	    	GauceInfo.response.writeException("SYS", "100002", "������ ���� ���� -> " + ex.getMessage());
	    }
	}
%>
