<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : 
/* 2. ����(�ó�����) : Update Page
/* 3. ��  ��  ��  �� : 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-03-23)
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
						strSql = "{call SP_T_SET_IND_INSUR_INFO_I(?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("WORK_YM", CITData.VARCHAR2);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("HO_IND_DISASTER_AMT", CITData.NUMBER);
						lrArgData.addColumn("S_L_AMT_RATIO", CITData.NUMBER);
						lrArgData.addColumn("INSUR_RATIO", CITData.NUMBER);
						lrArgData.addColumn("PROJ_SUMMARY", CITData.VARCHAR2);
						lrArgData.addColumn("CUST_SEQ", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsMAIN.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("WORK_YM", rows[i].getString(dsMAIN.indexOfColumn("WORK_YM")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("HO_IND_DISASTER_AMT", rows[i].getString(dsMAIN.indexOfColumn("HO_IND_DISASTER_AMT")));
						lrArgData.setValue("S_L_AMT_RATIO", rows[i].getString(dsMAIN.indexOfColumn("S_L_AMT_RATIO")));
						lrArgData.setValue("INSUR_RATIO", rows[i].getString(dsMAIN.indexOfColumn("INSUR_RATIO")));
						lrArgData.setValue("PROJ_SUMMARY", rows[i].getString(dsMAIN.indexOfColumn("PROJ_SUMMARY")));
						lrArgData.setValue("CUST_SEQ", rows[i].getString(dsMAIN.indexOfColumn("CUST_SEQ")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_SET_IND_INSUR_INFO_U(?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("WORK_YM", CITData.VARCHAR2);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("HO_IND_DISASTER_AMT", CITData.NUMBER);
						lrArgData.addColumn("S_L_AMT_RATIO", CITData.NUMBER);
						lrArgData.addColumn("INSUR_RATIO", CITData.NUMBER);
						lrArgData.addColumn("PROJ_SUMMARY", CITData.VARCHAR2);
						lrArgData.addColumn("CUST_SEQ", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsMAIN.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("WORK_YM", rows[i].getString(dsMAIN.indexOfColumn("WORK_YM")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("HO_IND_DISASTER_AMT", rows[i].getString(dsMAIN.indexOfColumn("HO_IND_DISASTER_AMT")));
						lrArgData.setValue("S_L_AMT_RATIO", rows[i].getString(dsMAIN.indexOfColumn("S_L_AMT_RATIO")));
						lrArgData.setValue("INSUR_RATIO", rows[i].getString(dsMAIN.indexOfColumn("INSUR_RATIO")));
						lrArgData.setValue("PROJ_SUMMARY", rows[i].getString(dsMAIN.indexOfColumn("PROJ_SUMMARY")));
						lrArgData.setValue("CUST_SEQ", rows[i].getString(dsMAIN.indexOfColumn("CUST_SEQ")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_SET_IND_INSUR_INFO_D(?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("WORK_YM", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsMAIN.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("WORK_YM", rows[i].getString(dsMAIN.indexOfColumn("WORK_YM")));
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
				GauceInfo.response.writeException("USER", "900001", "T_SET_IND_INSUR_INFO ���̺� ����Ÿ ���� ����" + ex.getMessage());
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
